package com.moseory.service;

import java.util.List;
import javax.inject.Inject;
import org.junit.Test;

import com.moseory.dao.NoticeDaoImpl;
import com.moseory.domain.Criteria;
import com.moseory.domain.NoticeVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class NoticeServiceTest {

	@Inject
	private NoticeServiceImpl service;
	
	@Inject
	private NoticeDaoImpl dao;


	@Test
	public void testGetListWithPaging() {
		service.getListWithPaging(new Criteria(2,10)).forEach(NoticeVO -> log.info(NoticeVO));
	}
}
