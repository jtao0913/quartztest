<%@ page language="java" import="java.util.*, com.cnipr.cniprgz.entity.MenuInfo, com.cnipr.cniprgz.commons.DataAccess" pageEncoding="UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*,com.cnipr.cniprgz.commons.Constant"%>

<%
//System.out.println("path="+path);
String username = session.getAttribute(Constant.APP_USER_NAME)==null?"":(String)session.getAttribute(Constant.APP_USER_NAME);
String useremail = session.getAttribute("useremail")==null?"":(String)session.getAttribute("useremail");
String userrealname = session.getAttribute("userrealname")==null?"":(String)session.getAttribute("userrealname");
//System.out.println("include-head-nav.jsp........................................username="+username);
Integer intAdministerState = session.getAttribute("intAdministerState")==null?0:(Integer)session.getAttribute("intAdministerState");
//System.out.println("include-head-nav.jsp........................................intAdministerState="+intAdministerState);
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//System.out.println("hangye="+hangye);

//String _path = request.getContextPath();
//String _basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+_path;
//System.out.println("=========title="+title);

String hangyename = "";

if(areacode.equals("041")&&!hangye.equals("")){
	if(hangye.equals("scy")){
		hangyename = "沙产业";
	}else if(hangye.equals("nmnj")){
		hangyename = "内蒙农机";
	}else if(hangye.equals("nmnx")){
		hangyename = "内蒙农畜";
	}else if(hangye.equals("xcy")){
		hangyename = "畜产业";
	}else if(hangye.equals("ysjs")){
		hangyename = "有色金属";
	}else if(hangye.equals("zbzz")){
		hangyename = "装备制造";
	}else if(hangye.equals("stcy")){
		hangyename = "生态产业";
	}
}
//System.out.println("=========hangyename="+hangyename);
//out.println("======include-head-nav.jsp=====");
String guestlogin = "";
if(application.getAttribute("guestlogin")==null){
	guestlogin = com.cnipr.cniprgz.commons.DataAccess.getProperty("guestlogin");
	 application.setAttribute("guestlogin",guestlogin);
}
guestlogin = (String)application.getAttribute("guestlogin");
//guestlogin = (guestlogin==null||guestlogin.equals(""))?"1":guestlogin;

String ShowVerifyCode = "";
if(application.getAttribute("ShowVerifyCode")==null){
	ShowVerifyCode = com.cnipr.cniprgz.commons.DataAccess.getProperty("ShowVerifyCode");
	application.setAttribute("ShowVerifyCode",ShowVerifyCode);
}
ShowVerifyCode = (String)application.getAttribute("ShowVerifyCode");


String register = "";
if(application.getAttribute("register")==null){
	register = com.cnipr.cniprgz.commons.DataAccess.getProperty("register");
	 application.setAttribute("register",register);
}
register = (String)application.getAttribute("register");

//long begin = System.currentTimeMillis();

String menulist = (String)session.getAttribute("menuList");
//System.out.println("menulist="+menulist);

//long end = System.currentTimeMillis();
//float total_seceond = (end - begin)/1000.00F;
//System.out.println("total_seceond="+total_seceond);

/*
String website_title = (application.getAttribute("website_title") == null || application.getAttribute("website_title").equals(""))
				? "综合信平台息服务"
				: (String) application.getAttribute("website_title");
*/
%>
<input value='<%=menulist%>' id='menulist' type='hidden'>
<input value='<%=website_title%>' id='title' type='hidden'>
<input value='<%=ShowVerifyCode%>' id='ShowVerifyCode' type='hidden'>


<!--导航-->
		<nav class="navbar navbar-default small" role="navigation">
			<div class="navbar navbar-inverse">
				<div class="navbar-bg-color">
					<div class="row-fluid">

<!-- begin 用ajax填充内容 -->
						<div id="menucontent" class="nav-collapse" style="overflow:visible;"></div>

						<div id="UserDiv" class="pull-right"></div>
						
					</div>
				</div>
			</div>
		</nav>

<script type="text/javascript">
function showlogindiv(){
	$("#div_login").css('display','block');
	$("#div_register").css('display','none');
//	$("#login_tr_verify").html($("#div_verify").html());	
	$("#login_imgObj").attr("src","<%=basePath%>authImage");
}
function showregisterdiv(){
	$("#div_login").css('display','none');
	$("#div_register").css('display','block');	
//	$("#register_tr_verify").html($("#div_verify").html());
	$("#register_imgObj").attr("src","<%=basePath%>authImage");
}
</script>

