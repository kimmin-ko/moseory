package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberDaoTest {
 
    @Setter(onMethod_ = @Autowired)
    private MemberDao dao;
    
    private List<MemberVO> members;
    
    @Before
    public void setUp() {
	members = Arrays.asList(
		new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", 11554, "address1", "address2", "tel", "phone", "kimmin@naver.com", "1992-02-16"),
		new MemberVO("seungchan00", "seungchanpw00", "자신의 인생 좌우명은?", "착하게 살자", "문승찬", "seungchan@nate.com"),
		new MemberVO("geunho00", "geunhopw00", "자신의 보물 제1호는?", "추억", "홍근호", "geunho@daum.net"),
		new MemberVO("dohyeong00", "dohyeongpw00", "가장 기억에 남는 선생님은?", "갈매기", "김도형", "dohyeong@gmail.com"));
    }
    
    
    @Test
    public void testInsertMember() {

	dao.deleteMember(members.get(0).getId());
	
	assertThat(dao.getCount(), is(0));
	
	dao.insertMember(members.get(0));
	
	assertThat(members.get(0).getId(), is("min00"));
    }
    
    @Test
    public void testGetMember() {
	
	MemberVO vo = dao.getMember(members.get(0).getId());
	
	assertTrue(vo.getBirth().equals(members.get(0).getBirth()));
	
    }
    
}














