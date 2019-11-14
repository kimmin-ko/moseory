package com.moseory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moseory.domain.NoticeVO;
import com.moseory.service.NoticeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice/*")
public class NoticeController {

	@Setter(onMethod_= @Autowired)
	NoticeService service;
	
	@GetMapping("/noticeText")
	public void getnoticeText() {
		log.info("write the text");
	}
	
	//게시글 작성하기
	@PostMapping("/noticeText")
	public String writeText(NoticeVO vo, RedirectAttributes rttr) throws Exception{
		log.info("write notice" + vo);
		service.create(vo);
		log.info(vo.getNO());
		rttr.addFlashAttribute("result",vo.getNO());
		//vo.getNo()가 인식이 안되는 문제가 있음... why?
		//create 자체에서 게시글을 만들어 주긴하지만
		//vo객체에는 저장되지 않기에
		return "redirect:/notice/noticeList"; //도배를 막기 위해서 사용한다
	}

	// 전체 리스트를 읽어 온다
	@GetMapping("/noticeList")
	public void getList(Model model) throws Exception{
		log.info("list");
		List<NoticeVO> list = null;
		list = service.noticeList();
		model.addAttribute("list",list);
	}
	
	//게시글 조회하기
	@GetMapping({"/noticeGet","/noticeModify"})
	public void getNotice(@RequestParam("NO") int bno, Model model) {
		log.info("게시글 조회  or 게시글 삭제하기");
		NoticeVO vo = service.read(bno);
		model.addAttribute("board",vo);
	}
	
	//게시글 수정하기
	@PostMapping("/noticeModify")
	public String noticeModify(NoticeVO vo, RedirectAttributes rttr) {
		log.info("modify" + vo);
		service.update(vo);
		//rttr.addFlashAttribute("result","successs"); 구현오류
		
		return "redirect:/notice/noticeList";
	    
	}
	
	//게시글 삭제하기
	//@PostMapping("/noticeDelete")
	@GetMapping("/noticeDelete")
	public String remove(@RequestParam("NO") int bno, RedirectAttributes rttr) {
		log.info("remove" + bno);
		service.delete(bno);
		//rttr.addFlashAttribute("result","succeess");
		return "redirect:/notice/noticeList";
	}
	
	//수정과 삭제는 별개의 페이지에서 진행한다
	
	



}