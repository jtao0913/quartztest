<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
//定义变量
String  strTip = null;//成功提示语

//取参数
String act=request.getParameter("act");
strTip = request.getParameter("tip");
if( strTip == null )
{
	strTip = "";
} else {
	strTip = new String(strTip.getBytes("ISO8859_1"),"UTF-8");
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>检索服务平台后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="../../css/style.css" type="text/css">
	<script language="javascript">
	<!--
	function nextstep()
	{
		if(typeof(window.opener)!="undefined")
		{
			window.opener.location.reload();
		}
		history.go(-1);
	}
	
	function finishwork()
	{
		if(typeof(window.opener)!="undefined")
		{
			window.opener.location.reload();
		}
		window.close();
	}
	-->
	</script>

  </head>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="left"><img src="../../images/good.gif"></div>
    </td>
    <td>&nbsp; </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="2"> 
      <div align="left"></div>
      <div align="left"></div>
      <hr width="100%" align="left">
    </td>
  </tr>
  <tr> 
    <td valign="middle"> 
      <p align="center"><img src="../../images/success.gif"></p>
    </td>
    <td > 
      <div align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;<%=strTip%></td>
          </tr>
          <tr height="120" valign="bottom">
            <td>
			<%
			if(act!=null && act.equals("goon"))
			{
			%>
             <a href="#" onclick="javascript:nextstep()"><img src="../../images/goon.gif" border="0"></a> 
             <a href="#" onclick="javascript:finishwork()"><img src="../../images/finish.gif"  border="0"></a>
			 <%
			 }
			 else
			 {
			 %>
			 <a href="#" onclick="javascript:finishwork()"><img src="../../images/finish.gif"  border="0"></a>
			 <%
			 }
			 %>
            </td>
          </tr>
        </table>
        <font color="#FF0000"> </font></div>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <hr>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp; </td>
  </tr>
  <tr> 
    <td> 
      <div align="center"><font color="#000000">国家知识产权局知识产权出版社版权所有<br>
        http://www.cnipr.com </font></div>
    </td>
  </tr>
</table>

<% 
//String strExpTime = session.getAttribute("SDate");
String strExpTime = request.getParameter("strExpTime");
//out.print(strExpTime);
//out.print("benben");
%>
</html>
