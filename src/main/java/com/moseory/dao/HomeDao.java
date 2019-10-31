package com.moseory.dao;

import java.util.List;

import com.moseory.domain.ProductVO;

public interface HomeDao {
    
    public List<ProductVO> getProductSaleCount();
    
    public List<ProductVO> getProductNew();
}
