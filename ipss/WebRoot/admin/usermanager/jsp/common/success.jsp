<%@page contentType="text/html; charset=utf-8" errorPage="error.jsp"%>

<html><head><title>检索服务平台后台管理</title>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<%
request.setCharacterEncoding("utf-8");
//定义变量
String  strTip = null;//成功提示语
//取参数
String act=request.getParameter("act");
strTip = request.getParameter("tip");
if( strTip == null )
{
	strTip = "";
} else {
	//strTip = java.net.URLDecoder.decode(strTip,"utf-8");
	//strTip = new String(strTip.getBytes("ISO8859_1"),"UTF-8");
}
%>
<body>
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
             <a href="#" onClick="javascript:nextstep()"><img src="../../images/goon.gif" border="0"></a> 
             <a href="#" onClick="javascript:finishwork()"><img src="../../images/finish.gif"  border="0"></a>
			 <%
			 }
			 else
			 {
			 %>
			 <a href="#" onClick="javascript:finishwork()"><img src="../../images/finish.gif"  border="0"></a>
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


<% 
//String strExpTime = session.getAttribute("SDate");
String strExpTime = request.getParameter("strExpTime");
//out.print(strExpTime);
//out.print("benben");
%>
</body></html>