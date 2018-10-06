<%@ page contentType="text/html; charset=GBK" errorPage="jsp/error.jsp"%>
 
<%
 
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("login.htm");
}
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<link rel="stylesheet" href="css/was_style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<frameset rows="*,0">
  <frame noresize src="console.jsp" name="main">
  <frame name="refresh" src="refresh.jsp" scrolling="no" marginwidth="0" marginheight="0">
</frameset><noframes></noframes>
</html>
<body>
</body>
