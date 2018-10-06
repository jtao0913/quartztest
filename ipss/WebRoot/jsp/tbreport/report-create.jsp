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
<%@ page import="java.net.*"%>
<%
	String path = request.getContextPath();
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
	$("#lawWarnCreate").validate();
});
</script>
</head>
<body>
 
<% 
 

String channels = request.getParameter("channels"); 
String exp = request.getParameter("exp"); 
String namedecode = null;
  

String start = "1";
if(request.getParameter("start")!=null)
	start = request.getParameter("start");
int userId = -1; 
if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
{
	userId = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));
%>
<form id="reportCreate" name="reportCreate" method="post" action="<%=basePath%>jsp/tbreport/report-edit-do.jsp?method=create">

<table  border="1" width="100%" align="center" cellpadding="0" cellspacing="0"  bordercolor="#FFFFFF">

<tr><td  bgColor="#ffffff" valign="middle">
<br/>
<br/>

<table width="70%" align="center" class="border" bgColor="#ffffff" border="0" cellSpacing="0" cellPadding="0" 　bgcolor="#FFFFFF">
	<tr bgcolor="#FFFFFF" class="gray"  onMouseOver="this.style.backgroundColor='#D7E1EC'" onMouseOut="this.style.backgroundColor='#ffffff'">
    <td width="200" height="30" class="title" align='right'>表达式：</td>
    <td height="22" colspan="5" align="left"> 
    <input type='hidden' value="<%=exp %>" name="exp"/>
          <%= URLDecoder.decode(exp,"utf-8") %>
   </td>
  </tr>
  <tr align="center" bgcolor="#E3EBFF" class="gray" onMouseOver="this.style.backgroundColor='#D7E1EC'" onMouseOut="this.style.backgroundColor='#F5F9FF'">
    <td height="30" class="title" align='right'>请设置名称：</td>
    <td height="22" colspan="5" align="left"> 
      <label>
        <input type="text" name="name" />
      </label>
       
  </td>
  </tr>
    
  <tr> 
    <td background="<%=basePath%>images/pic002.jpg" colspan="6" height="40" align="center">     
      <input type="hidden" name="channels" value="<%=channels %>"/>
	  <input type="submit"  name="button" id="button"	 value="加入我的报告" />
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
     
  