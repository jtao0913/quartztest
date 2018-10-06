<%@ page import="com.cnipr.cniprgz.commons.Util" contentType="text/html; charset=GBK" errorPage="/error.jsp"%>

<Script language="JavaScript">
//var m_CurrentPageNumber = 1;
//if(window.parent.topFrame.document.all.txtCurrentPage.value == null)
//	window.parent.topFrame.document.all.txtCurrentPage.value = m_CurrentPageNumber;
//alert(window.parent.document.PatentInfo.strUrl.value);
</Script>

<%
String path = request.getContextPath();
try { 
	String platform_username="was41_gd"+"|"+request.getSession().getAttribute("username");

	String vCode = Util.getCheckCode();
//String strUrl = request.getParameter("strUrl");
%>
<HTML>
<HEAD>
<TITLE>说明书原文</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<link href="../zljs/style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td  valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="350">
                <OBJECT id=PatTifActiveX1 classid=clsid:C7D7CC85-4485-41AC-BBFB-39BD95481DAE
 					codeBase="<%=basePath%>PatTifAcTiveX.ocx#version=1,0,0,12" width="1000" height="2000" >
                		<PARAM NAME="_Version" VALUE="65536">
                		<PARAM NAME="_ExtentX" VALUE="18706">
                		<PARAM NAME="_ExtentY" VALUE="12012">
                		<PARAM NAME="_StockProps" VALUE="0">
                </OBJECT>                	
                	</td>
        </tr>
      </table></td>
  </tr>
</table>

</BODY>
</HTML>
<Script language="JavaScript">
var maindoc = window.parent.document;
//PatTifAcTiveX1.SetStatusDisplayOrDownload(0);

PatTifAcTiveX1.bViewOrDown = "0";
var r = PatTifAcTiveX1.InitCtrl();

if(r == 0)
{
	PatTifAcTiveX1.SetCheckCode('<%=vCode%>');
	PatTifAcTiveX1.SetUserName('<%=platform_username%>');
	PatTifAcTiveX1.SetScreenSize(screen.width-40);
}

function SetReadUrl()
{
//alert(window.parent.PatentInfo.strUrl.value);
//alert(window.parent.PatentInfo.strAPO.value);
//alert("<%=platform_username%>");
PatTifAcTiveX1.SetNetTifPath(window.parent.PatentInfo.strUrl.value, "<%=platform_username%>", window.parent.PatentInfo.strAPO.value);
//PatTifAcTiveX1.SetNetTifPath("http://192.168.3.217/WGGB/2008/wg01/000005.tif", "<%=platform_username%>", window.parent.PatentInfo.strAPO.value);
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
		window.parent.topFrame.document.all.btnCheck.click()
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
}catch(Exception exp)
{
	
}
finally
{
}
%>
<Script Language="JavaScript">
//SetReadUrl();
//window.status="数据接收已经完成";
</Script>
