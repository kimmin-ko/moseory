package com.moseory.domain;

import lombok.Data;

@Data
public class OrderDetailVO {
    
    // order detail
    private String order_code;
    private int product_detail_no;
    private int quantity;
    private int amount;
    private int discount;
    private int point;
    
    // product
    private int product_code;
    private String product_file_path;
    private String product_name;
    private int product_price;
    
    
    // product detail
    private String product_color;
    private String product_size;
    
}


