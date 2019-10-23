package com.moseory.service;

import org.springframework.stereotype.Service;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Service
public interface AdminService {

	void regist(ProductVO productVO, ProductDetailVO productdetailVO);
	
}
