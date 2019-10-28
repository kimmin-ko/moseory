package com.moseory.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository
public interface AdminDao {

	void product_regist(ProductVO productVO);

	int setCode(String name);

	void product_detail_regist(ProductDetailVO productdetailVO);


}
