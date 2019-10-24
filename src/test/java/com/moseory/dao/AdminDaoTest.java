package com.moseory.dao;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@Transactional
public class AdminDaoTest {

    @Setter(onMethod_ = @Autowired)
    private AdminDao dao;
    
    private ProductVO pVO;
    private ProductDetailVO pdVO;
    
    @Before
    public void setup() {
	pVO = new ProductVO();
    }
    
    @Test
    @Rollback(false)
    public void registerProduct() {
	
    }
    
}




