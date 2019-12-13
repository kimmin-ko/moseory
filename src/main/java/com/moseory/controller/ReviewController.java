package com.moseory.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.moseory.domain.MemberVO;
import com.moseory.domain.ReviewCriteria;
import com.moseory.domain.ReviewPageDTO;
import com.moseory.domain.ReviewVO;
import com.moseory.service.ReviewService;
import lombok.extern.log4j.Log4j;
import javax.servlet.http.HttpSession;

@Controller
@Log4j

@RequestMapping("/review")
public class ReviewController {

	private final ReviewService service;

	public ReviewController(ReviewService service) {
		this.service = service;
	}

	@GetMapping("/reviewModal")
	public String modal() {
		return "/review/reviewModal";
	}

	@GetMapping("/reviewText")
	public String reviewText() {
		return "/review/reviewText";
	}

	@PostMapping("/reviewText")
	public @ResponseBody String reviewText(ReviewVO reviewVO, RedirectAttributes rttr) throws Exception {
		log.info("write notice" + reviewVO);
		service.insert(reviewVO);
		log.info(reviewVO.getNo());
		rttr.addFlashAttribute("reviewResult", reviewVO.getNo());

		return "success";
	}

	// 제목 클릭하면 modal 창 뛰우기
	@GetMapping("/reviewGet/{no}")
	public @ResponseBody ResponseEntity<ReviewVO> replyGet(@PathVariable("no") int bno) {
		
		return new ResponseEntity<>(service.read(bno), HttpStatus.OK);
		
	}

	/*
	 * @GetMapping({ "/reviewGet", "/reviewModify" }) public void
	 * getNotice(@RequestParam("no") int bno, @ModelAttribute("reviewCri")
	 * ReviewCriteria reviewCri, Model model) { log.info("게시글 조회  or 게시글 삭제하기");
	 * model.addAttribute("review", service.read(bno)); }
	 */

	@PostMapping("/reviewModify")
	public String reviewModify(@ModelAttribute ReviewVO reviewVO, @ModelAttribute("reviewCri") ReviewCriteria reviewCri,
			RedirectAttributes rttr) {
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
		model.addAttribute("reviewList", service.getListWithPaging(reviewCri));
		int total = service.totalCount(reviewCri);
		log.info("total" + total);
		model.addAttribute("reviewPageMaker", new ReviewPageDTO(reviewCri, total));
	}

	@GetMapping("/reviewMyList")
	public void reviewMyList(ReviewCriteria reviewCri, Model model, HttpSession session) {
		MemberVO memberVO = (MemberVO) session.getAttribute("user");
		log.info(memberVO);
		String member_id = memberVO.getId();
		reviewCri.setMember_id(member_id);
		log.info(member_id);
		log.info("list:" + reviewCri);
		model.addAttribute("ReviewMylist", service.getListMyPage(reviewCri));
		int total = service.totalCount(reviewCri);
		log.info("total" + total);
		model.addAttribute("reviewMyPageMaker", new ReviewPageDTO(reviewCri, total));
	}

}
