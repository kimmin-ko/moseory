package com.moseory.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthInterceptor extends HandlerInterceptorAdapter{

	// 페이지 요청 정보 저장
	private void saveDestination(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String query = req.getQueryString();
		if(query == null || query.equals("null")) {
			query ="";
		}else {
			query= "?" + query;
		}
		if(req.getMethod().equals("GET")) {
			req.getSession().setAttribute("destination", uri + query);
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null) {
//			log.info("authinterceptor -> preHandle null");
			saveDestination(request);
			response.sendRedirect("/member/login");
			return false;
		}
//		System.out.println("authinterceptor -> preHandle not null");
		return true;
	}
	
}














