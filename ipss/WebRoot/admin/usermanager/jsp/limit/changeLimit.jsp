<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.cnipr.cniprgz.entity.IprUser"%>
<%@page import="com.cnipr.cniprgz.commons.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(basePath.endsWith("//")){
	basePath = basePath.substring(0,basePath.length()-1);
}

out.print(request.getAttribute("jsonResult"));
%>
 