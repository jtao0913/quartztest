/**
 * 
 */
package com.cnipr.cniprgz.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;



public class LogoffAction extends ActionSupport {
//	public ActionForward logoff(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) throws Exception{
//		HttpSession session = request.getSession();
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

	public String logoff() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		session.removeAttribute(Constant.APP_USER_NAME);//Constant.APP_USER_NAME
		session.removeAttribute(Constant.APP_USER_ID);
		
		session.removeAttribute("menuList");
		session.setAttribute("username", "guest");
		String logoffPage = (String)session.getAttribute("logoffPage");
		
		session.invalidate();
		
		jsonresult = "已经退出";
		
		return SUCCESS;
		
	}
	
}
