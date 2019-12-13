package com.moseory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaReplyVO;
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
    public List<QnaVO> getMyListWithPaging(Criteria cri){
    	return sqlSession.selectList(namespace+".getMyListWithPaging",cri);
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

    @Override
    public void increaseQnaHit(int no) {
	sqlSession.update(namespace+".increaseQnaHit", no);
    }

    @Override
    public void deleteQna(int no) {
	sqlSession.delete(namespace+".deleteQna", no);
    }

    @Override
    public void updateQna(QnaVO vo) {
	sqlSession.update(namespace+".updateQna", vo);
    }

    @Override
    public void insertReply(QnaReplyVO vo) {
	sqlSession.insert(namespace+".insertReply", vo);
    }

    @Override
    public List<QnaReplyVO> getReplyList(int qna_no) {
	return sqlSession.selectList(namespace+".getReplyList", qna_no);
    }

    @Override
    public void deleteAllReplyForQna(int qna_no) {
	sqlSession.delete(namespace+".deleteAllReplyForQna", qna_no);
    }

    @Override
    public void deleteReply(int no) {
	sqlSession.delete(namespace+".deleteReply", no);
    }

    @Override
    public void increaseGroupStep(int p_ref, int p_step) {
	Map<String, Integer> param = new HashMap<String, Integer>();
	param.put("ref", p_ref);
	param.put("step", p_step);
	
	sqlSession.update(namespace+".increaseGroupStep", param);
    }

    @Override
    public void insertQnaAnswer(QnaVO vo) {
	sqlSession.insert(namespace+".insertQnaAnswer", vo);
    }

    
    
    
}
















