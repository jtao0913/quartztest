package com.cnipr.cniprgz.struts.action;

//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.struts.action.ActionForm;
//import org.apache.struts.action.ActionForward;
//import org.apache.struts.action.ActionMapping;
//
//import com.cnipr.cniprgz.commons.Constant;
//import com.cnipr.cniprgz.commons.fenye.Page;
//import com.cnipr.cniprgz.entity.PageVisitLogInfo;
import com.cnipr.cniprgz.func.VisitCountFunc;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 页面访问日志、统计
 * 
 * @author Administrator
 * 
 */
public class VisitAction extends ActionSupport {

	private VisitCountFunc visitFunc;

	public void setVisitFunc(VisitCountFunc visitFunc) {
		this.visitFunc = visitFunc;
	}

	public String execute() throws Exception
	{
//		System.out.println("name=" + userinfo.getUsername());  
//		System.out.println("age=" + userinfo.getPassword());  
				
		return SUCCESS; 
	}
	/*
	public ActionForward getPageVisitLog(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {

		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");

		request.setAttribute("pagevisitLog", visitFunc.getPageVisitLog(
				startTime, endTime));

		return mapping.findForward("pageVisit");
	}

	public ActionForward getMemberVisitLog(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		// 当前页下标
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "1";
		}

		List<PageVisitLogInfo> visitInfoList = visitFunc.getMemberVisitInfo();

		int totalRecord = visitInfoList.size();
		// 设置总页数
		String count = Integer.toString((int) java.lang.Math
				.ceil((totalRecord - 1) / Constant.PAGERECORD) + 1);

		Page nav = new Page();
		nav.setPageCount(count);
		nav.setPageIndex(pageIndex);
		nav.setNavigationUrl(request.getContextPath());

		int startIndex = (Integer.parseInt(pageIndex) - 1)
				* Constant.PAGERECORD;
		// 本次显示 最后一条记录下标
		int endIndex = startIndex + Constant.PAGERECORD;
		if (endIndex > totalRecord) {
			endIndex = totalRecord;
		}
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("nav", nav);
		request.setAttribute("memberVisitLog", visitInfoList.subList(
				startIndex, endIndex));

		return mapping.findForward("memberVisit");
	}

	public ActionForward getMemberVisitHistory(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		// 当前页下标
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "1";
		}

		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userId = request.getParameter("userId");

		List<String> visitHistory = visitFunc.getMemberVisitHistory(Integer
				.parseInt(userId), startTime, endTime);

		int totalRecord = visitHistory.size();
		// 设置总页数
		String count = Integer.toString((int) java.lang.Math
				.ceil((totalRecord - 1) / Constant.PAGERECORD) + 1);

		Page nav = new Page();
		nav.setPageCount(count);
		nav.setPageIndex(pageIndex);
		nav.setNavigationUrl(request.getContextPath());

		int startIndex = (Integer.parseInt(pageIndex) - 1)
				* Constant.PAGERECORD;
		// 本次显示 最后一条记录下标
		int endIndex = startIndex + Constant.PAGERECORD;
		if (endIndex > totalRecord) {
			endIndex = totalRecord;
		}
		request.setAttribute("userName", request.getParameter("userName"));
		request.setAttribute("userId", userId);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("nav", nav);
		request.setAttribute("memberVisitHistory", visitHistory.subList(startIndex,
				endIndex));

		return mapping.findForward("memberhistory");
	}
*/
	
	
}
