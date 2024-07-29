package com.icia.guree.controller;

import com.icia.guree.entity.NoticeDto;
import com.icia.guree.entity.SearchDto;
import com.icia.guree.service.ReportService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
public class ReportController {

    @Autowired
    private ReportService rSer;

    @GetMapping("/report/list")
    String ReportList(SearchDto sDto, Model model, HttpSession ses) throws JsonProcessingException {
        if(sDto.getPageNum() == null){
            sDto.setPageNum(1);
        }
        if(sDto.getListCnt() == null){
            sDto.setListCnt(ReportService.LISTCNT);
        }
        if(sDto.getStartIdx() == null){
            sDto.setStartIdx(0);
        }
        log.info("sDto: {}", sDto);
        List<NoticeDto> rList = null;
        rList = rSer.getReportList(sDto);
        log.info("==============제발 나와주세요~{}", rList);
        if(rList != null){
            String pageHtml = rSer.getPaging(sDto);
            model.addAttribute("json", new ObjectMapper().writeValueAsString(rList));
            model.addAttribute("rList", rList);
            model.addAttribute("pageHtml", pageHtml);
            if(sDto.getColName() != null){
                ses.setAttribute("sDto", sDto);
            }else{
                ses.setAttribute("pageNum", sDto.getPageNum());
                ses.removeAttribute("sDto");
            }
            return "notice/ReportList";
        }else{
            return "redirect:/";
        }
    }

    @GetMapping("/report/write")
    public String reportWrite(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails userDetails) {
            model.addAttribute("userId", userDetails.getUsername());
        }
        log.info("글쓰기 창 열렷냐??");
        return "notice/ReportWrite";
    }

    @PostMapping("/report/write")
    public String reportWrite(NoticeDto nDto, HttpSession ses, RedirectAttributes rt){
        log.info("글쓰기 창 열렷냐???");
        log.info("nDto: {}", nDto);
        log.info("Dto : {}", nDto.getAttachments());
        for(MultipartFile mFile : nDto.getAttachments()){
            log.info("파일명 : {}", mFile.getOriginalFilename());
            log.info("파일 사이즈 : {}", mFile.getSize());
        }

        boolean result = rSer.reportWrite(nDto, ses);
        if(result){
            System.out.println("글쓰기 성공");
            rt.addFlashAttribute("msg", "정상적으로 작성되었습니다.");
            return "redirect:/report/list";
        }else{
            System.out.println("글쓰기 실패");
            rt.addFlashAttribute("msg", "작성에 실패했습니다.");
            return "redirect:/report/write";
        }
    }

    @SuppressWarnings("unused")
    @GetMapping("/report/detail")
    public String reportDetail(@RequestParam("n_num") Integer n_num, Model model) throws JsonProcessingException {
        log.info("n_num: {}", n_num);
        if(n_num == null){
            return "redirect:/report/list";
        }
        NoticeDto nDto = rSer.getReportDetail(n_num);
        log.info("NoticeDto : {}", nDto);
        log.info("NoticeFile : {}", nDto.getNfList());
        if(nDto != null){
            model.addAttribute("json", new ObjectMapper().writeValueAsString(nDto));
            model.addAttribute("nDto", nDto);
            return "notice/ReportDetail";
        }else{
            return "redirect:/report/list";
        }
    }

    @GetMapping("/report/update")
    public String reportUpdate(@RequestParam("n_num") Integer n_num, Model model) {
        log.info("글 수정창 열었냐??");
        NoticeDto nDto = rSer.getReportDetail(n_num);
        if(nDto != null){
            model.addAttribute("nDto", nDto);
            return "notice/ReportUpdate";
        }else{
            return "redirect:/report/list";
        }
    }

    @PostMapping("/report/update")
    public String reportUpdate(NoticeDto nDto, HttpSession ses, RedirectAttributes rt){
        log.info("글 수정하러 왔냐???");
        log.info("nDto: {}", nDto);
        log.info("파일 사이즈 : {}", nDto.getAttachments().size());
        boolean result = rSer.reportUpdate(nDto, ses);
        if(result){
            rt.addFlashAttribute("msg", "수정 성공!");
            log.info("수정 성공");
            return "redirect:/report/detail?n_num=" + nDto.getN_num();
        }else{
            log.info("수정 실패");
            rt.addFlashAttribute("msg", "수정 실패!");
            return "redirect:/report/update?n_num=" + nDto.getN_num();
        }
    }

}

