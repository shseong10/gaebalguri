package com.icia.seong.controller;

import com.icia.seong.dto.InventoryDto;
import com.icia.seong.service.InventoryService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
public class InventoryRestController {

    @Autowired
    private InventoryService iSer;

    @GetMapping("/admin/quickupdate")
    public String quickUpdate() {
        log.info("quickUpdate");
        return "redirect:/admin/main";
    }

    @GetMapping("/admin/quickview")
    public List<InventoryDto> getQuickView(@RequestParam("h_p_num") Integer h_p_num, Model model) {
        log.info("<<<<<<<h_p_num=" + h_p_num);
        List<InventoryDto> quickView = iSer.getQuickView(h_p_num);
        log.info("<<<<<<<<InventoryDto: {}", quickView);
        model.addAttribute("quickView", quickView);
        return quickView;
    }

    @PostMapping("/admin/quickupdate")
    public HashMap<String, Object> quickUpdate(@RequestBody InventoryDto inventory) {
        List<InventoryDto> iList = iSer.quickUpdate(inventory);
        HashMap<String, Object> hMap = new HashMap<>();
        hMap.put("iList", inventory);
        log.info(">>>>>> quickUpdate: {}", hMap);

        return hMap;
    }
}
