<!DOCTYPE html>
<html>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cnipr.cniprgz.func.stat.*" %>
<%
List<StatBean> resultList = (List<StatBean>)request.getAttribute("resultList");
//System.out.println("resultList="+resultList);
String statrealname = (String)request.getAttribute("statrealname");
//System.out.println("statrealname="+statrealname);
int userid = 0;
//System.out.println("userid="+userid);

if(request.getAttribute("userid")!=null){
	userid = (Integer)request.getAttribute("userid");
}
%>
<head>
<title>统计管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>

<script type="text/javascript" src="admin/usermanager/jsp/stat/newdate/WdatePicker.js"></script>

<%
if(resultList!=null){
%>
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">		
<%String menuname = "statmanage";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>
        <div class="span10">
         <!--span10 -->
       
<table cellspacing="0" cellpadding="0" width="96%" border="0" style="margin-left: 5px;">
<form action="statdetail.do" method="post">
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="statrealname" value="<%=statrealname%>">


	<tr>
		<td width="40%" align="center">
			<strong>开始时间：</strong>
			<input id="begin_recepttime" name="begin_recepttime" onFocus="WdatePicker({lang:'zh-cn'})" class="Wdate"/>
		</td>
		<td width="40%">
		<strong>结束时间：</strong>
		<input id="end_recepttime" name="end_recepttime" onFocus="WdatePicker({lang:'zh-cn'})" class="Wdate"/>
			
		</td>
		<td width="20%">
		 <input type="submit" class="btn btn-primary" value="统 计"/>
		</td>
	</tr>
	<tr>
	</tr>
	</form>
</table>

<br>
<table class="table table-striped table-bordered table-hover " style="font-size:12px;">
	<caption><strong><span style="font-size: 18px;"><%=statrealname%> 平台使用情况统计</span></strong></caption>
	<tr bgcolor="#4787b8"> 
	      <td  align="center" width="9%"><b>时间段</b></td>
	      <td  align="center" width="6%"><b>登录</b></td>
	      <td  align="center" width="6%"><b>查询</b></td>
	      <td  align="center" width="8%"><b>查看文摘</b></td>
	      <!--<td  align="center" width="10%"><b>中国专利说明书浏览量</b></td>
	      <td  align="center" width="10%"><b>发明授权说明书浏览量</b></td>
	      <td  align="center" width="10%"><b>实用新型说明书浏览量</b></td>
	      <td  align="center" width="10%"><b>外观设计说明书浏览量</b></td>-->
	      <td  align="center" width="8%"><b>国外文摘浏览量</b></td>
	      <%--<td  align="center" width="9%"><b>说明书下载</b></td>
	      <td  align="center" width="9%"><font color="#FFFFFF"><b>说明书打印</b></font></td>
	    --%></tr>
	    <% int item1=0,item2=0,item3=0,item4=0,item5=0,item6=0,item7=0,item8=0,item9=0,item10=0; %>
	    <%  
	    	for(int i=0;i<resultList.size();i++){ %>
		<tr <%if(i%2!=0){ %> bgcolor="#F5F9FF" <%} %>>
	      <td align="center"><%=resultList.get(i).getStrTime()%></td>
	      <td align="center"><%=resultList.get(i).getLoginCount()%></td>
	      <td align="center"><%=resultList.get(i).getSearchCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewCount()%></td>
	      <!--<td align="center"><%=resultList.get(i).getViewDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewSQDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewXXDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewWGDocCount()%></td>-->
	      <td align="center"><%=resultList.get(i).getViewFrCount()%></td>
	      <%--<td align="center"><%=resultList.get(i).getDownloadDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getPrintDocCount()%></td>
	    --%></tr>
		    <%
		    item1+=resultList.get(i).getLoginCount();
		    item2+=resultList.get(i).getSearchCount();
		    item3+=resultList.get(i).getViewCount();
//		    item4+=resultList.get(i).getViewDocCount();
//		    item5+=resultList.get(i).getViewSQDocCount();
//		    item6+=resultList.get(i).getViewXXDocCount();
//		    item7+=resultList.get(i).getViewWGDocCount();
		    item8+=resultList.get(i).getViewFrCount();
//		    item9+=resultList.get(i).getDownloadDocCount();
//		    item10+=resultList.get(i).getPrintDocCount();
		   }
	    %>
	    <tr>
	    	<td align="center">合计</td>
	    	<td align="center"><%=item1 %></td>
	    	<td align="center"><%=item2 %></td>
	    	<td align="center"><%=item3 %></td>
	    	<!-- <td align="center"><%=item4 %></td>
	    	<td align="center"><%=item5 %></td>
	    	<td align="center"><%=item6 %></td>
	    	<td align="center"><%=item7 %></td> -->
	    	<td align="center"><%=item8 %></td>
	    	<%--<td align="center"><%=item9 %></td>
	    	<td align="center"><%=item10 %></td>
	    --%></tr>

</table>
         <!--span10 -->
        </div>
      </div>
</div>
</div>
<%} %>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lhgdialog/lhgcore.lhgdialog.min.js"></script>


<!--main结束-->	
<%@ include file="/jsp/zljs/include-buttom.jsp"%>
</body>
</html>