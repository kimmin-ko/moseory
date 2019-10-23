package com.moseory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.moseory.service.MemberService;

import lombok.Setter;

@Controller
@RequestMapping("/member/*")
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
    public String join() {
	return "";
    }
    
}
