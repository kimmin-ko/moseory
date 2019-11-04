package com.moseory.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.moseory.domain.LevelEnumMapperValue;
import com.moseory.domain.MemberVO;
import com.moseory.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/user/*") // 로그인 정보가 필요함
public class UserController {
    
    @Setter(onMethod_ = @Autowired)
    private UserService userService;
    
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
	Map<String, Object> memberMap = getUserJson(req);
	
	model.addAttribute("member", memberMap.get("member"));
	model.addAttribute("memberJson", memberMap.get("memberJson"));
	model.addAttribute("levelJson", memberMap.get("levelJson"));
    }
    
    //장바구니 상품 추가
    @PostMapping("/addCart")
    public void addCart() {
	
    }
    
    //로그아웃 기능
    @GetMapping("/logout")
    public String logout(HttpSession session, Model model) {
    	// 세션 전체를 날린다.
        session.invalidate();  
        return "redirect:/index"; 
    }

}
