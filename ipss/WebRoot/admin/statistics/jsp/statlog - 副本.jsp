<%@ page language="java" import="java.util.*,com.cnipph.util.LogStatVO" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List ll=(List)request.getAttribute("ll");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>统计</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="../../css/style.css">
	<link rel="stylesheet" href="../../css/cds_style.css" type="text/css">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
*{font-size: 12px;margin: 0;}
a{text-decoration: none;color: #000;}
a:hover{text-decoration: underline;}
select{border: 1px #cacaca solid;}
</style>
  </head>
  
  <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
  <tr>
    <td align="center" valign="top">
    	<table width="100%" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
        	<tr align="center"> 
        	  <td colspan="10" nowrap>
			  <table width="100%"   border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF">
  		<tr>
  			<td>用户名</td>
  			<td>下载次数</td>
  			<td>打印次数</td>
  		</tr>
  		<%
  			for(int a=0;a<ll.size();a++){
  				LogStatVO svo=(LogStatVO)ll.get(a);
  		%>
  		<tr>
  			<td><%=svo.getUsername() %></td>
  			<td><%=svo.getCount1() %></td>
  			<td><%=svo.getCount2() %></td>
  			
  		</tr>
  		<%		
  			}
  		%>
  	</table>
  	</td>
  	</tr>
  	</table>
  	</td>
  	</tr>
  	</table>
  </body>
</html>
