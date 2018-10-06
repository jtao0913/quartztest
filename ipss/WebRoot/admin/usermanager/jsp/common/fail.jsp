<%@page contentType="text/html; charset=GBK" errorPage="error.jsp"%>
<%@ include file="../../inc/head.jsp" %>
<%@ page import="com.trs.usermanage.*,java.sql.*,java.util.*" %>
<script language="javascript">
<!--
function nextstep()
{
	var curl = document.all.jixu.value
	if(typeof(window.opener)!="undefined"&&typeof(window.opener.frames)!="unknown")
	{
		if(curl=='null')
		{
			if(window.opener.frames.length==0)
			{
				window.opener.location.reload()
			}
			if(window.opener.frames.length==2)
			{
				window.opener.frames("frame2").location.reload()
			}
		}
		else
		{
			window.opener.location=curl
		}
	}
	window.close()
}

function finishwork()
{
	if(typeof(window.opener)!="undefined"&&typeof(window.opener.frames)!="unknown")
	{
		if(window.opener.frames.length==2)
		{
			window.opener.frames("frame2").location.reload()
		}
		if(window.opener.frames.length==0)
		{
			window.opener.close()	//能关就关
		}
	}
	window.close();
}
-->
</script>
<html>
<head>
<title>TRS内容分发服务器（CDS） V4.5</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../css/style.css" type="text/css">
</head>
<%
//定义变量
String  strTip = null;//成功提示语
String  strfurl	 = null;//完成操作刷新的页面
String	strFlag = null;
int	nFlag=0;	//默认不要刷新

//取参数
strTip = RequestParameterOperation.getParameter(request,"tip");
strfurl	  = RequestParameterOperation.getParameter(request,"f_url");
strFlag	  = RequestParameterOperation.getParameter(request,"refresh");

if( strTip == null )
{
	strTip = "";
}
if( strFlag != null && ValidCheck.isNumber( strFlag ) )
{
	nFlag = Integer.parseInt( strFlag );
}

%>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <div align="left"></div>
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
          <tr  height="120" valign="bottom">
            <td>
              <a href="#" onclick="javascript:history.go(-1)"><img src="../../images/retry.gif" border="0"></a>
              <a href="#" onclick="javascript:self.close()"><img src="../../images/cancel1.gif"  border="0"></a>
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
      <div align="center"><font color="#000000">TRS信息技术有限公司版权所有<br>
        TRS Information technology Limited<br>
        http://www.trs.com.cn </font></div>
    </td>
  </tr>
</table>
</body></html>