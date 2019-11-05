package com.moseory.service;

import static org.junit.Assert.assertThat;

import java.time.LocalDate;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.Level;
import com.moseory.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserServiceTest {
    
    @Setter(onMethod_ = @Autowired)
    private UserService userService;
    
    @Setter(onMethod_ = @Autowired)
    private MemberService memberService;

    private MemberVO member1;
    private MemberVO member2;
    
    @Before
    public void setUp() {
	member1 = new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", "15466", "address1", "address2", 
		"032-674-2030", "010-3725-9670", "kimmin@daum.net", LocalDate.of(1992, 02, 16), Level.BRONZE, 0, 0, LocalDate.now());
	member2 = new MemberVO("min01", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", null, null, null, 
		null, "010-3725-9670", "kimmin@daum.net", null, null, 0, 0, LocalDate.now());
    }
    
    @Test
    public void testModifyMember() {
	userService.removeMember(member1.getId());
	
	memberService.registerMember(member1);
	
	member1.setPwd_confirm_a("hh");
	
	userService.modifyMember(member1);
	
    }

    
}
