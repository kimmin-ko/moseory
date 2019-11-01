package com.moseory.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
		model.addAttribute("color", color); // 해당 상품의 색상 option 표시 여부 수단
		model.addAttribute("productColorList", productColor);
		
		log.info("is product color : " + color);
		log.info("is product productColor : " + productColor);
		
		/* 사이즈 조회 */
		String size = productDetailVO.get(0).getProduct_size();
		List<String> productSize = null;
		// 사이즈가 있고, 색상이 없을 경우에는 상품 정보 페이지에 사이즈 뿌려줌
		if(size != null && color == null) {
		    productSize = productService.getProductSize(code, color);
		}
		model.addAttribute("size", size); // 해당 상품의 사이즈 option 표시 여부 수단
		model.addAttribute("productSizeList", productSize);
		
		log.info("is product size : " + size);
		log.info("is product productSize : " + productSize);
		
		model.addAttribute("productDetailList", productDetailVO);
		model.addAttribute("product", productVO);
		
		return "product/productInfo";
	}
	
	@GetMapping("/getSize/{code}/{color}")
	public ResponseEntity<List<String>> getColor(@PathVariable("code") int code,
			     @PathVariable("color") String color) {
	    
	    List<String> productSize = productService.getProductSize(code, color);
	    
	    return productSize != null 
		    ? new ResponseEntity<>(productSize, HttpStatus.OK)
		    : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}











