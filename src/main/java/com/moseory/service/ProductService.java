package com.moseory.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.moseory.domain.Criteria;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductAndFileVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductFileVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnaVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

@Service
public interface ProductService {

	List<ProductAndFileVO> highCateList(Map<String,Object> map);

	ProductVO getProduct(int code);
	
	public int getProductListCount(Map<String,Object> map);
	

	List<ProductDetailVO> getDetailView(int code);
	
	List<String> getProductColor(int product_code);

	List<ProductDetailVO> getProductSize(int product_code, String product_color);
	
	int getProductDetailNo(Map<String, Object> param);
	
	int getProductStock(int product_detail_no);
	
	List<Map<String, Object>> getProductColorAndStock(int product_code);
	
	int getReviewCount(int product_code);
	
	int getQnaCount(int product_code);
	
	List<ReviewVO> getReview(ReviewCri reviewCri);
	
	ReviewVO getOriginalReview(int review_no);
	
	List<QnaVO> getQnA(Criteria cri, int product_code);
	
	void increaseRecommend(int review_no);
	
	void decreaseRecommend(int review_no);

	List<ProductVO> getBestProduct(int high_code);

	public HighCateVO getHighCate(int high_code);
	
	public List<LowCateVO> getLowCate(int high_code);

	List<ProductAndFileVO> getSearchList(Map<String, Object> param);

	int getHighCateCode(String keyword);

	int getSearchCount(Map<String, Object> param);

	int getLowCateCode(String keyword);

	ProductFileVO getProductFile(int code);

}
