package com.moseory.service;

import java.util.List;

import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

public interface NoticeService {
	
	public void create(NoticeVO vo);
	
	/* public List<NoticeVO> noticeList(); */
	
	public NoticeVO read(int b_no);
	
	public void delete(int b_no);
	
	public void update(NoticeVO vo);
	
	public List<NoticeVO> getListWithPaging(Criteria cri);
	
}
