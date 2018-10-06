<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

<script src="<%=basePath%>wap/js/uaredirect.js"></script>
<script type="text/javascript">uaredirect("wap/");</script>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>辽宁省知识产权综合信息平台-专利检索查询,专利搜索下载</title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
    <meta name="description" content="<%=SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

	<link href="liaoning/css/liaoning.css" rel="stylesheet" type="text/css"/>
</head>

<body style="background-image:url(liaoning/images/bg_a.jpg); background-repeat:repeat-x; background-color:#F1F1F1;">
<div class="ha_all" style="background-image: url(liaoning/images/shiyouzhuangbei.jpg)">
<form method="post" name="loginform" action="login.do?method=login">
<input type="hidden" id="navID" name="navID" value="6602" />
<input type="hidden" id="hangye" name="hangye" value="shiyouzhuangbei" />

<input name="errorurl" type="hidden" value="error.jsp">
<input name="NickName" type="hidden">
<input type="hidden" name="url" value="zljs/index.jsp"> 
	  <div class="login">
		<ul>用户名： <input name="username" id="username" type="text" class="border" value="shiyouzhuangbei"/></ul>
		<ul class="m_t1">密　 码：<input name="password" type="password"  class="border" id="password" value="123456"/>	</ul>
		<ul class="m_t1 p_l1"> 
		  	<a href="#" target="_self">
		  		<img onClick="javascript:initLoginRequestData();" src="liaoning/images/dl.jpg" border="0" />
		  	</a><br>
		</ul>
		
   </div>
</form>
   
</div>

<!--table border='0' width='80%' align='center'>
<tr><td>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(938,1);return false;' >仪器仪表</a>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(868,1);return false;' >数控机床</a>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(832,1);return false;' >中草药</a>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(749,1);return false;' >光伏产业</a>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(1028,1);return false;' >液压</a>
<a href="#" class="bltd" onclick='javascript:expresswayForMajorIndustries(1348,1);return false;' >试点县（市、区）</a> 
</td></tr>
</table-->
</div>	 


<script type="text/javascript">
function initLoginRequestData() {
//alert("initLoginRequestData....");
//	$('body').mask('请等待...');	
	var aaa = $('#username').val();
	var bbb = $('#password').val();

//alert(aaa);
//alert(bbb);	

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
//alert(params.username);
//alert(params.password);
	
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
