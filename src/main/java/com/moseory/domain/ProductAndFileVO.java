package com.moseory.domain;

import org.springframework.format.annotation.NumberFormat;

import lombok.Data;

@Data
public class ProductAndFileVO {
	
	private int code;
	private String name;
	@NumberFormat(pattern = "#,###,###")
	private int price;
	private int high_code;
	private int low_code;
	private int sale_count;
	private int wish_count;
	private String product_comment;
	private double grade;
	private int fileno;
	private String thumbnail_name;
	private String file_path;
	private String file_name;
	private String reg_date;
	private int product_stock;
}
