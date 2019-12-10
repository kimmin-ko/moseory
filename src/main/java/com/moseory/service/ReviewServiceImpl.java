package com.moseory.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moseory.dao.ReviewDao;
import com.moseory.domain.ReviewCriteria;
import com.moseory.domain.ReviewVO;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Inject
	ReviewDao dao;
	
	@Override
	public void insert(ReviewVO reviewVO) {
		dao.insert(reviewVO);
	}

	@Override
	public ReviewVO read(int bno) {
		log.info("read Review board" + bno);
		dao.viewCount(bno);
		return dao.read(bno);
	}
	
	@Override
	public void delete(int bno) {
		log.info("delete Notice board");
		dao.delete(bno);
	}
	
	@Override
	public void update(ReviewVO reviewVO) {
		log.info("update Notice board");
		dao.update(reviewVO);
	}
	
	@Override
	public List<ReviewVO> getListWithPaging(ReviewCriteria reviewCri){
		log.info("get List with paging" + reviewCri);
		return dao.getListWithPaging(reviewCri);
	}
	
	@Override
	public int totalCount(ReviewCriteria reviewCri) {
		log.info("get total count");
		return dao.totalCount(reviewCri);
	}
	
	@Override
	public List<ReviewVO> getListMyPage(ReviewCriteria reviewCri){
		log.info("get List My Page" + reviewCri);
		return dao.getListMyPage(reviewCri);
	}
	

}
