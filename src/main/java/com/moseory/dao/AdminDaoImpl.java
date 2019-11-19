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
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

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
	return sqlSession.selectOne("product.getHighCate", high_code);
    }

    @Override
    public String getLowCate(int low_code) {
	return sqlSession.selectOne("product.getLowCate", low_code);
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
    public List<ProductVO> getProductList(int start, int finish) {
	Map<String, Integer> param = new HashMap<String, Integer>();
	param.put("start", start);
	param.put("finish", finish);
	System.out.println(sqlSession.selectList("product.getProductList", param));
	return sqlSession.selectList("product.getProductList", param);
    }

    @Override
    public int getProductCount() {
	return sqlSession.selectOne("product.getProductCount");
    }

    @Override
    public List<ProductVO> getProductList(int start, int finish, String searchType, String keyword) {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put("start", start);
	param.put("finish", finish);
	param.put("searchType", searchType);
	param.put("keyword", keyword);

	return sqlSession.selectList("product.getListOnSearch", param);
    }

}
