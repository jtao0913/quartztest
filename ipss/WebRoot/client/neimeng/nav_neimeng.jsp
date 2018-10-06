<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//out.println(basePath);
%>

<table>
<tr><td><a href="<%=basePath%>index_nmnj.jsp">农机业</a></td></tr>
<tr><td><a href="<%=basePath%>index_nmnx.jsp">农畜业</a></td></tr>
<tr><td><a href="<%=basePath%>index_scy.jsp">沙产业</a></td></tr>
<tr><td><a href="<%=basePath%>index_xcy.jsp">畜产业</a></td></tr>
<tr><td><a href="<%=basePath%>index_ysjs.jsp">有色金属产业</a></td></tr>
<tr><td><a href="<%=basePath%>index_zbzz.jsp">装备制造产业</a></td></tr>
<tr><td><a href="<%=basePath%>index_stcy.jsp">生态产业</a></td></tr>
</table>
