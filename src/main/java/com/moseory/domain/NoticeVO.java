package com.moseory.domain;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor

//데이터를 저장하는 클래스
public class NoticeVO {
	
	private int NO;
	
	private int MEMBER_NO;
	
	private String TITLE;
	
	private String CONTENT;
	
	private Date REG_DATE;
	
	private int HIT;
	
	private String FILE_PATH;
	
	private String FILE_NAME;
	
}
