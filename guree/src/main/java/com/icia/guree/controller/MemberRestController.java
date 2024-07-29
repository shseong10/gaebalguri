package com.icia.guree.controller;

import com.icia.guree.entity.MemberDto;
import com.icia.guree.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class MemberRestController {
    @Autowired
    private MemberService mSer;


    @PostMapping("/member/idFind")
    public String idFind(MemberDto mem){
        log.info("mem--------------:"+mem);
      String id = mSer.idFind(mem);
      return id;
    }
    @PostMapping("/member/pwFind")
    public String pwFind(MemberDto mem){
        log.info("mem--------------:"+mem);
        String id = mSer.pwFind(mem);

            return id;
        }
    @GetMapping("/member/idCheck")
        public boolean idCheck(@RequestParam("m_id") String m_id){
        boolean result = mSer.idCheck(m_id);
        System.out.println(result);
        return result;
        }
    @GetMapping("/member/userid")
        public String userid(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            return userDetails.getUsername();  // Return the username
        }
        return null;
    }
//    @PostMapping("/member/attendance")
//    public AttendanceDto attandence(@RequestParam("m_id") String m_id){
//        System.out.println(m_id);
//        AttendanceDto result = mSer.attendance(m_id);
//        log.info("리절트값 +++++++++++++++++++++++++" + result);
//
//        return result;
//    }
//




}
