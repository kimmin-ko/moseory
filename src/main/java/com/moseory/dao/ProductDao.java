package com.moseory.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.moseory.domain.Criteria;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductAndFileVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnaVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

@Repository("productDao")
public interface ProductDao {

	List<ProductAndFileVO> highCateList(int high_code);

	List<ProductVO> highCateListDetail(Map<Object, Object> map);
	
	ProductVO getProduct(int code);
	
	ProductDetailVO getProductDetail(int product_detail_no);

	List<ProductDetailVO> getDetailView(int product_code);
	
	List<String> getProductColor(int product_code);
	
	List<ProductDetailVO> getProductSize(int product_code, String product_color);
	
	int getProductDetailNo(Map<String, Object> param);
	
	int getProductStock(int product_detail_no);
	
	int getReviewCount(int product_code);

	List<QnaVO> getListWithPaging(Criteria cri, int product_code);
	
	int getQnaCount(int product_code);
	
	List<ReviewVO> getReview(ReviewCri reviewCri);
	
	ReviewVO getOriginalReview(int review_no);
	
	
	void increaseRecommend(int review_no);
	
	void decreaseRecommend(int review_no);

	List<ProductVO> getBestProduct(int high_code);
	
	public HighCateVO getHighCate(int high_code);
	
	public List<LowCateVO> getLowCate(int high_code);

	List<ProductVO> getSearchList(Map<String, Object> param);

	int getHighCateCode(String keyword);

	int getSearchCount(Map<String, Object> param);

	int getLowCateCode(String keyword);
}
