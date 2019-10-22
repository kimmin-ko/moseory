package com.moseory.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moseory.domain.NoticeVO;

@Repository // db에 접근하기 위한 클래스 이다
public class NoticeDao {
	
	//@Inject
	//private SqlSession sql;
	
	// 게시글 작성하기
	public void create(NoticeVO vo) throws Exception{
		
	}
	
	//게시글 읽어오기
	/*
	 * public ArticleVO read(int bno) throws Exception{
	 * 
	 * }
	 */
	
	//게시글 수정하기
	public void update(NoticeVO vo) throws Exception{
		
	}
	
	//게시글 삭제하기
	public void delete(int bno) throws Exception{
		
	}
	
	
	
}
