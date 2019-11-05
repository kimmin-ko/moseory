package com.moseory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.moseory.domain.ProductVO;
import com.moseory.service.HomeService;

import lombok.Setter;

@Controller
public class HomeController {
    
    	@Setter(onMethod_ = @Autowired)
    	private HomeService homeService;

	@GetMapping("/index")
	public void index() {
		
	public void index(Model model) {
	    // WEEKLY BEST ITEM -> 판매량 순으로 데이터를 가져옴
	    List<ProductVO> productSaleCount = homeService.readProductSaleCount();
	    model.addAttribute("productSaleCount", productSaleCount);
	    
	    // NEW ARRIVAL -> 최신 등록 순으로 데이터를 가져옴
	    List<ProductVO> productNew = homeService.readProductNew();
	    model.addAttribute("productNew", productNew);
	}
	
}





















