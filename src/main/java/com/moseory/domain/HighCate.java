package com.moseory.domain;

public enum HighCate {
	
	OUTER(1),
	BOTTOM(2);
	
	private final int code;
	
	HighCate(int code) {
		this.code = code;
	}
	
	public int getCode() {
		return this.code;
	}
	
}
