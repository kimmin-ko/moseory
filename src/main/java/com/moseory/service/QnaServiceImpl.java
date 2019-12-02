package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.QnaDao;
import com.moseory.domain.Criteria;
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

    
    
}
