package com.moseory.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moseory.domain.Criteria;
import com.moseory.domain.MemberVO;
import com.moseory.domain.PageDTO;
import com.moseory.domain.QnaReplyVO;
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

	// 회원 정보 조회
	private MemberVO getMember(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberVO member = (MemberVO) session.getAttribute("user");

		return member;
	}

	// Q&A 목록
	@GetMapping("/qnaList")
	public void qnaList(@ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("qnaList", qnaService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, qnaService.getQnaCount(cri)));
	}

	// Q&A 등록 페이지
	@GetMapping("/qnaRegist")
	public void qnaRegist(@ModelAttribute("cri") Criteria cri) {

	}

	// 상품 정보 페이지에서 Q&A 등록
	@GetMapping("/qnaRegistOnProductInfo")
	public String qnaRegistOnProductInfo(@ModelAttribute("cri") Criteria cri, @RequestParam("code") int product_code,
			Model model) {

		// 상품 코드를 가지고 qnaRegist로 이동
		model.addAttribute("product_code", product_code);

		return "/qna/qnaRegist";
	}

	// Q&A 등록
	@PostMapping("/qnaRegist")
	public String qnaRegistPost(@ModelAttribute("cri") Criteria cri, @ModelAttribute QnaVO qnaVO,
			RedirectAttributes rttr) {

		log.info("Post qnaRegist qnaVO :  " + qnaVO);

		qnaService.registQna(qnaVO);

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		// Q&A에 상품 코드가 존재 (특정 상품에 대한 Q&A)
		if (qnaVO.getProduct_code() != null) {
			return "redirect:/product/productInfo?code=" + qnaVO.getProduct_code();
		} else { // 일반 Q&A
			return "redirect:/qna/qnaList";
		}
	}

	// Q&A 조회
	@GetMapping("/qnaGet")
	public String qnaGet(@RequestParam int no, @ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest req,
			HttpServletResponse res) {

		MemberVO member = getMember(req);

		String user_id = "";

		if (member != null)
			user_id = member.getId();
		else
			user_id = "u";

		// 조회수 증가 & 조회수 중복 방지
		Cookie[] cookies = req.getCookies();

		boolean isCookie = false;

		if (cookies != null) {
			for (Cookie cookie : cookies) { // ex) admin11_Qna_550
				if (cookie.getName().equals(user_id + "_Qna_" + no)) {
					isCookie = true;
				}
			}
		}

		if (!isCookie) { // 쿠키가 존재하지 않으면 쿠키 생성 및 조회수 증가 처리
			Cookie cookie = new Cookie(user_id + "_Qna_" + no, "qna_hit");
			cookie.setMaxAge(60 * 60 * 24 * 365);
			cookie.setPath("/");

			res.addCookie(cookie);

			qnaService.increaseQnaHit(no);
		}

		model.addAttribute("qna", qnaService.getQna(no));

		return "/qna/qnaGet";
	}

	// QnA 삭제
	@PostMapping("/qnaDelete")
	public String qnaDelete(@RequestParam("no") int no, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		qnaService.deleteQna(no);

		rttr.addFlashAttribute("result", "success_delete");

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		if (cri.getType().equals("P")) {
			return "redirect:/product/productInfo?code=" + cri.getKeyword();
		} else {
			return "redirect:/qna/qnaList";
		}
	}

	// QnA 수정 페이지
	@GetMapping("/qnaModify")
	public void qnaModify(@RequestParam("no") int no, @ModelAttribute("cri") Criteria cri, Model model) {
		QnaVO qna = qnaService.getQna(no);

		model.addAttribute("qna", qna);
	}

	// QnA 수정
	@PostMapping("/qnaModify")
	public String qnaModifyPost(@ModelAttribute("qnaVO") QnaVO qnaVO, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		qnaService.modifyQna(qnaVO);

		rttr.addFlashAttribute("result", "success_modify");

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		if (cri.getType().equals("P")) {
			return "redirect:/product/productInfo?code=" + cri.getKeyword();
		} else {
			return "redirect:/qna/qnaList";
		}

	}

	// QnA Answer 등록 페이지
	@GetMapping("/qnaAnswerRegist")
	public void qnaAnswerRegist(@ModelAttribute("cri") Criteria cri, @RequestParam("no") int no, Model model) {
		QnaVO parentsQna = qnaService.getQna(no);

		model.addAttribute("qna", parentsQna);
	}

	// QnA Answer 등록
	@PostMapping("/qnaAnswerRegist")
	public String qnaAnswerRegistPost(@ModelAttribute QnaVO qnaVO, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {

		log.info("qna answer 등록 type : " + cri.getType());
		log.info("qna answer 등록 keyword : " + cri.getKeyword());

		qnaService.registQnaAnswer(qnaVO);

		rttr.addFlashAttribute("result", "success_answerRegist");

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		if (cri.getType().equals("P")) {
			return "redirect:/product/productInfo?code=" + cri.getKeyword();
		} else {
			return "redirect:/qna/qnaList";
		}
	}

	// QnA Reply 등록 및 조회
	@PostMapping(value = "/replyRegistAndGet", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<List<QnaReplyVO>> replyRegistAndGet(@RequestBody QnaReplyVO vo) {

		return new ResponseEntity<>(qnaService.registAndGetReply(vo), HttpStatus.OK);
	}

	// QnA Reply 조회
	@GetMapping("/replyGet/{qna_no}")
	public @ResponseBody ResponseEntity<List<QnaReplyVO>> replyGet(@PathVariable("qna_no") int qna_no) {

		return new ResponseEntity<>(qnaService.getReply(qna_no), HttpStatus.OK);
	}

	// QnA Reply 삭제
	@PostMapping("/replyDelete")
	public @ResponseBody ResponseEntity<String> replyDelete(@RequestBody int no) {

		qnaService.deleteReply(no);

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	// Qna MyList 조회
	@GetMapping("/qnaMyList")
	public void qnaMyList(Criteria cri, Model model, HttpSession session) {
		MemberVO memberVO = (MemberVO) session.getAttribute("user");
		log.info("memberVO");
		String member_id = memberVO.getId();
		cri.setMember_id(member_id);
		log.info(member_id);
		model.addAttribute("qnaMyList", qnaService.getMyList(cri));
		int total = qnaService.getQnaCount(cri);
		log.info("total" + total);
		model.addAttribute("qnaPageMaker", new PageDTO(cri, qnaService.getQnaCount(cri)));

	}

}
