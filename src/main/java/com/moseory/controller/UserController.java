package com.moseory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.moseory.domain.CartVO;
import com.moseory.domain.LevelEnumMapperValue;
import com.moseory.domain.MemberVO;
import com.moseory.domain.WishListVO;
import com.moseory.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user/*") // 로그인 정보가 필요함
public class UserController {
    
    @Setter(onMethod_ = @Autowired)
    private UserService userService;
    
    //로그아웃 기능
    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
    	// 세션 전체를 날린다.
        session.invalidate();  
        return "redirect:/index"; 
    }
    
    // 로그인한 사용자의 정보와 JSON 변경 값
    private Map<String, Object> getUserJson(HttpServletRequest req) {
	HttpSession session = req.getSession();
	
	MemberVO member = (MemberVO)session.getAttribute("user");
	
	LevelEnumMapperValue levelMapper = new LevelEnumMapperValue(member.getLevel());
	
	String memberJson = new Gson().toJson(member);
	String levelJson = new Gson().toJson(levelMapper);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("member", member);
	map.put("memberJson", memberJson);
	map.put("levelJson", levelJson);
	
	return map;
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
	
	log.info("수정된 회원 정보 : " + ((MemberVO)memberMap.get("member")).getPwd_confirm_a());
	
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
	
	member = userService.readMember(member.getId());
	
	// 수정한 회원 정보를 세션에 업데이트
	session.setAttribute("user", member);
	
	return "redirect:/user/modifyOk";
    }
    
    // 회원 정보 수정 성공 페이지
    @GetMapping("/modifyOk")
    public void modifyOk() {
	
    }
    
    // 회원 탈퇴
    @GetMapping("/withdrawal")
    public void withdrawal() {
	
    }
    
    // 주문 페이지
    @GetMapping("/order")
    public void order(Model model, HttpServletRequest req) {
	Map<String, Object> memberMap = getUserJson(req);
	
	model.addAttribute("member", memberMap.get("member"));
	model.addAttribute("memberJson", memberMap.get("memberJson"));
	model.addAttribute("levelJson", memberMap.get("levelJson"));
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
	MemberVO member = (MemberVO)memberMap.get("member");
	String member_id = member.getId();
	
	List<CartVO> cartList = userService.getCartList(member_id);
	
	// 총 상품 구매 금액
	int total_prodcut_price = 0;
	// 회원의 할인율 : ex) 1%, 2% ..
	int discount = member.getLevel().getDiscount();
	// 장바구니의 담겨있는 상품들의 총 할인금액
	int product_discount = 0;
	
	// 장바구니 목록 상품들의 가격을 모두 더한 후에 할인금액을 제외 
	for(int i = 0; i < cartList.size(); i++) {
	    // 상품의 가격
	    int price = cartList.get(i).getProduct_price();
	    // 상품의 수량
	    int quantity = cartList.get(i).getQuantity();
	    // 할인 금액의 총합
	    product_discount += (price / 100) * discount * quantity;
	    // 상품 금액의 총합
	    total_prodcut_price += (price * quantity);
	}
	// 상품금액 - 할인금액 = 주문금액
	total_prodcut_price -= product_discount;
	
	model.addAttribute("total_product_price", total_prodcut_price);
	model.addAttribute("cartList", cartList);
	
	// 회원의 아이디를 이용해서 장바구니 목록 개수 조회
	int cartCount = userService.getCartCount(member_id);
	
	model.addAttribute("cartCount", cartCount);
    }
    
    //장바구니 상품 추가
    @PostMapping(value =  "/addToCart",
	    	 consumes = "application/json; charset=utf-8")
    public @ResponseBody ResponseEntity<String> addToCart(
	    @RequestBody Map<String, Object> param) {
	
	log.info("cart  : " + param.toString());
	
	int count = userService.addToCart(param);
	
	// count = 0 : 장바구니에 정상적으로 추가
	// count = 1 : 장바구니에 해당 상품 존재 
	return count == 0 ? new ResponseEntity<>("success"
		+ "", HttpStatus.OK)
			  : new ResponseEntity<>("duplication", HttpStatus.OK);
    }
    
    @PostMapping("/modifyCartQuantity")
    public String modifyCart(@RequestParam int no,
	    		     @RequestParam int quantity) {
	
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
	
	MemberVO member = (MemberVO)session.getAttribute("user");
	
	String member_id = member.getId();
	
	// 아이디를 이용해 WishList 를 가져옴
	WishListVO wishList = userService.getWishList(member_id);
	
	model.addAttribute("wishList", wishList);
    }
    
    // 관심상품 등록
    @PostMapping("/addWishList")
    public @ResponseBody ResponseEntity<String> addWishList(
	    @RequestBody Map<String, Object> param) {
	
	int result = userService.checkWishList(param);
	
	// 이미 관심상품으로 등록되어 있을 경우
	if(result == 1) {
	    return new ResponseEntity<>("fail", HttpStatus.OK);
	} else {
	    userService.addWishList(param);
	    return new ResponseEntity<>("success", HttpStatus.OK);
	}
    }
    
    // 위시리스트 삭제
    @PostMapping("/deleteWishList")
    public @ResponseBody ResponseEntity<String> deleteWidhList(
	    @RequestBody Map<String, Object> param) {
	
	int result = userService.deleteWishList(param);
	
	// result = 1, 삭제 성공
	if(result == 1) {
	    return new ResponseEntity<>("success", HttpStatus.OK);
	} else {
	    return new ResponseEntity<>("fail", HttpStatus.OK);
	}
	
    }

} // END







