<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<head>
<%
//String ip1 = request.getHeader("X-Real-IP");
//out.println("request.getHeader(\"X-Real-IP\")="+ip1);

//out.println("<br>");

//String ip2 = request.getRemoteAddr();
//out.println("request.getRemoteAddr()="+ip2);
%>

<%
/*
String fromSource = "X-Real-IP";  
String ip = request.getHeader("X-Real-IP");  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("X-Forwarded-For");  
    fromSource = "X-Forwarded-For";  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("Proxy-Client-IP");  
    fromSource = "Proxy-Client-IP";  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getHeader("WL-Proxy-Client-IP");  
    fromSource = "WL-Proxy-Client-IP";  
}  
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
    ip = request.getRemoteAddr();  
    fromSource = "request.getRemoteAddr";  
}  
out.println("App Client IP: "+ip+", fromSource: "+fromSource);
*/
%>

<%
/*
String ip = request.getHeader("x-forwarded-for");
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("Proxy-Client-IP");
}
out.println("11===="+ip+"<br>");
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("WL-Proxy-Client-IP");
}
out.println("22===="+ip+"<br>");
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getRemoteAddr();
}
out.println("33===="+ip);
*/
%>

<%
/*
String _ip = "";
    String ip = request.getHeader("X-Forwarded-For");
    if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
        //多次反向代理后会有多个ip值，第一个ip才是真实ip
        int index = ip.indexOf(",");
        if(index != -1){
        	_ip = ip.substring(0,index);
        }else{
        	_ip=ip;
        }
    }
    out.println("X-Forwarded-For--------" + _ip);
    out.println("<br>");
    
    ip = request.getHeader("X-Real-IP");
    if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
    	_ip=ip;
    }
    out.println("X-Real-IP--------"+_ip);
*/
    String remoteAddr = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
    out.println("IP--------"+remoteAddr);
%>

</head>