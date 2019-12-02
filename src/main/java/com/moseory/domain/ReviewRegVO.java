package com.moseory.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewRegVO {

    private String member_id;
    private String title;
    private String content;
    private String order_code;
    private int product_detail_no;
    private int grade;
    
}