<!-- 
<div id="div_verify" style="display:none">
     <td colspan="2">请输入验证码：<input type="text" id="verifycode" name="verifycode" style="width: 80px;" /> <img id="imgObj" alt="验证码"
     style="width:50px;height:20px;"><a href="#" onclick="changeImg()">换一张</a>
     </td>
</div>
 -->
<!--登录模块-->
<div class="modal hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header mycolor">
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel" >
               <%=website_title%>
            </h4>
         </div>
         
         <div id="div_login">
         
         <s:form name="loginform" action="/login.do">
		 	<s:hidden name="rootId" value="" />
			<s:hidden name="logoffPage" value="" />
			<s:hidden name="isCorpLogin" value="" />
			<s:hidden name="errorurl" value="error.jsp" />
			<s:hidden name="NickName" />
			<s:hidden name="url" value="zljs/index.jsp" />
			
			<input type="hidden" id="hangye" name="hangye" value="<%=hangye%>">
         <table width="746" class="table table-condensed" >
            <!-- 
            <tr>
              <td width="88px" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;用户名：</p></td>
              <td width="651px">
			  <input type="text" id="username" class="input-large" placeholder="请输入用户名" title="<%=username%>" style="width:180px;">
			  </td>
            </tr>
             -->
            <tr>
                <td style="border:none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;用户名/邮箱：</p></td>                
                <td style="border:none;">
                <input type="hidden" id="useremail" name="useremail" title="<%=useremail%>">
                <input type="hidden" id="userrealname" name="userrealname" title="<%=userrealname%>">
				<input id="username" name="username" type="text" class="input-large" value="<%=username%>" placeholder="请输入您的用户名或邮箱"  style="width:180px;">
                </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;密 码：</p>
                
                </td>
                <td style="border:none;">				
				<input id="password" name="password"x type="password"  class="input-large" placeholder="请输入登录密码" style="width:180px;">

<%if(register.equals("1")){%>
                <span class="btn btn-warning"  onclick="javascript:initcallbackpassword()">找回密码</span>
                <span class="btn btn-primary" onclick="javascript:showregisterdiv()">注 册</span>
<%}%>
                </td>
            </tr>

<%
//String ShowVerifyCode = DataAccess.getProperty("ShowVerifyCode");
if(ShowVerifyCode!=null&&ShowVerifyCode.equals("1")){
%>
           <tr>
                <td style="border:none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;验证码：</p></td>                
                <td style="border:none;"><input type="text" id="login_verifycode" name="login_verifycode" style="width:80px;"/> <img id="login_imgObj" alt="验证码"
    style="width:50px;height:20px;"><a href="#" onclick="changeImg('login')">换一张</a>
                </td>
            </tr>
<%}%>
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
       
       
       <div id="div_register" style="display:none">
       <s:form name="registerform" action="/register.do">		
         <table width="746" class="table table-condensed">
            <tr>
              <td width="88px" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;用户名：</p></td>
              <td width="651px">
			  <input type="text" id="registerusername" class="input-large" placeholder="请输入用户名" title="<%=username%>" style="width:180px;">
			  </td>
            </tr>
            <tr>
                <td style="border:none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;邮 箱：</p></td>                
                <td style="border:none;">
				<input id="registeremail" name="registeremail" type="text" class="input-large" placeholder="请输入您的电子邮箱" style="width:180px;">
                </td>
            </tr>
            <tr>
              <td style="border:none;" width="100px" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;昵 称：</p></td>
              <td width="651" style="border:none;">
			  <input type="text" id="registeruserrealname" name="registeruserrealname" class="input-large" placeholder="请输入登录用户名" title="<%=userrealname%>" style="width:180px;">
			  </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;密 码：</p></td>
                <td style="border: none;">
				<input id="registerpassword" name="registerpassword"x type="password"  class="input-large" placeholder="请输入登录密码" style="width:180px;">
                </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">确认密码：</p></td>
                <td style="border: none;">
				<input id="repassword" name="repassword" type="password"  class="input-large" placeholder="请再次输入登录密码" style="width:180px;">
				
				<div style="display:none" class="tips" id="m_mainCfmPwd"><span class="txt-err"><b class="ico ico-warn-sml"></b>&nbsp;&nbsp;两次填写的密码不一致，请重新输入</span></div>
				
				<span class="btn btn-primary" onclick="javascript:showlogindiv()">返回登录</span>
                </td>
            </tr>

