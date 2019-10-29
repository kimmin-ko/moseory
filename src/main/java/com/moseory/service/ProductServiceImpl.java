package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.ProductDao;
import com.moseory.domain.ProductVO;

@Service("productService")
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao productDao;
	
	@Override
	public List<ProductVO> highCateList(int high_code) {
		return productDao.highCateList(high_code);
	}
	
}
