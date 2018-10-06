<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //????????
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("????????!");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
     String strAdminID=request.getParameter("adminid");
	 int    intAdminID=Integer.parseInt(strAdminID);
	 AdminManage adminmanage=new AdminManage();
	 String adminName=request.getParameter("adminname");
	 String adminPass=request.getParameter("adminpassword");
	 String allowIP=request.getParameter("adminIP");
	 String adminMemo=request.getParameter("memo");
	 
	 String adminRight[]=request.getParameterValues("adminRight");
	 String adminRightItem=null;
	 for(int i=0;i<adminRight.length;i++)
	 {
	   if(i==0)
	   {
	       adminRightItem=adminRight[i];
	   }
	   else
	   {
	       adminRightItem=adminRightItem+","+adminRight[i];
	   }
	 }	 
	 
	 int adminok=0;
	 String tip="ÐÞ¸Ä³É¹¦!";
	 tip=new String(tip.getBytes("GBK"),"8859_1");
	 adminok=adminmanage.updateAdministrator(intAdminID,adminName,adminPass,allowIP,adminMemo,adminRightItem);
	 if(adminok==-1)
	 {
	   response.sendRedirect("adminerror.jsp?act=mend");
	 }
	 if(adminok==-2)
	 {
	   response.sendRedirect("adminerror.jsp?act=mendsame");
	 }
	 response.sendRedirect("../common/success.jsp?tip="+tip);
%>