<%if(ShowVerifyCode!=null&&ShowVerifyCode.equals("1")){%>
<tr><td colspan="2">
请输入验证码：<input type="text" id="register_verifycode" name="register_verifycode" style="width: 80px;" /> <img id="register_imgObj" alt="验证码"
  style="width:50px;height:20px;"><a href="#" onclick="changeImg('register')">换一张</a>
</td></tr>
<%}%>

            <tr>
             	<td valign="middle"></td>
                <td>
                <input class="btn" type="button" data-toggle="modal1" data-target="#myModalRegister1" onclick="javascript:initRegisterRequestData()" value="注  册">
                </td>
            </tr>
        </table>
       </s:form>
       </div>  
       
         <!--<div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary">
               提交更改
            </button>
         </div>-->
      </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%
//if(areacode.equals("jshyqp")||areacode.equals("jszldq")||areacode.equals("xhlh")){
if(guestlogin.equals("0")){
//System.out.println("username="+username);
//System.out.println("useremail="+useremail);
//System.out.println("userrealname="+userrealname);
if(
//username.equals("guest")||
		username.equals("")&&useremail.equals("")){%>
<script>
$(function () {	
//	alert("<%=basePath%>authImage");
	$("#login_imgObj").attr("src","<%=basePath%>authImage");
	$('#myModal').modal({
		keyboard: true
})});
</script>
<%}}%>

<script type="text/javascript">
var regex = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
function changeImg(_type) {	
    var imgSrc = $("#"+_type+"_imgObj");
    var src = imgSrc.attr("src");
    var alt = imgSrc.attr("alt");    
//alert("alt="+alt);
//alert("src="+src);    
    imgSrc.attr("src", chgUrl(src));
}

//时间戳
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
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

function initcallbackpassword(){
	var username = $('#username').val();
	var verifycode = $("#login_verifycode").val();
	var ShowVerifyCode = $("#ShowVerifyCode").val();

//alert("ShowVerifyCode="+ShowVerifyCode);

	username = $.trim(username);
	verifycode = $.trim(verifycode);
	
	if((ShowVerifyCode===1||ShowVerifyCode==="1")&&verifycode===''){
		showexp("请输入验证码");
	}else{
//var regex = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g;
		if ( regex.test(username) )
		{
			params = {
				email : username,
				verifycode : verifycode
			};
			// 这里清空频道缓存	
			callbackpassword(params);
		}else{
			showexp("请正确输入邮件");
		}
	}
}
function callbackpassword(params) {
	var text = "";
	$.ajax({
		type : "GET",
		url : "<%=basePath%>callbackpassword.do?timeStamp=" + new Date(),
		data : {
			'email' : params.email,
			'verifycode' : params.verifycode
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			showexp(jsonresult);
		}
	});
}

$(document).ready(function(){
    $("#repassword").blur(function(){
	   	var password = $('#registerpassword').val();
	   	var repassword = $('#repassword').val();
	    	
	   	password = $.trim(password);
	   	repassword = $.trim(repassword);
	   	
	   	if(password!=""&&repassword!=""&&password!=repassword){		
	//    		alert("两次填写的密码不一致");display:none
	   		$("#m_mainCfmPwd").css("display","block");
	   	}else{
	   		$("#m_mainCfmPwd").css("display","none");
	   	}
    });
});

