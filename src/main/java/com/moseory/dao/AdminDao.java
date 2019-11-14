package com.moseory.dao;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

public interface AdminDao {

	void product_regist(ProductVO productVO);

	int setCode(String name);

	void product_detail_regist(ProductDetailVO productdetailVO);

	String getHighCate(int high_code);

	String getLowCate(int low_code);


}
