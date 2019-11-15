package com.moseory.service;

import java.util.List;
import java.util.Map;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
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
    
    public int addToCart(Map<String, Object> param);
    
    public List<CartVO> getCartList(String member_id);
    
    public int getCartCount(String member_id);
    
    public int modifyCartQuantity(int no, int quantity);
    
    public int getCartQuantity(int no);
    
    public void deleteCartOne(int no);
    
    public void deleteCartList(List<Integer> noList);
    
    public void deleteCartAll(String member_id);
    
    public List<AddedOrderInfoVO> getAddedOrderInfoList(List<Integer> product_detail_no, List<Integer> quantity);
}
