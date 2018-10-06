package com.cnipr.cniprgz.servlet.proxy.event;

import java.util.EventObject;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.cnipr.cniprgz.security.SecurityTools;
import com.cnipr.cniprgz.servlet.proxy.CniprProxyServlet;

public class AuthorityValidListener implements IListener{

	public void performed(EventObject e) {
		CniprProxyServlet common = (CniprProxyServlet)e.getSource();
		HttpServletRequest request = common.getRequest();
		if(request.getParameter("appType").equals("0") && request.getRequestURI().startsWith(request.getContextPath())){
			common.setValidCode("0");
		} else {
			String securityCode = request.getParameter("securityCode");
			String strWhere = request.getParameter("strWhere");
		
			if (securityCode == null || securityCode.equals("")) {
				common.setValidCode("101"); // 请求参数不合法，securityCode为空
				return;
			}
			
			if (strWhere == null || strWhere.equals("")) {
				common.setValidCode("102"); // 请求参数不合法，表达式为空
				return;
			}
			
			if (SecurityTools.getSecurityCode(strWhere).equals(securityCode)){
				common.setValidCode("0");
			} else {
				common.setValidCode("103");  // 验证码不匹配
			}
				//DataAccess.getProperty(remoteAddr);
//			if (appType != null && !appType.equals("")) {
//				// 如果配置文件中含有请求的IP，则视为合法，放行
//				if(DataAccess.getProperty(appType).contains(remoteAddr)){ 
//					common.setValidCode("0");
//				} else {
//					common.setValidCode("102"); // 请求IP不合法，不在指定的范围内
//				}
//			} else {
//				common.setValidCode("101");  // 应用类型ID不合法，不在指定的范围内
//			}
//		}
		}
	}
	
}
