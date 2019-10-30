package com.moseory.dao;

import java.util.List;
import com.moseory.domain.NoticeVO;

public interface NoticeDao {
	
	// 게시글 작성하기
	public void create(NoticeVO vo);
	
	// 전체 게시글 리스트 조회하기
	public List<NoticeVO> noticeList();
	
	// 게시글 번호로 조회하기
	public NoticeVO read(int seq_notice_no);
	
	// 게시글 수정하기
	public void update(NoticeVO vo);
	
	// 게시글 삭제하기
	public void delete(int seq_notice_no);
	

}
