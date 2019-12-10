package com.moseory.util;

import org.springframework.stereotype.Component;

@Component
public class ImageUtil {

    public static String convertImagePath(String file_path) {
	
	if(file_path == null || file_path.equals(""))
	    return "";
	
	int file_path_idx = 0;
	
	if(file_path.startsWith("/var")) { // 리눅스 환경 경로
	    file_path_idx = file_path.indexOf("/images");
	}else if(file_path.startsWith("C")) { // 윈도우 환경 경로
	    file_path_idx = file_path.indexOf("\\images");
	}else if(file_path.startsWith("E")) { // 윈도우 환경 경로
	    file_path_idx = file_path.indexOf("\\images");
	} else { // 그 외의 경우
	    return "";
	}
	
	String result = file_path.substring(file_path_idx);
	
	return result;
    }
    
}
