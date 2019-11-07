package com.moseory.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnAVO;
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
	ProductVO product = productDao.getView(2);
	
	log.info(product);
	
	List<ProductDetailVO> productDetail = productDao.getDetailView(2);
	
	log.info(productDetail);
    }
    
    @Test
    public void testGetProductColor() {
	List<String> colorStr = productDao.getProductColor(34);
	colorStr.stream().forEach(x -> log.info(x));
    }
    
    @Test
    public void testGetProductSize() {
	List<ProductDetailVO> sizeStr = productDao.getProductSize(34, "화이트");
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
    public void testGetQna() {
	List<QnAVO> qnaList = productDao.getQnA(34);
	qnaList.stream().forEach(x -> log.info(x.toString()));
    }
    
    @Test
    public void testModifyRecommend() {
	ReviewVO review = productDao.getOriginalReview(21);
	
	productDao.increaseRecommend(21);
	
	ReviewVO updateReview = productDao.getOriginalReview(21);
	
	assertThat(review.getRecommend() + 1, is(updateReview.getRecommend()));
    }
    
    
    
}













