package com.moseory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.moseory.domain.MemberVO;
import com.moseory.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {
    
    @Setter(onMethod_ = @Autowired)
    private MemberService memberService;
    
    // 요청 시 해당 필드만 데이터 입력 허용
    @InitBinder
    public void InitBinder(WebDataBinder dataBinder) {
	dataBinder.setAllowedFields("id", "password", "pwd_confirm_*", "name", 
		"zipcode", "address*", "tel", "phone", "email", "birth");
    }
    
    @GetMapping("/login")
    public void login() {
	
    }
    
    @GetMapping("/findId")
    public void fintId() {
	
    }
    
    @GetMapping("/findPw")
    public void findPw() {
	
    }
    
    @GetMapping("/join")
    public void joinForm() {
	
    }
    
    @PostMapping("/join")
    public String join(@ModelAttribute("member") MemberVO vo) {
	
	log.info("get birth : " + vo.getBirth());
	
	memberService.registerMember(vo);
	
	// 회원 가입 응답 페이지에서 새로고침 시 데이터 등록이 중복되지 않도록 redirect를 이용
	// 시스템(session, DB)에 변화가 생기지 않는 단순조회(리스트, 검색)의 경우 forward 이용
	return "redirect:joinOk";
    }
    
    // 회원가입 시 아이디 중복  체크
    @GetMapping("/checkDuplId/{id}")
    @ResponseBody
    public String checkDuplId(@PathVariable("id") String id) {
	
	int result = memberService.isMember(id);
	
	if(result > 0) { // 중복인 경우
	    return "duplicaiton";
	} else { // 중복이 아닌 경우
	    return "";
	}
    }
    
    // 회원 가입 성공 페이지
    @GetMapping("/joinOk")
    public void joinOk() {
	
    }
    
    // 마이페이지
    @GetMapping("/myPage")
    public void myPage() {
	
    }
    
    // 회원 정보 수정
    @GetMapping("/modify")
    public void modify(@RequestParam String id, Model model) {
	MemberVO member = memberService.readMember(id);
	
	String memberJson = new Gson().toJson(member);
	
	model.addAttribute("member", member);
	// member 객체를 자바스크립트에서 사용하기 위해 JSON으로 전달
	model.addAttribute("memberJson", memberJson);
    }
    
    // 회원 탈퇴
    @GetMapping("/withdrawal")
    public void withdrawal() {
	
    }
    
}


























