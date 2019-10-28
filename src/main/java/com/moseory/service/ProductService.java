package com.moseory.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.moseory.domain.ProductVO;

@Service("productService")
public interface ProductService {

	List<ProductVO> highCateList(int high_code);

}