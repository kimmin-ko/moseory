package com.moseory.dao;

import java.util.List;
import java.util.Map;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderListCri;
import com.moseory.domain.OrderListVO;
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
    public void updateOrderMember(String member_id, int used_point);
    
    public void updateOrderProduct(int product_code, int quantity);
    
    public void updateOrderProductDetail(int product_detail_no, int quantity);
    
    public void deleteOrderCart(int product_detail_no, String member_id);
    
    public void addOrder(OrderVO vo);
    
    public void addOrderDetail(OrderDetailVO details);
    
    public OrderVO getOrder(String code);
    
    public List<OrderDetailVO> getOrderDetail(String order_code);
    
    /* 주문 목록 */
    public List<OrderListVO> getOrderList(OrderListCri cri);
    
    /* 주문 취소 */
    public void updateOrderState(String order_code, String state);
    
    public void decreaseSaleCount(int product_code, int quantity);
    
    public void increaseProductStock(int product_detail_no, int quantity);
    
    public void increaseMemberPoint(String member_id, int used_point); 
    
    /* 교환 모달 주문 정보 */
    public OrderListVO getExchangeModalInfo(String order_code, int product_detail_no); 
    
    public void updateOrderStateToExchange(String  order_code, int product_detail_no, String state);\
    
    /* 구매 확정 */
    public void increasePointAndAmount(String member_id, int point, int amount);
    
    
}



















