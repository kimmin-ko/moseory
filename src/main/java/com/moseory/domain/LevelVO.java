package com.moseory.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LevelVO {
    
    private Integer lev;
    private String grade;
    private Integer saving;
    private Integer discount;
    
}
