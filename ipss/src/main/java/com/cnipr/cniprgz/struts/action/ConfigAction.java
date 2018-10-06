package com.cnipr.cniprgz.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.jbase.common.util.security.MD5;

import com.cnipr.cniprgz.commons.DataAccess;
import com.opensymphony.xwork2.ActionSupport;

public class ConfigAction extends ActionSupport {
	/*
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	{		
		String key = DataAccess.getProperty("key");
		String configkey = request.getParameter("configkey");
		String appconfigkey = DataAccess.getProperty("configkey");
		if(appconfigkey!=null )
		{
			MD5 md5 = new MD5();
			String md5key = md5.md5(configkey+key);
			
			if(md5key!=null && md5key.equals(appconfigkey))
			{
				request.setAttribute("islogin", "1");
			}
		}
		
		return mapping.findForward("config");
	}
	*/
}
