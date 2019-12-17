package com.moseory.service;

import java.util.List;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.ProductAndFileVO;
import com.moseory.domain.ProductVO;

public interface HomeService {

    public List<ProductVO> readProductSaleCount();
    
    public List<ProductAndFileVO> readProductNew();
    
    public List<HighCateVO> readHighCate();
}
