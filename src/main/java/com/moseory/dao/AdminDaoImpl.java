package com.moseory.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void regist(ProductVO productVO, ProductDetailVO productdetailVO) {
		sqlSession.insert("product.regist", productVO);
		sqlSession.insert("product.regist2", productdetailVO);
		
	}
	
	
}
