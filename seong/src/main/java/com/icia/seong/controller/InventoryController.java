package com.icia.seong.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icia.seong.dto.InventoryDto;
import com.icia.seong.service.InventoryService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
public class InventoryController {
    @Autowired
    private InventoryService iSer;

    @GetMapping("/add_item")
    public String addItem() {
        log.info("상품 업로드 페이지로 이동");
        return "addItem";
    }

    @PostMapping("/add_item")
    public String addItem(InventoryDto inventory, HttpSession session, RedirectAttributes rttr) {
        log.info("상품 업로드");
        log.info(">>>>상품: {}", inventory);
        for(MultipartFile mf : inventory.getAttachments()) {
            log.info(">>> 파일명: ", mf.getOriginalFilename());
            log.info("====================================================");
        }
        boolean result = iSer.addItem(inventory, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 업로드 성공");
            return "redirect:/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 업로드 실패");
            return "redirect:/add_Item";
        }
    }

    @GetMapping("/list")
    public String inventoryList(Model model, HttpSession session) throws JsonProcessingException {
        List<InventoryDto> iList = iSer.getInventoryList();
        if (iList != null) {
            System.out.println("iList:" + iList);
            model.addAttribute("iList", iList);
            return "itemList";
        } else {
            return "redirect:/";
        }
    }
}
