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

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/productList")
	public String productList(@RequestParam int high_code, Model model) {
		System.out.println(high_code);
		List <ProductVO> productVO = productService.highCateList(high_code);
		model.addAttribute("productVO",productVO);
		for(ProductVO pVO : productVO) System.out.println(pVO);
		
		return "product/productList";
	}
	
	
	@GetMapping("/productInfo")
	public String productInfo(@RequestParam int code, Model model) {
		// 상품 조회
		ProductVO productVO = productService.getView(code);
		// 상품 디테일 조회
		List<ProductDetailVO> productDetailVO = productService.getDetailView(code);
		
		/* 색상 조회 */
		String color = productDetailVO.get(0).getProduct_color();
		List<String> productColor = null;
		// 상품의 색상이 있을 경우
		if(color != null) { 
		    // 상품 색상 중복 없이 조회
		    productColor = productService.getProductColor(code);
		}
		model.addAttribute("productColorList", productColor);
		
		log.info("is product color : " + productColor);
		
		/* 사이즈 조회 */
		String size = productDetailVO.get(0).getProduct_size();
		model.addAttribute("size", size);
		
		log.info("is product size : " + size);
		
		model.addAttribute("productDetailList", productDetailVO);
		model.addAttribute("product", productVO);
		
		return "product/productInfo";
	}
	
	
}
