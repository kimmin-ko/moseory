package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberDaoTest {
 
    @Setter(onMethod_ = @Autowired)
    private MemberDao dao;
    
    private List<MemberVO> members;
    
    @Before
    public void setUp() {
	members = Arrays.asList(
		new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", "kimmin@naver.com"),
		new MemberVO("seungchan00", "seungchanpw00", "자신의 인생 좌우명은?", "착하게 살자", "문승찬", "seungchan@nate.com"),
		new MemberVO("geunho00", "geunhopw00", "자신의 보물 제1호는?", "추억", "홍근호", "geunho@daum.net"),
		new MemberVO("dohyeong00", "dohyeongpw00", "가장 기억에 남는 선생님은?", "갈매기", "김도형", "dohyeong@gmail.com"));
    }
    
    
    @Test
    public void testInsertMember() {
	
	dao.insertMember(members.get(0));
	
	assertThat(dao.getCount(), is(1));
	
	assertThat(members.get(0).getId(), is("min00"));
	
    }
    
}














