package com.moseory.domain;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaVO {

    private int no; // qna 번호
    private String member_id; // 작성자 아이디
    private Integer product_code; // 문의글의 상품 코드
    private String title; // 제목
    private String content; // 내용
    private LocalDate reg_date; // 등록일
    private int hit; // 조회수
    private int ref; // 그룹 번호
    private int depth; // 단계
    private int step; // 글순서
    private int pno; // 부모 번호
    private int secret; // 비밀글
    
}
