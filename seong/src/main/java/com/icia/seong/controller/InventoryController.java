package com.icia.seong.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icia.seong.dto.CartDto;
import com.icia.seong.dto.CategoryDto;
import com.icia.seong.dto.InventoryDto;
import com.icia.seong.dto.OrderDto;
import com.icia.seong.exception.DBException;
import com.icia.seong.service.CartService;
import com.icia.seong.service.InventoryService;
import com.icia.seong.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;

@Slf4j
@Controller
public class InventoryController {
    @Autowired
    private InventoryService iSer;

    @Autowired
    private OrderService oSer;

    @Autowired
    private CartService cSer;

    //상품 업로드
    @GetMapping("/add_item")
    public String addItem(Model model) {
        log.info("상품 업로드 페이지로 이동");
        List<CategoryDto> cList = iSer.getCategoryList();
        if (cList != null) {
            System.out.println("cList:" + cList);
            model.addAttribute("cList", cList);
        }
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

    //상품 목록
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

    //상품 상세
    @GetMapping("/list/detail")
    public String inventoryDetail(@RequestParam("h_p_num") Integer h_p_num, Model model) throws JsonProcessingException {
        log.info("<<<<<<<h_p_num=" + h_p_num);
        if (h_p_num == null) {
            return "redirect:/list";
        }
        InventoryDto inventory = iSer.getInventoryDetail(h_p_num);
        log.info("<<<<<<<<InventoryDto: {}", inventory);
        log.info("<<<<<<<<InventoryFile: {}", inventory.getIfList());
        if (inventory != null) {
            model.addAttribute("json", new ObjectMapper().writeValueAsString(inventory));
            model.addAttribute("inventory", inventory);
            return "viewItem";
        } else {
            return "redirect:/list";
        }
    }

    //상품 수정하기
    @GetMapping("/update_item")
    public String updateItem(@RequestParam("h_p_num") Integer h_p_num, Model model) throws JsonProcessingException {
        log.info("{}번째 상품 수정 페이지로 이동", h_p_num);
        InventoryDto inventory = iSer.getInventoryDetail(h_p_num);
        List<CategoryDto> cList = iSer.getCategoryList();
        if (cList != null) {
            System.out.println("cList:" + cList);
            model.addAttribute("cList", cList);
        }
        if (inventory != null) {
            model.addAttribute("json", new ObjectMapper().writeValueAsString(inventory));
            model.addAttribute("inventory", inventory);
            return "updateItem";
        } else {
            return "redirect:/list";
        }
    }

    @PostMapping("/update_item")
    public String updateItem(InventoryDto inventory, HttpSession session, RedirectAttributes rttr) {
        log.info("상품 수정");
        log.info(">>>>상품: {}", inventory);
        for(MultipartFile mf : inventory.getAttachments()) {
            log.info(">>> 파일명: ", mf.getOriginalFilename());
            log.info("====================================================");
        }
        boolean result = iSer.updateItem(inventory, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 업로드 성공");
            return "redirect:/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 업로드 실패");
            return "redirect:/update_Item";
        }
    }

    //상품 삭제하기 *이미 주문되었거나 장바구니에 담긴 상품은 삭제 불가.
    @GetMapping("/delete_item")
    public String deleteItem(@RequestParam("h_p_num") Integer h_p_num, HttpSession session, RedirectAttributes rttr) {
        log.info(">>>>>삭제 대상 글번호: {}", h_p_num);

        try {
            iSer.deleteItem(h_p_num, session); // *****
            rttr.addFlashAttribute("msg", h_p_num + "번 삭제성공");
            return "redirect:/list";
        } catch (DBException e) {
            log.info(e.getMessage());
            rttr.addFlashAttribute("msg", h_p_num + "번 삭제실패");
            return "redirect:/list/detail?h_p_num=" + h_p_num;
        }
    }

    //구매하기
    @GetMapping("/buy_item")
    public String buyItem() {
        log.info("상품 구매 페이지로 이동");
        return "buyItem";
    }
    
    @PostMapping("/buy_item")
    public String buyItem(OrderDto order, HttpSession session, RedirectAttributes rttr) {
        log.info("상품 주문");
        log.info("주문 옵션: {}", order);
        boolean result = oSer.buyItem(order, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 업로드 성공");
            return "redirect:/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 업로드 실패");
            return "redirect:/list";
        }
    }

    //장바구니
    @GetMapping("/take_item")
    public String takeItem() {
        log.info("상품을 장바구니에 저장");
        return "takeItem";
    }

    @PostMapping("/take_item")
    public String takeItem(CartDto cart, HttpSession session, RedirectAttributes rttr) {
        log.info("상품을 장바구니에 저장");
        log.info("주문 옵션: {}", cart);
        boolean result = cSer.takeItem(cart, session);
        if (result) {
            rttr.addFlashAttribute("msg", "상품 업로드 성공");
            return "redirect:/list";
        } else {
            rttr.addFlashAttribute("msg", "상품 업로드 실패");
            return "redirect:/list";
        }
    }


    //관리자페이지
    @GetMapping("/admin/main")
    public String getAdmin(Model model, HttpSession session) throws JsonProcessingException {
        List<InventoryDto> iList = iSer.getInventoryList();
        if (iList != null) {
            System.out.println("iList:" + iList);
            model.addAttribute("json", new ObjectMapper().writeValueAsString(iList));
            model.addAttribute("iList", iList);
            return "adminMain";
        } else {
            return "redirect:/list";
        }
    }
}
