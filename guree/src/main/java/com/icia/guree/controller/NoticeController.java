package com.icia.guree.controller;

import com.icia.guree.entity.NoticeDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.service.NoticeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Slf4j
@Controller
public class NoticeController {

    @Autowired
    private NoticeService nSer;

    @GetMapping("/notice/list")
    String noticeList(SearchDto sDto, Model model, HttpSession session) throws JsonProcessingException {
        if(sDto.getPageNum() == null){
            sDto.setPageNum(1);
        }
        if(sDto.getListCnt() == null){
            sDto.setListCnt(NoticeService.LISTCNT);
        }
        if(sDto.getStartIdx() == null){
            sDto.setStartIdx(0);
        }
        log.info("sDto: {}", sDto);
        List<NoticeDto> nList = null;
        nList = nSer.getNoticeList(sDto);
        log.info("==============제발 나와주세요~{}", nList);
        if(nList != null){
            String pageHtml = nSer.getPaging(sDto);
            model.addAttribute("nList", nList);
            model.addAttribute("pageHtml", pageHtml);
            if(sDto.getColName() != null){
                session.setAttribute("sDto", sDto);
            }else{
                session.setAttribute("pageNum", sDto.getPageNum());
                session.removeAttribute("sDto");

            }
            return "notice/NoticeList";
        }else{
            return "redirect:/";
        }
    }

    @GetMapping("/notice/write")
    public String noticeWrite( Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails userDetails) {
            model.addAttribute("userId", userDetails.getUsername());
        }
        log.info("글쓰기 창 오픈했냐???");
        return "notice/NoticeWrite";
    }

    @PostMapping("/notice/write")
    public String noticeWrite(NoticeDto nDto, HttpSession ses, RedirectAttributes rt){

        log.info("글쓰기 창 오픈했냐????");
        log.info("nDto: {}", nDto);
        log.info("Dto : {}", nDto.getAttachments());
        for(MultipartFile mFile : nDto.getAttachments()){
            log.info("파일명 : {}", mFile.getOriginalFilename());
            log.info("파일 사이즈 : {}", mFile.getSize());
        }

        boolean result = nSer.noticeWrite(nDto, ses);
        if(result){
            System.out.println("글쓰기 성공");
            rt.addFlashAttribute("msg", "공지가 작성되었습니다.");
            return "redirect:/notice/list";
        }else{
            System.out.println("글쓰기 실패");
            rt.addFlashAttribute("msg", "공지 작성에 실패했습니다.");
            return "redirect:/notice/write";
        }
    }

    @SuppressWarnings("unused")
    @GetMapping("/notice/detail")
    public String noticeDetail(@RequestParam("n_num") Integer n_num, Model model) throws JsonProcessingException{
        log.info("n_num = {}", n_num);
        if(n_num == null){
            return "redirect:/notice/list";
        }
        NoticeDto nDto = nSer.getNoticeDetail(n_num);
        log.info("NoticeDto : {}", nDto);
        log.info("NoticeFile : {}", nDto.getNfList());
        if(nDto != null){
            model.addAttribute("json", new ObjectMapper().writeValueAsString(nDto));
            model.addAttribute("nDto", nDto);
            return "notice/NoticeDetail";
        }else{
            return "redirect:/notice/list";
        }
    }

    @GetMapping("notice/update")
    public String noticeUpdate(@RequestParam("n_num") Integer n_num, Model model){
        log.info("글 수정창 열었냐??");
        NoticeDto nDto = nSer.getNoticeDetail(n_num);
        if(nDto != null){
            model.addAttribute("nDto", nDto);
            return "notice/NoticeUpdate";
        }else{
            return "redirect:/notice/list";
        }
    }

    @PostMapping("notice/update")
    public String noticeUpdate(NoticeDto nDto, HttpSession ses, RedirectAttributes rt){
        log.info("글 수정 처리 왓냐??");
        log.info("nDto: {}", nDto);
        log.info("파일 사이즈 : {}", nDto.getAttachments().size());
        //log.info("파일 첨부여부 : {}", nDto.getAttachments().isEmpty());
        boolean result = nSer.noticeUpdate(nDto, ses);
        if(result){
            rt.addFlashAttribute("msg", "공지 수정 성공!");
            log.info("수정 성공");
            return "redirect:/notice/detail?n_num=" + nDto.getN_num();
        }else{
            log.info("수정 실패");
            rt.addFlashAttribute("msg", "공지 수정 실패!");
            return "redirect:/notice/update?n_num=" + nDto.getN_num();
        }

    }

}
