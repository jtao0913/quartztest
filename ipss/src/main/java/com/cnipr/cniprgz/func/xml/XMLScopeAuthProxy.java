package com.cnipr.cniprgz.func.xml;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.authority.AbsDataAuthority;
import com.cnipr.cniprgz.authority.normal.NormalDataScopeAuthority;
import com.cnipr.cniprgz.log.CniprLogger;

public class XMLScopeAuthProxy extends AbsDataAuthority {

	private NormalDataScopeAuthority dataScopeAuthority;

	private HttpServletRequest request;

	private HttpServletResponse response;

	public XMLScopeAuthProxy(HttpServletRequest request,
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public boolean hasDataAuthority(String role, String funcName,
			String dataType, int page) {

		if (dataScopeAuthority == null)
			dataScopeAuthority = new NormalDataScopeAuthority();

		if (!dataScopeAuthority.hasDataAuthority(role, funcName,
				dataType, page))
			postValid();

		return dataScopeAuthority.isAuthorityFlag();
	}

	// 数据权限验证前的要做的一些处理
	public void preValid() {
	}

	// 数据权限验证后的要做的一些处理
	public void postValid() {
		// 以后可能会扩展一些log，或者监控什么的功能
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		try {
			response
					.getWriter()
					.write(
							"对不起，您的权限不允许访问代码化数据，请点击<a href=\"javascript:history.back()\">这里</a>返回，或<a href=\""
									+ request.getContextPath()
									+ "/logoff.do?method=logoff\" target=\"_top\">退出</a>后使用其他注册用户访问更多数据。");
		} catch (IOException e) {
			CniprLogger.LogError("XMLScopeAuthProxy postValid happend error : " + e.getMessage());
		}
	}

}
