package com.moseory.domain;

import lombok.Data;

@Data
public class ProductFileVO {
	private int fileno;
	private int high_code;
	private String thumbnail_name, thumbnail_path;
	private String file_path, file_name;
	
}
