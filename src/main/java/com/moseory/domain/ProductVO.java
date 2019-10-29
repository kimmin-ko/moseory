package com.moseory.domain;

import lombok.Data;

@Data
public class ProductVO {
	private int code;
	private String name;
	private int high_code, low_code, price, sale_count, wish_count, grade;
	private String file_path, file_name, product_comment;
	
	
}
