package com.icia.guree.service;

import com.icia.guree.common.ProfileFileManager;
import com.icia.guree.dao.FileDao;
import com.icia.guree.dao.MemberDao;
import com.icia.guree.entity.AttendanceDto;
import com.icia.guree.entity.MemberDto;
import com.icia.guree.entity.ProfileFile;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class MemberService {
    @Autowired
    private ProfileFileManager fm;
    @Autowired
    private MemberDao mDao;
    @Autowired
    private FileDao fDao;
    @Autowired
    PasswordEncoder passwordEncoder;


    public boolean memJoin(MemberDto member) {
        member.setM_pw(passwordEncoder.encode(member.getM_pw()));
        return mDao.join(member);
    }


    public String idFind(MemberDto mem) {
        String id = mDao.idFind(mem);
        System.out.println(id);
        return id;
    }


    public String pwFind(MemberDto mem) {
        String pw = mDao.pwFind(mem);
        return pw;
    }

    public boolean pwChange(MemberDto mDto) {
        mDto.setM_pw(passwordEncoder.encode(mDto.getM_pw()));
        return mDao.pwChange(mDto);
    }

    public boolean idCheck(String m_id) {
        return mDao.idCheck(m_id);
    }

    public AttendanceDto attendance(String m_id) {
        AttendanceDto result = mDao.attendance(m_id);
        return result;
    }

    public int pointPlus(String username) {
        int result = mDao.pointPlus(username);
        log.info("포인트 :" + result);
        return result;
    }

    public void attendancePlus(String username) {
        mDao.attendancePlus(username);
    }

    public ProfileFile myPage(String username) {
        ProfileFile result = mDao.profile(username);
        return result;
    }

    public boolean profileupdate(ProfileFile pDto, HttpSession session) {

            String[] sysFiles = fDao.getSysFiles(pDto.getM_id());
            if (sysFiles.length != 0) {
                fm.fileDelete(sysFiles, session);
                fDao.profileDelete(pDto.getM_id());
            }
        return fm.fileUpload(pDto, session);
    }


    public void profileDelete(String username, HttpSession session) {
        String[] sysFiles = fDao.getSysFiles(username);
        if (sysFiles.length != 0) {
            fm.fileDelete(sysFiles, session);
            fDao.profileDelete(username);
        }
    }


    public List<MemberDto> MemberList() {
        List<MemberDto> memberList = mDao.getMemberList();
        return memberList;
    }

    public MemberDto userInfo(String username) {
        MemberDto userInfo = mDao.getMemberInfo(username);

        return userInfo;
    }

    public void infoUpdate(MemberDto mDto) {
        mDao.infoUpdate(mDto);
    }
}
