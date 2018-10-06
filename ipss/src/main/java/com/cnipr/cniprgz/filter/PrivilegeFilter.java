package com.cnipr.cniprgz.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class PrivilegeFilter {
	private String onErrorUrl;

	private FilterConfig filterConfig;

	public void init(FilterConfig config) throws ServletException {

		filterConfig = config;
		onErrorUrl = filterConfig.getInitParameter("onError");
		if (onErrorUrl == null || "".equals(onErrorUrl)) {
			onErrorUrl = "/index.jsp";
		}
	}
	
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain next) throws IOException, ServletException {
//		HttpServletRequest httpRequest = (HttpServletRequest) request;
//		HttpServletResponse httpResponse = (HttpServletResponse) response;
//		
//		String userId = (String) httpRequest.getSession().getAttribute(
//				Constant.APP_USER_ID);
//		
//		String method = request.getParameter("method");
	}
}
