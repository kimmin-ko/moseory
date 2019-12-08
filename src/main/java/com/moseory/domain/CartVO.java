package com.moseory.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartVO {
    
    private int no;
    private String member_id;
    private int product_detail_no;
    private int quantity;
    
    // product 정보
    private int product_code;
    private String product_name;
    private int product_price;
    
    // product file 정보
    private String file_path;
    private String thumbnail_name;
    
    // product detail 정보
    private String product_color;
    private String product_size;
    private int product_stock;
    
    public CartVO(String memeber_id, int product_detail_no) {
	this.member_id = memeber_id;
	this.product_detail_no = product_detail_no;
    }
    
}
