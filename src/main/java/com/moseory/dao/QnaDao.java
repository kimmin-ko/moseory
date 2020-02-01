package com.moseory.dao;

import java.util.List;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaReplyVO;
import com.moseory.domain.QnaVO;

public interface QnaDao {
    
    // 페이징처리하여 QnA List 조회
    public List<QnaVO> getListWithPaging(Criteria cri);
    
    // QnA 개수
    public int getQnaCount(Criteria cri);
    
    // QnA 등록
    public void insertQna(QnaVO vo);
    
    // QnA 조회
    public QnaVO getQna(int no);
    
    // 조회수 증가
    public void increaseQnaHit(int no);
    
    // QnA 삭제
    public void deleteQna(int no);
    
    // QnA의 모든 Reply 삭제
    public void deleteAllReplyForQna(int qna_no);
    
    // QnA 수정
    public void updateQna(QnaVO vo);
    
    // QnA Reply 등록
    public void insertReply(QnaReplyVO vo);
    
    // QnA Reply List 조회
    public List<QnaReplyVO> getReplyList(int qna_no);
    
    // QnA Reply 삭제
    public void deleteReply(int no);
    
    // QnA 답글 등록 전 그룹 step 증가
    public void increaseGroupStep(int p_ref, int p_step);
    
    // QnA 답글 등록
    public void insertQnaAnswer(QnaVO vo);
    
    // QnA 원글 작성자 조회
    public String getOriginalWriter(int no);
     
}

















