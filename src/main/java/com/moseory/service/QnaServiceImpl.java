package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.QnaDao;
import com.moseory.domain.Criteria;
import com.moseory.domain.QnaReplyVO;
import com.moseory.domain.QnaVO;

import lombok.Setter;

@Service
public class QnaServiceImpl implements QnaService {
    

    @Setter(onMethod_ = @Autowired)
    private QnaDao qnaDao;

    @Override
    public List<QnaVO> getList(Criteria cri) {
	return qnaDao.getListWithPaging(cri);
    }

    @Override
    public int getQnaCount(Criteria cri) {
	return qnaDao.getQnaCount(cri);
    }

    @Override
    public void registQna(QnaVO vo) {
	qnaDao.insertQna(vo);
    }

    @Override
    public QnaVO getQna(int no) {
	return qnaDao.getQna(no);
    }

    @Override
    public void increaseQnaHit(int no) {
	qnaDao.increaseQnaHit(no);
    }

    @Transactional
    @Override
    public void deleteQna(int no) {
	
	// Reply 삭제
	qnaDao.deleteAllReplyForQna(no);
	
	// QnA 삭제
	qnaDao.deleteQna(no);
    }

    @Override
    public void modifyQna(QnaVO vo) {
	qnaDao.updateQna(vo);
    }

    @Transactional
    @Override
    public List<QnaReplyVO> registAndGetReply(QnaReplyVO vo) {
	
	// reply 등록
	qnaDao.insertReply(vo);
	
	// reply list 조회
	return qnaDao.getReplyList(vo.getQna_no());
    }

    @Override
    public List<QnaReplyVO> getReply(int qna_no) {
	return qnaDao.getReplyList(qna_no);
    }

    @Override
    public void deleteReply(int no) {
	qnaDao.deleteReply(no);
    }

}
