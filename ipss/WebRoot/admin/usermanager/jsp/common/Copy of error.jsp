<%@ page contentType="text/html;charset=GBK"%> 
<%@ page isErrorPage="true" %> 
<%@ page import="com.trs.usermanage.*,java.sql.*,java.util.*" %>
<%@ include file="../../inc/head.jsp" %>
<html>
<head>
<TITLE>TRS内容分发服务器（CDS） V4.5</TITLE>
<link rel="stylesheet" href="../../css/style.css" type="text/css">
</HEAD>
<BODY>
<CENTER><TABLE height="80">
<TR>
	<TD></TD>
</TR>
</TABLE>
  <table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="94"> 
        <div align="right"><img src="../../images/tit-error.gif" width="81" height="62"></div>
      </td>
      <td width="662">&nbsp; </td>
    </tr>
  </table>
  <table width="600" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td colspan="2"> 
        <div align="left"></div>
        <div align="left"></div>
        <hr width="600" align="left" size="1">
      </td>
    </tr>
    <tr> 
      <td width="258" valign="middle" rowspan="2"> 
        <p align="center"><img src="../../images/error.jpg" border="1" width="139" height="168"></p>
      </td>
      <td width="419" height="162" class="b12"> 
        <center>
          <font color=red> 
          <p align="center">  
<%
	String strCode = "";
	String strMessage = "";
	String strBack = "";
	String sessPrevURL = (String)session.getValue("sessPrevURL");
	if (sessPrevURL == null)
	{
		strBack = "<a href=\"#\" onclick=\"JavaScript:history.go(-1)\"><img src=\"../../images/back.gif\" border=\"0\"></a> \n";
	}	
	else
	{
		strBack = "<a href=\"" + sessPrevURL + "\"><img src=\"../../images/back.gif\" border=\"0\"></a> \n";
	}
	session.removeValue("sessPrevURL");
	if(!(exception instanceof com.trs.usermanage.UNIException) )
	{
		Exception 	mException = (Exception)exception;
		strCode = "出现异常";
		strMessage = mException.getMessage();
	}
	else
	{
		com.trs.usermanage.UNIException mException=(com.trs.usermanage.UNIException)exception;
		
		if( mException.m_th instanceof SQLException)
		{
			mException.m_th.printStackTrace(System.out);
		}
		strCode = String.valueOf(mException.m_iErrorCode);
		
		if( mException.m_iErrorCode == 5000 )
		{
			strBack = "<a href=\"/admin/index.htm\"><img src=\"../../images/back.gif\" border=\"0\"></a> \n";		
		}
		strMessage = mException.getMessage();
	}	
%>
			</font>
			<p align="left"><br>
			
			<table width="355">
			<tr>
			  <td width="85" nowrap ><font color="red" >错误号：</font></td>
			  <td width="258">
			  <%=strCode%> </td>
			</tr>
			<br>
			<tr>
			  <td width="85"><font color="red" >错误说明：</font></td>
			  <td width="258">
			  <%=strMessage%>
			  </td>
			</table>

<font color="red"> </font>
</center>
<tr>
  <td>
	<%=strBack%>
  </td>
</tr>
    <tr> 
      <td width="419"> 
        <div align="center"></div>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <hr width="600" align="left" size="1">
      </td>
    </tr>
  </table>
  <table width="600" border="0" cellspacing="0" cellpadding="0">
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
</CENTER>
</body>
</html>


