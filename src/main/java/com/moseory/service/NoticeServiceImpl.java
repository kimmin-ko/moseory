package com.moseory.service;

import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.moseory.dao.NoticeDao;
import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class NoticeServiceImpl implements NoticeService  {
	
	@Inject
	NoticeDao dao;
	
	
	@Override
	public void create(NoticeVO vo) {
		log.info("write Notice board");
		dao.create(vo);
	}

	@Override
	public NoticeVO read(int b_no) {
		log.info("read Notice board" + b_no);
		dao.viewCount(b_no);
		return dao.read(b_no);
	}
	
	@Override
	public void delete(int b_no) {
		log.info("delete Notice board");
		dao.delete(b_no);
	}
	
	@Override
	public void update(NoticeVO vo) {
		log.info("update Notice board");
		dao.update(vo);
	}

	
	@Override
	public List<NoticeVO> getListWithPaging(Criteria cri){
		log.info("get List with paging" + cri);
		return dao.getListWithPaging(cri);
	}
	
	@Override
	public int totalCount(Criteria cri) {
		log.info("get total count");
		return dao.totalCount(cri);
	}
	
}
