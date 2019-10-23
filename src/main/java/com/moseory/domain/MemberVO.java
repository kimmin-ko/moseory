package com.moseory.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
    
    private int no; // 회원 번호
    private String id; // 회원 아이디
    private String password; // 회원 비밀번호
    private String pwd_confirm_q; // 비밀번호 확인 질문
    private String pwd_confirm_a; // 비밀번호 확인 답변
    private String name; // 회원 이름
    private int zipcode; // 우편번호
    private String address1; // 기본주소
    private String address2; // 상세주소
    private String tel; // 일반 전화 번호
    private String phone; // 휴대폰 번호
    private String email; // 이메일
    private String birth; // 생년월일
    private int lev; // 회원 등급
    private int point; // 적립금
    private int total; // 총 결제 금액
    private boolean enabled; // 계정 사용 가능 여부
    private String join_date; // 가입일
    
    public MemberVO(String id, String password, String pwd_confirm_q, String pwd_confirm_a, String name, String email) {
	this.id = id;
	this.password = password;
	this.pwd_confirm_q = pwd_confirm_q;
	this.pwd_confirm_a = pwd_confirm_a;
	this.name = name;
	this.email = email;
    }
    
    public MemberVO(String id, String password, String pwd_confirm_q, String pwd_confirm_a, String name, int zipcode, 
	    String address1, String address2, String tel, String phone, String email, String birth) {
	this.id = id;
	this.password = password;
	this.pwd_confirm_q = pwd_confirm_q;
	this.pwd_confirm_a = pwd_confirm_a;
	this.name = name;
	this.zipcode = zipcode;
	this.address1 = address1;
	this.address2 = address2;
	this.tel = tel;
	this.phone = phone;
	this.email = email;
	this.birth = birth;
    }
    
}










