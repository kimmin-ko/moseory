package com.moseory.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderVO {
    
    private String code; // 주문번호
    private String member_id; // 회원아이디
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime order_date; // 주문 등록 날짜
    private int delivery_charge; // 배송비
    private String recipient_name; // 수령인 이름
    private int recipient_zipcode; // 수령인 우편번호
    private String recipient_address1; // 수령인 기본주소
    private String recipient_address2; // 수령인 상세주소
    private String recipient_tel; // 수령인 일반전화
    private String recipient_phone; // 수령인 휴대전화
    private String recipient_email; // 수령인 이메일
    private String message; // 배송메세지
    private String pay_method; // 결제 수단
    private int used_point; // 사용한 적립금
    
}

