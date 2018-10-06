<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>中国内蒙古自治区装备制造业专利</title>
<link href="css/css_nmnj.css" rel="stylesheet" type="text/css" />
</head>

<body style="background:#888888 url(images/bg.jpg) repeat-x">
<form method="post" name="loginform" action="login.do?method=login"  > 
<input type="hidden" id="navID" name="navID" value="444" />
<input type="hidden" id="hangye" name="hangye" value="zbzz" />

<div class="wrap">
<div class="home_box2" style="background:url(images/bj_zbzz.jpg) no-repeat center;">
<dl class="home_login">
<dd><strong>用户名：</strong><input class="text" name="username" id="username" type="text" value="zbzz" style="background:url(images/text_iput.gif) no-repeat center;;width:150px;"/></dd>
<dd><strong>密&nbsp;&nbsp;&nbsp;码：</strong><input name="password" type="password" id="password" value="123456" class="text" style="background:url(images/text_iput.gif) no-repeat center;;width:150px;"/></dd>
<dt>
<a href="#" onclick="initLoginRequestData()" class="dl" style="background:url(images/but.jpg) no-repeat center;">登 录</a>
</dt>
</dl>
</div>
<div class="login_foot">主办单位　　内蒙古自治区知识产权局  内蒙古知识产权服务中心</div>
</div>
</form>

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
