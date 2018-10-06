<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //用户当前登录对象
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("您的登录已经失效！");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
    String strAdminIDs[]=request.getParameterValues("sel");
	AdminManage adminmanage=new AdminManage();
	for(int i=0;i<strAdminIDs.length;i++)
	{
	   adminmanage.deleteAdministrator(Integer.parseInt(strAdminIDs[i]));
	}
	response.sendRedirect("AdminList.jsp");
%>