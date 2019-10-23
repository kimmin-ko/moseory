package com.moseory.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MemberControllerTest {
    
    private MockMvc mockMvc;
    
    @Before
    public void setup() {
	
    }
    
    @Test
    public void testMemberJoin() throws Exception {
	mockMvc.perform(MockMvcRequestBuilders.get("/member/join"));
    }
    
}










