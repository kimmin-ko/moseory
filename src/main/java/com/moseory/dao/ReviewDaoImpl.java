package com.moseory.dao;

import java.util.List;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.moseory.domain.ReviewCriteria;
import com.moseory.domain.ReviewVO;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Inject
	private SqlSession sqlSession;
	
	private static String namespace = "com.moseory.mapper.ReviewMapper";
	
	@Override
	public void insert(ReviewVO reviewVO) {
		sqlSession.insert(namespace+".insert",reviewVO);
	}
	
	@Override
	public ReviewVO read(int bno) {
		return sqlSession.selectOne(namespace+".select",bno);
	}
	
	@Override
	public void update(ReviewVO reviewVO) {
		sqlSession.update(namespace + ".update", reviewVO);
	}
	@Override
	public void delete(int notice_no) {
		sqlSession.delete(namespace + ".delete", notice_no);
	}
	
	@Override
	public List<ReviewVO> getListWithPaging(ReviewCriteria reviewCri){
		return sqlSession.selectList(namespace+".getListWithPaging",reviewCri);
	}
	
	@Override
	public int totalCount(ReviewCriteria reviewCri) {
		return sqlSession.selectOne(namespace +".totalCount",reviewCri);
	}
	
	@Override
	public void viewCount(int num) {
		sqlSession.update(namespace+".hit",num);
	}
	
	@Override
	public List<ReviewVO> getListMyPage(ReviewCriteria reviewCri){
		return sqlSession.selectList(namespace+".getListMyPage",reviewCri);
	}

	
}

