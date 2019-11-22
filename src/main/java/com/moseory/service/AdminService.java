
package com.moseory.service;


import java.util.ArrayList;
import java.util.List;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

public interface AdminService {

    void product_regist(ProductVO productVO);

    int setCode(String name);

    void product_detail_regist(ProductDetailVO productdetailVO);

	String getHighCate(int high_code);

	String getLowCate(int low_code);

	//상위 카테고리 목록
	public List<HighCateVO> getPrantCategory();

	List<ProductVO> getProductList(int start, int finish);

	int getProductCount();
	int getProductCount(String searchType, String keyword);
	//상위 카테고리 저장
	public int saveParentsCategory(List<Integer> code, List<String> name, List<String> kname);
	
	//상위 카테고리 삭제
	public int deleteParentsCategory(ArrayList<Integer> codes);
	
	//하위 카테고리 목록
	public List<LowCateVO> getChildCategory(int highCode);
	
	//하위 카테고리 저장
	public int saveChildCategory(List<Integer> code, List<String> name, List<Integer> highCode);
	
	//상위 카테고리 삭제
	public int deleteChildCategory(ArrayList<Integer> codes);

	List<ProductVO> getProductList(int start, int finish, String searchType, String keyword);

	int getHighCateCode(String keyword);

	int getLowCateCode(String keyword);

	
}
