package com.moseory.service;

import com.moseory.domain.MemberVO;

public interface MemberService {
    
    // 회원 등록
    public void joinMember(MemberVO vo);
    
    // 회원 모두 삭제
    public void deleteAll();
    
}
