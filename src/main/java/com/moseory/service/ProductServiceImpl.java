package com.moseory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.ProductDao;
import com.moseory.domain.Criteria;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductAndFileVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductFileVO;
import com.moseory.domain.ProductVO;
import com.moseory.domain.QnaVO;
import com.moseory.domain.ReviewCri;
import com.moseory.domain.ReviewVO;
import com.moseory.util.ImageUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao productDao;
	
	@Override
	public List<ProductAndFileVO> highCateList(int high_code) {
		return productDao.highCateList(high_code);
	}

	@Override
	public List<ProductVO> highCateListDetail(int high_code, String lowCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("high_code", high_code);
		map.put("lowCode", lowCode);
		return productDao.highCateListDetail(map);
	}
	
	@Override
	public ProductVO getProduct(int code) {
	    	ProductVO product = productDao.getProduct(code);
	    	product.setFile_path(ImageUtil.convertImagePath(product.getFile_path()));
		return product;
	}

	@Override
	public List<ProductDetailVO> getDetailView(int product_code) {
		return productDao.getDetailView(product_code);
	}

	@Override
	public List<String> getProductColor(int product_code) {
	    return productDao.getProductColor(product_code);
	}

	@Override
	public List<ProductDetailVO> getProductSize(int product_code, String product_color) {
	    if(product_color != null && product_color.equals("null")) {
		product_color = null;
	    }
	    List<ProductDetailVO> product_detail = productDao.getProductSize(product_code, product_color);
	    return product_detail;
	}
	
	@Override
	public int getProductDetailNo(Map<String, Object> param) {
	    return productDao.getProductDetailNo(param);
	}
	
	@Override
	public int getProductStock(int product_detail_no) {
	    return productDao.getProductStock(product_detail_no);
	}

	@Override
	public int getReviewCount(int product_code) {
	    return productDao.getReviewCount(product_code);
	}

	@Override
	public int getQnaCount(int product_code) {
	    return productDao.getQnaCount(product_code);
	}

	@Override
	public List<ReviewVO> getReview(ReviewCri reviewCri) {
	    List<ReviewVO> vo_list = productDao.getReview(reviewCri);
	    
	    for(int i = 0; i < vo_list.size(); i++) {
		ReviewVO vo = vo_list.get(i);
		vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
	    }
	    
	    return vo_list;
	}

	@Override
	public ReviewVO getOriginalReview(int review_no) {
	    return productDao.getOriginalReview(review_no);
	}
	
	@Override
	public List<QnaVO> getQnA(Criteria cri, int product_code) {
	    return productDao.getListWithPaging(cri, product_code);
	}

	@Override
	public void increaseRecommend(int review_no) {
	    productDao.increaseRecommend(review_no);
	}

	@Override
	public void decreaseRecommend(int review_no) {
	    productDao.decreaseRecommend(review_no);
	}

	@Override
	public List<ProductVO> getBestProduct(int high_code) {
		return productDao.getBestProduct(high_code);
	}
	
	@Override
	public HighCateVO getHighCate(int high_code) {
		return productDao.getHighCate(high_code);
	}

	@Override
	public List<LowCateVO> getLowCate(int high_code) {
		return productDao.getLowCate(high_code);
	}

	@Override
	public List<ProductAndFileVO> getSearchList(Map<String, Object> param) {
		return productDao.getSearchList(param);
	}

	@Override
	public int getHighCateCode(String keyword) {
		return productDao.getHighCateCode(keyword);
	}

	@Override
	public int getSearchCount(Map<String, Object> param) {
		return productDao.getSearchCount(param);
	}

	@Override
	public int getLowCateCode(String keyword) {
		return productDao.getLowCateCode(keyword);
	}

	@Override
	public List<Map<String, Object>> getProductColorAndStock(int product_code) {
	    return productDao.getProductColorAndStock(product_code);
	}

	@Override
	public ProductFileVO getProductFile(int code) {
		return productDao.getProductFile(code);
	}


	
	
	
}