function initRegisterRequestData()
{
	var username = $('#registerusername').val(); 
	var realname = $('#registeruserrealname').val();
	var password = $('#registerpassword').val();
	var repassword = $('#repassword').val();
	
	var registeremail = $('#registeremail').val();
	var verifycode = $('#register_verifycode').val();
	/*
	if(password!=repassword){		
		alert("两次填写的密码不一致");
	}	
	var regex = new RegExp('(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}');
	console.log(regex.test('a123456-'));
	*/
	username = $.trim(username);
	realname = $.trim(realname);
	password = $.trim(password);
	repassword = $.trim(repassword);
	registeremail = $.trim(registeremail);
	verifycode = $.trim(verifycode);
	
	
	var ShowVerifyCode = $("#ShowVerifyCode").val();

//	alert("ShowVerifyCode="+ShowVerifyCode);
	if((ShowVerifyCode===1||ShowVerifyCode==="1")&&verifycode===''){
		showexp("请输入验证码");
		return false;
	}
	if(!(password!=""&&repassword!=""&&password===repassword)){
		showexp("两次填写的密码不一致");
		return false;
	}
	/* if(!(regex.test(registeremail))){
		showexp("请正确输入邮件");
		return false;
	} */
	params = {
			username:username,
			realname : realname,
			password : password,
			email : registeremail,
			verifycode : verifycode
	};
	register(params);
	/*
	if((ShowVerifyCode===1||ShowVerifyCode==="1")&&verifycode===''){
		showexp("请输入验证码");
	}else{
	
		if(password!=""&&repassword!=""&&password===repassword){		
			if (regex.test(registeremail) )
			{
				params = {
					username:username,
					realname : realname,
					password : password,
					email : registeremail,
					verifycode : verifycode
				};
				// 这里清空频道缓存	
				register(params);
			}else{
				showexp("请正确输入邮件");
			}
		}
	}*/
}
function register(params) {
	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=basePath%>register.do?timeStamp=" + new Date(),
		data : {
			'username' : escape(params.username),
			'realname' : escape(params.realname),
			'password' : params.password,
			'email' : params.email,
			'verifycode' : params.verifycode
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			alert(jsonresult);
		}
	});
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
	var ShowVerifyCode = $("#ShowVerifyCode").val();

	username = $.trim(username);
//email = $.trim(email);
	password = $.trim(password);
	verifycode = $.trim(verifycode);
	
	if(username===""){
		showexp("请输入用户名或邮箱地址");
	}else{
//		if(username!='guest'&&verifycode==='')
		if((ShowVerifyCode===1||ShowVerifyCode==="1")&&username!='guest'&&verifycode==='')
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
	var dingqiyujing = "<%=SetupAccess.getProperty(SetupConstant.DINGQIYUJING)%>";
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
				//window.location.reload();
				showmenu(ret[1],ret[3]);
			}
		},

		error : function(jsonresult) {
			//alert("请核对用户信息，并重新输入");
		}	
	});	
}

function showmenu(username,content){
//	var username = ret[1];
//	var title = ret[3];
//alert("showmenu....");
//$(document).attr("title",title + "-专利检索查询,专利搜索下载");
//	 $('#menucontent').html('');
			text = '<ul class="nav">';
			text = text + '<li><a href="<%=basePath%>">首&nbsp;页</a></li>';
//			var menucontent = eval("("+jsonresult+")");
			var menucontent = eval("("+content+")");
//alert(menucontent);			
			$.each($(menucontent),function(index) {
				// 处理分类号
				var ipcStr = ""
				if (this.chrEnMenuName != null && this.chrEnMenuName != "" && this.menuType != "notshow") {			
//					alert("开始一个新的菜单-------------------");					
//					alert("this.childMenu.length = "+this.childMenu.length);					
//					alert(this.chrMenuName);
//					alert(this.chrEnMenuName);
//					alert(this.chrMenuURL);
//					alert(this.intMenuID);
//					alert(this.intParentID);
//					alert(this.menuType);					
					if(this.childMenu.length > 0 ){
						text = text + '<li class="dropdown"><a href="<%=basePath%>'+this.chrMenuURL+'" class="dropdown-toggle" data-toggle="dropdown">'+this.chrMenuName+'<b class="w_caret"></b></a>';
						text = text + '<ul class="dropdown-menu">';						
						
						//alert("开始子菜单-------------------");
						for ( var i = 0; i < this.childMenu.length; i++) {
							//alert(this.childMenu[i].chrMenuName);

							if(this.childMenu[i].chrMenuName=="定期预警"){
								if(dingqiyujing=="1"){
									text = text + '<li><a href="<%=basePath%>'+this.childMenu[i].chrMenuURL+'">'+this.childMenu[i].chrMenuName+'</a></li>';
								}else{

								}
							}else{							
								text = text + '<li><a href="<%=basePath%>'+this.childMenu[i].chrMenuURL+'">'+this.childMenu[i].chrMenuName+'</a></li>';
							}
						}
						text = text + '</ul>';
					}else{
						text = text + '<li><a href="<%=basePath%>'+this.chrMenuURL+'">'+this.chrMenuName+'</a></li>';
					}
							
				}			
			});		
			
			
			$("#menucontent").html(text + '</ul>');
			
			//alert($("#menucontent").html());
			
			$('#UserDiv').html('');
			
			//alert($(this).attr("alt"));
			var _username = $('#username').attr("title");
//			alert("111="+_username);
			
			if(username!=''){
//				alert("222="+params.username);
				_username = username;
			}
			//alert('_username='+_username);
			if(_username=='guest'||_username==''){
				_username = "游客";
			}
						
			var userdivcontent = '<ul class="nav">';
			userdivcontent = userdivcontent + '<li><a href="#">欢迎您：'+_username+'</a></li>';
			if(_username!='游客'){
				userdivcontent = userdivcontent + '<li><a href="javascript:logoff();">退出</a></li>';
			}else{
				userdivcontent = userdivcontent + '<li><a href="#" data-toggle="modal" onclick="javascript:showlogindiv();" data-target="#myModal">登录</a></li>';
				//userdivcontent = userdivcontent + '<li><a href="#" data-toggle="modal" data-target="#myModalRegister">注册</a></li>';
			}
			
//			if(_username=='guest'||_username==''){}			
//			userdivcontent = userdivcontent + '<li><a href="javascript:loginOut();">意见反馈</a></li>';
			userdivcontent = userdivcontent + '<li><a href="ipph-help/index.html" target="_blank">帮助中心</a></li>';
			userdivcontent = userdivcontent + '</ul>';
			
			$('#UserDiv').html(userdivcontent);
			$('#myModal').modal('hide');
}

