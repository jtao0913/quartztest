<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<%
	String method = request.getParameter("method");
	TSimpleWarnDAO simpleWarnDAO = new TSimpleWarnDAO(); 

	TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO();
	  
	if(method!=null && method.equals("delete"))//删除
	{
		String id = request.getParameter("id");
		String warnid = request.getParameter("warnid");
		String start = "1";
		if(request.getParameter("start")!=null){
			start = request.getParameter("start");
		}  
		simpleExecuteDAO.delete(id);
		request.setAttribute("warnMessage","删除成功！"); 
		RequestDispatcher rd = null;
		ServletContext sc = getServletContext();
//      rd = sc.getRequestDispatcher("/warnExecuteList.do?start="+start);//定向的页面 
//      rd.forward(request, response);
        
        response.sendRedirect(basePath + "warnExecuteList.do?warnid="+warnid);
	}else
		 if(method!=null && method.equals("isnew"))
		 {
			String id = request.getParameter("id");
			String start = "1";
			if(request.getParameter("start")!=null){
				start = request.getParameter("start");
			} 
			simpleExecuteDAO.updateIsnew(id,0);
			out.print("{jsonMessage:'true'}");
		 }
%>     
