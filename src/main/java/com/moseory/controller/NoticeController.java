package com.moseory.controller;

import java.util.List;
import java.util.logging.Logger;

import javax.inject.Inject;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moseory.domain.NoticeVO;
import com.moseory.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

	@Inject
	NoticeService service;
	
	@GetMapping("/noticeText")
	public void getnoticeText() {
		
	}

	
	//게시글 작성하기
	@PostMapping("/noticeText")
	public String writeText(NoticeVO vo) throws Exception{
		service.create(vo);
		return "redirect:/notice/noticeList";
	}

	// 전체 리스트를 읽어 온다
	@GetMapping("/noticeList")
	public void getList(Model model) throws Exception{
		List<NoticeVO> list = null;
		list = service.noticeList();
		model.addAttribute("list",list);
	}
	
	//게시글 조회하기
	/*
	 * @GetMapping("/noticeText") public void gerView(@RequestParam("NO") int
	 * notice_no, Model model) throws Exception{ NoticeVO vo =
	 * service.read(notice_no); model.addAttribute("view",vo); }
	 */



}