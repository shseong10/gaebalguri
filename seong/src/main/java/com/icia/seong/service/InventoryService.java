package com.icia.seong.service;

import com.icia.seong.common.FileManager;
import com.icia.seong.dao.InventoryDao;
import com.icia.seong.dto.InventoryDto;
import com.icia.seong.dto.InventoryFile;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
