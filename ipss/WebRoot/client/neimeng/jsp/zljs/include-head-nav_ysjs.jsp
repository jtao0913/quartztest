<%@ page language="java" import="java.util.*, com.cnipr.cniprgz.entity.MenuInfo, com.cnipr.cniprgz.commons.DataAccess" pageEncoding="UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*,com.cnipr.cniprgz.commons.Constant"%>

<%
//System.out.println("path="+path);
String username = session.getAttribute(Constant.APP_USER_NAME)==null?"":(String)session.getAttribute(Constant.APP_USER_NAME);
//System.out.println("include-head-nav.jsp........................................username="+username);
Integer intAdministerState = session.getAttribute("intAdministerState")==null?0:(Integer)session.getAttribute("intAdministerState");
//System.out.println("include-head-nav.jsp........................................intAdministerState="+intAdministerState);
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//System.out.println("hangye="+hangye);
%>

<!--导航-->

		<nav class="navbar navbar-default small" role="navigation">
			<div class="navbar navbar-inverse">
				<div class="navbar-bg-color">
					<div class="row-fluid">

<!-- begin 用ajax填充内容 -->
						<div class="nav-collapse" id="menucontent" style="overflow: visible;">
							<ul class="nav">
	
<li class="dropdown"> <a class="dropdown-toggle" href="#" data-toggle="dropdown">专利检索<b class="w_caret"></b></a>
<ul class="dropdown-menu">


<li><a href="<%=basePath%>showSearchForm.do?area=cn">表格检索【中国】</a></li>
<li><a href="<%=basePath%>showSearchForm.do?area=fr">表格检索【港澳台及国外】</a></li>
<li><a href="<%=basePath%>showLogicForm.do?area=cn">专家检索【中国】</a></li>
<li><a href="<%=basePath%>showLogicForm.do?area=fr">专家检索【港澳台及国外】</a></li>
<li><a href="<%=basePath%>mytreeipc.do">IPC分类导航</a></li>
<li><a href="<%=basePath%>showFlztSearchForm.do">中国法律状态检索</a></li>
</ul>
</li>

<li><a href="/ipss/mytreehangye.do">有色金属</a></li>

</ul>
</div>



						<div id="UserDiv" class="pull-right">
							<ul class="nav">
							 
								<%if(!username.equals("guest")&&!username.equals("")){%>
									<li><a href="#">欢迎您：<%=username%></a></li>
									<!-- <li><a href="<%=basePath%>logoff.do">退出</a></li> -->
									<li><a href="javascript:logoff();">退出</a></li>
								<%}else{
									if(username.equals("guest")||username.equals("")){
								%>
									<li><a href="#">欢迎您：游客</a></li>
									<li><a href="#" data-toggle="modal" data-target="#myModal">登录</a></li>
									<%}%>
								<%
								}%>
								
								<!-- 
								<li><a href="<%=basePath%>common/sysm.zip">帮助中心</a></li>
								 -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>


  <!--登录模块-->
