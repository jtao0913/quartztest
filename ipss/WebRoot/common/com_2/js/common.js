/**
 * 不做任何操作， 因void(0)在IE6下面有问题故此添加此函数
 */
function noAction() {
	return;
}

/**
 * 两号判断是否要加CN
 */
function isAppendCN(str) {
	var reg = /^\d*\.?\w?$/;
	if (reg.exec(str)) {
		str = "CN" + str;
	}
	return str;
}
/**
 * 验证邮件格式
 */
function checkEmail(str) {
	var patrn = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	if (!patrn.exec(str)) {
		alert("电子邮件地址格式不正确! ");
		return false;
	}
	return true;
}
// 1.js验证只能输入数字.
function isIp(ip) {
	var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	 return re.test(ip);
}
// 1.js验证只能输入正整数
function isZzs(zs) {
  var re = /^\d+$/;
  return re.test(zs);
}

function ipToInt(ip) {
	var ip_int = 0;
	var ip_split = ip.split('.');
	ip_int = ((((((+ ip_split[0])* 256)+(+ ip_split[1]))* 256)+(+ ip_split[2]))* 256)+(+ ip_split[3]);
// alert(ip_int);
	return ip_int;
}

function checkSession(){
	var resp = ajaxCallBySync("/login!checkLogin.action","");
	if(resp){
		var msg = eval('['+resp+']')[0].msg;
		if(msg){
			return true;
		}
	}
	return false;
}

function getDownloadCount(){
	var resp = ajaxCallBySync("/user!getAbsDownloadCount.action","");
	var msg = 0;
	if(resp){
		msg = eval('['+resp+']')[0].downloadCount;
	}
	return msg;
}

function trim(str){ // 删除左右两端的空格
     return str.replace(/(^\s*)|(\s*$)/g, "");
 }

/**
 * 判断浏览器类型
 */
function CheckBrowser(){
    var cb = "Unknown";
    if(window.ActiveXObject){
        cb = "IE";
    }else if(navigator.userAgent.toLowerCase().indexOf("firefox") != -1){
        cb = "Firefox";
    }else if((typeof document.implementation != "undefined") && (typeof document.implementation.createDocument != "undefined") && (typeof HTMLDocument != "undefined")){
        cb = "Mozilla";
    }else if(navigator.userAgent.toLowerCase().indexOf("opera") != -1){
        cb = "Opera";
    }
    return cb;
}
function isIE6(){
	var browser=navigator.appName 
	var b_version=navigator.appVersion 
	var version=b_version.split(";");
	try {
		var trim_Version=version[1].replace(/[ ]/g,""); 
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") { 
			// alert("IE 7.0");
		} 
		else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") { 
			// alert("IE 6.0");
			return true;
		} 
	} catch (e) {
		return false;
	}
	
	return false;
}

/**
 * yib
 * 
 * @param {}
 *            url
 * @param {}
 *            params
 * @return {}
 */
function ajaxCallByAsync(url, params) {
	var returnJson = $.ajax({
		url : sRoot + url + "?randomNum=" + Math.random(),
		data : params,
		type : "POST",
		async : true
	});
	var returnText = returnJson.responseText;
	return returnText;
}
/**
 * 同步获取数据
 * 
 * @param {}
 *            url
 * @param {}
 *            params
 * @return {}
 */
function ajaxCallBySync(url, params) {
	var flag = "success";
	var returnText = "";
	var returnJson = $.ajax({
		url : sRoot + url + "?randomNum=" + Math.random(),
		data : params,
		type : "POST",
		async : false,
		// success:function(data,
		// textStatus){alert("ajaxCallBySync:"+data.data);},
		error : function() {
			flag = "failure";
		}
	});
	if (flag == "success") {
		returnText = returnJson.responseText;
	}
	// alert(returnText);
	return returnText;
}

function Map() {
	 var struct = function(key, value) {
	  this.key = key;
	  this.value = value;
	 }
	 
	 var put = function(key, value){
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	    this.arr[i].value = value;
	    return;
	   }
	  }
	   this.arr[this.arr.length] = new struct(key, value);
	 }
	 
	 var get = function(key) {
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	     return this.arr[i].value;
	   }
	  }
	  return null;
	 }
	 
	 var remove = function(key) {
	  var v;
	  for (var i = 0; i < this.arr.length; i++) {
	   v = this.arr.pop();
	   if ( v.key === key ) {
	    continue;
	   }
	   this.arr.unshift(v);
	  }
	 }
	 
	 var size = function() {
	  return this.arr.length;
	 }
	 
	 var isEmpty = function() {
	  return this.arr.length <= 0;
	 } 
	 this.arr = new Array();
	 this.get = get;
	 this.put = put;
	 this.remove = remove;
	 this.size = size;
	 this.isEmpty = isEmpty;
	}

function len(s) { 
	var l = 0; 
	var a = s.split(""); 
	for (var i=0;i<a.length;i++) 
	{ 
		if (a[i].charCodeAt(0)<299) 
		{ 
			l++; 
		} else { 
			l+=2; 
		} 
	} 
	return l;
}

function checkAuthority(){
	var resp = ajaxCallBySync("/user!getSearchLowAuthority.action" + "?randomNum=" + Math.random(),"");
	if(resp){
		var msg = eval('['+resp+']')[0].success;
		if(msg){
			return true;
		}
	}
	return false;
}
/**********************弹出窗口登录***********************/
/**
 * 弹出窗口登录整逐渐被lhgdialog控件取代wbox控件，
 * 在这里实现统一处理
 * 下面为lhgdialog需要定义的窗口变量
 */
var api , W ;
if(frameElement){
	api = frameElement.api;
	W = api.opener;
}
/**
 * 统一的关闭窗口事件，便于插件更换
 */
