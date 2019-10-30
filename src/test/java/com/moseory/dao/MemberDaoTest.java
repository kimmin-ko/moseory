package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.domain.Level;
import com.moseory.domain.MemberVO;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberDaoTest {
 
    @Setter(onMethod_ = @Autowired)
    private MemberDao dao;
    
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
    public void testInsertMember() {
	dao.deleteMember(member1.getId());
	dao.deleteMember(member2.getId());
	
	dao.insertMember(member1);
	dao.insertMember(member2);
	
	assertThat(dao.getCountMember(member1.getId()), is(1));
	assertThat(dao.getCountMember(member2.getId()), is(1));
    }	
    
    @Test
    public void testUpdateMember() {
	MemberVO vo = dao.getMember(member1.getId());
	
	checkGetMember(vo);
	
	vo.setPassword("modifypwd");
	vo.setBirth(LocalDate.of(1984, 12, 16));
	
	dao.updateMember(vo);
	
	assertThat(dao.getMember(vo.getId()).getPassword(), is("modifypwd"));
	assertThat(dao.getMember(vo.getId()).getBirth(), is(LocalDate.of(1984, 12, 16)));
    }
    
    @Test
    public void testGetMember() {
	dao.deleteMember(member1.getId());
	
	dao.insertMember(member1);
	
	checkGetMember(dao.getMember(member1.getId()));
    }
    
    public void checkGetMember(MemberVO vo) {
	assertEquals(member1.getPassword(), vo.getPassword());
	assertEquals(member1.getPwd_confirm_q(), vo.getPwd_confirm_q());
	assertEquals(member1.getPwd_confirm_a(), vo.getPwd_confirm_a());
	assertEquals(member1.getName(), vo.getName());
	assertEquals(member1.getZipcode(), vo.getZipcode());
	assertEquals(member1.getAddress1(), vo.getAddress1());
	assertEquals(member1.getAddress2(), vo.getAddress2());
	assertEquals(member1.getTel(), vo.getTel());
	assertEquals(member1.getPhone(), vo.getPhone());
	assertEquals(member1.getEmail(), vo.getEmail());
	assertEquals(member1.getBirth(), vo.getBirth());
	assertEquals(member1.getLevel(), vo.getLevel());
	assertEquals(member1.getPoint(), vo.getPoint());
	assertEquals(member1.getTotal(), vo.getTotal());
    }
    
    @Test
    public void testIsMember() {
	dao.deleteMember(member1.getId());
	
	dao.insertMember(member1);
	
	assertThat(dao.getCountMember(member1.getId()), is(1));
    }
    
}














