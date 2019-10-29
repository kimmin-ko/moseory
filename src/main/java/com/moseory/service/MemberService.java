package com.moseory.service;

import java.util.List;
import java.util.Map;

import com.moseory.domain.MemberVO;

public interface MemberService {
    
    // 회원 등록
    public void joinMember(MemberVO vo);
    
    // 회원 모두 삭제
    public void deleteAll();

    //로그인
    public MemberVO loginProc(Map<String, Object> param);
    
    //ID찾기 
    public List<Map<String, Object>> findIdProc(Map<String, Object> param);
    
}
