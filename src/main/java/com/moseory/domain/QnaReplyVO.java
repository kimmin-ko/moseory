package com.moseory.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnaReplyVO {

    private int no;
    private int qna_no;
    private String member_id;
    private String content;
    private LocalDateTime reg_date;
    
}
