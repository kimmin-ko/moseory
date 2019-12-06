package com.moseory.util;

import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class ImageUtil {

    public static String convertImagePath(String file_path) {
	
	if(file_path == null || file_path.equals(""))
	    return "";
	
	String result = file_path.substring(file_path.indexOf("\\images"));
	log.info("result : " + result);
	return result;
    }
    
}
