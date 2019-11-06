package com.moseory.dao;

import java.util.Map;

import com.moseory.domain.MemberVO;
import com.moseory.domain.WishListVO;

public interface UserDao {
    
    public MemberVO getMember(String id);
    
    public void updateMember(MemberVO vo);
    
    public void deleteMember(String id);
    
    public int addWishList(Map<String, Object> param);
    
    public void increaseWishCount(int product_code);
    
    public int deleteWishList(Map<String, Object> param);
    
    public void decreaseWishCount(int product_code); 
    
    public WishListVO getWishList(String member_id);
    
    public int checkWishList(Map<String, Object> param);
}
