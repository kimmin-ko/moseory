package com.moseory.converter;

import java.time.LocalDate;

import org.springframework.core.convert.converter.Converter;

public class StringToLocalDateConverter implements Converter<String, LocalDate> {

    @Override
    public LocalDate convert(String source) {
	
	if(source == null || source.isEmpty()) {
	    return null;
	}
	
	return LocalDate.parse(source);
    }

}
