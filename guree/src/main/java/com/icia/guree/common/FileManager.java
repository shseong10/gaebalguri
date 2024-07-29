package com.icia.guree.common;

import com.icia.guree.dao.InventoryDao;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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

    //파일 삭제
    public void fileDelete(String[] sysFiles, HttpSession session) {
        String realPath = session.getServletContext().getRealPath("/");
        realPath += "upload/";
        log.info("삭제 경로: {}", realPath);
        for (String sysname : sysFiles) {
            File file = new File(realPath + sysname);
            log.info("삭제 대상: {}", file.getAbsoluteFile());
            if (file.exists()) {
                file.delete();
                log.info("서버 파일 삭제 완료");
            } else {
                log.info("이미 삭제된 파일입니다.");
            }
        }
    }

    public Map<String, Object> editorFileUpload (MultipartHttpServletRequest request, HttpSession session) {
        //반환할 URL을 저장하는 변수 생성
        Map<String, Object> map = new HashMap<>();

        //첨부파일 경로 조회
        String realPath = session.getServletContext().getRealPath("/");
        realPath += "upload/admin/";

        //첨부파일을 저장할 폴더가 없다면 생성
        File dir = new File(realPath);
        if (dir.isDirectory() == false) {
            dir.mkdir();
        }

        //이미지 정보 받아오기
        MultipartFile uploadFile = request.getFile("upload");

        //파일 이름 재설정
        String oriFileName = uploadFile.getOriginalFilename();
        String sysFileName = System.currentTimeMillis() + "."
                + oriFileName.substring(oriFileName.lastIndexOf(".") + 1);

        File file = new File(realPath + sysFileName);

        try {
            uploadFile.transferTo(file);
            map.put("url", "/upload/admin/" + sysFileName);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return map;
    }


    //선택한 파일 삭제
    public boolean deleteSelFmap(HttpSession session, Map fMap){
        log.info("선택한 파일 삭제: {}", fMap);
        boolean result = iDao.deleteSelFmap(fMap);
        if (result) {
            return true;
        }
        return false;
    }
}

