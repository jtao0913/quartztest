<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>
<%@ include file="jsp/zljs/include-head.jsp"%>

<head>


</head>


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
				<input id="username" name="username" type="text" class="input-large"  placeholder="请输入您的用户名"  style="width:180px;">
                </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;密 码：</p>
                
                </td>
                <td style="border:none;">				
				<input id="password" name="password"x type="password"  class="input-large" placeholder="请输入登录密码" style="width:180px;">
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
                <input class="btn btn-success" type="button"   data-toggle="modal" data-target="#myModal" onclick="javascript:initLoginRequestData()" value="登&nbsp;&nbsp;录">
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
$(document).ready(function(){
	//alert("img");
	$("#login_imgObj").attr("src","<%=basePath%>authImage");
});

var regex = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
function changeImg(_type) {	
    var imgSrc = $("#"+_type+"_imgObj");
    var src = imgSrc.attr("src");
    var alt = imgSrc.attr("alt");
    
    //alert("alt="+alt);
    //alert("src="+src);
    
    imgSrc.attr("src", chgUrl(src));
}
function chgUrl(url) {
	//alert(url);
	    var timestamp = (new Date()).valueOf();
	//alert("timestamp="+timestamp);
	//url = url.substring(0, 20);
	    if (url.indexOf("&") >= 0) {
	    	url = url + "×tamp=" + timestamp;
	    } else {
	    	url = url + "?timestamp=" + timestamp;
	    }
	    return url;
	}

function initLoginRequestData() {
//	$('body').mask('请等待...');
	var username = $('#username').val();
//	var email = $('#email').val();
	var password = $('#password').val();
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
function login(params) {
//alert(params.login_user_chrUserName);
//alert(params.login_user_chrUserPass);
//alert(params.totalPages);
//var exp = new Date();
//alert("login...");
//alert(dingqiyujing);
//alert(params.username);
//alert(params.password);
	
//$('#currentPage').val(params.currentPage);
//$('#data-process-img').show();
//isLoading = true;
	var username = params.username;
//	var email = params.email;
	var text = "";
	$.ajax({
		type : "GET",
		url : "<%=basePath%>login.do?timeStamp=" + new Date(),
		data : {
			'username' : params.username,
			'verifycode':params.verifycode,
//			'email' : params.email,
			'password' : params.password
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//		alert(jsonresult);
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
				showexp(ret[1]);
			}else{
				window.location.href='index.jsp';
				//window.location.reload();
				//showmenu(ret[1],ret[3]);
			}
		},

		error : function(jsonresult) {
			//alert("请核对用户信息，并重新输入");
		}	
	});	
}
</script>