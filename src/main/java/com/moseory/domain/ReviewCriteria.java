package com.moseory.domain;

import javax.mail.Session;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class ReviewCriteria {
	
	private int reviewPageNum; // 페이지 번호
	private int reviewAmount; // 한 페이지당 보여지는 Data
	private String member_id;
	private String reviewType;
	private String reviewKeyword;
	
	public ReviewCriteria() {
		this(1,10);
	}
	
	public ReviewCriteria(int reviewPageNum,int reviewAmount) {
		this.reviewPageNum = reviewPageNum;
		this.reviewAmount = reviewAmount;
	}
	
	public String[] getReviewTypeArr() {
		return reviewType == null ? new String[] {}: reviewType.split("");
	} 

}
