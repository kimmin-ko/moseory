package com.moseory.dao;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.ProductVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class HomeDaoTest {
    
    @Setter(onMethod_ = @Autowired)
    private HomeDao homeDao;
    
    private ProductVO product1;
    private ProductVO product2;
    
    @Before
    public void setup() {
	
    }
    
    @Test
    public void testGetProductSaleCount() {
	List<ProductVO> list = homeDao.getProductSaleCount();
	
	list.stream().forEach(x -> log.info(x));
    }
    
    @Test
    public void testGetProductNew() {
	List<ProductVO> list = homeDao.getProductNew();
	
	list.stream().forEach(x -> log.info(x));
    }
    
}























