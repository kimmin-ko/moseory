package com.moseory.dao;

import com.moseory.domain.MemberVO;

public interface MemberDao {
    
    public void insertMember(MemberVO vo);
    
    public void deleteAll();
    
    public int getCount();
    
    public MemberVO getMember(String id);
    
}
