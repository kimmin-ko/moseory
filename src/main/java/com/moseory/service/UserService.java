package com.moseory.service;

import java.util.Map;

import com.moseory.domain.MemberVO;
import com.moseory.domain.WishListVO;

public interface UserService {
    
    public MemberVO readMember(String id);
    
    public void modifyMember(MemberVO vo);
    
    public void removeMember(String id);
    
    public int addWishList(Map<String, Object> param);
    
    public int deleteWishList(Map<String, Object> param);
    
    public WishListVO getWishList(String member_id);
    
    public int checkWishList(Map<String, Object> param);
}
