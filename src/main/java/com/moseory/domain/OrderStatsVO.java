package com.moseory.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderStatsVO {
	private int code; //tbl_order
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime order_date; // 주문 등록 날짜
	private String pay_method;	//tbl_order
	private int amount;	//tbl_order_detail
	private int quantity;	//tbl_order_detail
	
}
