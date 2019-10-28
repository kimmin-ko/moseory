package com.moseory.dao;

import com.moseory.domain.MemberVO;

public interface MemberDao {
    
    public void insertMember(MemberVO vo);
    
    public void deleteMember(String id);
    
    public void deleteAll();
    
    public int getCount();
    
    public MemberVO getMember(String id);
    
    public int getCountMember(String id);
    
}
