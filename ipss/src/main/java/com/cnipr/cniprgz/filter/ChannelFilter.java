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

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.dao.IprUserDAO;

/**
 * 
 */
public class ChannelFilter implements Filter {

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
		onErrorUrl = "/jsp/SampleShow/SearchSample_fr.jsp";
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		// Current session
		String method = request.getParameter("method");

		if (method != null && method.equalsIgnoreCase("search")) {
			String[] channelArray = null;
			
			//获取查询频道信息（频道ID）
			String[] dbArray = request.getParameterValues("strdb");
			String tempChannel = "";
			if (dbArray != null) {
				for(String strChannel : dbArray) {
					tempChannel += strChannel + ",";
				}
				
				if (!tempChannel.equals("")) {
					channelArray = tempChannel.split(",");
				}
			}
			String strChannels = "";
			if (channelArray != null) {
				for (int i = 0; i < channelArray.length; i++) {
					strChannels += channelArray[i] + ",";
				}
				strChannels = strChannels.substring(0, strChannels.length() - 1);
			} else {
				strChannels = request.getParameter("strChannels");
				channelArray = strChannels.split(",");
			}
			
			String userId = (String) httpRequest.getSession().getAttribute(
					Constant.APP_USER_ID);
			IprUserDAO userDao = new IprUserDAO();
			String userChannelId = userDao.getUserChannelGrantById(userId);
			if (userChannelId != null && !userChannelId.equals("")) {
				String[] userChannelArray = userChannelId.split(",");
				if (checkChannelRight(channelArray, userChannelArray)) {
					next.doFilter(request, response);
					return;
				} else {
					request.setAttribute("have_no_right", "您没有检索国外专利信息的权限！");
					request.getRequestDispatcher(onErrorUrl).forward(httpRequest,
							httpResponse);
					return;
				}
			}
		} else {
			next.doFilter(request, response);
			return;
		}
	}
	
	private boolean checkChannelRight(String[] channelArray, String[] userChannelArray){
		for (String channel : channelArray) {
			boolean flag = false; 
			for (String userChannel : userChannelArray) {
				if (channel.equals(userChannel)) {
					flag = true;
					break;
				}
			}
			
			if (!flag) {
				return false;
			}
		}
		
		return true;
	}

	public void destroy() {
	}

	public static void main(String[] args){
//		String[] channelArray = {"1","2","3","4"};
//		String[] userChannelArray = {"1","2","8","3","4","5","7"};
//		System.out.println(ChannelFilter.checkChannelRight(channelArray, userChannelArray));
	}
}
