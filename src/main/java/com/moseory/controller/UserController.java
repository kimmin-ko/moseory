package com.moseory.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
import com.moseory.domain.LevelEnumMapperValue;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderDetailVO;
import com.moseory.domain.OrderListCri;
import com.moseory.domain.OrderListVO;
import com.moseory.domain.OrderVO;
import com.moseory.domain.PageDTO;
import com.moseory.domain.ReviewRegVO;
import com.moseory.domain.WishListVO;
import com.moseory.service.ProductService;
import com.moseory.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user/*") // 로그인 정보가 필요함
public class UserController {

	@Setter(onMethod_ = @Autowired)
	private UserService userService;

	@Setter(onMethod_ = @Autowired)
	private ProductService productService;

	// 로그아웃 기능
	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		// 세션 전체를 날린다.
		session.invalidate();
		return "redirect:/index";
	}

	// 로그인한 사용자의 정보와 JSON 변경 값
	private Map<String, Object> getUserJson(HttpServletRequest req) {
		HttpSession session = req.getSession();

		MemberVO member = (MemberVO) session.getAttribute("user");

		LevelEnumMapperValue levelMapper = new LevelEnumMapperValue(member.getLevel());

		String memberJson = new Gson().toJson(member);
		String levelJson = new Gson().toJson(levelMapper);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("member", member);
		map.put("memberJson", memberJson);
		map.put("levelJson", levelJson);
		
		return map;
	}

	// 회원의 정보가 수정된 후 세션 업데이트
	private void updateMember(HttpSession session, String id) {
		MemberVO member = userService.readMember(id);

		// 수정한 회원 정보를 세션에 업데이트
		session.setAttribute("user", member);
	}

	// 마이페이지
	@GetMapping("/myPage")
	public String myPage(Model model, HttpServletRequest req) {
		Map<String, Object> memberMap = getUserJson(req);

		model.addAttribute("member", memberMap.get("member"));
		// member 객체를 자바스크립트에서 사용하기 위해 JSON으로 전달
		model.addAttribute("memberJson", memberMap.get("memberJson"));
		model.addAttribute("levelJson", memberMap.get("levelJson"));

		return "/user/myPage";
	}

	// 회원 정보 수정 페이지
	@GetMapping("/modify")
	public String modify(Model model, HttpServletRequest req) {
		Map<String, Object> memberMap = getUserJson(req);

		model.addAttribute("member", memberMap.get("member"));
		// member 객체를 자바스크립트에서 사용하기 위해 JSON으로 전달
		model.addAttribute("memberJson", memberMap.get("memberJson"));
		model.addAttribute("levelJson", memberMap.get("levelJson"));

		return "/user/modify";
	}
	
	// 회원 정보 수정
	@PostMapping("/modifyProc")
	public String modify(@ModelAttribute MemberVO member, HttpSession session) {

		userService.modifyMember(member);

		log.info(member.getPassword());
		
		updateMember(session, member.getId());

		return "redirect:/user/modifyOk";
	}

	// 회원 정보 수정 성공 페이지
	@GetMapping("/modifyOk")
	public void modifyOk() {

	}

	// 비밀번호 체크
	@GetMapping("/checkPwd/{id}/{input_password}")
	public @ResponseBody ResponseEntity<String> checkPwd(
			@PathVariable("id") String id, 
			@PathVariable("input_password") String input_password) {

		boolean checkEqualPassword = userService.checkPwd(id, input_password);

		return checkEqualPassword ? new ResponseEntity<>("success", HttpStatus.OK)
								  : new ResponseEntity<>("failure", HttpStatus.OK);
	}

	// 회원 탈퇴
	@PostMapping("/withdrawal")
	public String withdrawal(@RequestParam("id") String id, HttpSession session, RedirectAttributes rttr) {

		userService.withdrawal(id);

		session.invalidate();

		rttr.addFlashAttribute("withdrawal_result", "탈퇴 처리가 완료되었습니다.");

		return "redirect:/index";
	}

	// 주문 페이지
	@GetMapping("/order")
	public void order(Model model, HttpServletRequest req, @RequestParam List<Integer> product_detail_no_list,
			@RequestParam List<Integer> quantity_list) {

		// 로그인 되어있는 회원의 정보
		Map<String, Object> memberMap = getUserJson(req);

		MemberVO member = (MemberVO) memberMap.get("member");

		model.addAttribute("member", member);
		model.addAttribute("memberJson", memberMap.get("memberJson"));
		model.addAttribute("levelJson", memberMap.get("levelJson"));

		// 주문 목록에 추가된 상품 리스트
		List<AddedOrderInfoVO> addedOrderInfoList = new ArrayList<AddedOrderInfoVO>();

		// 디테일 번호와 수량을 같이 전달해줘서 같은 VO에 저장함
		addedOrderInfoList = userService.getAddedOrderInfoList(product_detail_no_list, quantity_list);
		model.addAttribute("addedOrderInfoList", addedOrderInfoList);
	}

	private List<OrderDetailVO> details_list = new ArrayList<OrderDetailVO>();

	// details 받아오기
	@PostMapping("/addDetailsList")
	public void addDetailsList(@RequestBody OrderDetailVO details) {
		details_list.add(details);
	}

	// 주문 등록
	@PostMapping("/addOrder")
	public String addOrderPost(@ModelAttribute OrderVO vo, HttpSession session, RedirectAttributes rttr) {

		String order_code = userService.addOrder(vo, details_list);

		// 회원이 적립금을 사용했으니 세션 최신화
		updateMember(session, vo.getMember_id());

		// 주문 완료 페이지에 주문 번호를 넘겨준다
		rttr.addAttribute("order_code", order_code);

		if (details_list != null)
			details_list.clear();

		return "redirect:/user/orderCompletion";
	}

	// 주문 완료 페이지
	@GetMapping("/orderCompletion")
	public void orderCompletion(@RequestParam String order_code, Model model) {
		// 주문 번호를 통해 페이지에 필요한 정보를 조회
		OrderVO order = userService.getOrder(order_code);
		List<OrderDetailVO> orderDetailList = userService.getOrderDetails(order_code);

		model.addAttribute("order", order);
		model.addAttribute("orderDetailList", orderDetailList);
	}

	// orderList 페이지
	@GetMapping("/orderList")
	public void orderList(HttpSession session, Model model, @ModelAttribute OrderListCri orderCri) {

		MemberVO member = (MemberVO) session.getAttribute("user");

		if (orderCri.getState() == null) /* 페이지 처음 호출 시 */
			// orderList 페이지 호출 시 전체 기간, 전체 상태, 1페이지로 초기화
			orderCri = new OrderListCri(member.getId(), null, null, "전체 상태", 1, 10);
		else { /* 검색 조건으로 조회 시 */
			// 접속중인 id로 초기화 (다른 데이터는 클라이언트에서 넘어옴)
			orderCri.setMember_id(member.getId());
		}

		List<OrderListVO> orderList = userService.getOrderList(orderCri);

		model.addAttribute("orderList", orderList);
		model.addAttribute("pageMaker", new PageDTO(orderCri, userService.getOrderListCount(orderCri)));
	}

	// 주문 취소
	@PostMapping("/orderCancel")
	public String orderCancel(@RequestParam String order_code, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("user");

		userService.orderCancel(order_code, member.getId());

		// 사용자 적립금 반환 세션에 적용
		updateMember(session, member.getId());

		return "redirect:/user/orderList";
	}

	// 교환 요청
	@PostMapping("/exchangeRequest")
	public String exchangeRequest(@RequestParam String order_code, @RequestParam int product_detail_no,
			@RequestParam int e_product_detail_no) {

		userService.exchangeRequest(order_code, product_detail_no, e_product_detail_no);

		return "redirect:/user/orderList";
	}

	// 환불 요청
	@PostMapping("/returnRequest")
	public String returnRequest(@RequestParam String order_code, @RequestParam int product_detail_no) {

		userService.returnRequest(order_code, product_detail_no);

		return "redirect:/user/orderList";
	}

	// 교환 모달 주문 정보
	@GetMapping(value = "/getExchangeModalInfo/{order_code}/{product_detail_no}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<OrderListVO> getExchangeModalInfo(@PathVariable("order_code") String order_code,
			@PathVariable("product_detail_no") int product_detail_no) {

		OrderListVO orderList = userService.getExchangeModalInfo(order_code, product_detail_no);

		return orderList != null ? new ResponseEntity<>(orderList, HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 구매 확정
	@PostMapping("/orderConfirm")
	public String orderConfirm(@RequestParam Map<String, Object> param, HttpSession session) {
		// order_code, product_detail_no, point, amount
		MemberVO member = (MemberVO) session.getAttribute("user");

		param.put("member_id", member.getId());

		userService.orderConfirm(param);

		// 사용자 적립금 증가, 총 구매금액 증가 세션에 적용
		updateMember(session, member.getId());

		return "redirect:/user/orderList";
	}

	// 리뷰 등록
	@PostMapping("/registReview")
	public @ResponseBody ResponseEntity<String> registReview(@RequestBody ReviewRegVO vo) {

		userService.registReview(vo);

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	// 장바구니 페이지
	@GetMapping("/cart")
	public void cart(Model model, HttpServletRequest req) {
		// 접속중인 회원의 정보를 가져와서 JSON 으로 변환하여 넘겨줌
		Map<String, Object> memberMap = getUserJson(req);

		model.addAttribute("member", memberMap.get("member"));
		model.addAttribute("memberJson", memberMap.get("memberJson"));
		model.addAttribute("levelJson", memberMap.get("levelJson"));

		// 회원의 아이디를 이용해서 장바구니 목록 조회
		MemberVO member = (MemberVO) memberMap.get("member");
		String member_id = member.getId();

		List<CartVO> cartList = userService.getCartList(member_id);
		model.addAttribute("cartList", cartList);

		// 회원의 아이디를 이용해서 장바구니 목록 개수 조회
		int cartCount = userService.getCartCount(member_id);
		model.addAttribute("cartCount", cartCount);
	}

	// 장바구니 상품 추가
	@PostMapping(value = "/addToCart", consumes = "application/json; charset=utf-8")
	public @ResponseBody ResponseEntity<String> addToCart(@RequestBody Map<String, Object> param) {

		int count = userService.addToCart(param);

		// count = 0 : 장바구니에 정상적으로 추가
		// count = 1 : 장바구니에 해당 상품 존재
		return count == 0 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>("duplication", HttpStatus.OK);
	}

	@PostMapping("/modifyCartQuantity")
	public String modifyCart(@RequestParam int no, @RequestParam int quantity) {

		userService.modifyCartQuantity(no, quantity);

		return "redirect:/user/cart";
	}

	@PostMapping("/deleteCartOne")
	public String deleteCartOne(@RequestParam int no) {

		userService.deleteCartOne(no);

		return "redirect:/user/cart";
	}

	@PostMapping("/deleteCartList")
	public String deleteCartList(@RequestParam List<Integer> noList) {

		userService.deleteCartList(noList);

		return "redirect:/user/cart";
	}

	@PostMapping("/deleteCartAll")
	public String deleteCartAll(@RequestParam String member_id) {

		userService.deleteCartAll(member_id);

		return "redirect:/user/cart";
	}

	// 관심상품 페이지
	@GetMapping("/wishList")
	public void wishList(HttpServletRequest req, Model model) {
		// 로그인한 사용자의 아이디를 얻어옴
		HttpSession session = req.getSession();

		MemberVO member = (MemberVO) session.getAttribute("user");

		String member_id = member.getId();

		// 아이디를 이용해 WishList 를 가져옴
		WishListVO wishList = userService.getWishList(member_id);

		model.addAttribute("wishList", wishList);
	}

	// 관심상품 등록
	@PostMapping("/addWishList")
	public @ResponseBody ResponseEntity<String> addWishList(@RequestBody Map<String, Object> param) {

		int result = userService.checkWishList(param);

		// 이미 관심상품으로 등록되어 있을 경우
		if (result == 1) {
			return new ResponseEntity<>("fail", HttpStatus.OK);
		} else {
			userService.addWishList(param);
			return new ResponseEntity<>("success", HttpStatus.OK);
		}
	}

	// 위시리스트 삭제
	@PostMapping("/deleteWishList")
	public @ResponseBody ResponseEntity<String> deleteWidhList(@RequestBody Map<String, Object> param) {

		int result = userService.deleteWishList(param);

		// result = 1, 삭제 성공
		if (result == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("fail", HttpStatus.OK);
		}

	}

} // END
