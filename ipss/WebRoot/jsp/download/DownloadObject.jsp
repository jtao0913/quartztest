<%@ page import="com.cnipr.cniprgz.commons.Util" errorPage=""%>

<%@ page contentType="text/html;charset=utf-8"%>
<% 
	String path = request.getContextPath();
	String vCode = Util.getCheckCode();
	String userName = (String)request.getSession().getAttribute("username");
%>

<html>
<head>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>说明书下载管理器</title>
<script type="text/javascript"> 

  //屏蔽鼠标右键、Ctrl+N、Shift+F10、F11、F5刷新、退格键 
  //Author: meizz(梅花雨) 2002-6-18 
function document.oncontextmenu(){event.returnValue=false;}//屏蔽鼠标右键 
function window.onhelp(){return false} //屏蔽F1帮助 
function document.onkeydown() 
{ 
  if ((window.event.altKey)&& 
      ((window.event.keyCode==37)||   //屏蔽 Alt+ 方向键 ← 
       (window.event.keyCode==39)))   //屏蔽 Alt+ 方向键 → 
  { 
     alert("不准你使用ALT+方向键前进或后退网页！"); 
     event.returnValue=false; 
  } 
     /* 注：这还不是真正地屏蔽 Alt+ 方向键， 
     因为 Alt+ 方向键弹出警告框时，按住 Alt 键不放， 
     用鼠标点掉警告框，这种屏蔽方法就失效了。以后若 
     有哪位高手有真正屏蔽 Alt 键的方法，请告知。*/ 
  if ((event.keyCode==8)  ||                 //屏蔽退格删除键 
      (event.keyCode==116)||                 //屏蔽 F5 刷新键 
      (event.ctrlKey && event.keyCode==82)){ //Ctrl + R 
     event.keyCode=0; 
     event.returnValue=false; 
     } 
  if (event.keyCode==122){event.keyCode=0;event.returnValue=false;}  //屏蔽F11 
  if (event.ctrlKey && event.keyCode==78) event.returnValue=false;   //屏蔽 Ctrl+n 
  if (event.shiftKey && event.keyCode==121)event.returnValue=false;  //屏蔽 shift+F10 
  if (window.event.srcElement.tagName == "A" && window.event.shiftKey)  
      window.event.returnValue = false;             //屏蔽 shift 加鼠标左键新开一网页 
  if ((window.event.altKey)&&(window.event.keyCode==115))             //屏蔽Alt+F4 
  { 
      window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px"); 
      return false; 
  } 
} 

</script>
</head>

<body onbeforeunload="ObjUnload()">
<object id=PatTifAcTiveX1 height=300 width=600 classid="clsid:C7D7CC85-4485-41AC-BBFB-39BD95481DAE"  border="0"></object>

 

<script language="vbscript">
'Sub window_onload
'	PatTifAcTiveX1.InitCtrlForDown()
'	PatTifAcTiveX1.SetCheckCode(<%=vCode%>)
'	PatTifAcTiveX1.SetUserName(<%=userName%>)
'	PatTifAcTiveX1.InitBatchDown()
'	call Download()
'End Sub
</script>

<Script language="JavaScript">

function window.onload()
{
	OCXint();
}

function OCXint()
{
	PatTifAcTiveX1.bViewOrDown = "1";
	PatTifAcTiveX1.SetCheckCode('<%=vCode%>');
	PatTifAcTiveX1.SetUserName('<%=userName%>'); 
	setTimeout("Download()",0);	
}
</Script>

<input type="button" name="btnDownload" value="" onClick="javascript:Download();" style="visibility:hidden">
</body>
<script type="text/javascript">
function Download()
{
	var arrAPO = window.parent.DownloadInfo.strAPO.value.split(",");
	var arrUrl = window.parent.DownloadInfo.strUrl.value.split(",");
	var arrPage = window.parent.DownloadInfo.strPage.value.split(",");
	
	var m_strSavePath = window.parent.DownloadInfo.strSavePath.value;
	
//	alert(window.parent.DownloadInfo.strAPO.value);
	
//	alert(m_strSavePath);
//	alert(PatTifAcTiveX1.CtrGetIP());
	PatTifAcTiveX1.InitBatchDown()
	for(var i=0;i<arrAPO.length;i++)
	{
//		alert(arrAPO[i]);
		PatTifAcTiveX1.SetDownLoadInfo(m_strSavePath, arrUrl[i], arrPage[i], arrAPO[i]);
//		alert(arrUrl[i]);
	}
//	alert('ok');
	PatTifAcTiveX1.batchdown();
}

function ObjUnload()
{
	var dtToday = new Date();
	var strSaveDays = dtToday.getTime() - 1*24*60*60*1000;
	dtToday.setTime(strSaveDays);
	document.cookie = "DownloadFormObj=;expires="+dtToday.toGMTString();


//	if(PatTifAcTiveX1.CtrIsDowning() == 1)
		PatTifAcTiveX1.CtrStopThread();
}
</script>
</html>

