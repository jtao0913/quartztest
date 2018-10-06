package com.cnipr.cniprgz.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.func.print.PrintFunc;
import com.cnipr.cniprgz.log.CniprLogger;
import com.cnipr.cniprgz.log.PlatformLog;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.opensymphony.xwork2.ActionSupport;

public class PrintAction extends ActionSupport {

	private PrintFunc printFunc;

	public void setPrintFunc(PrintFunc printFunc) {
		this.printFunc = printFunc;
	}
	/*
	public ActionForward abstractPrint(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String displayCol = request.getParameter("downloadcol");
		String strPatentList = request.getParameter("patentList");
		String area = request.getParameter("area");

		boolean isGetPages = false;
		if (area.equals("0")) {
			isGetPages = true;
		}

		// System.out.println("strPatentList = " + strPatentList);

		List<PatentInfo> patentList = null;
		try {
			patentList = printFunc.abstractPrint(strPatentList,
					PatentInfo.class, isGetPages, Integer
							.valueOf((String) request.getSession()
									.getAttribute(Constant.APP_USER_ID)),
					(String) request.getSession().getAttribute(
							Constant.APP_USER_NAME), request.getRemoteAddr(),
					(Integer) request.getSession().getAttribute(
							Constant.APP_USER_FEETYPE));
		} catch (Exception e) {
			CniprLogger.LogError("PrintAction -> abstractPrint error: "
					+ e.getMessage());
		}

		
		
//		记录检索日志
		
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
		String userName = "";
		userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
		PlatformLog.insertTableLog(userName, request.getRemoteAddr(), "print");
		}
		
		request.setAttribute("patentList", patentList);
		request.setAttribute("displayCol", displayCol.split(","));

		return mapping.findForward("print");
	}

	public ActionForward documentPrint(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("documentPrint");
	}

	public ActionForward printXml(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		return mapping.findForward("printXml");
	}
	*/
}
