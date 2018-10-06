<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	-->
	<Script src="<%=basePath%>js/DisplayTip.js"></Script>
	
	<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	scrollbar-face-color:ffffff; 
	scrollbar-shadow-color:C1C1BB; 
	scrollbar-highlight-color:C1C1BB; 
	scrollbar-3dlight-color:EBEBE4; 
	scrollbar-darkshadow-color:EBEBE4; 
	scrollbar-track-color:F4F4F0; 
	scrollbar-arrow-color:CACAB7; 
}

td{
font size:12px;
}
A:link {text-decoration:none;}
A:visited {text-decoration:none;}
A:active {text-decoration:none;}
A:hover {text-decoration:none;}

#tipBox {position: absolute;
width: 400px;
z-index: 100;
border: 1pt black solid;
font-family:宋体;
font-size: 9pt;
background: #fffacd;
visibility: hidden}
-->
</style>

  </head>
  
  <body>  
  <div ID="tipBox"></div>
    This is my Test JSP page.<br><div align="center"><input type="text" onmouseover="this._tip = '    申请号字段检索支持<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符,字段内各检索词之间进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>    1、输入完整申请号，如键入：<B><font color=red>CN02144686.5</font></B><BR>    2、已知申请号前五位为02144，应键入：<B><font color=red>CN02144%</font></B><BR>    3、已知申请号中间几位为2144，应键入：<B><font color=red>%2144%</font></B><BR>    4、已知申请号不连续的几位为021和468，应键入：<B><font color=red>%021%468%</font></B>'" alt="sdfasdf" name="text1">&nbsp; 
  </div>
  </body>
</html>
