/**
 * 
 */
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

import com.cnipr.cniprgz.authority.AbsFuncAuthority;
import com.cnipr.cniprgz.authority.normal.NormalFuncAuthority;
import com.cnipr.cniprgz.commons.Constant;

public class AuthenticationFilter implements Filter {

	private String onErrorUrl;

	private FilterConfig filterConfig;

	protected boolean ignore = true;

	public void init(FilterConfig config) throws ServletException {
		filterConfig = config;
		onErrorUrl = filterConfig.getInitParameter("onError");
		if (onErrorUrl == null || "".equals(onErrorUrl)) {
			onErrorUrl = "/index.htm";
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain next) throws IOException, ServletException {
		onErrorUrl = "/logoff.jsp";
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		// Current session
		String method = request.getParameter("method");
		String userId = (String) httpRequest.getSession().getAttribute(
				Constant.APP_USER_ID);
		// Integer userRoleId = (Integer) httpRequest.getSession().getAttribute(
		// Constant.APP_USER_ROLE);
		if (httpRequest.getRequestURI().endsWith("cniprProxy.do")) {
			HttpSession session = httpRequest.getSession();
			session.setAttribute(Constant.APP_USER_NAME, "admin");
			session.setAttribute(Constant.APP_USER_ID, "1");
			session.setAttribute(Constant.APP_USER_CHANNELID, "");
			session.setAttribute(Constant.APP_USER_ITEMGRANT, "");
			session.setAttribute(Constant.APP_USER_ROLE, 2);
			session.setAttribute(Constant.APP_USER_FEETYPE, 0);
			session.setAttribute("strUserType", "corp");
			session.setAttribute("intCHCount", 0);
			session.setAttribute("intFRCount", 0);
			session.setAttribute("dtRegisterTime", "");
			session.setAttribute("dtCurrentCardTime", "");
		} else {
			if (!hasLogin(method, userId)) {
				request.setAttribute("timeout", "超时, 请重新登录!");
				request.getRequestDispatcher(onErrorUrl).forward(httpRequest,
						httpResponse);
				return;
			}
		}

		// if (method != null && !method.equalsIgnoreCase("login")
		// && !hasAuthority(method, userRoleId, httpRequest, httpResponse)) {
		// return;
		// }

		next.doFilter(request, response);
		return;
		// if (method != null && method.equalsIgnoreCase("login")) {
		// next.doFilter(request, response);
		// return;
		// } else if (method != null) {
		//			
		// if (userId == null) {
		//				
		// } else {
		// next.doFilter(request, response);
		// return;
		// }
		// } else {
		// next.doFilter(request, response);
		// return;
		// }
	}
	
	private boolean hasLogin(String method, String userId) {
		if (method != null && !method.equalsIgnoreCase("login")
				 && !method.equalsIgnoreCase("logoff")
				&& !method.equalsIgnoreCase("dataScopeSearch")
				&& !method.equalsIgnoreCase("quickShowChannelForm")
				&& !method.equalsIgnoreCase("quickIndustriesSearch")
				&& userId == null) {
			return false;
		} else {
			return true;
		}
	}

//	private boolean hasAuthority(String method, Integer userRoleId,
//			HttpServletRequest httpRequest, HttpServletResponse httpResponse) {
//		AbsFuncAuthority authority = new NormalFuncAuthority(httpRequest,
//				httpResponse);
//		return authority.hasFuncAuthority(method, userRoleId);
//	}

	public void destroy() {
	}

}
