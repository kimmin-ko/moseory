package com.moseory.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaVO;

import lombok.Setter;

@Repository
public class QnaDaoImpl implements QnaDao {
    
    private String namespace = "com.moseory.mapper.QnaMapper";

    @Setter(onMethod_ = @Autowired)
    private SqlSession sqlSession;

    @Override
    public List<QnaVO> getListWithPaging(Criteria cri) {
	return sqlSession.selectList(namespace+".getListWithPaging", cri);
    }

    @Override
    public int getQnaCount(Criteria cri) {
	return sqlSession.selectOne(namespace+".getQnaCount", cri);
    }

    @Override
    public void insertQna(QnaVO vo) {
	sqlSession.insert(namespace+".insertQna", vo);
    }

    @Override
    public QnaVO getQna(int no) {
	return sqlSession.selectOne(namespace+".getQna", no);
    }

    
    
    
}
















