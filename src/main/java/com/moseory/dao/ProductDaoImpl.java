package com.moseory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository("productDao")
public class ProductDaoImpl implements ProductDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ProductVO> highCateList(int high_code) {
		return sqlSession.selectList("product.highCateList", high_code);
	}

	@Override
	public ProductVO getView(int code) {
		return sqlSession.selectOne("product.getView", code);
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
	public List<String> getProductSize(int product_code, String product_color) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("product_code", product_code);
	    map.put("product_color", product_color);
	    return sqlSession.selectList("product.getProductSize", map);
	}

}
