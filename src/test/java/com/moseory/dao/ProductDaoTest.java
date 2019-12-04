package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ProductDaoTest {
    
    @Setter(onMethod_ = @Autowired)
    private ProductDao productDao;
    
    @Test
    public void testGetProduct() {
	ProductVO product = productDao.getProduct(2);
	
	log.info(product);
	
	List<ProductDetailVO> productDetail = productDao.getDetailView(2);
	
	log.info(productDetail);
    }
    
    @Test
    public void testGetProductColor() {
	List<String> colorStr = productDao.getProductColor(81);
	colorStr.stream().forEach(x -> log.info(x));
    }
    
    @Test
    public void testGetProductSize() {
	List<ProductDetailVO> sizeStr = productDao.getProductSize(81, null);
	sizeStr.stream().forEach(x -> log.info(x));
    }
    
    @Test
    public void testGetReviewCount() {
	int count = productDao.getReviewCount(34);
	log.info(count);
    }
    
    @Test
    public void testGetQnaCount() {
	int count = productDao.getQnaCount(34);
	log.info(count);
    }
    
    @Test
    public void testGetReview() {
	ReviewCri reviewCri = new ReviewCri(34, "L", 10);
	List<ReviewVO> reviewList = productDao.getReview(reviewCri);
	reviewList.stream().forEach(x -> log.info(x.toString()));
    }
    
    @Test
    public void testModifyRecommend() {
	ReviewVO review = productDao.getOriginalReview(21);
	
	productDao.increaseRecommend(21);
	
	ReviewVO updateReview = productDao.getOriginalReview(21);
	
	assertThat(review.getRecommend() + 1, is(updateReview.getRecommend()));
    }
    
    @Test
    public void testGetproductDetailNo() {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put("product_code", 32);
	param.put("product_color", "블랙");
	param.put("product_size", null);
	
	int result = productDao.getProductDetailNo(param);
	
	log.info("result : " + result);
    }
    
    @Test
    public void testGetProductColorAndStock() {
	List<Map<String, Object>> colorAndStock = productDao.getProductColorAndStock(82);
	colorAndStock.forEach(x -> log.info(x.get("PRODUCT_COLOR")));
	colorAndStock.forEach(x -> log.info(x.get("PRODUCT_STOCK")));
	log.info(colorAndStock.toString());
	
    }
    
}













