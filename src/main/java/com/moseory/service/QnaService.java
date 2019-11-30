package com.moseory.service;

import java.util.List;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaVO;

public interface QnaService {
    
    // 페이징처리하여 QnA 조회
    public List<QnaVO> getList(Criteria cri);
    
    // QnA 개수
    public int getQnaCount(Criteria cri);
  
    // Qna 등록
    public void registQna(QnaVO vo);
}
