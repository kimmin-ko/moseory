package com.moseory.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductVO;

import lombok.Setter;

@Repository
public class HomeDaoImpl implements HomeDao {
    
    private final String namespace = "com.moseory.mapper.HomeMapper";
    
    @Setter(onMethod_ = @Autowired)
    private SqlSession sqlSession;
    
    @Override
    public List<ProductVO> getProductSaleCount() {
	return sqlSession.selectList(namespace+".getProductSaleCount");
    }

    @Override
    public List<ProductVO> getProductNew() {
	return sqlSession.selectList(namespace+".getProductNew");
    }
    
}
















