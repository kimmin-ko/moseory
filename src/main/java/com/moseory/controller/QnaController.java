package com.moseory.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moseory.domain.Criteria;
import com.moseory.domain.PageDTO;
import com.moseory.domain.QnaVO;
import com.moseory.service.QnaService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/qna")
public class QnaController {
    
    @Setter(onMethod_ = @Autowired)
    private QnaService qnaService;
    
    @GetMapping("/qnaList")
    public void qnaList(Criteria cri, Model model) {
	log.info("cri : " + cri);
	model.addAttribute("qnaList", qnaService.getList(cri));
	model.addAttribute("pageMaker", new PageDTO(cri, qnaService.getQnaCount(cri)));
    }
    
    // Q&A 작성 페이지
    @GetMapping("/qnaRegist")
    public void qnaRegist() {
	
    }
    
    // Q&A 등록
    @PostMapping("/qnaRegist")
    public String qnaRegistPost(@ModelAttribute QnaVO qnaVO, Model model) {
	
	log.info(qnaVO);
	
	qnaService.registQna(qnaVO);
	
	return "redirect:/qna/qnaList";
    }
    
    // Q&A 조회
    @GetMapping("/qnaGet")
    public void qnaGet(@RequestParam int no) {
	
    }
    
}



