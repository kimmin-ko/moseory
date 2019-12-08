package com.moseory.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewVO {
    
    private int no;
    
    private MemberVO member;
    
    private String title;
    private String content;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate reg_date;
    private int hit;
    private String file_path;
    private String thumbnail_name;
    
    private ProductDetailVO product_detail;
    
    private int recommend;
    private double grade;
    
}
