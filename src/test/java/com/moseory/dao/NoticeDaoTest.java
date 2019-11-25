package com.moseory.dao;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
@Log4j

public class NoticeDaoTest {


	@Setter(onMethod_ =@Autowired)
	private NoticeDao dao;

	private NoticeVO board1;

	

	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<NoticeVO> list = dao.getListWithPaging(cri);
		list.forEach(board -> log.info(board.getNo()));
	}
	
	@Test
	public void testDynamic1() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setKeyword("글");
		cri.setType("t");
		
		log.info("=================");
		List<NoticeVO> list = dao.getListWithPaging(cri);
		for(NoticeVO noticeVO : list) {
			log.info(noticeVO.getNo() +":" +noticeVO.getTitle());
		}
		
		log.info("========================");
		log.info("count : " + dao.totalCount(cri));
		
	}
	
	

}
