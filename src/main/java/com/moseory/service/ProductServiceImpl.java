package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.ProductDao;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
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
	public ProductVO getView(int code) {
		return productDao.getView(code);
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
	public List<String> getProductSize(int product_code, String product_color) {
	    return productDao.getProductSize(product_code, product_color);
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
	public List<ReviewVO> getReview(int product_code) {
	    return productDao.getReview(product_code);
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
	    productDao.modifyRecommend(review_no);
	}
	
}
