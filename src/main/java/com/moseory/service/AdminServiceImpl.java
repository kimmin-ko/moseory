package com.moseory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.AdminDao;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.AdminDao;
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
	

	
public class AdminServiceImpl implements AdminService {

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

}
