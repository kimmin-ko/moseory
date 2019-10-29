package com.moseory.dao;

import java.util.List;
import java.util.Map;

import com.moseory.domain.MemberVO;

public interface MemberDao {
    
    public void insertMember(MemberVO vo);
    
    public void deleteAll();
    
    public int getCount();
    
    public MemberVO getMember(String id);
    
    public MemberVO loginProc(Map<String, Object>param);
    
    public List<Map<String, Object>> findIdProc(Map<String, Object>param);
    
}
