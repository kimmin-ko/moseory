package com.moseory.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class OrderListVO {
    
    // product
    private int product_code; // 상품 코드
    private String file_path; // 상품 이미지 경로
    private String name; // 상품 이름
    
    // product_detail
    private int product_detail_no; // 상품 디테일 번호
    private String product_color; // 상품 색상
    private String product_size; // 상품 사이즈
    
    // order
    private String code; // 주문 번호
    private LocalDate order_date; // 주문 날짜
    
    // order_detail
    private int point; // 주문 적립금
    private int amount; // 주문 금액
    private int quantity; // 주문 수량
    private String state; //주문 상태
    
}
