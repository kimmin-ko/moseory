package com.moseory.service;

import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.moseory.dao.NoticeDao;
import com.moseory.domain.NoticeVO;


@Service
public class NoticeServiceImpl implements NoticeService  {
	
	@Inject
	NoticeDao dao;
	
	@Override
	public void create(NoticeVO vo) {
		dao.create(vo);
	}

	@Override
	public NoticeVO read(int b_no) {
		return dao.read(b_no);
	}
	
	@Override
	public void delete(int b_no) {
		dao.delete(b_no);
	}
	
	@Override
	public void update(NoticeVO vo) {
		dao.update(vo);
	}

	@Override
	public List<NoticeVO> noticeList() {
		return dao.noticeList();
	}
	
}
