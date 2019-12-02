package com.moseory.dao;

import java.util.List;

import com.moseory.domain.Criteria;
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
    
}

















