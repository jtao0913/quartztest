<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>

<%@ include file="../jsp/zljs/include-head-base.jsp"%>

<%

String settype = request.getParameter("settype");
String name = request.getParameter("name");
String val = request.getParameter("val");


if(settype!= null && settype.equals("app"))
{
	DataAccess.set(name,val);
	out.print("{jsonMessage:\"true\"}"); 
}
else if(settype!= null && settype.equals("setup"))
{
	SetupAccess.set(name,val);
	out.print("{jsonMessage:'true'}");
}
else
if(settype!= null && settype.equals("log74"))
{
	System.out.println(name);
	Log74Access.set(name,val);
	out.print("{jsonMessage:'true'}");
}
%>

 
