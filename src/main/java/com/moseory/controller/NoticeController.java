package com.moseory.controller;

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

	/*
	 * @GetMapping("/noticeView") public String noticeView() { return
	 * "/notice/noticeView"; }
	 */

	@PostMapping("/noticeText")
	public String writeText(NoticeVO vo, RedirectAttributes rttr) throws Exception {
		log.info("write notice" + vo);
		service.create(vo);
		log.info(vo.getNo());
		rttr.addFlashAttribute("result", vo.getNo());
		return "redirect:/notice/noticeList";
	}

	@GetMapping({ "/noticeGet", "/noticeModify" })
	public void getNotice(@RequestParam("no") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("게시글 조회  or 게시글 삭제하기");
		model.addAttribute("board", service.read(bno));
	}

	@PostMapping("/noticeModify")
	public String noticeModify(@ModelAttribute NoticeVO vo, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		log.info("modify" + vo);
	public String noticeModify(@ModelAttribute NoticeVO vo, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {
		log.info("modify : " + vo);
		service.update(vo);
		rttr.addFlashAttribute("pageNum", cri.getPageNum());
		rttr.addFlashAttribute("amount", cri.getAmount());
		log.info("--------------------------------");
		return "redirect:/notice/noticeList";

	}

	@PostMapping("/noticeDelete")
	public String remove(@RequestParam("no") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
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
		int total = service.totalCount(cri);
		log.info("total" + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}