package com.moseory.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Service("productService")
public interface ProductService {

	List<ProductVO> highCateList(int high_code);

	ProductVO getView(int code);

	List<ProductDetailVO> getDetailView(int code);
	
	List<String> getProductColor(int product_code);

	List<String> getProductSize(int product_code, String product_color);
}
