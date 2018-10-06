<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中国内蒙古自治区生态产业专利</title>
<link type="text/css" rel="stylesheet" href="<%=basePath%>neimeng/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>neimeng/css/index.css" />

    <meta name="viewport" content="width=device-width, initial-scale=1" /><!-- 网页宽度默认等于屏幕宽度 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> <!--优先使用 IE 最新版本和 Chrome-->
    <meta http-equiv="X-UA-Compatible" content="IE=8" ><!-- 使用IE8 -->
    <meta http-equiv="X-UA-Compatible" content="IE=7" ><!-- 使用IE7 -->
    <meta http-equiv="X-UA-Compatible" content="IE=6" ><!-- 使用IE6 -->
    <meta name="renderer" content="webkit"><!--360 使用Google Chrome Frame-->
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" /><!--360 极速核-->
    <meta http-equiv="Cache-Control" content="no-siteapp" /><!--百度禁止转码-->

</head>

<body>


  <!-- 整体格局  -->
  <div class="title"><img src="<%=basePath%>neimeng/images/title.png"></div>
	<!---------------------表单-------------------------->
	<h2 class="h2">系统登录</h2>
	<div class="login-img"> </div>
	

    <div class="login-bg">
<form class="login-xx" method="post" name="loginform" action="login.do?method=login"  > 
<input type="hidden" id="navID" name="navID" value="829" />
<input type="hidden" id="hangye" name="hangye" value="stcy" />			
			<p style="color:#ffffff;">用户名</p>
			<input class="login-input" type="text" name="username" id="username" type="text" value="stcy"><br>
			<p style="color:#ffffff;">密码</p>
			<input class="login-input" type="password" name="password" id="password" value="123456">
			<input class="dl" onclick="initLoginRequestData()" type="submit" name="submit" value="登录">
</form>
	</div>
	
	<!---------------------表单_end-------------------------->
	
	<!---------------------浮动效果-------------------------->
	<div>
		<div class="img-1"><img src="<%=basePath%>neimeng/images/shou.png"></div>
		<div class="img-2 a-bouncein"><img src="<%=basePath%>neimeng/images/shu-img.png"></div>
		<div class="img-3 a-bouncein"><img src="<%=basePath%>neimeng/images/xiaocao1-img.png"></div>
		<div class="img-4 a-bouncein"><img src="<%=basePath%>neimeng/images/xiaocao-img.png"></div>
		<div class="img-5 a-fadeinT"><img src="<%=basePath%>neimeng/images/yezi1-img.png"></div>
		<div class="img-6 "><img src="<%=basePath%>neimeng/images/yezi2-img.png"></div>
	</div>
	<!---------------------浮动效果_end-------------------------->
	
	<!----------------------footer------------------->
	<footer class="footer">
		<span>技术支持：</span>
		<img src="<%=basePath%>neimeng/images/bottom-img.png">
	</footer>
	<!----------------------footer_end------------------->
  	<!--  整体格局_end  -->
  	
<script type="text/javascript">
function initLoginRequestData() {
//	$('body').mask('请等待...');	
	var aaa = $('#username').val();
	var bbb = $('#password').val();
//	alert(aaa);
//	alert(bbb);	
	params = {
		username : $('#username').val(),
		password : $('#password').val(),
		hangye : $('#hangye').val(),
		totalPages : 0
	};
	// 这里清空频道缓存	
	login(params);
}
function login(params) {
//alert(params.login_user_chrUserName);
//alert(params.login_user_chrUserPass);
//alert(params.totalPages);
//var exp = new Date();
//alert(exp);
//	alert(dingqiyujing);
//	alert(params.username);
//	alert(params.password);
	
//	$('#currentPage').val(params.currentPage);
//	$('#data-process-img').show();
//	isLoading = true;
	var text = "";
	$.ajax({
//	alert("5555");
	
		type : "GET",
		url : "<%=path%>/login.do?timeStamp=" + new Date(),
		data : {
			'username' : params.username,
			'password' : params.password,
			'hangye' : params.hangye,
			'totalPages' : params.totalPages
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {

//alert(jsonresult);
var ret = jsonresult.split("##");
if(ret[0]=="error"){
	showexp(ret[1]);
}else{
//	var navID = $('#navID').val();
	location.href = "<%=path%>/mytreehangye.do";
}
		},

		error : function(jsonresult) {
			alert("请核对用户信息，并重新输入");
		}		
	});	
}
</script>
  	
  </body>
</html>