package com.moseory.dao;

import java.util.List;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.ProductAndFileVO;
import com.moseory.domain.ProductVO;

public interface HomeDao {
    
    public List<ProductVO> getProductSaleCount();
    
    public List<ProductAndFileVO> getProductNew();
    
    public List<HighCateVO> getHighCate();
}
