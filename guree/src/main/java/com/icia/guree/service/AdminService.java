package com.icia.guree.service;

import com.icia.guree.common.BoardFileManager;
import com.icia.guree.dao.BoardDao;
import com.icia.guree.dao.FileDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AdminService {
    @Autowired
    private FileDao fDao;
    @Autowired
    private BoardFileManager bfm;
    @Autowired
    private BoardDao bDao;
    @Autowired
    private MemberDao mDao;



    public void realDelete(Integer sb_num, HttpSession session) {
        String[] sysFiles = fDao.getBoardSysFiles(sb_num);
        if (sysFiles.length != 0) {
            bfm.fileDelete(sysFiles, session);
        }
        bDao.realDelete(sb_num);
    }

    public void restore(Integer sb_num) {
        bDao.restore(sb_num);
    }

    public void cateDelete(String c_kind) {
        bDao.cateDelete(c_kind);
    }

    public void cateAttend(String c_kind) {
        bDao.cateAttend(c_kind);
    }

    public void memberUpdate(MemberDto mDto) {
         mDao.memberUpdate(mDto) ;
    }
}