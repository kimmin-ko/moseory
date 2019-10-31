package com.moseory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.HomeDao;
import com.moseory.domain.ProductVO;

import lombok.Setter;

@Service
public class HomeServiceImpl implements HomeService {

    @Setter(onMethod_ = @Autowired)
    private HomeDao homeDao;
    
    @Override
    public List<ProductVO> readProductSaleCount() {
	return homeDao.getProductSaleCount();
    }

    @Override
    public List<ProductVO> readProductNew() {
	return homeDao.getProductNew();
    }

}
