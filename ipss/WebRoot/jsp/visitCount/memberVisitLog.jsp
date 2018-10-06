<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>用户登陆次数统计</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   
<link rel="stylesheet" href="/cniprGD/admin/css/style.css" type="text/css">
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
	<script type="text/javascript">
			function nextPage(pageIndex){
				document.searchForm.pageIndex.value = pageIndex;
				document.searchForm.submit();
			}
	</script>
  </head>
  
  <body>
  <form name="searchForm" action="visitCount.do?method=getMemberVisitLog" method="post">
  	<input type="hidden" name="pageIndex"/>
  </form>
  
  
  <div>
  <a href="visitCount.do?method=getPageVisitLog">首页访问量统计</a> 
  <a href="visitCount.do?method=getMemberVisitLog"><span style="color:red">会员访问统计</span></a> 
  </div>
  <br/> 
  
 <div style="height:300px">
	   
 
   <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
   <tr bgcolor="#C2C6DA"><td height="35">用户名</td><td>访问次数</td><td>访问记录</td></tr>
   		<c:forEach var="memberVisitInfo" items="${requestScope.memberVisitLog}">
   		<tr>
  		<td width="34%" height="20">
       ${memberVisitInfo.name}
  		</td> 
  		<td>${memberVisitInfo.totalVisitCount}</td>
  		<td>
  		<a href="visitCount.do?method=getMemberVisitHistory&userName=${memberVisitInfo.name}&userId=${memberVisitInfo.id}" target="_blank">历史记录</a>
  		</td>
  		</tr> 
   		</c:forEach>
   
    	<tr><td align="right" colspan="3">
		<div align="center">
			记录总数:${requestScope.totalRecord} &nbsp;&nbsp;共${requestScope.nav.pageCount}页  &nbsp;&nbsp;
			<n:nav pageCount="${requestScope.nav.pageCount}"
				pageIndex="${requestScope.nav.pageIndex}"
				navigationUrl="${requestScope.nav.navigationUrl}/search.do?method=overviewSearch"
				params="${requestScope.nav.params}"></n:nav>
		</div>           
  	</td></tr>
    </table> 
  </div> 
   
  </body>
</html>