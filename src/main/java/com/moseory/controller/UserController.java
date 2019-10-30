package com.moseory.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    
    // 마이페이지
    @GetMapping("/myPage")
    public String myPage(Model model, HttpServletRequest req) {
	HttpSession session = req.getSession();
	
	MemberVO member = (MemberVO)session.getAttribute("user");
	log.info("session user : " + member.toString());
	LevelEnumMapperValue levelMapper = new LevelEnumMapperValue(member.getLevel());
	
	String memberJson = new Gson().toJson(member);
	String levelJson = new Gson().toJson(levelMapper);
	
	// member 객체를 자바스크립트에서 사용하기 위해 JSON으로 전달
	model.addAttribute("memberJson", memberJson);
	model.addAttribute("levelJson", levelJson);
	
	return "/user/myPage";
    }
    
    // 회원 정보 수정 페이지
    @GetMapping("/modify")
    public String modify(Model model, HttpServletRequest req) {
	HttpSession session = req.getSession();
	
	MemberVO member = (MemberVO)session.getAttribute("user");
	LevelEnumMapperValue levelMapper = new LevelEnumMapperValue(member.getLevel());
	
	String memberJson = new Gson().toJson(member);
	String levelJson = new Gson().toJson(levelMapper);
	
	model.addAttribute("member", member);
	// member 객체를 자바스크립트에서 사용하기 위해 JSON으로 전달
	model.addAttribute("memberJson", memberJson);
	model.addAttribute("levelJson", levelJson);
	
	return "/user/modify";
    }
    
    // 회원 정보 수정
    @PostMapping("/modify")
    public String modify(@ModelAttribute MemberVO member) {
	log.info("modify member : " + member.getPwd_confirm_a());
	userService.modifyMember(member);
	return "redirect:/user/modifyOk";
    }
    
    @GetMapping("/modifyOk")
    public void modifyOk() {
	
    }
    
    // 회원 탈퇴
    @GetMapping("/withdrawal")
    public void withdrawal() {
	
    }
    
}
