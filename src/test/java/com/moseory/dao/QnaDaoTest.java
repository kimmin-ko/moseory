package com.moseory.dao;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.Criteria;
import com.moseory.domain.QnaReplyVO;
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
	Criteria cri = new Criteria(2, 10);
	//cri.setKeyword("원글");
	//cri.setType("TC");
	
	List<QnaVO> list = qnaDao.getListWithPaging(cri);
	
	list.forEach(qna -> log.info(qna.getNo()));
    }
    
     @Test
     public void testGetQna() {
	 log.info(qnaDao.getQna(10));
     }
     
     @Test
     public void testDeleteQna() {
	 qnaDao.deleteQna(65527);
     }
     
     @Test
     public void testUpdateQna() {
	 QnaVO vo = new QnaVO();
	 vo.setNo(65522);
	 vo.setTitle("test modify");
	 vo.setContent("test modify");
	 vo.setSecret(0);
	 
	 qnaDao.updateQna(vo);
     }
     
     @Test
     public void testQnaReply() {
	 QnaReplyVO vo = new QnaReplyVO();
	 vo.setQna_no(65583);
	 vo.setMember_id("admin11");
	 vo.setContent("테스트");
	 
	 qnaDao.insertReply(vo);
	 
	 log.info(qnaDao.getReplyList(65583));
     }
     
}












