package com.cnipr.cniprgz.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.struts.action.LoginAction;

/**
 * 登录过滤器
 * 
 * @author Administrator
 * 
 */
public class LoginFilter implements Filter {

	public void init(FilterConfig arg0) throws ServletException {}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain filterChain) throws IOException, ServletException {		
		HttpServletRequest httpReq = (HttpServletRequest) req;
		HttpServletResponse httpRes = (HttpServletResponse) res;
		HttpSession session = httpReq.getSession();

		String username = session.getAttribute(Constant.APP_USER_NAME) == null ? ""
				: (String) session.getAttribute(Constant.APP_USER_NAME);
//		System.out.println("username1=" + username);
		
		if(username.equals("")){
//			LoginAction loginaction = new LoginAction();
//			loginaction.setUsername("guest");
//			loginaction.setUsername("123456");
//			loginaction.login();
			(httpRes).sendRedirect("/login.jsp");
		}
		
//		String reqUrl = httpReq.getServletPath();
//		boolean isFolder = false;
//		if (reqUrl.endsWith("/")) { // url格式是....pro/lan时所做的处理。
//			reqUrl = reqUrl.substring(0, reqUrl.length() - 1);
//			isFolder = true;
//		}
//		// logger.debug("url-logger:"+reqUrl);
//		if (reqUrl.indexOf(".") == -1) { // 一个页面里的js文件引入，CSS文件引入，图片引入都是url，都要
//			// 在这里处理
//			// logger.debug("access url :"+reqUrl);
//			// 这里用getClass().getResourceAsStream这个方法是为了得到page.properties的真实地址
//			InputStream is = getClass().getResourceAsStream(
//					"/config/page.properties");
//			Properties prop = new Properties();
//			prop.load(is);
//			String disPatchUrl = prop.getProperty(reqUrl);
//			// logger.debug("dispatch Url :"+disPatchUrl);
//			if (disPatchUrl != null && !"".equals(disPatchUrl)) {
//				if (isFolder)
//					httpRes.sendRedirect(disPatchUrl);
//				else
//					httpReq.getRequestDispatcher(disPatchUrl).forward(req, res);
//			} else {
//				filterChain.doFilter(req, res);
//			}
//		} else { 
//			//当一些请求是js引入文件的url，或者是一些图片的url时所做的处理，这样图片的地址
//			//就不会被过滤掉，不然你页面上的图片不能正常显示
//			filterChain.doFilter(req, res);
//		}
		filterChain.doFilter(req, res);
	}

	public void doFilter1(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest re = (HttpServletRequest) request;
		HttpSession session = re.getSession();

		String username = session.getAttribute(Constant.APP_USER_NAME) == null ? ""
				: (String) session.getAttribute(Constant.APP_USER_NAME);
//		System.out.println("username1=" + username);

		if (session.getAttribute("loginuser") != null) {
			chain.doFilter(request, response);
		} else {
			request.getRequestDispatcher("index.jsp")
					.forward(request, response);
		}
	}

	public void destroy() {
	}
}