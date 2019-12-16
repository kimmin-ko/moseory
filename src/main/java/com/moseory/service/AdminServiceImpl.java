
package com.moseory.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.AdminDao;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.OrderStatsVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service("adminService")
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDao adminDao;

	@Override
	public void product_regist(ProductVO productVO) {
	    log.info(productVO);
		adminDao.product_regist(productVO);
	}

	@Override
	public int setCode(String name) {
		return adminDao.setCode(name);
	}

	@Override
	public void product_detail_regist(ProductDetailVO productdetailVO) {
	    	log.info(productdetailVO);
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
	@Override
	public int getProductCount(String searchType, String keyword) {
		return adminDao.getProductCount(searchType, keyword);
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


	@Override
	public List<ProductVO> getProductList(int start, int finish, String searchType, String keyword) {
		return adminDao.getProductList(start, finish, searchType, keyword);
	}

	@Override
	public int getHighCateCode(String searchType) {
		return adminDao.getHighCateCode(searchType);
	}

	@Override
	public int getLowCateCode(String keyword) {
		return adminDao.getLowCateCode(keyword);
	}

	@Override
	public List<MemberVO> getUser(HashMap<String, Object> map) {
		return adminDao.getUser(map);
	}

	@Override
	public MemberVO getUserDetail(String id) {
		return adminDao.getUserDetail(id);
	}

	@Override
	public int modifyUserInfo(Map<String, Object> param) {
		
		return adminDao.modifyUserInfo(param);
	}

	@Override
	public int getUserCount(HashMap<String, Object> map) {
		return adminDao.getUserCount(map);
	}

	@Override
	public List<HashMap<String, Object>> getOrder(HashMap<String, Object> map) {
		return adminDao.getOrder(map);
	}

	@Override
	public int getOrderCount(HashMap<String, Object> map) {
		return adminDao.getOrderCount(map);
	}

	@Override
	public HashMap<String, Object> getOrderInfo(HashMap<String,Object> map) {
		
		HashMap<String, Object> orderInfo = new HashMap<String, Object>();
		HashMap<String, Object> changeInfo = new HashMap<String, Object>();
		
		orderInfo = adminDao.getOrderInfo(map);
		
		String e_no = orderInfo.get("E_PRODUCT_DETAIL_NO") != null ? orderInfo.get("E_PRODUCT_DETAIL_NO").toString() : "";
		
		if(e_no != "") {
			changeInfo = adminDao.getChangeInfo(e_no);
			orderInfo.put("changeInfo", changeInfo);
		}
		
		return orderInfo;
	}
	
	@Override
	public void saveFile(Map<String, Object> fileParam) {
		adminDao.saveFile(fileParam);
	}

	@Override
	public Integer getOrderCount(int code) {
		return adminDao.getOrderCount(code);
	}
	
	@Override
	@Transactional
	public int modifyOrderInfo(HashMap<String,Object> param) {
		/*
		 * STATE 
		 * 1 교환 처리 중 : 반품 재고 증가, 교환 상품 재고 감소
		 * 2 교환 완료 : e_no 삽입 후 삭제
		 * 3 환불 처리 중 : 상품 판매량 감소, 상품 재고 증가
		 * */
		try {
			adminDao.modifyShippingInfo(param); //order 배송 정보 update
			adminDao.modifyShippingDetailInfo(param); //order_detail 주문 상태 update
			
			String state = param.get("state") != null ? param.get("state").toString() : "";
			String newState = param.get("newState") != null ? param.get("newState").toString() : "";
			
			//주문 배송 상태의 변경이 일어난지 체크
			if((newState != "" && state != "") && !newState.equals(state)) {
				if(newState.equals("교환 처리 중")) {
					adminDao.addStock(param); //반품 재고 증가
					adminDao.exchangeRemoveStock(param); //교환 상품 재고 감소
				}
				
				if(newState.equals("교환 완료")) {
					adminDao.modifyProductCode(param); //e_no 삽입 후 삭제
				}
				
				if(newState.equals("환불 처리 중")) {
					adminDao.addStock(param); //재고 증가
					adminDao.productSalesRateRemove(param); //상품 판매량 감소
				}
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public void registTransChk(ProductVO productVO,Map<String, Object> fileParam,
			List<ProductDetailVO> detailInfo) {
		/* product DB */
		product_regist(productVO);
		int code = setCode(productVO.getName());
		fileParam.put("product_code", code);
		saveFile(fileParam);
		/* product_detail DB */
		for (int i = 0; i < detailInfo.size(); i++) {
			ProductDetailVO productdetailVO = detailInfo.get(i);
			productdetailVO.setProduct_code(code);
			product_detail_regist(productdetailVO);
		}
		
		
	}

	@Override
	public List<OrderStatsVO> getOrderStats(String selectTerm) {
		return adminDao.getOrderStats(selectTerm);
	}
}	
