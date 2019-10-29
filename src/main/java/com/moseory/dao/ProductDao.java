package com.moseory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductVO;

@Repository("productDao")
public interface ProductDao {

	List<ProductVO> highCateList(int high_code);

}
