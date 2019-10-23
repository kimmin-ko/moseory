package com.moseory.dao;

import org.springframework.stereotype.Repository;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Repository
public interface AdminDao {

	void regist(ProductVO productVO, ProductDetailVO productdetailVO);

}
