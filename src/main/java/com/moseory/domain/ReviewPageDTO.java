package com.moseory.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReviewPageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private ReviewCriteria reviewCri;
	
	public ReviewPageDTO(ReviewCriteria reviewCri, int total) {
		this.reviewCri = reviewCri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(reviewCri.getReviewPageNum()/10.0))*10;
		
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total*1.0)/ reviewCri.getReviewAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
	
}