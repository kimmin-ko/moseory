package com.moseory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;
import com.moseory.domain.PageDTO;
import com.moseory.service.NoticeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
public class NoticeController {

	@Setter(onMethod_ = @Autowired)
	NoticeService service;

	@GetMapping("/noticeText")
	public void getnoticeText() {
		log.info("write the text");
	}

	// 게시글 작성하기
	@PostMapping("/noticeText")
	public String writeText(NoticeVO vo, RedirectAttributes rttr) throws Exception {
		log.info("write notice" + vo);
		service.create(vo);
		log.info(vo.getNO());
		rttr.addFlashAttribute("result", vo.getNO());
		// vo.getNo()가 인식이 안되는 문제가 있음... why?
		// create 자체에서 게시글을 만들어 주긴하지만
		// vo객체에는 저장되지 않기에
		return "redirect:/notice/noticeList"; // 도배를 막기 위해서 사용한다
	}


	// 게시글 조회하기
	@GetMapping({ "/noticeGet", "/noticeModify" })
	public void getNotice(@RequestParam("NO") int bno , @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("게시글 조회  or 게시글 삭제하기");
		model.addAttribute("board", service.read(bno));
	}

	// 게시글 수정하기
	@PostMapping("/noticeModify")
	public String noticeModify(@ModelAttribute NoticeVO vo, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("modify : " + vo);
		service.update(vo);
		rttr.addFlashAttribute("pageNum", cri.getPageNum());
		rttr.addFlashAttribute("amount", cri.getAmount());

		return "redirect:/notice/noticeList";
	}

	// 게시글 삭제하기
	
	//@GetMapping("/noticeDelete")
	@PostMapping("/noticeDelete")
	public String remove(@RequestParam("NO") int bno,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify" + bno);
		service.delete(bno);
		rttr.addFlashAttribute("pageNum", cri.getPageNum());
		rttr.addFlashAttribute("amount", cri.getAmount());
		return "redirect:/notice/noticeList";
	}

	@GetMapping("/noticeList")
	public void List(Criteria cri, Model model) {
		log.info("list:" + cri);
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageDTO(cri,123));
	}

}