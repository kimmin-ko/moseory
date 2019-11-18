
package com.moseory.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.AdminDao;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
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

	@Override
	public int saveParentsCategory(List<Integer> code, List<String> name, List<String> kname) {

		// return : 0 err 
		// return : 1  정상
		int status = 0;
		HighCateVO vo = new HighCateVO();;
		
		if(code.size() == name.size()) {
			
			for(int i=0; i<code.size();i++) {
				vo.setCode(code.get(i));
				vo.setName(name.get(i));
				vo.setKname(kname.get(i));
				adminDao.saveParentsCategory(vo);
			}
			
			status = 1;
		}else {
			status = 0;
		}
		return status;
	}

	@Override
	public List<ProductVO> getProductList(int start, int finish) {
		return adminDao.getProductList(start, finish);
	}

	@Override
	public int getProductCount() {
		return adminDao.getProductCount();
	}

	public int deleteParentsCategory(ArrayList<Integer> codes) {

		int status = 0;
		
		try {
			status = adminDao.deleteParentsCategory(codes);
		}catch(Exception e) {
			e.printStackTrace();
			status = 0;
		}
		
		return status;
	}

	@Override
	public List<LowCateVO> getChildCategory(int highCode) {
		return adminDao.getChildCategory(highCode);
	}

	@Override
	public int saveChildCategory(List<Integer> code, List<String> name, List<Integer> highCode) {
		// return : 0 err 
		// return : 1  정상
		int status = 0;
		LowCateVO vo = new LowCateVO();;
		
		if(code.size() == name.size()) {
			
			for(int i=0; i<code.size();i++) {
				vo.setCode(code.get(i));
				vo.setName(name.get(i));
				vo.setHigh_code(highCode.get(i));
				adminDao.saveChildCategory(vo);
			}
			
			status = 1;
		}else {
			status = 0;
		}
		return status;
	}

	@Override
	public int deleteChildCategory(ArrayList<Integer> codes) {

		int status = 0;
		
		try {
			status = adminDao.deleteChildCategory(codes);
		}catch(Exception e) {
			e.printStackTrace();
			status = 0;
		}
		
		return status;
	}
	
}	
