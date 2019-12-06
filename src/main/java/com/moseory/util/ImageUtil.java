package com.moseory.util;

import org.springframework.stereotype.Component;

@Component
public class ImageUtil {

    public static String convertImagePath(String file_path) {
	
	String result = file_path.substring(file_path.indexOf("\\images"));
	
	return result;
    }
    
}
