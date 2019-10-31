package com.moseory.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository("productDao")
public interface ProductDao {

	List<ProductVO> highCateList(int high_code);

	ProductVO getView(int code);

	List<ProductDetailVO> getDetailView(int product_code);
	
	List<String> getProductColor(int product_code);
	
	List<String> getProductSize(int product_code, String product_color);
	
}
