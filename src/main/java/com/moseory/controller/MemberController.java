package com.moseory.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String join(@ModelAttribute MemberVO vo) {
	
	memberService.registerMember(vo);
	
	return "joinOk";
    }
    
}
