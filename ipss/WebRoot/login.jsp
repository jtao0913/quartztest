<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>
<%if(areacode!=null&&areacode.equals("000")){ %>
<!-- 
<div class="clearfix"  style="text-align:center;background: #D8D8D8;border: 1px solid #000;padding:4px;">
	本网站是内部演示测试版本，随时可能关闭，敬请知晓！如有疑问请点击联系工作人员。<a href="http://www.cnipr.com/fw/fwtd/" target="_blank">点击联系</a>
</div>
 -->
<%}%>
<%
String showtype = request.getParameter("showtype")==null?"":request.getParameter("showtype");//computer

String wap = DataAccess.get("wap")==null?"0":DataAccess.get("wap");
if(wap.equals("1")&&!showtype.equals("computer")){
%>
<script src="<%=basePath%>wap/js/uaredirect.js"></script>
<script type="text/javascript">uaredirect("wap/");</script>
<%}%>

<%@ include file="jsp/zljs/include-head.jsp"%>
<%@ include file="jsp/zljs/include-head-nav.jsp"%>

<head>
<%
String hangyeID = (String)session.getAttribute("hangye");
hangyeID = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//out.println("hangyeID="+hangyeID);
%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=website_title%>-专利检索查询,专利搜索下载</title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
    <meta name="description" content="<%=SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	<link href="common/com_2/css/panel.css" rel="stylesheet">
	
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="common/com_2/css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="common/com_2/css/ie.css">
    <![endif]-->
	
<!-- 
<STYLE type=text/css>
body{
	background:url(images/area/<%= Log74Access.get("log74.areacode")%>/common/com_2/img/index/x003.jpg) no-repeat 0 0;
	background-position: center;
	background-repeat: no-repeat;
}
</STYLE>
-->
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
</head>
	<body>&nbsp; 
	 
<!--LOGO-->
 <div style="height: 100px"></div>
 <div class="container">
 	<div class="row text-center" >

 	<img src="images/area/<%= Log74Access.get("log74.areacode")%>/common/com_2/img/index/logo.png"  />
 	
 	</div>
</div>
<!--搜索-->
<div style="height: 20px"></div>





<div id="div_login">
         
         <s:form name="loginform" action="/login.do">
		 	<s:hidden name="rootId" value="" />
			<s:hidden name="logoffPage" value="" />
			<s:hidden name="isCorpLogin" value="" />
			<s:hidden name="errorurl" value="error.jsp" />
			<s:hidden name="NickName" />
			<s:hidden name="url" value="zljs/index.jsp" />
			
         <table width="746" class="table table-condensed" >
            <tr>
                <td style="border:none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;用户名：</p></td>                
                <td style="border:none;">
				<input id="username1" name="username1" type="text" class="input-large"  placeholder="请输入您的用户名"  style="width:180px;">
                </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;密 码：</p>
                
                </td>
                <td style="border:none;">				
				<input id="password1" name="password1" type="password"  class="input-large" placeholder="请输入登录密码" style="width:180px;">
                </td>
            </tr>


           <tr>
                <td style="border:none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;验证码：</p></td>                
                <td style="border:none;"><input type="text" id="login_verifycode" name="login_verifycode" style="width:80px;"/> <img id="login_imgObj" alt="验证码"
    style="width:50px;height:20px;"><a href="#" onclick="changeImg('login')">换一张</a>
                </td>
            </tr>

            <tr>
             	<td valign="middle"></td>
                <td>
                <!-- 
				<s:submit value="登 录" cssClass="btn" />
                <button class="btn btn-info" class="btn" onclick="loginIn(false)">游客</button>
                 -->
                <input class="btn btn-success" type="button"   data-toggle="modal" data-target="#myModal" onclick="javascript:initLoginRequestData1()" value="登&nbsp;&nbsp;录">
                </td>
            </tr>
            <!--<tr>
                <td colspan="2" align="center"><input type="checkbox" id="autoLogin"/>下次自动登录</td>
                <td>
                <button class="btn btn-info" class="btn" onclick="loginIn(false)">登录</button>
                <button class="btn btn-info" class="btn" onclick="loginIn(false)">游客</button>
                </td>
            </tr>-->
        </table>
       </s:form>
       </div>

 
 
 
 

<script type="text/javascript">
window.onload = function(){
	$("#login_imgObj").attr("src","<%=basePath%>authImage");
};

function initLoginRequestData1() {
//	$('body').mask('请等待...');
	var username = $('#username1').val();
//	var email = $('#email').val();
	var password = $('#password1').val();
	var verifycode = $('#login_verifycode').val();
//alert(verifycode);
//alert(email);
//alert(password);
	
	username = $.trim(username);
//email = $.trim(email);
	password = $.trim(password);
	verifycode = $.trim(verifycode);
	
	if(username===""){
		showexp("请输入用户名或邮箱地址");
	}else{
		if(username!='guest'&&verifycode==='')
		{
			showexp("请输入验证码");
		}else{
			params = {
					username : username,
					verifycode : verifycode,
//					email : email,
					password : password,
					totalPages : 0
			};
			// 这里清空频道缓存	
			login(params);		
		}
	}
}
</script>
 
 

 
<!--底部展示-->

<%@ include file="jsp/zljs/include-buttom.jsp"%>

</body>
</html>

	<!--[if lte IE 6]>
    <script type="text/javascript" src="common/com_2/js/bootstrap-ie.js"></script>
    <![endif]-->