function logoff() {
//alert("logoff....");
	var hangye=$("#hangye").val();
	//alert(hangye);
	$('#menucontent').html('');
	params = {
		email : "guest",
		password : "123456",
		totalPages : 0
	};
	
	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=basePath%>logoff.do?timeStamp=" + new Date(),
		data : {
			'email' : params.email,
			'password' : params.password
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//			alert(jsonresult);
//			$("#username").attr("value","guest");//清空内容 
//			$("#password").attr("value","123456");
		
			<%
			if(areacode.equals("shaanxiyangling")&&hangye.equals("fxspcy")){
				if(hangye!=null){
			%>
					location.href = "<%=basePath%>index_"+hangye+".jsp";
			<%
				}else{
			%>
					location.href = "<%=basePath%>index.jsp";
			<%
				}
			}else{			
				if(guestlogin.equals("1")){
			%>
					$("#username").val("guest");//清空内容 
					$("#password").val("123456");
					initLoginRequestData();
			<%
				}else{
			%>
					location.href = "<%=basePath%>index.jsp";
			<%
				}
			}
			%>
		}
	})
}
</script>

<%
//System.out.println("guestlogin="+guestlogin);
if(guestlogin.equals("1"))
{
//System.out.println("username="+username);
//System.out.println("useremail="+useremail);
%>
<script type="text/javascript">
//window.onload = function(){
$(function() {
//alert("window.onload....");	
	$(document).attr("title",$('#title').val() + "-专利检索查询,专利搜索下载");
//var username = $('#username').val();
//var useremail = $('#useremail').val();
	var username = '<%=username%>';
	var useremail = '<%=useremail%>';
//alert('username='+username);	
//alert('useremail='+useremail);
	if(username===''&&useremail===''){
//alert('username为空');
//$("#username").attr("value","guest");//清空内容
//$("#password").attr("value","123456");		
		$('#username').val("guest");
		$('#password').val("123456");
		initLoginRequestData();
	}else{
		//alert("menucontent="+$("#menucontent").html());
		var menulist = $("#menulist").val();
		showmenu(username,menulist);
	}	
	//var menucontent = $("#menucontent").html();	
});
</script>
<%}else{%>
<script type="text/javascript">
//window.onload = function(){
$(function() {
	var username = '<%=username%>';
	var menulist = $("#menulist").val();
	
//alert(username);
//alert(menulist);
	
	if(username!=''&&menulist!=''){
		showmenu(username,menulist);
	}
});
</script>
<%}%>