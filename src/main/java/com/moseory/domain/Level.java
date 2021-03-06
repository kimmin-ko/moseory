package com.moseory.domain;

import com.moseory.typeHandler.BaseLevelEnum;

import lombok.Getter;

@Getter // @Data는 class만 지원
public enum Level implements BaseLevelEnum, LevelEnumMapperType {

	VVIP(5, "VVIP", 3, 3, null), 
	VIP(4, "VIP", 3, 2, VVIP), 
	GOLD(3, "GOLD", 2, 2, VIP), 
	SILVER(2, "SILVER", 2, 1, GOLD),
	BRONZE(1, "BRONZE", 1, 1, SILVER);

	private final int level;
	private final String grade;
	private final int saving;
	private final int discount;
	private final Level next;

	Level(int level, String grade, int saving, int discount, Level next) {
		this.level = level;
		this.grade = grade;
		this.saving = saving;
		this.discount = discount;
		this.next = next;
	}

	public int intLevel() {
		return this.level;
	}

	/* BaseLevelEnum */
	@Override
	public int getLevel() {
		return this.level;
	}

	/* LevelEnumMapperType */
	@Override
	public String getGrade() {
		return this.grade;
	}

	@Override
	public int getSaving() {
		return this.saving;
	}

	@Override
	public int getDiscount() {
		return this.discount;
	}

}
