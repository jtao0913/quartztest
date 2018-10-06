<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
		<script language="javascript">
		</script>
		<title></title>
	</head>
	<Script language="JavaScript">
self.moveTo(0,0)
self.resizeTo(screen.availWidth,screen.availHeight)

//无提示关闭窗口
function CloseWin()
{
	var ua=navigator.userAgent
	var ie=navigator.appName=="Microsoft Internet Explorer"?true:false
	if(ie)
	{
    	var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE "))))
		if(IEversion< 5.5)
		{
		    	var str  = '<object id=noTipClose classid="clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11">'
		    	str += '<param name="Command" value="Close"></object>';
		    	document.body.insertAdjacentHTML("beforeEnd", str);
		    	document.all.noTipClose.Click();
		}
		else
		{
		    window.opener =null;
		    window.close();
		}
	}
	else
	{
		window.close()
	}
}
</Script>

	<form name="PatentInfo">
		<input type="hidden" name="strChannel" value="${requestScope.strChannel}">
		<input type="hidden" name="strUrl" value="${requestScope.tifDistributePath}">
		<input type="hidden" name="strAPO" value="${requestScope.an }">
		<input type="hidden" name="strTI" value="${requestScope.ti}">
		<input type="hidden" name="strIPC" value="${requestScope.strIPC}">
		<input type="hidden" name="strANN" value="${requestScope.strANN}">
		<input type="hidden" name="strPage" value="${requestScope.pages }">
		<input type="hidden" name="strCurPage" value="${requestScope.strCurPage }">
		<input type="hidden" name="strCryp" value="">
		<input type="hidden" name="strThirdParty" value="">
	</form>

	<frameset id="fsMain" rows="30,*" cols="*" framespacing="0"
		frameborder="no" border="0" height="100%" onUnload="clearUserInfo()">
		<frame src="<%=basePath%>jsp/viewPlugin/tif/patentInstructionHead.htm" id="topFrame" scrolling="no" noresize>
		<frame
			src="<%=basePath%>jsp/viewPlugin/tif/patentInstructionBody.jsp?an=${requestScope.an }&channel=${requestScope.strChannel}&url=${requestScope.tifDistributePath}&tifpages=${requestScope.pages }&ThirdParty=${requestScope.strThirdParty }"
			id="mainFrame">
	</frameset>
	<noframes>
	</noframes>
</html>
