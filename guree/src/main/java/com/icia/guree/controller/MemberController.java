package com.icia.guree.controller;

import com.icia.guree.dao.FileDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.AttendanceDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.ProfileFile;
import com.icia.guree.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Slf4j
@Controller
public class MemberController {
    @Autowired
    private MemberService mSer;
    @Autowired
    private MemberDao mDao;
    @Autowired
    private FileDao pDao;

    //로그인 안된경우만 로그인창으로
    @PreAuthorize("isAnonymous()")
    @GetMapping("/member/login")
    public String login() {
        return "member/login";
    }

    @GetMapping("/member/login/error")
    public String loginError(Model model) {
        model.addAttribute("msg", "로그인 실패-model");
        return "member/login";
    }

    @PostMapping("/member/join")
    public String memberJoin(MemberDto mem, Model model, Principal principal) {
        boolean result = mSer.memJoin(mem);
        if (result) {
            System.out.println("회원가입 성공");
            return "redirect:/member/login";
        } else {
            System.out.println("회원가입 실패");
            return "redirect:/member/join";
        }
    }

    //아이디 찾기
    @GetMapping("/member/idFind")
    public String idFind() {
        return "member/idFinder";
    }

    //비밀번호 찾기
    @GetMapping("/member/pwFind")
    public String pwFind() {
        return "member/pwFinder";
    }

    //비밀번호 바꾸기
    @PostMapping("/member/pwChange")
    public String pwChange(MemberDto mDto) {
        boolean result = mSer.pwChange(mDto);

        if (result) {
            System.out.println("비밀번호 변경 성공");
            return "redirect:/member/login";
        } else {
            System.out.println("비밀번호 변경 실패");
            return "redirect:/member/pwFinder";
        }
    }

    // 출석체크
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/attendance")
    public String pointPlus(RedirectAttributes redirectAttributes) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            AttendanceDto result = mSer.attendance(userDetails.getUsername());
            if (result == null) {
                mSer.attendancePlus(userDetails.getUsername());
                mSer.pointPlus(userDetails.getUsername());  // Return the username
                redirectAttributes.addFlashAttribute("msg","출석체크 되었습니다.");
                return "redirect:/";
            }
            LocalDate today = LocalDate.now();
            log.info("===========today==========" + today);
            log.info("===========가져온 날짜==========" + result.getA_date());
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDate attendDate = LocalDate.parse(result.getA_date(), formatter);
            log.info("===========가져온 날짜==========" + attendDate);
            if(attendDate.isEqual(today)) {
                redirectAttributes.addFlashAttribute("msg","이미 출석체크 되었습니다.");
            }else {
                mSer.attendancePlus(userDetails.getUsername());
                mSer.pointPlus(userDetails.getUsername());  // Return the username
                redirectAttributes.addFlashAttribute("msg","출석체크 되었습니다.");
            }
        }
        return "redirect:/";
    }

    //마이페이지
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/myPage")
    public String myPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            ProfileFile profile = mSer.myPage(userDetails.getUsername());
            model.addAttribute("profile", profile);
        }
        return "member/myPage";
    }

    // 프로필 사진 업로드
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/member/profileUpdate")
    public String profileupdate(ProfileFile pDto, HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            pDto.setM_id(userDetails.getUsername());

            boolean result = mSer.profileupdate(pDto, session);

            if (result) {
                System.out.println("프로필 변경 성공");
                session.setAttribute("profile", pDto);
                return "redirect:/member/myPage";
            } else {
                System.out.println("프로필 변경 실패");
                return "redirect:/member/myPage";
            }

        }
        System.out.println("프로필 등록 실패");
        return "redirect:/member/myPage";
    }

    // 프로필 사진 삭제
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/member/profileDelete")
    public String profileDelete(HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            mSer.profileDelete(userDetails.getUsername(), session);
            System.out.println("프로필 삭제 성공");
            return "redirect:/member/myPage";
        } else {
            System.out.println("프로필 삭제 실패");
            return "redirect:/member/myPage";
        }
    }

    @GetMapping("/member/infoUpdate")
    public String infoUpdate(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
           MemberDto mInfo = mSer.userInfo(userDetails.getUsername());
            model.addAttribute("mInfo",mInfo);

        }
        return "member/infoUpdate";
    }
    @PostMapping("/member/infoUpdate")
    public String infoUpdate(MemberDto mDto,Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            System.out.println(userDetails.getUsername());
            mDto.setM_id(userDetails.getUsername());
            mSer.infoUpdate(mDto);
            ProfileFile profile = mSer.myPage(userDetails.getUsername());
            model.addAttribute("profile", profile);
        }
        return "member/myPage";
    }






}