function closeOpenWin(loginWin){
//	关闭窗口
	loginWin.close();
}
/**
 * 所有的登录页面应该共用此方法弹出登录子窗口
 * forward参数为登录成功后需要跳转的页面，为空则直接关闭窗口即可
 * 	  myPatent：pages!myPatent.action
 * 	  expert：pages!expertSearch.action
 */

function openLoginWin(forward){
	$.dialog({
		id : 'winlogin',
		title : '已注册会员请登录',
		content : "url:windows/login.jsp?forward="+forward,
		width : 770,
		// height : 600,
		left : '50%',
		top : '50%',
		lock: true,
		fixed : true,
		drag : true,
		// time: 5,
		max : false,
		min : false,
		close : function() {
		},
		resize : false
	});
}
/**
 * 所有的登录页面应该共用此方法弹出登录子窗口
 * forward参数为登录成功后需要跳转的页面，为空则直接关闭窗口即可
 * 	  myPatent：pages!myPatent.action
 * 	  expert：pages!expertSearch.action
 */

function openLogin(forward){
	forward = forward? forward : "";
	$.dialog({
		id : 'winlogin',
		title : '已注册会员请登录',
		content : "url:windows/login-new.jsp?forward="+forward,
		width : 770,
		// height : 600,
		left : '50%',
		top : '50%',
		lock: true,
		fixed : true,
		drag : true,
		// time: 5,
		max : false,
		min : false,
		close : function() {
		},
		resize : false
	});
}

function winLoginSuccess(loginWin,userRole,username,forward){
	parent.document.getElementById('loginText1').innerHTML ="<a href='javascript:logout();'>退出</a>";
	if(userRole=="xtgly"){
		parent.document.getElementById('loginText2').innerHTML ="欢迎您，"+username+"&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
	}
	else if(userRole=="jtgly"){
		parent.document.getElementById('loginText2').innerHTML ="欢迎您，"+username+"&nbsp;<a href='${ctx}/admin.action' target='_self'>集团管理</a>&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
	}
	else{
		parent.document.getElementById('loginText2').innerHTML ="欢迎您，<a href='${ctx}/user!initPage4ModUserInfo.action' target='_self'>"+username+"</a>&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
	}
	parent.document.getElementById('ywkLink').innerHTML ="<a href='http://59.151.93.198/Medicine/autoLogin?username="+username+"&sessionid=<%=request.getSession().getId()%>' target='_blank'>药物库</a>";
	parent.document.getElementById("ywkLink").style.display = 'block';
	parent.isLogin = true;
	if(forward && forward=='expert'){
		parent.location.href=getContext()+'/pages!expertSearch.action';
	}
	else if(forward && forward=='myPatent'){
		parent.location.href=getContext()+'/pages!myPatent.action';
	}
	else{
//		关闭窗口
		closeOpenWin(loginWin);
	}
}

function loginSuccess(loginWin,userRole,username,forward){
//	parent.document.getElementById('loginText1').innerHTML ="<a href='javascript:logout();'>退出</a>";
//	if(userRole=="xtgly"){
//		parent.document.getElementById('loginText2').innerHTML ="欢迎您，"+username+"&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
//	}
//	else if(userRole=="jtgly"){
//		parent.document.getElementById('loginText2').innerHTML ="欢迎您，"+username+"&nbsp;<a href='${ctx}/admin.action' target='_self'>集团管理</a>&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
//	}
//	else{
//		parent.document.getElementById('loginText2').innerHTML ="欢迎您，<a href='${ctx}/user!initPage4ModUserInfo.action' target='_self'>"+username+"</a>&nbsp;<a href='user!rechargePage.action' target='_blank'>充值</a>";
//	}
//	parent.document.getElementById('ywkLink').innerHTML ="<a href='http://59.151.93.198/Medicine/autoLogin?username="+username+"&sessionid=<%=request.getSession().getId()%>' target='_blank'>药物库</a>";
//	parent.document.getElementById("ywkLink").style.display = 'block';
//	parent.isLogin = true;
	var html = '<span style="color: #FFFFFF;line-height: 40px;display: inline-block;">欢迎您：</span><a href="login!loginPage.action">'+username+'</a>&nbsp;&nbsp;&nbsp;';
	html += '<a href="javascript:noAction()" onclick="logout()">退出</a>';
	parent.document.getElementById('navLogin').innerHTML = html;
	if(forward && forward=='expert'){
		parent.location.href=getContext()+'/pages!expertSearch.action';
	}
	else if(forward && forward=='myPatent'){
		parent.location.href=getContext()+'/pages!myPatent.action';
	}
	else{
//		关闭窗口
		closeOpenWin(loginWin);
	}
}
function getContext(){
	var localObj = window.location;
	var contextPath = localObj.pathname.split("/")[1];
	var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
	var server_context=basePath;
	return server_context;
}

function openLhgdialogWin(id,title,url){
	$.dialog({
		id : id,
		title : title,
		content : "url:"+url,
		left : '50%',
		top : '50%',
		lock: true,
		fixed : true,
		drag : true,
		// time: 5,
		max : false,
		min : false,
		close : function() {
		},
		resize : false
	});
}

function logout(){
	$.dialog({
		title:"提醒",
		lock:true,
		content:"确定退出系统么？",
		icon:'prompt.gif',
		ok:function(){
			//logout action
			$.post("login!logout.action?rd="+Math.random(),
					function(){
				var html = '<a href="javascript:noAction()"  onclick="openLogin()">登录</a>&nbsp;';
				html += '<a href="javascript:noAction()">注册</a>';
				$("#navLogin").html(html)
			});
		}
	});
}