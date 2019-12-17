package com.moseory.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Criteria {
	
	private int pageNum; // 페이지 번호
	private int amount; // 한 페이지당 보여지는 Data 수
	private String member_id; // member _id ;
	private String type;
	private String keyword;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {}: type.split("");
	} 
	//검색 조건을 배열로 만들어 한꺼번에 처리한다
	
}
