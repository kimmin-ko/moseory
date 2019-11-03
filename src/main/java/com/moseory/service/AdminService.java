
package com.moseory.service;
  
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

public interface AdminService {

	void product_regist(ProductVO productVO);

	int setCode(String name);

	void product_detail_regist(ProductDetailVO productdetailVO);


}
