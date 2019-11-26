package com.moseory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;
import com.moseory.service.ProductService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("/productList")
	public String productList(@RequestParam int high_code,  Model model, HttpServletRequest req) {
		
		if(req.getParameter("lowCode") == null || req.getParameter("lowCode").equals("")) {
			List <ProductVO> productVO = productService.highCateList(high_code);
			model.addAttribute("productVO",productVO);
			for(ProductVO pVO : productVO) System.out.println(pVO);
		}else {
			String lowCode = req.getParameter("lowCode");
			List <ProductVO> productVO = productService.highCateListDetail(high_code, lowCode);
			model.addAttribute("productVO",productVO);
		}
		
		HighCateVO highCate = productService.getHighCate(high_code);
		List <LowCateVO> lowCate = productService.getLowCate(high_code);
		
		List <ProductVO> bestProducts = productService.getBestProduct(high_code);
		for(ProductVO bests : bestProducts)  System.out.println(bests);
		model.addAttribute("bestProducts", bestProducts);
		model.addAttribute("highCate", highCate);
		model.addAttribute("lowCate", lowCate);
		model.addAttribute("high_code", high_code);
		
		return "product/productList";
	}
	
	
	@GetMapping("/productInfo")
	public String productInfo(@RequestParam int code, Model model) {
		// 상품 조회
		ProductVO productVO = productService.getProduct(code);
		// 상품 디테일 조회
		List<ProductDetailVO> productDetailVO = productService.getDetailView(code);
		
		/* 색상 조회 */
		String color = null;
		if(productDetailVO.size() > 0) 
		    color = productDetailVO.get(0).getProduct_color();
		
		List<String> productColor = null;
		// 상품의 색상이 있을 경우
		if(color != null) { 
		    // 상품 색상 중복 없이 조회
		    productColor = productService.getProductColor(code);
		}
		model.addAttribute("productColorList", productColor);
		model.addAttribute("color", color); // 해당 상품의 색상 option 표시 여부 수단
		
		/* 사이즈 조회 */
		String size = null;
		if(productDetailVO.size() > 0)
		    size = productDetailVO.get(0).getProduct_size();
		
		List<ProductDetailVO> productSize = null;
		// 사이즈가 있고, 색상이 없을 경우에는 상품 정보 페이지에 사이즈 뿌려줌
		if(size != null && color == null) {
		    productSize = productService.getProductSize(code, color);
		}
		model.addAttribute("productSizeList", productSize);
		model.addAttribute("size", size); // 해당 상품의 사이즈 option 표시 여부 수단
		
		model.addAttribute("productDetailList", productDetailVO);
		model.addAttribute("product", productVO);
		
		// 상품의 Review 개수
		int reviewCount = productService.getReviewCount(code);
		model.addAttribute("reviewCount", reviewCount);
		
		//상품의 QnA 개수
		int qnaCount = productService.getQnaCount(code);
		model.addAttribute("qnaCount", qnaCount);
		
		// QnA 리스트
		List<QnAVO> qnaList = productService.getQnA(code);
		model.addAttribute("qnaList", qnaList);
		
		return "product/productInfo";
	}
	
	@GetMapping("/getProductDetailNo")
	public @ResponseBody ResponseEntity<Integer> getProductDetailNo(
		@RequestParam(required = false) Map<String, Object> param) {
	    
	    int no = productService.getProductDetailNo(param);
	    
	    return no != 0 ? new ResponseEntity<>(no, HttpStatus.OK)
		    	   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/getProductStock")
	public @ResponseBody ResponseEntity<Integer> getProductStock(@RequestParam int product_detail_no) {
	    
	    int stock = 0;
	    
	    if(product_detail_no > 0)
		stock = productService.getProductStock(product_detail_no);
	    
	    return stock != 0 ? new ResponseEntity<>(stock, HttpStatus.OK)
		    	      : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PostMapping("/increaseRecommend/{review_no}/{user_id}")
	public ResponseEntity<Integer> increaseRecommend(
		@PathVariable("review_no") int review_no, @PathVariable("user_id") String user_id, 
		HttpServletRequest req, HttpServletResponse res) {
	    boolean isCookie = false;
	    
	    Cookie[] cookies = req.getCookies();
	    
	    Cookie like_cookie = null;
	    
	    if(cookies != null) {
		for(int i = 0; i < cookies.length; i++) {
        		
        		if(cookies[i].getName().equals("like_" + user_id + "_" + review_no)) {
        		    isCookie = true;
        		    like_cookie = cookies[i];
        		}
    	    	}
	    }
	    
	    // cookie가 존재하지 않을 경우
	    if(!isCookie) {
		// 쿠키 생성
		like_cookie = new Cookie("like_" + user_id + "_" + review_no, "exist_cookie");
		like_cookie.setMaxAge(60 * 60 * 24 * 365);
		like_cookie.setPath("/");

		// 쿠키 저장
		res.addCookie(like_cookie);

		// 추천 수 증가
		productService.increaseRecommend(review_no);
	    } 
	    // cookie가 존재할 경우
	    else {
		// 쿠키 삭제
		like_cookie.setMaxAge(0);
		like_cookie.setPath("/");
		
		// 쿠키 저장
		res.addCookie(like_cookie);

		// 추천 수 감소
		productService.decreaseRecommend(review_no);
	    }
	    
	    int review_recommend = productService.getOriginalReview(review_no).getRecommend();
	    
	    return new ResponseEntity<>(review_recommend, HttpStatus.OK);
	}

	@GetMapping("/getSize/{code}/{color}")
	public ResponseEntity<List<ProductDetailVO>> getColor(@PathVariable("code") int code,
			     @PathVariable("color") String color) {
	    List<ProductDetailVO> productSize = productService.getProductSize(code, color);
	    
	    return productSize != null 
		    ? new ResponseEntity<>(productSize, HttpStatus.OK)
		    : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/getReviewList/{product_code}/{type}/{limit}",
		produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<List<ReviewVO>> getReviewList(
		@PathVariable("product_code") int product_code,
		@PathVariable("type") String type,
		@PathVariable("limit") int limit) {
	    ReviewCri reviewCri = new ReviewCri(product_code, type, limit);
	    
	    List<ReviewVO> reviewList = productService.getReview(reviewCri);
	    
	    return new ResponseEntity<>(reviewList, HttpStatus.OK);
	}
	
	
	
	@GetMapping("/search")
	public String search(@RequestParam(defaultValue = "") String searchType,
			@RequestParam String keyword,
			@RequestParam(defaultValue = "") String exceptkeyword,
			@RequestParam(defaultValue = "") String lowestprice,
			@RequestParam(defaultValue = "") String highestprice,
			@RequestParam(defaultValue = "") String orderby) {
		Map<String, String> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("keyword", keyword);
		param.put("exceptkeyword", exceptkeyword);
		param.put("lowestprice", lowestprice);
		param.put("highestprice", highestprice);
		param.put("orderby", orderby);
		
		
//		List <ProductVO> list = productService.getSearchList(param);
		return "product/search";
	}
	
	@PostMapping("/search")
	public String search() {
		
		return "product/search";
	}
	
	
	
	
	
}











