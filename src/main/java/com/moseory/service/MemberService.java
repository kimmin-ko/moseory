package com.moseory.service;

import com.moseory.domain.MemberVO;

public interface MemberService {
    
    // 회원 등록
    public void registerMember(MemberVO vo);
    
    // 회원 정보 가져오기
    public MemberVO readMember(String id);
    
    // 회원 모두 삭제
    public void deleteAll();
    
    // 회원 아이디 여부
    public int isMember(String id);
    
}
