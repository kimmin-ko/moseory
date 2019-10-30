package com.moseory.domain;

import lombok.Getter;

@Getter
public class LevelEnumMapperValue {
    
    private String grade;
    private int saving;
    private int discount;
    
    public LevelEnumMapperValue(LevelEnumMapperType levelEnumMapperType) {
	this.grade = levelEnumMapperType.getGrade();
	this.saving = levelEnumMapperType.getSaving();
	this.discount = levelEnumMapperType.getDiscount();
    }

}