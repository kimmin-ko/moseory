package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.domain.MemberVO;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@Transactional
public class MemberDaoTest {
 
    @Setter(onMethod_ = @Autowired)
    private MemberDao dao;
    
    private List<MemberVO> members;
    
    @Before
    public void setUp() {
	members = Arrays.asList(
		new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", 
			"11554", "address1", "address2", "032-674-2030", "010-3725-9670", "kimmin@naver.com", LocalDate.of(1992, 02, 16)),
		new MemberVO("min01", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", 
			"11554", "address1", "address2", "032-674-2030", "010-3725-9670", "kimmin@naver.com", null));
    }
    
    @Test
    @Rollback(false)
    public void testInsertMember() {

	dao.deleteMember(members.get(0).getId());
	dao.deleteMember(members.get(1).getId());
	
	dao.insertMember(members.get(0));
	dao.insertMember(members.get(1));
	
	assertThat(members.get(0).getId(), is("min00"));
    }
    
    @Test
    public void testGetMember() {
	dao.getMember("min00");
    }
    
    @Test
    public void testIsMember() {
	
	dao.insertMember(members.get(0));
	
	assertThat(dao.getCountMember(members.get(0).getId()), is(1));
    }
    
}














