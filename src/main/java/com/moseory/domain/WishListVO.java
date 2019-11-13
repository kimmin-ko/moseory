package com.moseory.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WishListVO {
    
    private String member_id;
    private List<ProductVO> products;
    
}
