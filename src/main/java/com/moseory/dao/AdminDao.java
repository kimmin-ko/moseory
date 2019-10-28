package com.moseory.dao;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

public interface AdminDao {

	void regist(ProductVO productVO, ProductDetailVO productdetailVO);

}
