<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>

<%@ include file="../jsp/zljs/include-head-base.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>系统设置登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>scripts/jquery/jquery-1.3.2.min.js"></script>
	 
	 
	<link rel="stylesheet" href="<%=basePath%>css/default.css" type="text/css" media="all"/> 
 
  </head>
  
  <body>
  <% 
   %>
   <form method="post" action="<%=basePath %>getKeySet.do">
   请输入管理动态密码：<input type="password" name="pwd1"/>
   <input type="submit" value="登录"/>
   </form>
  </body>
</html>
