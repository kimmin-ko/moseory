package com.moseory.dao;

import com.moseory.domain.MemberVO;

public interface UserDao {
    
    public MemberVO getMember(String id);
    
    public void updateMember(MemberVO vo);
    
    public void deleteMember(String id);
}
