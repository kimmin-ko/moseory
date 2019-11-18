package com.moseory.dao;

import java.util.List;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

public interface AdminDao {

	void product_regist(ProductVO productVO);

	int setCode(String name);

	void product_detail_regist(ProductDetailVO productdetailVO);

	String getHighCate(int high_code);

	String getLowCate(int low_code);

	//상위 카테고리 목록 
	public List<HighCateVO> getPrantCategory();
	
	public void saveParentsCategory(HighCateVO vo);

	List<ProductVO> getProductList(int start, int finish);

	int getProductCount();
	
}
