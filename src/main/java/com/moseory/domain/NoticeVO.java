package com.moseory.domain;

import java.sql.Date;

import lombok.Data;

@Data

//데이터를 저장하는 클래스
public class NoticeVO {
	
	private int bno;
	private int member_no;
	private String title;
	private String content;
	private Date reg_date;
	private int hit;
	private String file_path;
	private String file_name;
	

}
