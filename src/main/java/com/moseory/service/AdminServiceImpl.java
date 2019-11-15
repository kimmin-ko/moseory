
package com.moseory.service;

import java.util.ArrayList;
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

	@Override
	public int saveParentsCategory(List<Integer> code, List<String> name) {

		// return : 0 err 
		// return : 1  정상
		int status = 0;
		HighCateVO vo = new HighCateVO();;
		
		if(code.size() == name.size()) {
			
			for(int i=0; i<code.size();i++) {
				vo.setCode(code.get(i));
				vo.setName(name.get(i));
				adminDao.saveParentsCategory(vo);
			}
			
			status = 1;
		}else {
			status = 0;
		}
		return status;
	}

}	
