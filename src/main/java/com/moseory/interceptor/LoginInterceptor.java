package com.moseory.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter{

	private static final String LOGIN = "/member/login";
	
	/* 
	 * postHandle = Session에 컨트롤러에서 저장한 user를 저장하고 /로 리다이렉트한다.
	 * preHandle = 기존의 로그인 정보가 있을 경우 초기화하는 역할
	 */
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object memberVO = modelMap.get("user");

		if(memberVO != null) {
			log.info("LoginInterceptor VO Check "+memberVO.toString());
			session.setAttribute("user", memberVO);
			Object destination = session.getAttribute("destination");
			Object destinationAdmin = session.getAttribute("destinationAdmin");
			if(destinationAdmin != null) {
				if(!memberVO.toString().contains("auth=1")) {
					response.sendRedirect("/index");
				}else {					
					response.sendRedirect(destinationAdmin != null ? (String) destinationAdmin : "/index");
				}
			}else {
				response.sendRedirect(destination != null ? (String) destination : "/index");				
			}
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
								Object handler) throws Exception {
		HttpSession session = request.getSession();
		//기존의 로그인 정보 제거
		if(session.getAttribute("user") != null) {
			session.removeAttribute("user");
		}
		
		return true;
	}
	
	
}
