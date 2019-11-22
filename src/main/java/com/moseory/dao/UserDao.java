package com.moseory.dao;

import java.util.List;
import java.util.Map;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderVO;
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
    
    public void addToCart(Map<String, Object> param);
    
    public int isExistProductInCart(Map<String, Object> param);
    
    public List<CartVO> getCartList(String member_id);
    
    public int getCartCount(String member_id);
    
    public int updateCartQuantity(int no, int quantity);
    
    public int getCartQuantity(int no);
    
    public void deleteCartList(int no);
    
    public void deleteCartAll(String member_id);
    
    public AddedOrderInfoVO getAddedOrderInfo(int product_detail_no);
    
    /* 결제 완료 */
    public void updateOrderMember(String member_id, int total_point, int total_amount);
    
    public void updateOrderProduct(int product_code, int quantity);
    
    public void updateOrderProductDetail(int product_detail_no, int quantity);
    
    public void addOrder(OrderVO vo);
    
    public void addOrderDetail(String order_code, Map<String, Integer> details);
    
    public OrderVO getOrder(String code);
}



















