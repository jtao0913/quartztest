package com.cnipr.cniprgz.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class AdminAction extends ActionSupport {
	//public ActionForward addNode(ActionMapping mapping, ActionForm form,
	//		HttpServletRequest request, HttpServletResponse response) {
	public String addNode() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
//		System.out.println("添加节点");
		request.setAttribute("name", request.getParameter("name"));
		request.setAttribute("SequenceNum", request.getParameter("SequenceNum"));
		request.setAttribute("chrExpression", request.getParameter("chrExpression"));
		request.setAttribute("chrFRExpression", request.getParameter("chrFRExpression"));
		request.setAttribute("memo", request.getParameter("memo"));
		request.setAttribute("parentid", request.getParameter("parentid"));
		request.setAttribute("action", request.getParameter("action"));
		request.setAttribute("id", request.getParameter("id"));
		request.setAttribute("intMaxSearchCount", request.getParameter("intMaxSearchCount"));
//		System.out.println("--------::"+request.getParameter("CNChannels"));
		request.setAttribute("CNChannels", request.getParameter("CNChannels"));
		request.setAttribute("FRChannels", request.getParameter("FRChannels"));
		request.setAttribute("intType", request.getParameter("intType"));
		//return mapping.findForward("addNode");
		return SUCCESS;
	}
	
	//public ActionForward deleteNode(ActionMapping mapping, ActionForm form,
	//		HttpServletRequest request, HttpServletResponse response) {
	public String deleteNode() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		request.setAttribute("action", request.getParameter("action"));
		request.setAttribute("id", request.getParameter("id"));
		//return mapping.findForward("addNode");
		return SUCCESS;
	}
}
