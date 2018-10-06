<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>
<%@ include file="jsp/zljs/include-head.jsp"%>

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

<link href="client/shaanxiyangling/images/css.css" type=text/css rel=stylesheet />
<script type="text/javascript">  
window.onload = function()   
{  
  labels = document.getElementById('rd').getElementsByTagName('label');  
  radios = document.getElementById('rd').getElementsByTagName('input');  
  for(i=0,j=labels.length ; i<j ; i++)  
  {  
   labels[i].onclick=function()   
   {  
    if(this.className == '') {  
     for(k=0,l=labels.length ; k<l ; k++)  
     {  
      labels[k].className='';  
      radios[k].checked = false;  
     }  
     this.className='checked';  
     try{  
        document.getElementById(this.name).checked = true;  
     } catch (e) {}  
    }
   }
  }
}
 
</script>  
</head>

<body>
<div class="top01"></div>
<div id="top"><div id="div1"><img src="client/shaanxiyangling/images/logo01.png" border="0" /></div>
</div>



<div id="div22">
  <div id="div2">
    <div id="denglu" style="FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=client/shaanxiyangling/images/01.png')">
                <div id="dldiv">
                
                <div class="wz">登录到您的帐户</div>
               	
                <form method="post" name="loginform" action="login.do?method=login">
				<input type="hidden" id="hangye" name="hangye"/>

                    <br/>&nbsp;用户名<br/>
                    <div class="bja" style=" margin-bottom:10px;"> 
                    	 <input name="username" id="username" value="guest" class="NoneInput" type="text"  style="background-image:url(client/shaanxiyangling/images/human.png); background-repeat:no-repeat;background-color:transparent;border:none;height:36px;padding-left:40px;" />
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




<div class="links_gsf">
	<div class="pic_btn" style="padding-top:30px;">
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('skjc','123456','815')" alt="数控机床"><img src="client/shaanxiyangling/images/btn/01.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('syzb','123456','947')" alt="石油装备"><img src="client/shaanxiyangling/images/btn/02.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('tyngf','123456','804')" alt="太阳能光伏"><img src="client/shaanxiyangling/images/btn/03.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('xnyqc','123456','860')" alt="新能源汽车"><img src="client/shaanxiyangling/images/btn/04.png"></img></a>
    	</div>
	</div>
	<div class="pic_btn">
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('mhg','123456','1015')" alt="煤化工"><img src="client/shaanxiyangling/images/btn/05.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('flfd','123456','968')" alt="风力发电"><img src="client/shaanxiyangling/images/btn/06.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('zndw','123456','878')" alt="智能电网"><img src="client/shaanxiyangling/images/btn/07.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('zcy','123456','749')" alt="中草药"><img src="client/shaanxiyangling/images/btn/08.png"></img></a>
    	</div>
	</div>
	<div class="pic_btn" style="width: 696px;">
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('scl','123456','911')" alt="水处理"><img src="client/shaanxiyangling/images/btn/09.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('ggljgq','123456','983')" alt="高功率激光器"><img src="client/shaanxiyangling/images/btn/10.png"></img></a>
    	</div>
    	<div style="cursor:hand" class="pic_btn_con">
    		<a href="#" onClick="initLoginRequestData('fxspcy','123456','1047')" alt="富硒食品产业"><img src="client/shaanxiyangling/images/btn/11.png"></img></a>
    	</div>
    	
	</div>
</div>

<div id="di">
    <div id="div4">项目实施：中国杨凌农业知识产权信息中心&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术支持：知识产权出版社</div>
</div>

<script type="text/javascript">
function initLoginRequestData(_username,_password,_hangye) {

/*
//	$('body').mask('请等待...');	
	var aaa = $('#username').val();
	var bbb = $('#password').val();
//	alert(aaa);
//	alert(bbb);	
	params = {
		username : $('#username').val(),
		password : $('#password').val(),
//		hangye : $('#hangye').val(),
		hangye : hangye,
		totalPages : 0
	};
*/
//var aaa = _username;
//alert(_username);
	
if (typeof(_username) == "undefined") { 
   _username = "guest";
}
if (typeof(_password) == "undefined") { 
   _password = "123456";
}
if (typeof(_hangye) == "undefined") { 
   _hangye = "";
}

	params = {
		username : _username,
		password : _password,
//		hangye : $('#hangye').val(),
		hangye : _hangye,
		totalPages : 0
	};
	// 这里清空频道缓存	
	login(params);
}
function login(params) {
//var exp = new Date();

//	alert(params.username);
//	alert(params.password);
//	alert(params.hangye);
	
//	$('#currentPage').val(params.currentPage);
//	$('#data-process-img').show();
//	isLoading = true;
	var text = "";
	$.ajax({	
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
