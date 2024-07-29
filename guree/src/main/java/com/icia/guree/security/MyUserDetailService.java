package com.icia.guree.security;

import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.MemberDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class MyUserDetailService implements UserDetailsService {

    @Autowired
    private MemberDao mDao;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberDto mb = mDao.getMemberInfo(username);
        log.info("=========Member : {}", mb);
        if (mb == null){
            //로그인 실패 시 예외를 실패 핸들러에 던짐
            throw new UsernameNotFoundException(username + "사용자를 찾을 수 없습니다.");
        }
        //User클래스: UserDetails의 구현체
        //필수:아이디,비밀번호, 권한, 선택: disabled(t/f(로그인안됨)), accountLocked(t/f(로그인안됨)),accountExpired(t/f)
        return User.builder().username(mb.getM_id()).password(mb.getM_pw()).roles(mb.getM_role()).build();
    }
}
