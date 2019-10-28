package com.moseory.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;
	/**
	 *  1. product의 정보와 product_detail을 동시에 insert 하려고 함.
	 *  2. 근데 product_detail의 code를 삽입할 수 없음 
	 *  2-1. 이유는 컨트롤러에서 넘어온 product_detailVO의 code를 모르기 때문
	 *  2-2. 그래서 product를 insert 하고 select로 불러 오려고 함
	 *  2-3. null이 뜸
	 *	 3. productVO의 code가 시퀀스로 들어가서 받아오는 VO는 code를 모름
	 *	 4. 상품명을 중복되지 않게 하고 상품명으로 code를 가져옴
	 */
	@Override
	public void product_regist(ProductVO productVO) {
		System.out.println("dao까지 옴");
		sqlSession.insert("product.regist", productVO);
		System.out.println("dao insert 실행함");
	}
	@Override
	public int setCode(String name) {
		return sqlSession.selectOne("product.setCode", name);
	}
	@Override
	public void product_detail_regist(ProductDetailVO productdetailVO) {
		sqlSession.insert("product.product_detail_regist", productdetailVO);
	}

}
