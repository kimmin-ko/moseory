package com.moseory.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/article/*")
public class NoticeController {

    // @Inject
    // ArticleService articleService;

    @GetMapping("/noticeList")
    public String notice() {
	return "/notice/noticeList";
    }

    @GetMapping("/noticeView")
    public String articleForm() {
	return "/notice/noticeView";
    }

    @GetMapping("/list")
    public String list(Model model) throws Exception {
	// model.addAttribue("list",service.list());
	return "article/list";
    }

}