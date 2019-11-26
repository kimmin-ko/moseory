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
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderListCri;
import com.moseory.domain.OrderListVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.WishListVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
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
		"032-674-2030", "010-3725-9670", "kimmin@daum.net", LocalDate.of(1992, 02, 16), Level.BRONZE, 0, 0,
		LocalDate.now());
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
	userDao.increaseWishCount((Integer) (param1.get("product_code")));
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

	for (int no : cartList) {
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
	int random = (int) (Math.random() * 8999999) + 1000000;
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
	vo.setUsed_point(3000);

	userDao.addOrder(vo);

	log.info("OrderVO : " + userDao.getOrder(vo.getCode()).toString());

	/*
	 * order_code, product_code, product_detail_no, quantity, amount, discount,
	 * point
	 */
	List<OrderDetailVO> details_list = new ArrayList<OrderDetailVO>();

	OrderDetailVO[] param = new OrderDetailVO[3];

	param[0] = new OrderDetailVO();
	param[0].setProduct_code(102);
	param[0].setProduct_detail_no(32);
	param[0].setQuantity(2);
	param[0].setAmount(60500);
	param[0].setDiscount(1500);
	param[0].setPoint(1500);

	param[1] = new OrderDetailVO();
	param[1].setProduct_code(102);
	param[1].setProduct_detail_no(31);
	param[1].setQuantity(1);
	param[1].setAmount(30250);
	param[1].setDiscount(750);
	param[1].setPoint(750);

	param[2] = new OrderDetailVO();
	param[2].setProduct_code(103);
	param[2].setProduct_detail_no(23);
	param[2].setQuantity(1);
	param[2].setAmount(38000);
	param[2].setDiscount(1000);
	param[2].setPoint(1000);

	for (int i = 0; i < param.length; i++)
	    details_list.add(param[i]);

	int used_point = vo.getUsed_point();

	for (int i = 0; i < details_list.size(); i++) {
	    OrderDetailVO details = details_list.get(i);

	    details.setOrder_code(order_code);

	    // 상품 판매량 증가
	    userDao.updateOrderProduct(details.getProduct_code(), details.getQuantity());

	    // 상품 재고 감소
	    userDao.updateOrderProductDetail(details.getProduct_detail_no(), details.getQuantity());

	    // 주문 상세 등록 (order_code는 String 타입이라 구분해주었음)
	    userDao.addOrderDetail(details);
	} // end for

	// 회원의 사용한 적립금 감소
	userDao.updateOrderMember("admin11", used_point);
    }

    @Test
    public void testGetOrder() {
	String order_code = "201911221001277962271";
	OrderVO vo = userDao.getOrder(order_code);

	log.info(vo.toString());

	List<OrderDetailVO> detail_list = userDao.getOrderDetail(order_code);

	detail_list.stream().forEach(x -> log.info(x.toString()));
    }

    @Test
    public void testStringToLocalDateTime() {
	String order_code = "201911221001277962271";
	OrderVO vo = userDao.getOrder(order_code);

	String order_date = vo.getOrder_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

	log.info("order_date : " + order_date);

	LocalDateTime d = LocalDateTime.parse(order_date, DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));

	String formatted_order_date = d.toString();

	log.info("formatted_order_date : " + formatted_order_date);
    }

    @Test
    public void testGetOrderList() {
	//OrderListCri cri = new OrderListCri("admin11", LocalDate.of(2019, 11, 21), LocalDate.of(2019, 11, 25), "배송 준비 중");
	OrderListCri cri = new OrderListCri("admin11", null, null, "배송 준비 중");

	List<OrderListVO> voList = userDao.getOrderList(cri);

	for (OrderListVO vo : voList) {
	    log.info(vo.toString());
	}
    }
    
    @Test
    public void testOrderCancel() {
	List<OrderDetailVO> orderDetailList = userDao.getOrderDetail("201911251125472528058");
	
	// before
	for(OrderDetailVO orderDetail : orderDetailList) {
	    OrderVO order = userDao.getOrder(orderDetail.getOrder_code());
	    ProductVO product = productDao.getProduct(orderDetail.getProduct_code());
	    int stock = productDao.getProductStock(orderDetail.getProduct_detail_no());
	    MemberVO member = userDao.getMember("test55");
	    
	    log.info("before order_state : " + order.getState());
	    log.info("before sale_count : " + product.getSale_count());
	    log.info("before stock : " + stock);
	    log.info("before point : " + member.getPoint());
	}
	
	userDao.updateOrderStateToCancel(orderDetailList.get(0).getOrder_code());
	
	for(OrderDetailVO orderDetail : orderDetailList) {
	    userDao.decreaseSaleCount(orderDetail.getProduct_code(), orderDetail.getQuantity());
	    userDao.increaseProductStock(orderDetail.getProduct_detail_no(), orderDetail.getQuantity());
	    userDao.increaseMemberPoint("test55", 500);
	}
	
	// after
	for(OrderDetailVO orderDetail : orderDetailList) {
	    OrderVO order = userDao.getOrder(orderDetail.getOrder_code());
	    ProductVO product = productDao.getProduct(orderDetail.getProduct_code());
	    int stock = productDao.getProductStock(orderDetail.getProduct_detail_no());
	    MemberVO member = userDao.getMember("test55");

	    log.info("after order_state : " + order.getState());
	    log.info("after sale_count : " + product.getSale_count());
	    log.info("after stock : " + stock);
	    log.info("after point : " + member.getPoint());
	}
    }

}
