package com.moseory.domain;

import org.springframework.format.annotation.NumberFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVO {
    
    	// product
	private int code;
	private String name;
	@NumberFormat(pattern = "#,###,###")
	private int price;
	private int high_code, low_code, sale_count, wish_count;
	private String product_comment;
	private double grade;
	
	// product file
	private int fileno;
	private String file_path;
	private String thumbnail_name;
	private String file_name;
	
}
