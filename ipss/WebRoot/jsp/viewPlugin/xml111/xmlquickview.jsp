<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
	</head>
	<body onload="document.ViewXML.submit();">
		<form name="ViewXML" action="<%=basePath%>view.do?method=showXML"  method="post">
			<input type="hidden" id="an" name="an" value="${requestScope.an }">
			<input type="hidden" name="channel" value="${requestScope.channel}">
			<input type="hidden" name="pd" value="${requestScope.pd }">
			<input type="hidden" name="CLM_Page" value="${requestScope.CLM_Page }">
			<input type="hidden" name="DES_Page" value="${requestScope.DES_Page }">
			<input type="hidden" name="DRA_Page" value="${requestScope.DRA_Page }">
			<input type="hidden" name="strPage" value="${requestScope.strPage }">
			<input type="hidden" name="strUrl" value="${requestScope.strUrl}">
			<input type="hidden" name="strTI" value="${requestScope.strTI }">
		</form>
	</body>
</html>