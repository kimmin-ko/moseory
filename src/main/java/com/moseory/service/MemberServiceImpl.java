package com.moseory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.MemberDao;
import com.moseory.domain.MemberVO;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
    
    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;
    
    // 회원 등록
    @Override
    public void registerMember(MemberVO vo) {
	memberDao.insertMember(vo);
    }

    // 회원 모두 삭제
    @Override
    public void deleteAll() {
	memberDao.deleteAll();
    }

    // 회원 아이디 여부
    @Override
    public int isMember(String id) {
	return memberDao.getCountMember(id);
    }

}

















