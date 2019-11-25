package com.moseory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Repository("productDao")
public class ProductDaoImpl implements ProductDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ProductVO> highCateList(int high_code) {
		return sqlSession.selectList("product.highCateList", high_code);
	}

	@Override
	public List<ProductVO> highCateListDetail(Map<Object, Object> map) {
		return sqlSession.selectList("product.highCateListDetail", map);
	}
	
	@Override
	public ProductVO getProduct(int code) {
		return sqlSession.selectOne("product.getProduct", code);
	}
	
	@Override
	public ProductDetailVO getProductDetail(int product_detail_no) {
	    return sqlSession.selectOne("product.getProductDetail", product_detail_no);
	}

	@Override
	public List<ProductDetailVO> getDetailView(int product_code) {
		return sqlSession.selectList("product.getDetailView", product_code);
	}
	
	// 상품의 색상을 중복 없이 조회
	@Override
	public List<String> getProductColor(int product_code) {
	    return sqlSession.selectList("product.getProductColor", product_code);
	}

	// 상품 색상의 사이즈를 조회
	@Override
	public List<ProductDetailVO> getProductSize(int product_code, String product_color) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("product_code", product_code);
	    map.put("product_color", product_color);
	    return sqlSession.selectList("product.getProductSize", map);
	}
	
	@Override
	public int getProductDetailNo(Map<String, Object> param) {
	    return sqlSession.selectOne("product.getProductDetailNo", param);
	}
	
	@Override
	public int getProductStock(int product_detail_no) {
	    return sqlSession.selectOne("product.getProductStock", product_detail_no);
	}

	@Override
	public int getReviewCount(int product_code) {
	    return sqlSession.selectOne("product.getReviewCount", product_code);
	}

	@Override
	public int getQnaCount(int product_code) {
	    return sqlSession.selectOne("product.getQnaCount", product_code);
	}

	@Override
	public List<ReviewVO> getReview(ReviewCri reviewCri) {
	    return sqlSession.selectList("product.getReview", reviewCri);
	}

	
	@Override
	public ReviewVO getOriginalReview(int review_no) {
	    return sqlSession.selectOne("product.getOriginalReview", review_no);
	}
	
	@Override
	public List<QnAVO> getQnA(int product_code) {
	    return sqlSession.selectList("product.getQnA", product_code);
	}

	@Override
	public void increaseRecommend(int review_no) {
	    sqlSession.update("product.increaseRecommend", review_no);
	}

	@Override
	public void decreaseRecommend(int review_no) {
	    sqlSession.update("product.decreaseRecommend", review_no);
	}

	@Override

	public List<ProductVO> getBestProduct(int high_code) {
		return sqlSession.selectList("product.getBestProduct",high_code);
	}

	public HighCateVO getHighCate(int high_code) {
		return sqlSession.selectOne("product.getHighCate", high_code);
	}

	@Override
	public List<LowCateVO> getLowCate(int high_code) {
		return sqlSession.selectList("product.getLowCate", high_code);

	}

	


	

}


















