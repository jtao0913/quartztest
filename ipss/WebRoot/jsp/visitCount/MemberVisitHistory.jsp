<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
    <title>用户登陆记录</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   
<link rel="stylesheet" href="/admin/css/style.css" type="text/css">
<style type="text/css">
<!--
A:link {color: blue;text-decoration: none;font-size: 9pt;}
A:visited {color:blue;text-decoration: none;font-size: 9pt;}
A:active {color:blue;text-decoration: none;font-size: 9pt;}
A:hover {color: blue;text-decoration: underline;font-size: 9pt;} 
body {
	background-color: #f0f7ff;
}
 
-->
</style>
<script type="text/javascript" src="<%=basePath%>js/datepicker/WdatePicker.js"></script>
<script type="text/javascript">
			function nextPage(pageIndex){
				document.searchForm.pageIndex.value = pageIndex;
				document.searchForm.submit();
			}
	</script>
  </head>
  
  <body>
  <form name="searchForm" action="visitCount.do?method=getMemberVisitHistory" method="post">
  	<input type="hidden" name="userName" value="${requestScope.userName}"/>
  	<input type="hidden" name="userId" value="${requestScope.userId}"/>
  	<input type="hidden" name="startTime" value="${requestScope.startTime}"/>
  	<input type="hidden" name="endTime" value="${requestScope.endTime}"/>
  	<input type="hidden" name="pageIndex"/>
  </form>
  
  <center>
  <div>
   <span style="color:red">用户登陆记录</span>
  </div>
  </center>
  <br/> 
  
  
  <br/>
  <center>
  <form action="visitCount.do?method=getMemberVisitHistory&userName=${requestScope.userName}&userId=${requestScope.userId}" method='post' name="dateSearchForm">
  	起始时间：<input type='text' name='startTime' value="" onfocus="WdatePicker({isShowWeek:true})"/>
  	终止时间：<input type='text' name='endTime' value="" onfocus="WdatePicker({isShowWeek:true})"/>
  	<input type='submit' value="  查   询  "/>
  </form>
  </center>
  
  
 <div style="height:300px">
	   
 
   <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
   <tr bgcolor="#C2C6DA"><td height="35">用户名</td><td>访问时间</td></tr>
  		<c:forEach var="memberVisitHistory" items="${requestScope.memberVisitHistory}">
  		<tr>
  		<td width="34%" height="20">
        ${requestScope.userName}
  		</td> 
  		<td>${memberVisitHistory}</td>
  		 
  		</tr> 
		</c:forEach>
    	<tr><td align="right" colspan="2"> 
		记录总数:${requestScope.totalRecord} &nbsp;&nbsp;共${requestScope.nav.pageCount}页  &nbsp;&nbsp;
			<n:nav pageCount="${requestScope.nav.pageCount}"
				pageIndex="${requestScope.nav.pageIndex}"
				navigationUrl="${requestScope.nav.navigationUrl}/search.do?method=overviewSearch"
				params="${requestScope.nav.params}"></n:nav>         
  	</td></tr>
    </table> 
  </div> 
   
  </body>
</html>