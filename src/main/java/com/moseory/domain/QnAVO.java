package com.moseory.domain;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnAVO {

    private int no;
    private MemberVO member;
    private int product_code;
    private String title;
    private String content;
    private LocalDate reg_date;
    private int hit;
    
}
