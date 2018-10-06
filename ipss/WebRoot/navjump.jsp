<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

<head>
<%
String username = request.getParameter("username");
if(username==null){
	username="guest";
}

String jumpNavID = request.getParameter("jumpNavID");
if(jumpNavID==null){
	jumpNavID="793";
}
%>
</head>

<form method="post" name="loginform" action="login.do?method=login"> 
<input type="hidden" id="jumpNavID" name="jumpNavID" value="<%=jumpNavID%>" />
<input type="hidden" id="username" name="username" value="<%=username%>" />
<input type="hidden" id="password" name="password" value="123456"/>
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
//		hangye : $('#hangye').val(),
		totalPages : 0
	};
	// 这里清空频道缓存	
	login(params);
}
function login(params) {
//alert(params.login_user_chrUserName);
//alert(params.login_user_chrUserPass);
//alert(params.totalPages);
	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=path%>/login.do?timeStamp=" + new Date(),
		data : {
			'username' : params.username,
			'password' : params.password
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
				showexp(ret[1]);
			}else{
				location.href = "<%=path%>/mytreehangye.do?jumpNavID=<%=jumpNavID%>&username=<%=username%>";
			}
		},
		error : function(jsonresult) {
			alert("请核对用户信息，并重新输入");
		}		
	});	
}

window.onload = initLoginRequestData;
</script>
