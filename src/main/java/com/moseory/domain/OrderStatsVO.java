package com.moseory.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderStatsVO {
	
	private String date;
	private int amount;	//tbl_order_detail
	private int quantity;	//tbl_order_detail
	
}
