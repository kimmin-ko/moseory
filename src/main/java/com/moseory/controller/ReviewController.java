package com.moseory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.moseory.domain.ReviewCriteria;
import com.moseory.domain.ReviewPageDTO;
import com.moseory.domain.ReviewVO;
import com.moseory.service.ReviewService;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j

@RequestMapping("/review")
public class ReviewController {
	
	private final ReviewService service;
	
	public ReviewController(ReviewService service) {
		this.service = service;
	}
	
	@GetMapping("/reviewText")
	public String reviewText() {
		return "/review/reviewText";
	}
	
	@PostMapping("/reviewText")
	public String reviewText(ReviewVO reviewVO, RedirectAttributes rttr) throws Exception {
		log.info("write notice" + reviewVO);
		service.insert(reviewVO);
		log.info(reviewVO.getNo());
		rttr.addFlashAttribute("reviewResult", reviewVO.getNo());
		return "redirect:/review/reviewList";
	}
	
	@GetMapping({ "/reviewGet", "/reviewModify" })
	public void getNotice(@RequestParam("no") int bno, @ModelAttribute("reviewCri") ReviewCriteria reviewCri, Model model) {
		log.info("게시글 조회  or 게시글 삭제하기");
		model.addAttribute("review", service.read(bno));
	}

	
	@PostMapping("/reviewModify")
	public String reviewModify(@ModelAttribute ReviewVO reviewVO, @ModelAttribute("reviewCri") ReviewCriteria reviewCri,RedirectAttributes rttr) {
		log.info("modify : " + reviewVO);
		service.update(reviewVO);
		log.info(reviewCri.getReviewPageNum());
		rttr.addAttribute("reviewPageNum", reviewCri.getReviewPageNum());
		rttr.addAttribute("reviewAmount", reviewCri.getReviewAmount());
		rttr.addAttribute("reviewType", reviewCri.getReviewType());
		rttr.addAttribute("reviewKeyword", reviewCri.getReviewKeyword());
		log.info("--------------------------------");
		return "redirect:/review/reviewList/";

	}
	
	
	@GetMapping("/reviewList")
	public void List(ReviewCriteria reviewCri, Model model) {
		log.info("list:" + reviewCri);
		model.addAttribute("Reviewlist", service.getListWithPaging(reviewCri));
		int total = service.totalCount(reviewCri);
		log.info("total" + total);
		model.addAttribute("reviewPageMaker", new ReviewPageDTO(reviewCri, total));
	}
	
	
	
	
	
}
