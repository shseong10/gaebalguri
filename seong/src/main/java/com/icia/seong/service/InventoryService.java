package com.icia.seong.service;

import com.icia.seong.common.FileManager;
import com.icia.seong.dao.InventoryDao;
import com.icia.seong.dto.CategoryDto;
import com.icia.seong.dto.InventoryDto;
import com.icia.seong.exception.DBException;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class InventoryService {
    @Autowired
    private InventoryDao iDao;

    @Autowired
    private FileManager fm;

    //상품 리스트 가져오기
    public List<InventoryDto> getInventoryList() {
        List<InventoryDto> iList = null;
        iList = iDao.getInventoryList();
        if(iList != null) {
            return iList;
        } else  {
            return null;
        }
    }

    //상품 카테고리 가져오기
    public List<CategoryDto> getCategoryList() {
        List<CategoryDto> cList = null;
        return  iDao.getCategoryList();
    }

    //상품 등록하기
    public boolean addItem (InventoryDto inventory, HttpSession session) {
        boolean result = iDao.addItemSelectKey(inventory);
        if (result) {
            if(!inventory.getAttachments().get(0).isEmpty()) {
                if(fm.fileUpload(inventory.getAttachments(), session, inventory.getH_p_num())) {
                    log.info("=== 상품 등록 완료 ===");
                    return true;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    //상품 상세보기
    public InventoryDto getInventoryDetail(Integer h_p_num) {
        return iDao.getInventoryDetail(h_p_num);
    }

    //상품 수정하기
    public boolean updateItem (InventoryDto inventory, HttpSession session) {
        boolean result = iDao.updateItem(inventory);
        if (result) {
            if(!inventory.getAttachments().get(0).isEmpty()) {
                //기존 파일 삭제
                String[] sysFiles = iDao.getsysFiles(inventory.getH_p_num());
                if(sysFiles.length != 0) {
                    fm.fileDelete(sysFiles, session);
                    iDao.deleteFile(inventory.getH_p_num());
                }
                if(fm.fileUpload(inventory.getAttachments(), session, inventory.getH_p_num())) {
                    log.info("!!=== 상품 수정 완료 ===!!");
                    return true;
                }
            }
            return true;
        } else {
            return false;
        }
    }

    //상품 삭제하기
    @Transactional
    public void deleteItem(Integer h_p_num, HttpSession session) throws DBException {
        //파일 삭제
        String[] sysFiles = iDao.getsysFiles(h_p_num);
        if(sysFiles.length != 0) {
            if(iDao.deleteFile(h_p_num) == false) {
                log.info("!! deleteFile 예외발생");
                throw new DBException(); //롤백
            }
        }
        //원글 삭제
        if(!iDao.deleteItem(h_p_num)) {
            log.info("!! deleteItem 예외발생");
            throw new DBException(); //롤백
        }
        //서버 파일 삭제
        if(sysFiles.length != 0) {
            fm.fileDelete(sysFiles, session);
        }
    }

    //관리자페이지
    //상품 리스트 가져오기
    public List<InventoryDto> getAdmin() {
        List<InventoryDto> iList = null;
        iList = iDao.getInventoryList();
        if(iList != null) {
            return iList;
        } else  {
            return null;
        }
    }

    public List<InventoryDto> quickUpdate(InventoryDto inventory) {
        List<InventoryDto> iList = null;
        if(iDao.quickUpadate(inventory)) {
            iList = iDao.getInventoryList();
            log.info("빠른 수정 저장 성공");
        }
        return iList;
    }
}
