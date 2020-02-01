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

	@Transactional
	@Override
	public void registQnaAnswer(QnaVO vo) {

		// 1. pno를 이용해 부모의 정보를 가져온다.
		QnaVO parentsQna = qnaDao.getQna(vo.getPno());

		// 2. 부모의 정보를 이용해 자식의 데이터 값 세팅
		vo.setProduct_code(parentsQna.getProduct_code());
		vo.setRef(parentsQna.getRef());
		vo.setDepth(parentsQna.getDepth() + 1);
		vo.setStep(parentsQna.getStep() + 1);
		vo.setSecret(parentsQna.getSecret());

		// 3. 답글 등록 전 해당 그룹의 step을 1씩 증가시킨다
		qnaDao.increaseGroupStep(parentsQna.getRef(), parentsQna.getStep());

		// 4. 답글을 등록한다
		qnaDao.insertQnaAnswer(vo);

	}

	@Override
	public String getOriginalWriter(int no) {
		return qnaDao.getOriginalWriter(no);
	}

}
