package com.moseory.service;

import java.util.List;
import java.util.Map;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderListCri;
import com.moseory.domain.OrderListVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.ReviewRegVO;
import com.moseory.domain.WishListVO;

public interface UserService {
    
    public MemberVO readMember(String id);
    
    public void modifyMember(MemberVO vo);
    
    public void withdrawal(String id);
    
    public boolean checkPwd(String id, String input_password);
    
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
    
    public String addOrder(OrderVO vo, List<OrderDetailVO> details_list);

    public OrderVO getOrder(String code);
    
    public List<OrderDetailVO> getOrderDetails(String order_code);
    
    public List<OrderListVO> getOrderList(OrderListCri orderCri);
    
    public int getOrderListCount(OrderListCri orderCri);
    
    public void orderCancel(String order_code, String member_id);
    
    public OrderListVO getExchangeModalInfo(String order_code, int product_detail_no);
    
    public void exchangeRequest(String  order_code, int product_detail_no, int e_product_detail_no);
    
    public void returnRequest(String  order_code, int product_detail_no);
    
    public void orderConfirm(Map<String, Object> param);
    
    public void registReview(ReviewRegVO vo);
}









