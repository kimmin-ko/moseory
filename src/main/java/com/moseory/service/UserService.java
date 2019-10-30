package com.moseory.service;

import com.moseory.domain.MemberVO;

public interface UserService {
    
    public MemberVO readMember(String id);
    
    public void modifyMember(MemberVO vo);
    
}
