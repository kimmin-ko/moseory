package com.moseory.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderStatsVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Repository("adminDao")
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void product_regist(ProductVO productVO) {
		sqlSession.insert("product.regist", productVO);
	}

	@Override
	public int setCode(String name) {
		return sqlSession.selectOne("product.setCode", name);
	}

	@Override
	public void product_detail_regist(ProductDetailVO productdetailVO) {
		sqlSession.insert("product.product_detail_regist", productdetailVO);
	}

	@Override
	public String getHighCate(int high_code) {
		return sqlSession.selectOne("AdminMapper.getHighCate", high_code);
	}

	@Override
	public String getLowCate(int low_code) {
		return sqlSession.selectOne("AdminMapper.getLowCate", low_code);
	}

	@Override
	public List<HighCateVO> getPrantCategory() {
		return sqlSession.selectList("AdminMapper.getPrantCategory");
	}

	@Override
	public void saveParentsCategory(HighCateVO vo) {
		sqlSession.insert("AdminMapper.saveParentsCategory", vo);
	}

	@Override
	public int deleteParentsCategory(@Param(value = "codes") ArrayList<Integer> codes) {
		return sqlSession.delete("AdminMapper.deleteParentsCategory", codes);
	}

	@Override
	public List<LowCateVO> getChildCategory(int highCode) {
		return sqlSession.selectList("AdminMapper.getChildCategory", highCode);
	}

	@Override
	public void saveChildCategory(LowCateVO vo) {
		sqlSession.insert("AdminMapper.saveChildCategory", vo);
	}

	@Override
	public int deleteChildCategory(@Param(value = "codes") ArrayList<Integer> codes) {
		return sqlSession.delete("AdminMapper.deleteChildCategory", codes);
	}

	@Override
	public int getProductCount() {
		return sqlSession.selectOne("product.getProductCount");
	}

	@Override
	public int getProductCount(String searchType, String keyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		keyword = Integer.toString(sqlSession.selectOne("AdminMapper.getHighCateCode", keyword));
		param.put("searchType", searchType);
		param.put("keyword", keyword);

		return sqlSession.selectOne("product.getProductCount2", param);
	}

	@Override
	public List<ProductVO> getProductList(int start, int finish) {
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("start", start);
		param.put("finish", finish);
		return sqlSession.selectList("product.getProductList", param);
	}

	@Override
	public List<ProductVO> getProductList(int start, int finish, String searchType, String keyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		keyword = Integer.toString(sqlSession.selectOne("AdminMapper.getHighCateCode", keyword));
		param.put("start", start);
		param.put("finish", finish);
		param.put("searchType", searchType);
		param.put("keyword", keyword);

		return sqlSession.selectList("product.getListOnSearch", param);
	}

	@Override
	public int getHighCateCode(String keyword) {
		return sqlSession.selectOne("AdminMapper.getHighCateCode", keyword);
	}

	@Override
	public int getLowCateCode(String keyword) {
		return sqlSession.selectOne("AdminMapper.getLowCateCode", keyword);
	}

	@Override
	public List<MemberVO> getUser(HashMap<String, Object> map) {
		return sqlSession.selectList("AdminMapper.getUser", map);
	}

	@Override
	public MemberVO getUserDetail(String id) {
		return sqlSession.selectOne("AdminMapper.getUserDetail", id);
	}

	@Override
	public int modifyUserInfo(Map<String, Object> param) {
		log.info("password : " + param.get("password"));
		return sqlSession.update("AdminMapper.modifyUserInfo", param);
	}

	@Override
	public int getUserCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("AdminMapper.getUserCount", map);
	}

	@Override
	public List<HashMap<String, Object>> getOrder(HashMap<String, Object> map) {
		return sqlSession.selectList("AdminMapper.getOrder", map);
	}

	@Override
	public int getOrderCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("AdminMapper.getOrderCount", map);
	}

	@Override
	public HashMap<String, Object> getOrderInfo(HashMap<String, Object> map) {
		return sqlSession.selectOne("AdminMapper.getOrderInfo", map);
	}

	@Override
	public void saveFile(Map<String, Object> fileParam) {
		sqlSession.insert("product.saveFile", fileParam);
	}

	@Override
	public HashMap<String, Object> getChangeInfo(String e_no) {
		return sqlSession.selectOne("AdminMapper.getChangeInfo", e_no);
	}

	@Override
	public void modifyShippingInfo(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.modifyShippingInfo", param);
	}

	@Override
	public void modifyShippingDetailInfo(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.modifyShippingDetailInfo", param);
	}

	@Override
	public void addStock(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.addStock", param);
	}

	@Override
	public void modifyProductCode(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.modifyProductCode", param);
	}

	@Override
	public void exchangeRemoveStock(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.exchangeRemoveStock", param);
	}

	@Override
	public void productSalesRateRemove(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.productSalesRateRemove", param);
	}

	public Integer getOrderCount(int code) {
		return sqlSession.selectOne("AdminMapper.getOrderCount2", code);
	}

	@Override
	public void refundComplete(HashMap<String, Object> param) {
		sqlSession.update("AdminMapper.refundComplete", param);
	}

	@Override
	public List<OrderStatsVO> getOrderStats(String selectTerm) {
		System.out.println("selectTerm = " + selectTerm);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("selectTerm", selectTerm);
		System.out.println("dao : " + sqlSession.selectList("AdminMapper.getOrderStats", param));
		return sqlSession.selectList("AdminMapper.getOrderStats", param);
	}
}