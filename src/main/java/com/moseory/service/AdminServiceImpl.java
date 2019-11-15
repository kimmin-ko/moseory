
package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.AdminDao;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDao adminDao;

	@Override
	public void product_regist(ProductVO productVO) {
		adminDao.product_regist(productVO);
	}

	@Override
	public int setCode(String name) {
		return adminDao.setCode(name);
	}

	@Override
	public void product_detail_regist(ProductDetailVO productdetailVO) {
		adminDao.product_detail_regist(productdetailVO);
	}

	@Override
	public String getHighCate(int high_code) {
		return adminDao.getHighCate(high_code);
	}

	@Override
	public String getLowCate(int low_code) {
		return adminDao.getLowCate(low_code);
	}

	@Override
	public List<HighCateVO> getPrantCategory() {
		return adminDao.getPrantCategory();
	}

}	
