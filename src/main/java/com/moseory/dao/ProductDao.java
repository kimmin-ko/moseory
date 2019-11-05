package com.moseory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

@Repository("productDao")
public interface ProductDao {

	List<ProductVO> highCateList(int high_code);

	ProductVO getView(int code);

	List<ProductDetailVO> getDetailView(int product_code);
	
	List<String> getProductColor(int product_code);
	
	List<String> getProductSize(int product_code, String product_color);
	
	int getReviewCount(int product_code);

	int getQnaCount(int product_code);
	
	List<ReviewVO> getReview(ReviewCri reviewCri);
	
	ReviewVO getOriginalReview(int review_no);
	
	List<QnAVO> getQnA(int product_code);
	
	void plusRecommend(int review_no);
	
	void minusRecommend(int review_no);
}
