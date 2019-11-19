package com.moseory.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

@Service("productService")
public interface ProductService {

	List<ProductVO> highCateList(int high_code);

	ProductVO getView(int code);

	List<ProductDetailVO> getDetailView(int code);
	
	List<String> getProductColor(int product_code);

	List<ProductDetailVO> getProductSize(int product_code, String product_color);
	
	int getProductDetailNo(Map<String, Object> param);
	
	int getProductStock(int product_detail_no);
	
	int getReviewCount(int product_code);
	
	int getQnaCount(int product_code);
	
	List<ReviewVO> getReview(ReviewCri reviewCri);
	
	ReviewVO getOriginalReview(int review_no);
	
	List<QnAVO> getQnA(int product_code);
	
	void increaseRecommend(int review_no);
	
	void decreaseRecommend(int review_no);
}
