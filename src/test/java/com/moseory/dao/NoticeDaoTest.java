package com.moseory.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
	public void testGetList() { 
		dao.noticeList().forEach(board -> log.info(board)); 
	}


	@Test
	public void testRead() {
		NoticeVO board2 = dao.read(5);
		log.info(board2);

	}
	
	

}
