package com.moseory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moseory.domain.MemberVO;
import com.moseory.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {
    
    @Setter(onMethod_ = @Autowired)
    private MemberService memberService;

    @GetMapping("/login")
    public void login() {
	
    }
    
    @PostMapping("/loginProc")
    public String loginProc(@RequestParam Map<String, Object> param, HttpServletRequest req, HttpServletResponse res, Model model) {
    	log.info("Contorller loginProc param ["+ param.toString() +"]");
    	MemberVO vo = memberService.loginProc(param);
    	
    	if(vo == null) {
    		model.addAttribute("msg", "일치하는 회원 정보가 없습니다.");
    		return "member/login";
    	}else {
    		model.addAttribute("user", vo);
    		return "index";
    	}
    }

    @GetMapping("/findId")
    public void fintId() {
    	
    }
    
    @PostMapping("/findIdProc")
    public String fintIdProc(@RequestParam Map<String, Object> param, Model model) {
    	log.info("Contorller findIdProc param ["+ param.toString() +"]");
    	
    	List<Map<String,Object>> findIds = new ArrayList<Map<String,Object>>(); 
    	findIds = memberService.findIdProc(param);
    	
    	if(findIds.isEmpty()) {
    		model.addAttribute("msg", "입력하신 정보로 검색된 결과가 없습니다.");
    		return "/member/findId";
    	}else {
    		model.addAttribute("findIds", findIds);
    		model.addAttribute("findIdCount", findIds.size());
    		return "/member/findIdProc";    		
    	}
    }
    
    @GetMapping("/findPw")
    public void findPw() {
	
    }
    
    @GetMapping("/join")
    public void joinForm() {
	
    }
    
    @PostMapping("/join")
    public String join() {
	return "";
    }
    
}
