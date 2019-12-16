package com.moseory.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.UserDao;
import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderListCri;
import com.moseory.domain.OrderListVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.ReviewRegVO;
import com.moseory.domain.WishListVO;
import com.moseory.util.ImageUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService {

	@Setter(onMethod_ = @Autowired)
	private UserDao userDao;
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public MemberVO readMember(String id) {
		return userDao.getMember(id);
	}

	@Override
	public void modifyMember(MemberVO vo) {
		// 수정된 패스워드를 암호화한다
		String encodedPassword = bcryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodedPassword);
		userDao.updateMember(vo);
	}

	@Override
	public void withdrawal(String id) {
		userDao.withdrawal(id);
	}

	@Override
	public String checkPwd(String id) {
		return userDao.checkPwd(id);
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
		userDao.decreaseWishCount((Integer) (param.get("product_code")));

		return userDao.deleteWishList(param);
	}

	@Override
	public WishListVO getWishList(String member_id) {
		WishListVO vo = userDao.getWishList(member_id);
		if (vo != null) {
			for (int i = 0; i < vo.getProducts().size(); i++) {
				vo.getProducts().get(i)
						.setFile_path(ImageUtil.convertImagePath(vo.getProducts().get(i).getFile_path()));
			}
		}
		return vo;
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
		List<CartVO> vo_list = userDao.getCartList(member_id);

		for (int i = 0; i < vo_list.size(); i++) {
			vo_list.get(i).setFile_path(ImageUtil.convertImagePath(vo_list.get(i).getFile_path()));
		}

		return vo_list;
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
		for (int no : noList) {
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
		for (int i = 0; i < pdNoList.size(); i++) {
			vo = userDao.getAddedOrderInfo(pdNoList.get(i));
			vo.setQuantity(quantityList.get(i));
			vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
			orderList.add(vo);
		}

		return orderList;
	}

	@Transactional
	@Override
	public String addOrder(OrderVO vo, List<OrderDetailVO> details_list) {
		// 주문 번호 생성
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		int random = (int) (Math.random() * 8999999) + 1000000;
		String order_code = now + random;

		vo.setCode(order_code);

		// 1. order 등록
		userDao.addOrder(vo);

		int used_point = vo.getUsed_point();

		for (int i = 0; i < details_list.size(); i++) {
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

		List<OrderDetailVO> vo_list = userDao.getOrderDetail(order_code);

		for (int i = 0; i < vo_list.size(); i++) {
			OrderDetailVO vo = vo_list.get(i);
			vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
		}

		return vo_list;
	}

	@Override
	public List<OrderListVO> getOrderList(OrderListCri orderCri) {

		List<OrderListVO> vo_list = userDao.getOrderList(orderCri);
		for (int i = 0; i < vo_list.size(); i++) {
			OrderListVO vo = vo_list.get(i);
			vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
		}

		return vo_list;
	}

	@Override
	public int getOrderListCount(OrderListCri orderCri) {
		return userDao.getOrderListCount(orderCri);
	}

	@Transactional
	@Override
	public void orderCancel(String order_code, String member_id) {
		// 1. 주문 번호를 이용해 주문 취소에 필요한 정보를 조회
		List<OrderDetailVO> orderDetailList = userDao.getOrderDetail(order_code);

		// 2. 해당 주문의 상태를 '주문 취소'로 변경
		userDao.updateOrderState(orderDetailList.get(0).getOrder_code(), "주문 취소");

		for (OrderDetailVO orderDetail : orderDetailList) {
			// 3. 해당 상품의 판매량을 주문 수량만큼 감소
			userDao.decreaseSaleCount(orderDetail.getProduct_code(), orderDetail.getQuantity());
			// 4. 해당 상품의 재고를 주문 수량만큼 증가
			userDao.increaseProductStock(orderDetail.getProduct_detail_no(), orderDetail.getQuantity());
			// 5. 회원이 주문에 사용한 적립금 반환
			userDao.increaseMemberPoint(member_id, orderDetail.getPoint());
		}
	}

	@Override
	public OrderListVO getExchangeModalInfo(String order_code, int product_detail_no) {
		OrderListVO vo = userDao.getExchangeModalInfo(order_code, product_detail_no);
		vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
		return vo;
	}

	// 구매 확정
	@Transactional
	@Override
	public void orderConfirm(Map<String, Object> param) {
		String order_code = (String) param.get("order_code");
		int product_detail_no = Integer.parseInt(param.get("product_detail_no") + "");

		String member_id = (String) param.get("member_id");
		int point = Integer.parseInt(param.get("point") + "");
		int amount = Integer.parseInt(param.get("amount") + "");

		userDao.changeOrderState(order_code, product_detail_no, "구매 확정");

		userDao.increasePointAndAmount(member_id, point, amount);
	}

	@Transactional
	@Override
	public void registReview(ReviewRegVO vo) {

		// 사용자의 적립금 500 증가
		userDao.increaseMemberPoint(vo.getMember_id(), 500);

		// 리뷰 등록
		userDao.registReview(vo);

		// 주문 상태 변경
		userDao.changeOrderState(vo.getOrder_code(), vo.getProduct_detail_no(), "구매 확정 ");

		// 상품 코드 구하기
		int product_code = userDao.getProductCode(vo.getProduct_detail_no());

		// 상품의 리뷰 평점 합계 구하기
		int sumGrade = 0;
		List<Integer> gradeList = userDao.getProductReviewGrade(product_code);
		for (int grade : gradeList) {
			sumGrade += grade;
		}

		// 상품의 리뷰 개수 구하기
		int reviewCount = userDao.getReviewCount(product_code);

		// 상품 평점 구하기
		double avgGrade = Math.floor(((double) sumGrade / reviewCount) * 10) / 10.0;

		// 상품의 평점 최신화
		userDao.updateProductGrade(product_code, avgGrade);
	}

	@Override
	public void exchangeRequest(String order_code, int product_detail_no, int e_product_detail_no) {
		userDao.exchangeRequest(order_code, product_detail_no, e_product_detail_no);
	}

	@Override
	public void returnRequest(String order_code, int product_detail_no) {
		userDao.changeOrderState(order_code, product_detail_no, "환불 요청");
	}

}
