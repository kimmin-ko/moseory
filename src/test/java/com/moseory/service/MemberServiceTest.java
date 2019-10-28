package com.moseory.service;

import static org.junit.Assert.assertThat;

import java.time.LocalDate;
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
public class MemberServiceTest {
    
    @Setter(onMethod_ = @Autowired)
    private MemberService memberService;
    
    private List<MemberVO> members;
    
    @Before
    public void setUp() {
	members = Arrays.asList(
		new MemberVO("min00", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", 
			"11554", "address1", "address2", "032-674-2030", "010-3725-9670", "kimmin@naver.com", LocalDate.of(1992, 02, 16)),
		new MemberVO("min01", "minpw00", "기억에 남는 추억의 장소는?", "정동진", "김민", 
			"11554", "address1", "address2", "032-674-2030", "010-3725-9670", "kimmin@naver.com", null));
    }
    
}
















