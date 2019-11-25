package com.moseory.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.UserDao;
import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.WishListVO;

import lombok.Setter;

@Service
public class UserServiceImpl implements UserService {
    
    @Setter(onMethod_ = @Autowired)
    private UserDao userDao;

    @Override
    public MemberVO readMember(String id) {
	return userDao.getMember(id);
    }

    @Override
    public void modifyMember(MemberVO vo) {
	userDao.updateMember(vo);
    }

    @Override
    public void removeMember(String id) {
	userDao.deleteMember(id);
    }

    @Override
    @Transactional
    public int addWishList(Map<String, Object> param) {
	userDao.increaseWishCount(Integer.valueOf((String) param.get("product_code")));
	
	return userDao.addWishList(param);
    }

    @Override
    @Transactional
    public int deleteWishList(Map<String, Object> param) {
	userDao.decreaseWishCount((Integer)(param.get("product_code")));
	
	return userDao.deleteWishList(param);
    }
    
    @Override
    public WishListVO getWishList(String member_id) {
	return userDao.getWishList(member_id);
    }

    @Override
    public int checkWishList(Map<String, Object> param) {
	return userDao.checkWishList(param);
    }

    @Override
    public int addToCart(Map<String, Object> param) {
	int count = userDao.isExistProductInCart(param);
	
	// 장바구니에 해당 상품이 없다면 INSERT INTO CART
	if (count == 0) {
	    userDao.addToCart(param);
	    return count;
	} else { // 해당 상품이 이미 존재한다면 INSERT 생략 
	    return count;
	}
    }

    @Override
    public List<CartVO> getCartList(String member_id) {
	return userDao.getCartList(member_id);
    }

    @Override
    public int getCartCount(String member_id) {
	return userDao.getCartCount(member_id);
    }

    @Override
    public int modifyCartQuantity(int no, int quantity) {
	return userDao.updateCartQuantity(no, quantity);
    }

    @Override
    public int getCartQuantity(int no) {
	return userDao.getCartQuantity(no);
    }

    @Override
    public void deleteCartOne(int no) {
	userDao.deleteCartList(no);
    }

    @Transactional
    @Override
    public void deleteCartList(List<Integer> noList) {
	// 삭제할 장바구니 상품 목록의 번호를 List로 가져와서 반복문으로 호출
	for(int no : noList) {
	    userDao.deleteCartList(no);
	}
    }

    @Override
    public void deleteCartAll(String member_id) {
	userDao.deleteCartAll(member_id);
    }

    @Override
    public List<AddedOrderInfoVO> getAddedOrderInfoList(List<Integer> pdNoList, List<Integer> quantityList) {
	List<AddedOrderInfoVO> orderList = new ArrayList<AddedOrderInfoVO>();
	
	AddedOrderInfoVO vo = null;
	
	// 주문 목록 정보에 수량도 같이 저장해준다
	for(int i = 0; i < pdNoList.size(); i++) {
	    vo = userDao.getAddedOrderInfo(pdNoList.get(i));
	    vo.setQuantity(quantityList.get(i));
	    orderList.add(vo);
	}
	
	return orderList;
    }

    @Transactional
    @Override
    public String addOrder(OrderVO vo, List<OrderDetailVO> details_list) {
	// 주문 번호 생성
	String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
	int random = (int)(Math.random() * 8999999) + 1000000;
	String order_code = now + random;
	
	vo.setCode(order_code);
	
	// 1. order 등록
	userDao.addOrder(vo);
	
	int used_point = vo.getUsed_point();
	
	for(int i = 0; i < details_list.size(); i++) {
	    OrderDetailVO details = details_list.get(i);
	    
	    // 디테일에 주문 번호 등록
	    details.setOrder_code(order_code);
	    
	    // 2. 상품 판매량 증가
	    userDao.updateOrderProduct(details.getProduct_code(), details.getQuantity());
	    
	    // 3. 상품 재고 감소
	    userDao.updateOrderProductDetail(details.getProduct_detail_no(), details.getQuantity());
	    
	    // 4. 주문 상세 등록
	    userDao.addOrderDetail(details);
	    
	    // 5. 주문한 상품 장바구니에서 삭제
	    userDao.deleteOrderCart(details.getProduct_detail_no(), vo.getMember_id());
	} // end for
	
	// 6. 회원의 사용한 적립금 감소
	userDao.updateOrderMember(vo.getMember_id(), used_point);
	
	return order_code;
    }

    @Override
    public OrderVO getOrder(String code) { 
	return userDao.getOrder(code);
    }

    @Override
    public List<OrderDetailVO> getOrderDetails(String order_code) {
	return userDao.getOrderDetail(order_code);
    }
    
    

}

















