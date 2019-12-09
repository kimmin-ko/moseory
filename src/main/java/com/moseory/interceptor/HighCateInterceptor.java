package com.moseory.interceptor;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.moseory.service.HomeService;

public class HighCateInterceptor extends HandlerInterceptorAdapter {
    
    @Autowired
    private ServletContext servletContext;

    @Autowired
    private HomeService homeService;
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
	
	servletContext.setAttribute("highCateList", homeService.readHighCate());
    }

}
