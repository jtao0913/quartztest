<%@ page import="com.cnipr.cniprgz.commons.DataAccess,
com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>

<script type="text/javascript" src="<%=basePath%>scripts/app/global.js"></script>   
<script type="text/javascript" src="<%=basePath%>scripts/app/system.js"></script>
<script type="text/javascript" src="<%=basePath%>scripts/jquery/jquery-1.3.2.min.js"></script>   
<link rel="stylesheet" href="<%=basePath%>css/default.css" type="text/css" media="all"/>

<link href="<%=basePath%>css/navi.css" rel="stylesheet" type="text/css"/>

<script src="<%=basePath%>scripts/jquery/cluetip/jquery.cluetip.js" type="text/javascript"></script>
<style media="all" type="text/css">@import "<%=basePath%>scripts/jquery/cluetip/jquery.cluetip.css";</style>

<script type="text/javascript" src="<%=basePath%>scripts/jquery/validate/jquery.validate.pack.js"></script>
<script type="text/javascript" src="<%=basePath%>scripts/jquery/validate/jquery.metadata.js"></script> 
<script type="text/javascript" src="<%=basePath%>scripts/jquery/validate/message_cn.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>scripts/jquery/validate/css/screen.css" />

<script type="text/javascript">
$(document).ready(function() { 
	$("#simpleCreate").validate();
});
</script>
</head>
<body>
 
<% 
TSimpleWarnDAO simpleWarnDAO  =  new TSimpleWarnDAO(); 
String id = request.getParameter("id");
String start = "1";
if(request.getParameter("start")!=null)
	start = request.getParameter("start");

if(id!=null)
{
TSimpleWarn simpleWarn =  simpleWarnDAO.getSimpleWarn(Integer.parseInt(id));

%>
<form id="simpleCreate" name="simpleCreate" method="post" action="warnEditDo.do?method=edit">

<table  border="1" width="100%" align="center" cellpadding="0" cellspacing="0"  bordercolor="#FFFFFF">

<tr><td  bgColor="#ffffff" valign="middle">
<br/>
<br/>
	<table width="70%" align="center" class="border" bgColor="#ffffff" border="0" cellSpacing="0" cellPadding="0" 　bgcolor="#FFFFFF">
	  <tr bgcolor="#FFFFFF" class="gray"  onMouseOver="this.style.backgroundColor='#D7E1EC'" onMouseOut="this.style.backgroundColor='#ffffff'">
	    <td width="200" height="30" class="title" align="right">定期预警名称：</td>
	    <td height="22" colspan="5" align="left">
	        <input type="text" value="<%=simpleWarn.getName() %>" name="name" id="simpleWarnName" class="{required:true,messages:{required:'请输入内容'}}" style="color:#993300;text-decoration: none;width: 180px;"/>
	  	</td>
	  </tr>
	   <tr bgcolor="#E3EBFF" class="gray" onMouseOver="this.style.backgroundColor='#D7E1EC'" onMouseOut="this.style.backgroundColor='#F5F9FF'">
	    <td class="title" height="30" align="right">表达式：</td>
	    <td> 
	       <%=simpleWarn.getExpression() %>
	    </td>
	  </tr>
	  <tr align="center" bgcolor="#FFFFFF" class="gray"  onMouseOver="this.style.backgroundColor='#D7E1EC'" onMouseOut="this.style.backgroundColor='#ffffff'">
	    <td height="30" class="title" align="right">预警周期：</td>
	    <td height="22" colspan="5" align="left"> 
	      <label>
	        <select name="period" id="select" size="1" class="redl"> 
	          <option <% if (simpleWarn.getPeriod()==1) out.print("selected"); %> value="1">每周</option> 
	          <option <% if (simpleWarn.getPeriod()==3) out.print("selected"); %> value="3">每月</option> 
	        </select>
	      </label>
	       <a href="#" class="tooltip"  rel=".memo1"><img src="<%=basePath%>images/tooltip.gif" border='0'/></a>
	        <div class="memo1">系统将根据您设置的预警周期阶段性地提供新增专利</div>
	  </td>
	  </tr>
	  <tr> 
	    <td background="../images/pic002.jpg"  colspan="2" height="40" align="center"> 
	      <input type="hidden"  name="id" id="id"  value="<%=simpleWarn.getId() %>" />
	      <input type="hidden"  name="start" id="start"  value="<%=start %>" />
	      <input type="submit"  name="button" id="button"  value=" 修改 " />
	      <input type="button"  name="button" id="button" onclick="location.href='<%=basePath%>getMyWarm.do'"  value=" 取消 " />
	   </td>
	  </tr>
	</table>
	<br/>
	<br/>
	<br/>
	</td></tr>
	</table>
 </form>
 
 <%} %>
 </body>
 </html> 
     
 