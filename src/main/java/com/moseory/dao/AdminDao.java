package com.moseory.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderStatsVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
@Repository("adminDao")
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
	int getProductCount(String searchType, String keyword);
	//상위 카테고리 삭제
	public int deleteParentsCategory(@Param(value = "codes") ArrayList<Integer> codes);
	
	//하위 카테고리 목록
	public List<LowCateVO> getChildCategory(int highCode);
	
	//하위 카테고리 저장
	public void saveChildCategory(LowCateVO vo);
	
	//하위 카테고리 삭제
	public int deleteChildCategory(@Param(value = "codes") ArrayList<Integer> codes);

	List<ProductVO> getProductList(int start, int finish, String searchType, String keyword);

	int getLowCateCode(String keyword);

	int getHighCateCode(String keyword);

	public List<MemberVO> getUser(HashMap<String,Object> map);
	
	public int getUserCount(HashMap<String,Object> map);
	
	public MemberVO getUserDetail(String id);
	
	public int modifyUserInfo(Map<String, Object> param);

	void saveFile(Map<String, Object> fileParam);
	
	public List<HashMap<String, Object>> getOrder(HashMap<String,Object> map);
	
	public int getOrderCount(HashMap<String,Object> map);
	
	public HashMap<String, Object> getOrderInfo(HashMap<String,Object> map);
	
	public HashMap<String, Object> getChangeInfo(String e_no);
	
	public void modifyShippingInfo(HashMap<String,Object> param);
	
	public void modifyShippingDetailInfo(HashMap<String,Object> param);
	
	public void addStock(HashMap<String,Object> param);
	
	public void modifyProductCode(HashMap<String,Object> param);
	
	public void exchangeRemoveStock(HashMap<String,Object> param);
	
	public void productSalesRateRemove(HashMap<String,Object> param);

	Integer getOrderCount(int code);
	
	public void refundComplete(HashMap<String,Object> param);

	List<OrderStatsVO> getOrderStats(String selectTerm);

}

