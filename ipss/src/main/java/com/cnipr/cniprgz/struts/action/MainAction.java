package com.cnipr.cniprgz.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.func.VisitCountFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class MainAction extends ActionSupport {
	
	private VisitCountFunc visitFunc;

	public void setVisitFunc(VisitCountFunc visitFunc) {
		this.visitFunc = visitFunc;
	}
	
//	public String gotoMain(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
		
	public String gotoMain() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		visitFunc.addMemberVisitLog(Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID)));
		
		request.setAttribute("rootId", request.getParameter("rootId"));
		
		return SUCCESS;
	}
}
