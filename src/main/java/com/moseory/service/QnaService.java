package com.moseory.service;

import java.util.List;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaReplyVO;
import com.moseory.domain.QnaVO;

public interface QnaService {
    
    // 페이징처리하여 QnA List 조회
    public List<QnaVO> getList(Criteria cri);
    
    // QnA 개수
    public int getQnaCount(Criteria cri);
  
    // QnA 등록
    public void registQna(QnaVO vo);
    
    // QnA 조회
    public QnaVO getQna(int no);
    
    // QnA 조회수 증가
    public void increaseQnaHit(int no);
    
    // QnA 삭제
    public void deleteQna(int no);
    
    // QnA 수정
    public void modifyQna(QnaVO vo);
    
    // QnA Reply 등록 및 List 조회
    public List<QnaReplyVO> registAndGetReply(QnaReplyVO vo);
    
    // QnA Reply List 조회
    public List<QnaReplyVO> getReply(int qna_no);
    
    // QnA Reply 삭제
    public void deleteReply(int no);
    
}









