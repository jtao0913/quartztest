<%@ page import="com.cnipr.cniprgz.commons.Util" contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>

<%@ include file="../../../jsp/zljs/include-head-base.jsp"%>

<%
try { 
	String vCode = Util.getCheckCode();
	String userName = (String)request.getSession().getAttribute("username");
//int GroupID = wUser.getGroupID();
//String strUrl = request.getParameter("strUrl");
%>
<HTML>
<HEAD>
<TITLE>说明书原文</TITLE>
<link href="style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    <td height="350">
   <object id=PatTifAcTiveX1 height=0 width=0 classid="clsid:C7D7CC85-4485-41AC-BBFB-39BD95481DAE" border="0"></object>
	</td>
    </tr>
    </table>
	</td>
  </tr>
</table>

</BODY>
</HTML>
<Script language="JavaScript">
var maindoc = window.parent.parent.document;
//PatTifAcTiveX1.SetStatusDisplayOrDownload(0);

PatTifAcTiveX1.bViewOrDown = "0";
var r = PatTifAcTiveX1.InitCtrl();

if(r == 0)
{
	PatTifAcTiveX1.SetCheckCode('<%=vCode%>');
	PatTifAcTiveX1.SetUserName('<%=userName%>');
	PatTifAcTiveX1.SetScreenSize(screen.width-180);
}

function SetReadUrl()
{
PatTifAcTiveX1.SetNetTifPath(window.parent.parent.PatentInfo.strUrl.value, "<%=userName%>", window.parent.parent.PatentInfo.strAPO.value);
}
setTimeout("SetReadUrl()",1);

function reFresh()
{
	PatTifAcTiveX1.CtrFrash();
}
</Script>



<Script language="VBScript">
<!--
Sub PatTifAcTiveX1_ViewFileDownStatus(iPart)
	If(iPart < 100) Then
		window.status = "正在接收数据..." & iPart & "%"
	Else
		window.status = "接收完成"
		window.parent.parent.topFrame.document.all.btnCheck.click()
	End If
End Sub


Sub PDGPlug1_OnProgress(filelength,curpos)
	if(filelength=0)then
		exit sub
	end if
		
	if(curpos <> filelength) then
		dim st
		st = "正在接收数据.." & cstr(cint(100*curpos/filelength))& "%"
		if(st<>window.status) then
			window.status = st
		end if
	else
		window.status="下载完毕"
	end if
	
End Sub

-->
</Script>
<%
}
catch(Exception exp)
{
	exp.printStackTrace();
}
finally
{
}
%>
<Script Language="JavaScript">
//SetReadUrl();
//window.status="数据接收已经完成";
</Script>
