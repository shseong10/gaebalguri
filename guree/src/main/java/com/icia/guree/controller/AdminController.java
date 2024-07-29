package com.icia.guree.controller;

import com.icia.guree.entity.MemberDto;
import com.icia.guree.service.AdminService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
public class AdminController {
    @Autowired
    AdminService aSer;

    // 관리자 페이지로
    @Secured("ROLE_admin")
    @GetMapping("/member/admin")
    public String admin(Model model) {
        return "member/admin";
    }

    // 게시글 완전 삭제
    @Secured("ROLE_admin")
    @GetMapping("/admin/realDelete")
    public String realDelete(@RequestParam("sb_num") Integer sb_num, HttpSession session) {
        aSer.realDelete(sb_num, session);

        return "member/admin";
    }

    // 게시글 복원
    @Secured("ROLE_admin")
    @GetMapping("/admin/restore")
    public String restore(@RequestParam("sb_num") Integer sb_num) {
        aSer.restore(sb_num);

        return "member/admin";
    }

    @GetMapping("/admin/cateDelete")
    public String cateDelete(@RequestParam("c_kind") String c_kind) {
        aSer.cateDelete(c_kind);
        return "member/admin";
    }

    @PostMapping("/admin/cateAttend")
    public String cateAttend(@RequestParam("c_kind") String c_kind) {
        aSer.cateAttend(c_kind);
        return "member/admin";
    }
    @PostMapping("/admin/memberUpdate")
    public String memberUpdate(MemberDto mDto) {
        aSer.memberUpdate(mDto);
        return "member/admin";
    }

}
