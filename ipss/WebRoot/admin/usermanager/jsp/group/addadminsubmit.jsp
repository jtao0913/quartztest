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
	 AdminManage adminmanage=new AdminManage();
	 String adminName=request.getParameter("adminname");
	 String adminPassword=request.getParameter("adminpassword");
	 String adminIP=request.getParameter("adminIP");
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

//	 System.out.println("adminRightItem="+adminRightItem);

	 String tip="Ìí¼Ó³É¹¦!";
	 int   adminok=0;
	 tip=new String(tip.getBytes("GBK"),"8859_1");
	 adminok=adminmanage.addAdministrator(adminName,adminPassword,adminIP,adminMemo,adminRightItem);
	 if(adminok==-1)
	 {
	   response.sendRedirect("adminerror.jsp?act=add");
	 }
	 if(adminok==-2)
	 {
	   response.sendRedirect("adminerror.jsp?act=addsame");
	 }
	 response.sendRedirect("../common/success.jsp?tip="+tip+"&act=goon");
%>


