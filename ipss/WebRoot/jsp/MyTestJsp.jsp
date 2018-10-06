<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/lytebox.js"></script>
<link rel="stylesheet" href="<%=basePath%>css/lytebox.css" type="text/css" media="screen" />
<script type="text/javascript">
function onloadjs(){
document.getElementById("aa").innerHTML="<a href=\"http://www.163.com\"  rel=\"lyteframe\" title=\"网易网站主页\" rev=\"width: 780px; height: 660px; scrolling: no;\" class=\"thickbox\">网易网站主页(onload出来的代码)</a>";
}
function showajax(){
document.getElementById("aa").innerHTML="<a href=\"http://www.163.com\"  rel=\"lyteframe\" title=\"网易网站主页\" rev=\"width: 780px; height: 660px; scrolling: no;\" class=\"thickbox\">ajax函数生成的代码</a>";
}

function lyteshow(url,width,height,ftitle) {
   var objLink = document.createElement('a');
   objLink.setAttribute('href',url);
   objLink.setAttribute('rel','lyteframe');
   objLink.setAttribute('rev','width:'+width+';height:'+height+';')
   objLink.setAttribute('title',ftitle);
   myLytebox.start(objLink, false, true);
}


</script>
<title>无标题文档</title>
</head>
<body">
<span id="aa"></span>
<p><input type="button" onclick="showajax();" value="点击调用ajax函数showajax()"></p>
<p><input type="button" onclick="lyteshow('http://www.google.com/','820','420','Title');" value="lyteshow"></p>
</body>
</html>
