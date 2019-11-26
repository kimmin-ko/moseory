package com.moseory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.ProductDao;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

@Service("productService")
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao productDao;
	
	@Override
	public List<ProductVO> highCateList(int high_code) {
		return productDao.highCateList(high_code);
	}

	@Override
	public List<ProductVO> highCateListDetail(int high_code, String lowCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("high_code", high_code);
		map.put("lowCode", lowCode);
		return productDao.highCateListDetail(map);
	}
	
	@Override
	public ProductVO getProduct(int code) {
		return productDao.getProduct(code);
	}

	@Override
	public List<ProductDetailVO> getDetailView(int product_code) {
		return productDao.getDetailView(product_code);
	}

	@Override
	public List<String> getProductColor(int product_code) {
	    return productDao.getProductColor(product_code);
	}

	@Override
	public List<ProductDetailVO> getProductSize(int product_code, String product_color) {
	    return productDao.getProductSize(product_code, product_color);
	}
	
	@Override
	public int getProductDetailNo(Map<String, Object> param) {
	    return productDao.getProductDetailNo(param);
	}
	
	@Override
	public int getProductStock(int product_detail_no) {
	    return productDao.getProductStock(product_detail_no);
	}

	@Override
	public int getReviewCount(int product_code) {
	    return productDao.getReviewCount(product_code);
	}

	@Override
	public int getQnaCount(int product_code) {
	    return productDao.getQnaCount(product_code);
	}

	@Override
	public List<ReviewVO> getReview(ReviewCri reviewCri) {
	    return productDao.getReview(reviewCri);
	}

	@Override
	public ReviewVO getOriginalReview(int review_no) {
	    return productDao.getOriginalReview(review_no);
	}
	
	@Override
	public List<QnAVO> getQnA(int product_code) {
	    return productDao.getQnA(product_code);
	}

	@Override
	public void increaseRecommend(int review_no) {
	    productDao.increaseRecommend(review_no);
	}

	@Override
	public void decreaseRecommend(int review_no) {
	    productDao.decreaseRecommend(review_no);
	}

	@Override
	public List<ProductVO> getBestProduct(int high_code) {
		return productDao.getBestProduct(high_code);
	}

	
	public HighCateVO getHighCate(int high_code) {
		return productDao.getHighCate(high_code);
	}

	@Override
	public List<LowCateVO> getLowCate(int high_code) {
		return productDao.getLowCate(high_code);
	}

	@Override
	public List<ProductVO> getSearchList(Map<String, String> param) {
		return productDao.getSearchList(param);
	}


	
	
	
}
