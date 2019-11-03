package com.moseory.dao;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ProductDaoTest {
    
    @Setter(onMethod_ = @Autowired)
    private ProductDao productDao;
    
    @Before
    public void setup() {
	
    }
    
    @Test
    public void getProduct() {
	ProductVO product = productDao.getView(2);
	
	log.info(product);
	
	List<ProductDetailVO> productDetail = productDao.getDetailView(2);
	
	log.info(productDetail);
    }
    
    @Test
    public void getProductColor() {
	List<String> colorStr = productDao.getProductColor(34);
	colorStr.stream().forEach(x -> log.info(x));
    }
    
    @Test
    public void getProductSize() {
	List<String> sizeStr = productDao.getProductSize(34, "화이트");
	sizeStr.stream().forEach(x -> log.info(x));
    }
    
}













