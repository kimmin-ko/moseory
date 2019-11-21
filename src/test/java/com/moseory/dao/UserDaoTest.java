package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.Level;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.WishListVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDaoTest {
    
    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;

    @Setter(onMethod_ = @Autowired)
    private UserDao userDao;
    
    @Setter(onMethod_ = @Autowired)
    private ProductDao productDao;
    
    private MemberVO member1;
    
    @Before
    public void setUp() {
	member1 = new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", "15466", "address1", "address2", 
		"032-674-2030", "010-3725-9670", "kimmin@daum.net", LocalDate.of(1992, 02, 16), Level.BRONZE, 0, 0, LocalDate.now());
    }
    
    @Test
    public void testGetMember() {
	userDao.deleteMember(member1.getId());
	
	memberDao.insertMember(member1);
	
	log.info("member1 id : " + member1.getId());
	log.info("userDao.getMember id : " + userDao.getMember(member1.getId()).getId());
	
	assertThat(userDao.getMember(member1.getId()).getId(), is(member1.getId()));
    }
    
    @Test
    public void testUpdateMember() {
	userDao.deleteMember(member1.getId());
	
	memberDao.insertMember(member1);
	
	member1.setPwd_confirm_a("물통 modify");
	member1.setEmail("min00@daum.net");
	
	userDao.updateMember(member1);
	
	MemberVO modifyVO = userDao.getMember(member1.getId());
	
	assertThat(modifyVO.getPwd_confirm_a(), is("물통 modify"));
	assertThat(modifyVO.getEmail(), is("min00@daum.net"));
    }

    @Test
    public void testAddWishList() {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put("member_id", "admin00");
	param.put("product_code", 34);
	
	userDao.deleteWishList(param);
	
	userDao.addWishList(param);
    }
    
    @Test
    public void testGetWishList() {
	WishListVO vo = new WishListVO();
	vo = userDao.getWishList("admin11");
	
	vo.getProducts().stream().forEach(x -> log.info(x.toString()));
    }
    
    @Test
    public void testCheckWishList() {
	Map<String, Object> param1 = new HashMap<String, Object>();
	param1.put("member_id", "admin11");
	param1.put("product_code", 2);
	
	Map<String, Object> param2 = new HashMap<String, Object>();
	param2.put("member_id", "admin11");
	param2.put("product_code", 77);
	
	int result1 = userDao.checkWishList(param1);
	userDao.increaseWishCount((Integer)(param1.get("product_code")));
	int result2 = userDao.checkWishList(param2);
	
	log.info("result1: " + result1);
	log.info("result2 : " + result2);
    }
    
    @Test
    public void testAddToCart() {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put("member_id", "admin11");
	param.put("product_detail_no", 32);
	param.put("quantity", 1);
	
	userDao.addToCart(param);
    }
    
    @Test
    public void testIsExistProductInCart() {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put("member_id", "admin11");
	param.put("product_detail_no", 32);
	
	
	int result = userDao.isExistProductInCart(param);
	
	log.info("product count : " + result);
    }
    
    @Test
    public void testGetCartList() {
	String member_id = "admin00";
	List<CartVO> cartLsit = userDao.getCartList(member_id);
	
	cartLsit.stream().forEach(x -> log.info(x.toString()));
    }
    
    @Test
    public void testUpdateCartQuantity() {
	int no = 107;
	int quantity = 8;
	
	int result = userDao.updateCartQuantity(no, quantity);
	
	log.info("result : " + result);
	
	int count = userDao.getCartQuantity(107);
	
	log.info("count : " + count);
    }
    
    @Test
    public void testDeleteCartList() {
	List<Integer> cartList = new ArrayList<Integer>();
	cartList.add(91);
	cartList.add(92);
	
	log.info(userDao.getCartCount("admin00"));
	
	for(int no : cartList) {
	    userDao.deleteCartList(no);
	}
	
	log.info(userDao.getCartCount("admin00"));
    }	
    
    @Test
    public void testDeleteCartAll() {
	String member_id = "admin00";
	
	userDao.deleteCartAll(member_id);
	
	log.info(userDao.getCartCount(member_id));
    }
    
    @Test
    public void testGetAddedOrderInfo() {
	
	AddedOrderInfoVO vo = new AddedOrderInfoVO();
	vo = userDao.getAddedOrderInfo(1);
	
	log.info(vo.toString());
    }
    
    @Test
    public void testAddOrder() {
	String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
	int random = (int)(Math.random() * 8999999) + 1000000;
	String order_code = now + random;
	
	// 주문 등록
	OrderVO vo = new OrderVO();
	vo.setCode(order_code);
	vo.setMember_id("admin11");
	vo.setDelivery_charge(0);
	vo.setRecipient_name("김민");
	vo.setRecipient_zipcode(153534);
	vo.setRecipient_address1("경기도 부천시");
	vo.setRecipient_address2("1층 카페");
	vo.setRecipient_tel(null);
	vo.setRecipient_phone("010-8455-9966");
	vo.setRecipient_email("admin11@naver.com");
	vo.setMessage("배송메세지입니다.");
	vo.setPay_method("card");
	
	userDao.addOrder(vo);
	
	log.info("OrderVO : " + userDao.getOrder(vo.getCode()).toString());
	
	/* order_code, 
	 * product_code, 
	 * product_detail_no, 
	 * quantity, 
	 * amount, 
	 * discount, 
	 * point */
	List<Map<String, Integer>> details_list = new ArrayList<Map<String, Integer>>();
	
	Map<String, Integer> param1 = new HashMap<String, Integer>();
	param1.put("product_code", 102);
	param1.put("product_detail_no", 32);
	param1.put("quantity", 2);
	param1.put("amount", 60500);
	param1.put("discount", 1500);
	param1.put("point", 1500);
	
	Map<String, Integer> param2 = new HashMap<String, Integer>();
	param2.put("product_code", 102);
	param2.put("product_detail_no", 31);
	param2.put("quantity", 1);
	param2.put("amount", 30250);
	param2.put("discount", 750);
	param2.put("point", 750);
	
	Map<String, Integer> param3 = new HashMap<String, Integer>();
	param3.put("product_code", 103);
	param3.put("product_detail_no", 23);
	param3.put("quantity", 1);
	param3.put("amount", 38000);
	param3.put("discount", 1000);
	param3.put("point", 1000);
	
	details_list.add(param1);
	details_list.add(param2);
	details_list.add(param3);
	
	int total_point = 0;
	int total_amount = 0;
	
	for(int i = 0; i < details_list.size(); i++) {
	    Map<String, Integer> details = details_list.get(i);
	    
	    // 적립금, 총 구매금액
	    total_point += details.get("point");
	    total_amount += details.get("amount");
	    
	    // 상품 판매량 증가
	    userDao.updateOrderProduct(details.get("product_code"), details.get("quantity"));
	    
	    // 상품 재고 감소
	    userDao.updateOrderProductDetail(details.get("product_detail_no"), details.get("quantity"));
	    
	    // 주문 상세 등록 (order_code는 String 타입이라 구분해주었음)
	    userDao.addOrderDetail(order_code, details);
	}
	
	// 회원 적립금, 총 구매금액 증가
	userDao.updateOrderMember("admin11", total_point, total_amount);
	
    }
    
}

















