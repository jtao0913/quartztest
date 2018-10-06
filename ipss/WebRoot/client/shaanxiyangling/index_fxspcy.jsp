<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>

<%@ include file="jsp/zljs/include-head.jsp"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=website_title%>-专利检索查询,专利搜索下载</title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
    <meta name="description" content="<%=SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

<link href="client/shaanxiyangling/images/css.css" type=text/css rel=stylesheet />

</head>

<body>
<div class="top01"></div>
<div id="top"><div id="div1"><img src="client/shaanxiyangling/images/logo02.png"  usemap="#Map" border="0" />
    <map name="Map" id="Map">
      <area shape="rect" coords="8,10,359,68" href="/" />
    </map>
    
</div>
</div>
<div id="div22">
  <div id="div2">
    <div id="denglu" style="FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=client/shaanxiyangling/images/01.png')">
                <div id="dldiv">
                	
                  <div class="wz">登录到您的帐户</div>
               	  
                <form method="post" name="loginform" action="login.do?method=login">
				<input type="hidden" id="hangye" name="hangye" value="fxspcy"/>

                    <br/>&nbsp;用户名<br/>
                    <div class="bja" style=" margin-bottom:10px;"> 
                    	 <input name="username" id="username" value="fxspcy" class="NoneInput" type="text"  style="background-image:url(client/shaanxiyangling/images/human.png); background-repeat:no-repeat;background-color:transparent;border:none;height:36px;padding-left:40px;" />
                    </div>&nbsp;密&nbsp;&nbsp;&nbsp;码<br/>
                     <div class="bja"> 
                         <input class="NoneInput" name="password" type="password" value="123456" id="password" style="background-image:url(client/shaanxiyangling/images/lock.png); background-repeat:no-repeat;background-color:transparent;border:none;height:36px;height:41px;padding-left:40px;"/>
                     </div>

                    <input class="ButtonCSS" type="submit" value="登&nbsp;&nbsp;录" onclick="initLoginRequestData()"/>
                    
                    </form>
               	  
                    <script type="text/javascript">
                        /* 输入框获取 && 失去焦点时 样式控制 */
                        $('.NoneInput').focus(function(){
                            $(this).parent().attr('class','bjb');
                        }).blur(function(){
                            $(this).parent().attr('class','bja');
                        });
                    </script>
        </div>
            
            </div> 
   	<!--banner开始-->
            
            
            </div>

<!--banner结束-->    	
    

</div>

<div class="links_gsf" style="height:198px; margin:0 auto;">
	<div class="links_con" style="height:198px; width:100%; text-align:center;">
        <img src="client/shaanxiyangling/images/menu02.png"  height="198" border="0">
    </div>
</div>


<div id="di">
    <div id="div4">
      项目实施：中国杨凌农业知识产权信息中心&nbsp;&nbsp;&nbsp;&nbsp;安康市知识产权办公室&nbsp;&nbsp;&nbsp;&nbsp;技术支持：知识产权出版社
    </div>
</div>

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
		hangye : "fxspcy",
		totalPages : 0
	};

//var aaa = _username;
/*
	params = {
		username : _username,
		password : _password,
//		hangye : $('#hangye').val(),
		hangye : _hangye,
		totalPages : 0
	};
*/
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
