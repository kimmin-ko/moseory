package com.moseory.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.ProductDetailVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ProductServiceTest {

    @Setter(onMethod_ = @Autowired)
    private ProductService productService;
    
    @Test
    public void testGetProductSize() {
	List<ProductDetailVO> product_details = productService.getProductSize(81, null);
	product_details.forEach(x -> log.info(x.toString()));
    }
    
}











