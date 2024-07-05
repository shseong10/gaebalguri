package com.icia.seong.common;

import com.icia.seong.dao.InventoryDao;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class FileManager {

    @Autowired
    private InventoryDao iDao;

    public boolean fileUpload(List<MultipartFile> attachments, HttpSession session, int h_p_num) {
        //첨부파일 경로 조회
        String realPath = session.getServletContext().getRealPath("/");
        realPath += "upload/";

        //첨부파일을 저장할 폴더가 없다면 생성
        File dir = new File(realPath);
        if (dir.isDirectory() == false) {
            dir.mkdir();
        }

        //첨부파일 정보를 HashMap 형태로 저장
        Map<String, String> fMap = new HashMap<String, String >();
        fMap.put("h_p_num", h_p_num + "");
        boolean result = false;
        for (MultipartFile mf : attachments) {
            //첨부파일을 메모리에 저장
            String oriFileName = mf.getOriginalFilename();
            if(oriFileName.equals("")){
                return false;
            }
            fMap.put("oriFileName", oriFileName);
            //시스템 파일 이름 생성
            String sysFileName = System.currentTimeMillis() + "."
                    + oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
            fMap.put("sysFileName", sysFileName);

            //메모리에서 대상 경로로 파일 저장
            try {
                mf.transferTo(new File(realPath + sysFileName));
                result = iDao.fileInsertMap(fMap);
                if(result == false) break;
            } catch (IOException e) {
                System.out.println(e.getMessage());
                System.out.println("파일업로드 예외 발생");
                e.printStackTrace();
                result = false;
                break;
            }
        } // for end
        return result;
    }
}
