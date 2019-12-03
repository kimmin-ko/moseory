package com.moseory.domain;

import lombok.Data;

@Data
public class ProductFileVO {
	private int fileno;
	private int product_code;
	private String thumbnail_name;
	private String file_path, file_name;
	
}
