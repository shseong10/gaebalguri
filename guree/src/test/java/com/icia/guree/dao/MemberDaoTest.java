package com.icia.guree.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
public class MemberDaoTest {
    @Autowired
    MemberDao mDao;

    @Autowired
    PasswordEncoder passwordEncoder;
//
//    @Test
//    public void joinTest() {
//        System.out.println("pwEncoder : " + passwordEncoder);
//        mDao.join(new Mem("aaa", passwordEncoder.encode("1111"), "USER"));
//    }
}
