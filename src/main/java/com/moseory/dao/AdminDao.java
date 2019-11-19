package com.moseory.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
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
	
	//상위 카테고리 저장
	public void saveParentsCategory(HighCateVO vo);

	List<ProductVO> getProductList(int start, int finish);

	int getProductCount();
	//상위 카테고리 삭제
	public int deleteParentsCategory(@Param(value = "codes") ArrayList<Integer> codes);
	
	//하위 카테고리 목록
	public List<LowCateVO> getChildCategory(int highCode);
	
	//하위 카테고리 저장
	public void saveChildCategory(LowCateVO vo);
	
	//하위 카테고리 삭제
	public int deleteChildCategory(@Param(value = "codes") ArrayList<Integer> codes);

	List<ProductVO> getProductList(int start, int finish, String searchType, String keyword);
	
}
