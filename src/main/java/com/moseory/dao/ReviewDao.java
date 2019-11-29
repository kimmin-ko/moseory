package com.moseory.dao;

import java.util.List;
import com.moseory.domain.ReviewCriteria;
import com.moseory.domain.ReviewVO;

public interface ReviewDao {
	
	public void insert(ReviewVO reviewVO);
	
	public ReviewVO read(int bno);
	
	public void delete(int bno);
	
	public void update(ReviewVO reviewVO);
	
	public List<ReviewVO> getListWithPaging(ReviewCriteria reviewCri);
	
	public int totalCount(ReviewCriteria reviewCri);
	
	void viewCount(int num);
}
