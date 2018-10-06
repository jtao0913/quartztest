<%@ page language="java" pageEncoding="UTF-8"%>

<%@ page import="com.cnipr.cniprgz.commons.Log74Access"%>

<%@ include file="../jsp/zljs/include-head-base.jsp"%>

<script type="text/javascript" src="<%=basePath%>industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="<%=basePath%>wap/js/jquery.min.js"></script>

<script type="text/javascript">
function showexp(exp){
	var html1 =
		"<div style='max-width:800px;line-height:22px;word-break:break-all;word-wrap:break-word;'>"
		+ exp
		+ "</div>"
	$.dialog({
		title:'提示',
		max:false,
		min:false,
		lock: true,
		content: html1
	});
}
</script>

<script type="text/javascript">
//$(function() {
//})
function initLoginRequestData() {
//$('body').mask('请等待...');	
	var aaa = $('#username').val();
	var bbb = $('#password').val();
//alert(aaa);
//alert(bbb);	
	params = {
		username : $('#username').val(),
		password : $('#password').val(),
		totalPages : 0
	};
	//这里清空频道缓存
	login(params);
}
function login(params) {
//alert(params.login_user_chrUserName);
//alert(params.login_user_chrUserPass);
//alert(params.totalPages);
//var exp = new Date();
//alert(exp);
//alert(dingqiyujing);
//alert(params.username);
//alert(params.password);
	
//$('#currentPage').val(params.currentPage);
//$('#data-process-img').show();
//isLoading = true;
	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=basePath%>login.do?timeStamp=" + new Date(),
		data : {
			'username' : escape(params.username),
			'password' : params.password,
			'totalPages' : params.totalPages
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {

//alert(jsonresult);
var ret = jsonresult.split("##");
//alert(ret);
if(ret[0]=="error"){
	showexp(ret[1]);
}else{
	var title = ret[2];
//	$(document).attr("title",title + "-专利检索查询,专利搜索下载");
	
}
		},

		error : function(jsonresult) {
			//alert("请核对用户信息，并重新输入");
		}	
	});	
}


window.onload = function(){
//alert("window.onload......");
	var username = $('#username').attr('title');
//alert('username='+username);	
	if(username==''){
//alert('username为空');
//		$('#username').val()='guest';
//		$('#password').val()='123456';
		$("#username").attr("value","guest");//清空内容 
		$("#password").attr("value","123456");
		initLoginRequestData();
	}
};
</script>

<%
//System.out.println("path="+path);
String username = session.getAttribute(com.cnipr.cniprgz.commons.Constant.APP_USER_NAME)==null?"":(String)session.getAttribute(com.cnipr.cniprgz.commons.Constant.APP_USER_NAME);
//System.out.println("include-head-nav.jsp........................................username="+username);
Integer intAdministerState = session.getAttribute("intAdministerState")==null?0:(Integer)session.getAttribute("intAdministerState");
//System.out.println("include-head-nav.jsp........................................intAdministerState="+intAdministerState);
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//System.out.println("hangye="+hangye);

//String _path = request.getContextPath();
//String _basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+_path;
//System.out.println("=========title="+title);
%>
<form>
<input type="hidden" name="username" id="username" title="<%=username%>"/>
<input type="hidden" name="password" id="password" />
</form>