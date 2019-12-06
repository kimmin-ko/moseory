package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.HomeDao;
import com.moseory.domain.HighCateVO;
import com.moseory.domain.ProductVO;
import com.moseory.util.ImageUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class HomeServiceImpl implements HomeService {

    @Setter(onMethod_ = @Autowired)
    private HomeDao homeDao;
    
    @Override
    public List<ProductVO> readProductSaleCount() {
	List<ProductVO> product_list = homeDao.getProductSaleCount(); 
	for(ProductVO vo : product_list) {
	    vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
	}
	return product_list;
    }

    @Override
    public List<ProductVO> readProductNew() {
	List<ProductVO> product_list = homeDao.getProductNew(); 
	for(ProductVO vo : product_list) {
	    vo.setFile_path(ImageUtil.convertImagePath(vo.getFile_path()));
	}
	return product_list;
    }

    @Override
    public List<HighCateVO> readHighCate() {
	return homeDao.getHighCate();
    }

}
