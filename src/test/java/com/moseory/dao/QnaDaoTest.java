package com.moseory.dao;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class QnaDaoTest {

    @Setter(onMethod_ = @Autowired)
    private QnaDao qnaDao;
    
    @Test
    public void testPaging() {
	Criteria cri = new Criteria();
	cri.setKeyword("트1");
	cri.setType("TC");
	
	List<QnaVO> list = qnaDao.getListWithPaging(cri);
	
	list.forEach(qna -> log.info(qna.getNo()));
    }
    
     @Test
     public void testGetQna() {
	 log.info(qnaDao.getQna(10));
     }
}
