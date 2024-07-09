package com.icia.seong.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;

public class HomeController {
    @GetMapping("/")
    public String home(HttpSession session) {
        return "itemList";
    }
}
