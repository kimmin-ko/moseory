
  package com.moseory.service;
  
  import org.springframework.beans.factory.annotation.Autowired; import
  org.springframework.stereotype.Service;
  
  import com.moseory.dao.AdminDao; import com.moseory.domain.ProductDetailVO;
  import com.moseory.domain.ProductVO;
  
  @Service("adminService") public class AdminServiceImpl implements
  AdminService{
  
  @Autowired private AdminDao adminDao;
  
  @Override public void regist(ProductVO productVO, ProductDetailVO
  productdetailVO) { adminDao.regist(productVO, productdetailVO); }
  
  
  }
 