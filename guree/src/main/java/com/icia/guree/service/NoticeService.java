package com.icia.guree.service;

import com.icia.guree.common.NoticeFileManager;
import com.icia.guree.common.Paging;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.dao.NoticeDao;
import com.icia.guree.entity.NoticeDto;
import com.icia.guree.entity.SearchDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class NoticeService {

    @Autowired
    private NoticeDao nDao;

    @Autowired
    private MemberDao mDao;

    @Autowired
    private NoticeFileManager fm;

    public static final int LISTCNT = 10;
    public static final int PAGECOUNT = 2;

    public List<NoticeDto> getNoticeList(SearchDto sDto) {
        int pageNum = sDto.getPageNum();
        sDto.setStartIdx((pageNum - 1) * sDto.getListCnt());
        log.info("++++++++++++나 왓니????");
        return nDao.getNoticeList(sDto);
    }

    public String getPaging(SearchDto sDto) {
        int totalNum = nDao.getNoticeCount(sDto);
        log.info("totalNum:{}", totalNum);
        String listUrl = null;
        if (sDto.getColName() != null) {
            listUrl = "/notice/list?colName=" + sDto.getColName()
                    + "&keyword=" + sDto.getKeyword() + "&";
        } else {
            listUrl = "/notice/list?";
        }
        Paging p = new Paging(totalNum, sDto.getPageNum(), sDto.getListCnt(), PAGECOUNT, listUrl);
        return p.makeHtmlPaging();
    }

    public boolean noticeWrite(NoticeDto nDto, HttpSession ses) {
        boolean result = nDao.noticeWrite(nDto);
        if (!nDto.getAttachments().get(0).isEmpty()) {
            if (fm.fileUpload(nDto.getAttachments(), ses, nDto.getN_num())) {
                log.info("업로드 성공!");
                return true;
            }
            return true;
        }
        return result;
    }

    public NoticeDto getNoticeDetail(Integer n_num) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String viewId = nDao.getNoticeViewId(userDetails.getUsername(),n_num);
            if (viewId == null || !viewId.equals(userDetails.getUsername())) {
                nDao.setNoticeViewInfo(n_num,userDetails.getUsername());
                nDao.setNoticeView(n_num);
            }
        }
        return nDao.getNoticeDetail(n_num);
    }

    public boolean noticeUpdate(NoticeDto nDto, HttpSession ses) {
        log.info("수정할 Dto:{}",nDto);
        boolean result = nDao.noticeUpdate(nDto);
        if(result){
            if(!nDto.getAttachments().get(0).isEmpty()){
                String[] files = nDao.getSysFiles(nDto.getN_num());
                if(files.length != 0){
                    fm.fileDelete(files, ses);
                    nDao.fileDelete(nDto.getN_num());
                }
                if(fm.fileUpload(nDto.getAttachments(), ses, nDto.getN_num())){
                    log.info("업로드 성공!!");
                    return true;
                }
            }
            return true;
        }else{
            return false;
        }
    }
}

