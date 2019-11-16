package com.moseory.dao;

import java.util.List;

import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

public interface NoticeDao {
	
	// 게시글 작성하기
	public void create(NoticeVO vo);
	
	// 게시글 번호로 조회하기
	public NoticeVO read(int No);
	
	// 게시글 수정하기
	public void update(NoticeVO vo);
	
	// 게시글 삭제하기
	public void delete(int No);
	
	// 게시글 조회하기
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
	//게시글 총 수 구하기
	public int totalCount(Criteria cri);
	
	void viewCount(int num);
	

}
