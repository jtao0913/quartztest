<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/taglib/struts-bean.tld" prefix="bean"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'guestLogin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body width="400" height="200" style="background-color: #C7E2ED;">
  <div align="center" >
  	<div>
  	  <div align="right"><a href="javascript:window.parent.myLytebox.end();">取消</a></div>
  	</div>
    <table width="284">
		<tr>
			<td nowrap align="center">
				<strong>用户名：</strong>
			</td>
			<td align="center">
				<input name="userName" type="text" id="userName" value="cnipr"
					style="width:160;height:22">
			</td>
		</tr>
		<tr>
			<td nowrap align="center">
				<strong>密&nbsp;&nbsp;&nbsp; 码：</strong>
			</td>
			<td align="center">
				<input name="password" type="password"
					id="password" value="123456"
					style="width:160;height:22">
			</td>
		</tr>
		<tr><td></td><td align="center"><span class="style2"><html:errors property="login_error"/></span></td></tr>
	</table>
  </div>
</body>
</html>