<div class="modal hide fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
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
         <!--<div class="modal-body">
            按下 ESC 按钮退出。
         </div>-->
         <s:form name="loginform" action="/login.do">
		 	<s:hidden name="rootId" value="" />
			<s:hidden name="logoffPage" value="" />
			<s:hidden name="isCorpLogin" value="" />
			<s:hidden name="errorurl" value="error.jsp" />
			<s:hidden name="NickName" />
			<s:hidden name="url" value="zljs/index.jsp" />
			
			<input type="hidden" id="hangye" name="hangye" value="<%=hangye%>">
         <table width="746" class="table table-condensed" >
            <tr>
              <td width="88px" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;用户名：</p></td>
              <td width="651">
			  <!--<s:textfield name="user.chrUserName" value="guest" class="input-large" placeholder="请输入登录账号" style="width:180px;"/>-->
			  <input type="text" id="username" class="input-large" placeholder="请输入登录用户名" title="<%=username%>" style="width:180px;">
			  </td>
            </tr>
            <tr>
                <td style="border: none;" valign="middle"><p class="text-info text-center">&nbsp;&nbsp;密 码：</p></td>
                <td style="border: none;">
				<!--<s:password name="user.chrUserPass" cssClass="input-large" />-->
				
				<input id="password" name="password"x type="password"  class="input-large" placeholder="请输入登录密码" style="width:180px;">
                <span class="help-inline">&nbsp;&nbsp;欢迎您登录<%=website_title%>！ </span>
	
                </td>
            </tr>
            <tr>
            <!--
                <td valign="middle"><p class="text-info text-center"><input type="checkbox" id="autoLogin"/> 记住</p></td>
             -->
             	<td valign="middle"></td>
                <td>
                <!-- 
				<s:submit value="登 录" cssClass="btn" />
                <button class="btn btn-info" class="btn" onclick="loginIn(false)">游客</button>
                 -->
                <button class="btn" type="submit"  data-toggle="modal" data-target="#myModal" onclick="javascript:initLoginRequestData()">登 录</button>
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




		
<script type="text/javascript">
//$(function() {
//})
//	alert("2222");
function initLoginRequestData() {
//	$('body').mask('请等待...');	
	var aaa = $('#username').val();
	var bbb = $('#password').val();
//	alert(aaa);
//	alert(bbb);	
	params = {
		username : $('#username').val(),
		password : $('#password').val(),
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
	var dingqiyujing = "<%=SetupAccess.getProperty(SetupConstant.DINGQIYUJING)%>";
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
		url : "<%=basePath%>login.do?timeStamp=" + new Date(),
		data : {
			'username' : params.username,
			'password' : params.password,
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
	var title = ret[2];
	$(document).attr("title",title + "-专利检索查询,专利搜索下载");

			$('#menucontent').html('');
			text = '<ul class="nav">';
			text = text + '<li><a href="<%=basePath%>index.jsp">首&nbsp;页</a></li>';
//			var menucontent = eval("("+jsonresult+")");
			var menucontent = eval("("+ret[1]+")");
//alert(menucontent);
			
			$.each($(menucontent),function(index) {
				// 处理分类号
				var ipcStr = ""
				if (this.chrEnMenuName != null && this.chrEnMenuName != "") {			
//					alert("开始一个新的菜单-------------------");					
//					alert("this.childMenu.length = "+this.childMenu.length);					
//					alert(this.chrMenuName);
//					alert(this.chrEnMenuName);
//					alert(this.chrMenuURL);
//					alert(this.intMenuID);
//					alert(this.intParentID);
//					alert(this.menuType);					
					if(this.childMenu.length > 0){
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
					
//					alert("开始子菜单-------------------");
//					for ( var i = 0; i < this.childMenu.length; i++) {
//						alert(this.childMenu[i].chrMenuName);
//					}				
				}			
			});
			$('#menucontent').html(text + '</ul>');
			$('#UserDiv').html('');
			
			//alert($(this).attr("alt"));
			var _username = $('#username').attr("title");

			if(params.username!=''){
				_username = params.username;
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
				userdivcontent = userdivcontent + '<li><a href="#" data-toggle="modal" data-target="#myModal">登录</a></li>';
			}
//			userdivcontent = userdivcontent + '<li><a href="javascript:loginOut();">帮助中心</a></li>';
//			userdivcontent = userdivcontent + '<li><a href="javascript:loginOut();">意见反馈</a></li>';
			userdivcontent = userdivcontent + '</ul>';
			
			$('#UserDiv').html(userdivcontent);			
			$('#myModal').modal('hide');
			
//			isLoading = false;
//			$('body').unmask();

//			location.href = "<%=basePath%>index.jsp";
}
		},

		error : function(jsonresult) {
			alert("请核对用户信息，并重新输入");
		}	
	});	
}

function logoff() {
//alert("logoff....");
var hangye=$("#hangye").val();
//alert(hangye);
$('#menucontent').html('');
	params = {
		username : "guest",
		password : "123456",
		totalPages : 0
	};
			
	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=basePath%>logoff.do?timeStamp=" + new Date(),
		data : {
			'username' : params.username,
			'password' : params.password,
			'totalPages' : params.totalPages
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//			alert(jsonresult);

//			$("#username").attr("value","guest");//清空内容 
//			$("#password").attr("value","123456");
			if(hangye==""){
				$("#username").val("guest");//清空内容 
				$("#password").val("123456");
				
		　　		initLoginRequestData();
			}else{
				location.href = "<%=basePath%>index_"+hangye+".jsp";
			}
		}
	})
}

</script>


<script type="text/javascript">
window.onload = function(){
	var username = $('#username').attr('title');
//alert('username='+username);	
	if(username==''){
//alert('username为空');
		$("#username").attr("value","ysjs");//清空内容 
		$("#password").attr("value","123456");
　　		initLoginRequestData();
	}
}; 
</script>
