package com.moseory.dao;

import java.util.List;

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
	public ProductDetailVO getDetailView(int product_code) {
		return sqlSession.selectOne("product.getDetailView", product_code);
	}

}
