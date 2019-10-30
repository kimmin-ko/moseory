package com.moseory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/productList")
	public String productList(@RequestParam int high_code,
													Model model) {
		System.out.println(high_code);
		List <ProductVO> productVO = productService.highCateList(high_code);
		model.addAttribute("productVO",productVO);
		for(ProductVO pVO : productVO) System.out.println(pVO);
		
		return "product/productList";
	}
	
	
	@GetMapping("/productInfo")
	public String productInfo(@RequestParam int code,
													Model model) {
		ProductVO productVO = productService.getView(code);
		System.out.println(productVO);
		ProductDetailVO productdetailVO = productService.getDetailView(code);
		System.out.println(productdetailVO);
		return "product/productInfo";
	}
	
	
	
}
