package com.moseory.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderListCri {

    private String member_id;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;
    private String state;
    
    private int pageNum; // 페이지 번호
    private int amount; // 한 페이지당 보여지는 Data 수
    
    public OrderListCri() {
	this(1, 10);
    }
    
    public OrderListCri(int pageNum, int amount) {
	this.pageNum = pageNum;
	this.amount = amount;
    }
    
}
