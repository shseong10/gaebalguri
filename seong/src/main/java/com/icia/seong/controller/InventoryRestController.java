package com.icia.seong.controller;

import com.icia.seong.dto.InventoryDto;
import com.icia.seong.service.InventoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
public class InventoryRestController {
    @Autowired
    private InventoryService iSer;

    @GetMapping("/admin/quickupdate")
    public String quickUpadate() {
        log.info("quickUpadate");
        return "redirect:/admin/main";
    }

    @PostMapping("/admin/quickupdate")
    public HashMap<String, Object> quickUpadate(@RequestBody InventoryDto inventory) {
        List<InventoryDto> iList = iSer.quickUpdate(inventory);
        HashMap<String, Object> hMap = new HashMap<>();
        hMap.put("iList", inventory);
        log.info(">>>>>> quickUpadate: {}", hMap);

        return hMap;
    }
}
