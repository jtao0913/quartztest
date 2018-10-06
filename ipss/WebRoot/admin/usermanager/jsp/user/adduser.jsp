<!DOCTYPE html>
<html>
<%@ page contentType="text/html;charset=utf-8" import="com.trs.usermanage.*" %>
<%@page import="com.cnipr.cniprgz.authority.user.IPCheckUtils,java.util.Arrays" %>

<%@ include file="../../../../jsp/zljs/include-head-base.jsp"%>

<%
	try {
		//out.println("intGroupID="+intGroupID);

		String strAdminName = (String) request.getSession()
				.getAttribute("username");
		int intUserID = Integer.parseInt((String) request.getSession()
				.getAttribute("userid"));
//		int intGroupID = (Integer) request.getSession().getAttribute("user_group");

		UserManage.getAdministratorInfo();
		int adminIDs[] = UserManage.getAdministratorIDs();
		String adminNames[] = UserManage.getAdministratorNames();

		int intType = 1;
		String intTypeStr = request.getParameter("intType");
		if (intTypeStr != null) {
			try {
				intType = Integer.parseInt(intTypeStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		/*
		 GroupManage groupmanage=new GroupManage();
		 groupmanage.setMulti();
		 int     groupIDs[]=groupmanage.getGroupIDs();
		 String  groupNames[]=groupmanage.getGroupNames();
		 */
		/*
		 Grant  grant=new Grant();
		 grant.setAll();
		 int    count=0;
		 count=grant.getCount();
		 String strGrantNames[]=grant.getGrantNames();
		 int    intGrantIDs[]=grant.getGrantIDs();
		 */
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		GroupManage groupmanage = new GroupManage();
		groupmanage.setMulti();
		int groupIDs[] = groupmanage.getGroupIDs();
		String groupNames[] = groupmanage.getGroupNames();
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		//	String[] arrAreaInfo=AreaManage.getAreaInfo(intUserID);

		UserManage usermanage = new UserManage(intUserID);
		//如果此管理员是普通管理员，则看到ipr_navtable中此管理员的所有菜单项
		boolean b_Admin = false;
		if (strAdminName.equals("admin")) {
			b_Admin = true;
		}
		//out.println(strAdminName+"<br>");
		//out.println(b_Admin+"<br>");
//		String[] arrTradeInfo = usermanage.getTradeInfoByAdmin(b_Admin,3);

		String strAdminMenuInfo = usermanage.getMenuInfoByUserID();
		//out.println(strAdminMenuInfo+"<br>");

		usermanage.getMenuInfo();
		int[] arrMenuID = usermanage.getMenuIDs();
		String[] arrMenuName = usermanage.getMenuNames();

		//取出来的是ipr_navtable中的intID,chrName

		java.util.Date Now = new java.util.Date();
		String strExpTime = request.getParameter("SDate");
		//if (strExpTime<=Now)
		if (true) {
			//response.sendRedirect("../common/error1.jsp?");
		}
%>
<SCRIPT language=javascript src="<%=basePath%>admin/usermanager/js/user.js"></SCRIPT>
<SCRIPT language=javascript src="<%=basePath%>js/datepicker.js"></SCRIPT>
<LINK href="<%=basePath%>css/datepicker.css" type=text/css rel=stylesheet>
<SCRIPT language="javascript">
<!--
function toAdmin(state)
{
	if(state==1){
		document.form1.chrEnterpriseName.disabled=false;
		//document.form1.intMaxSearchCount.disabled=false;
		document.form1.intMaxNavCount.disabled=false;
		document.form1.intMaxUserCount.disabled=false;
	}
	if(state==0){
		document.form1.chrEnterpriseName.disabled=true;
		//document.form1.intMaxSearchCount.disabled=true;
		document.form1.intMaxNavCount.disabled=true;
		document.form1.intMaxUserCount.disabled=true;
	}
}
function checkform()
{

	if(document.form1.UserName.value=='')
	{
		alert("用户名不能为空");
		return false; 
	}
/*
	if(document.form1.UserName.value.length < 3)
	{
		alert("用户名长度不能少于4位，请重新输入");
		//document.form1.UserName.focus();
		return false;	
	}
*/

	if( document.form1.RealName.value=='')
	{
		alert("用户真名不能为空");
		return false; 
	}
	if(document.form1.Password.value!=document.form1.rePassword.value)
	{
		alert("两次输入的密码不一致");
		document.form1.Password.value='';
		document.form1.rePassword.value='';		
		return false;
	}
	
	if(document.form1.Password.value.length < 6)
	{
		alert("密码不能少于6位，请重新输入");
		//document.form1.Password.focus();
		return false;	
	}
	if(document.form1.rePassword.value.length < 6)
	{
		alert("确认密码不能少于6位，请重新输入");
		//document.form1.rePassword.focus();
		return false;	
	}
	
	if(document.form1.AdminState[0].checked){
		var enterprisename=document.form1.chrEnterpriseName.value;		
		enterprisename=enterprisename.replace(/(^\s*)|(\s*$)/g, "");
		if(enterprisename==''){
			alert("请输入管理员所在企业名称");
			return false;
		}
		/*
		var intMaxSearchCount=document.form1.intMaxSearchCount.value;		
		intMaxSearchCount=intMaxSearchCount.replace(/(^\s*)|(\s*$)/g, "");
		if(intMaxSearchCount==''){
			alert("请输入最大检索数");
			return false;
		}
		if(!isInteger(intMaxSearchCount))
		{
			alert("最大检索数必须是整数，请重新输入");
			//document.form1.rePassword.focus();
			return false;	
		}
		*/		
		var intMaxNavCount=document.form1.intMaxNavCount.value;		
		intMaxNavCount=intMaxNavCount.replace(/(^\s*)|(\s*$)/g, "");
		if(intMaxNavCount==''){
			alert("请输入最大一级导航数");
			return false;
		}
		if(!isInteger(intMaxNavCount))
		{
			alert("最大一级导航数必须是整数，请重新输入");
			//document.form1.rePassword.focus();
			return false;	
		}

		var intMaxUserCount=document.form1.intMaxUserCount.value;		
		intMaxUserCount=intMaxUserCount.replace(/(^\s*)|(\s*$)/g, "");
		if(intMaxUserCount==''){
			alert("请输入最大用户数");
			return false;
		}
		if(!isInteger(intMaxUserCount))
		{
			alert("最大用户数必须是整数，请重新输入");
			//document.form1.rePassword.focus();
			return false;	
		}		
	}

	//if(document.form1.defaultip.value.length <= 0)
	//{
		//alert("集团用户IP地址不能为空，请重新输入");
		//document.form1.defaultip.focus();
		//return false;	
	//}
//**********************************************
var year, month, date,strNow,varDate,vDate
  vDate = "";  //如果没有这行，则最后显示"undefined20060410"
	now = new Date(); 
	year = now.getYear();
	month = now.getMonth()+1;
	if (month<10){month="0"+month;}
	date = now.getDate();
	if (date<10){date="0"+date;}
	strNow = year+""+month+""+date;
	
	//alert("now"+strNow);
	
	varDate=document.form1.SDate.value;
	var pairs=varDate.split("-")
	
	for(var i=0;i<pairs.length;++i) 
	{
		if (pairs[i]<10)
		{
			//alert(pairs[i]);
			pairs[i]="0"+pairs[i];
			vDate=vDate+pairs[i];
		}
		else{
			vDate=vDate+""+pairs[i];
		}
	}
//alert("vDate:"+vDate);	
//alert("strNow:"+strNow);
if(document.form1.SDate.value=="2016-03-20")
{
	alert("请调整过期时间");
	return false;
}
//**********************************************
var herbal=document.getElementById("herbal");
//alert(herbal.value);
//menuIDs

//var menu=document.getElementById("menuid");
//alert(document.all.menuIDs.options.length);

//for (var i = 0; i < mySelect.options.length; i++) {
for (var i = 0; i < document.all.menuIDs.options.length; i++) {
	if(document.all.menuIDs.options[i].selected && document.all.menuIDs.options[i].text.indexOf("药")>-1){
		//alert(document.all.menuIDs.options[i].text+"=" +document.all.menuIDs.options[i].text)
		var herbal_name=(herbal.value).replace(/(^\s*)|(\s*$)/g, "");
		if(herbal_name==''){
			alert("请输入医药库用户名");
			return false;
		}
	}
}
/*
if(document.all.opers.selectedIndex>-1){
	for (var i = 0; i < document.all.menuIDs.options.length; i++){
		if(document.all.menuIDs.options[i].text.indexOf("|─专利检索")>-1){
			//alert(document.all.menuIDs.options[i].text+"=" +document.all.menuIDs.options[i].text)
			document.all.menuIDs.options[i].selected=true;
		}
	}
}
*/
//alert(document.all.TradeList.selectedIndex);

if(document.all.TradeList.selectedIndex>-1){
	for (var i = 0; i < document.all.menuIDs.options.length; i++){
//alert(document.all.menuIDs.options[i].text);
		if(document.all.menuIDs.options[i].text=="|─专题数据库"){
//alert("企业数据库");
			//alert(document.all.menuIDs.options[i].text+"=" +document.all.menuIDs.options[i].text)
			document.all.menuIDs.options[i].selected=true;
		}
	}
}

	var b_zljs=false;
	for (var i = 0; i < document.all.menuIDs.options.length; i++){
		if(document.all.menuIDs.options[i].text=="|─中外专利检索" && document.all.menuIDs.options[i].selected==true){
			//alert(document.all.menuIDs.options[i].text+"=" +document.all.menuIDs.options[i].text)
			b_zljs=true;
			//document.all.menuIDs.options[i].selected=true;
		}
	}

if(b_zljs==true){
	for (var i = 0; i < document.all.menuIDs.options.length; i++){
		if(document.all.menuIDs.options[i].text=="|　|─表格检索[中国]"){
			document.all.menuIDs.options[i].selected=true;
		}
		if(document.all.menuIDs.options[i].text=="|　|─表格检索[国外]"){
			document.all.menuIDs.options[i].selected=true;
		}
		if(document.all.menuIDs.options[i].text=="|　|─逻辑检索[中国]"){
			document.all.menuIDs.options[i].selected=true;
		}
		if(document.all.menuIDs.options[i].text=="|　|─逻辑检索[国外]"){
			document.all.menuIDs.options[i].selected=true;
		}
	}
}

	return true;
}


function disa()
{
	for(var i=0;i<document.all.operation.length;i++)
	{
		if(document.all.operation[i].value==event.srcElement.value)
		{
			if(document.all.operation[i].checked==true)
			{
				eval("document.all."+event.srcElement.value+".disabled=false")	
			}
			else
			{
				eval("document.all."+event.srcElement.value+".disabled=true")
			}
		}
	}
}

function iplimit(str)
{
	var limits,oper,username;
	var isDisable=false;
	if(document.all.UserName.value=="")
	{
		alert("用户名不能为空");
		return false;
	}
	
	if(str=="detail")
	{
		oper = "detail";
		limits = document.all.detail.value;
		if(document.all.detail.disabled==true)
		{
			limits = 0;
		}
	}
	if(str=="download")
	{
		oper = "download";
		limits = document.all.download.value;
		if(document.all.download.disabled==true)
		{
			limits = 0;
		}
	}
	if(str=="document")
	{
		oper = "document";
		limits = document.all.document.value;
		if(document.all.document.disabled==true)
		{
			limits = 0;
		}
	}
	if(str=="sendmail")
	{
		oper = "sendmail";
		limits = document.all.sendmail.value;
		if(document.all.sendmail.disabled==true)
		{
			limits = 0;
		}
	}
	
	username = document.all.UserName.value;
	if(limits == 0)
	{
		window.open("iplimit.jsp?username="+username+"&operation="+oper,'_blank','width=600,height=500,toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
	}
	else
	{
		window.open("iplimit.jsp?username="+username+"&operation="+oper+"&limit="+limits,'_blank','width=600,height=500,toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
	}
	
}	
// -->
</script>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>后台管理</title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet">
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->
</head>
<body bgcolor="#FFFFFF" text="#000000" style="padding:30px;" onLoad="">

<form name="form1" method="post" action="addusersubmit.do" onSubmit="return checkform();">
	<div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group">
		  <a class="btn btn-default mycolor_bor" href="#yiban" data-toggle="tab"><span title="用户一般信息"> 用户一般信息</span>		
		  </a>
		   <a class="btn btn-default mycolor_bor"  href="#fujia" data-toggle="tab"><span  title="用户附加信息"> 用户附加信息</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#zhanghu"  data-toggle="tab"><span title="用户账户信息"> 用户账户信息</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#quanxian" data-toggle="tab"><span  title="用户权限"> 用户权限</span>		
		  </a>
	    </div>
	 </div>
	<!--tabstart-->
    <div class="tab-content">
    	<!--用户一般信息 start-->
   <div class="tab-pane fade in active" id="yiban" style="min-height:680px ;">
   	  <table width="800" border="1" cellspacing="10" cellpadding="0">
			            <tr> 
			             <td bgcolor="#e6f2f0" height="340" valign="top"> 
			             <table width="100%" border="0" cellspacing="1" cellpadding="3">
			               <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">用 户 名：</td>
						     <td width="60%" align="left"><input name="UserName" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">用户真名：</td>
						     <td width="60%" align="left"><input name="RealName" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
						     <td width="60%" align="left"><input name="Password" class="form-control input-sm" style="width:160px;" type="password">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">确认密码：</td>
						     <td width="60%" align="left"><input name="rePassword" class="form-control input-sm" style="width:160px;" type="password">
						     </td>
						   </tr>
				           <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                <tr> 
				                   <td width="47" height="60"><button class="btn btn-success" type="submit">完 成</button></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><button class="btn btn-info" type="button" onClick="window.close()">放 弃</button></td>
				                   <td width="34">&nbsp;</td>
				                 </tr>
				               </table>
				             </td>
				           </tr>
				         </table>
			           </td>
			         </tr>
			       </table>
   </div>
   <!--用户一般信息 end-->
   <!--用户附加信息 start-->
   <div class="tab-pane fade" id="fujia" style="min-height:680px ;">
   	   <table width="800" border="1" cellspacing="10" cellpadding="0">
			         <tr> 
			           <td bgcolor="#e6f2f0" height="340" valign="top"> 
						 <table width="100%" border="0" cellspacing="1" cellpadding="3">
						  <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">电话号码：</td>
						     <td width="60%" align="left"><input name="Phone" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">手机号码：</td>
						     <td width="60%" align="left"><input name="Mobile" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">传真号码：</td>
						     <td width="60%" align="left"><input name="Fax" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">电子邮件：</td>
						     <td width="60%" align="left"><input name="Email" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" style="height:35px;line-height:35px;" align="right">通信地址：</td>
						     <td width="60%" align="left"><input name="Address" class="form-control input-sm" style="width:160px;" type="text">
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" style="height:35px;line-height:35px;" align="right">工作单位：</td>
						     <td width="60%" align="left"><input name="Department" class="form-control input-sm" style="width:160px;" type="text" value="">
						     </td>
						   </tr>
				           <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                <tr> 
				                   <td width="47" height="60"><button class="btn btn-success" type="submit">完 成</button></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><button class="btn btn-info" type="button" onClick="window.close()">放 弃</button></td>
				                   <td width="34">&nbsp;</td>
				                 </tr>
				               </table>
				             </td>
				           </tr>
				         </table>
			           </td>
			         </tr>
			       </table>
   </div>
   <!--用户附加信息 end-->
   <!--用户账户信息 start-->
   <div class="tab-pane fade" id="zhanghu" style="min-height:680px ;">
   	   <table width="800" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#e6f2f0" height="340" valign="top"> 
                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                        <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
                     

<tr style="display:none;">
<td align="right">第三方平台IP：</td>
<td><input id="ipaddress" name="IPAdress" type="text" value=""></td>
</tr>
<!--
<tr class="gray">
  <td align="right" style="height:35px;line-height:35px;">限制访问IP地址(%代表不限制，IP地址由“,”隔开)：</td>
  <td>
  <textarea name="limitIP" class="form-control" style="width:220px;"  cols="30" rows="3">%</textarea>
  </td>
</tr>
-->
<tr>
<td width="40%" align="right" style="height:35px;line-height:35px;">用户所属管理员：</td>
<td width="60%" align="left">
<%
	/*
		 out.println(strAdminName+"<br>");
		
		 for(int i=0;i<adminIDs.length;i++){
		 out.println(adminIDs[i]+"<br>");
		 }out.println("~~~~~~~~~~~~~~~~~~~~<br>");
		 for(int i=0;i<adminNames.length;i++){
		 out.println(adminNames[i]+"<br>");
		 }out.println("~~~~~~~~~~~~~~~~~~~~<br>");
		 */
		if (!strAdminName.equals("admin")) {
%>
	        <select name="administerID" class="form-control input-sm" style="width:160px;" disabled>
			<%
				} else {
			%>
			<select name="administerID" class="form-control input-sm" style="width:100px;" >
			<%
				}
					for (int i = 0; i < adminIDs.length; i++) {
						//			  if(i==(adminIDs.length-1))
						if (adminNames[i].equals(strAdminName)) {
			%>
			<option value="<%=adminIDs[i]%>" selected><%=adminNames[i]%></option>
			<%
				} else {
			%>
            <option value="<%=adminIDs[i]%>"><%=adminNames[i]%></option>
<%
	}
		}
%>
		    </select>
							
							</td>
                          </tr>

                    <tr> 
                    <td width="40%" align="right">单次文摘批量下载量：</td>
                    <td width="60%" align="left"><input id="ABSTBatchCount" name="ABSTBatchCount" type="text" value="0" onchange="checkField(this.value)">条
                    <BR><B>（<font color="red">此项不得超过5000条</font>）</b>
                    </td>
                    </tr>
                    
<script type="text/javascript">
function checkField(val){
	//alert(v);
	var r = /^\+?[1-9][0-9]*$/;
	if(!r.test(val)){
		alert("输入条数错误，请重新输入！");
		return false;
	}
	if(val>5000){
		alert("此项不得超过5000条，请重新输入！");
		$('#ABSTBatchCount').val("5000");
	}
}
</script>

				    <tr> 
				    <td width="28%" align="right" style="height:35px;line-height:35px;">过期时间：</td>
                      			<td width="72%" align="left" vAlign=top >
<%--<%
java.util.Date rightNow = new java.util.Date();
%>
--%><input class="Wdate form-control input-sm" name="SDate" style="width:160px;" type="text" value="2016-03-20">
				  
				      </td>
				    </tr>
<tr style='display:none'> 
    <td width="40%" align="right">中药检索平台用户名:</td>
    <td width="60%" align="left"><input id="herbal" name="herbal_name" type="text" value=""></td>
</tr>
<!--
						<tr>
                            <td width="40%" align="right" style="height:35px;line-height:35px;">最大登录数：</td>
                            <td width="60%" align="left"><input name="MaxLogin" class="form-control input-sm" style="width:160px;" type="text" value="1">
                            </td>
                          </tr>
-->
						  
                          <!--tr> 
                            <td width="40%" align="right">每页显示记录数：</td>
                              <td width="60%" align="left"><input name="NumberPerPage" type="text" value="10"> 
                              </td>
                          </tr-->
                          <input name="NumberPerPage" type="hidden" value="10">
                          <tr style="display:none;"> 
                            <td width="40%" align="right">国内权限：</td>
                            <td width="60%" align="left"><input name="AllMoney" type="text" value="0"  disabled>件
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">增加国内权限：</td>
                            <td width="60%" align="left"><input name="Count_in" type="text" value="0">
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">国外权限：</td>
                            <td width="60%" align="left"><input name="AllMoney" type="text" value="0"  disabled>件
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">增加国外权限：</td>
                            <td width="60%" align="left"><input name="Count_out" type="text" value="0">
                            </td>
                          </tr>

                          <tr style="display:none">
						    <td width="40%" align="right">开通IP限制功能：</td>
                            <td width="60%" align="left">
							<input type="radio" name="IPLimit" value="1" id="as1">
                            <label for="as1" style="cursor:hand">限制
                            <input type="radio" name="IPLimit" value="0" checked id="as0">
                            <label for="as0" style="cursor:hand">不限制
							</td>
						  </tr>
						  
                          <tr>
						    <td width="40%" align="right">开通专利分析功能：</td>
                            <td width="60%" align="left">
							<input type="radio" name="AnalyseState" value="1" id="as1">
                            <label for="as1" style="cursor:hand">开通
                            <input type="radio" name="AnalyseState" value="0" checked id="as0">
                            <label for="as0" style="cursor:hand">不开通
							</td>
						  </tr>
						  
						  <input id="AnalyseNumUpperlimit" name="AnalyseNumUpperlimit" type="hidden" value="1000000">
						  <!-- 
                          <tr>
						    <td width="40%" align="right">专利分析条数上限：</td>
                            <td width="60%" align="left">
							<input id="AnalyseNumUpperlimit" name="AnalyseNumUpperlimit" type="text">
							</td>
						  </tr>
						   -->
                          <tr> 
                            <td width="40%" align="right">管理员修改备注：</td>
                            <td width="60%" align="left"><textarea name="CMemo" class="form-control" style="width:220px;"  cols="30" rows="5"></textarea>
                            </td>
                          </tr>
	                      
						   <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                <tr> 
				                   <td width="47" height="60"><button class="btn btn-success" type="submit">完 成</button></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><button class="btn btn-info" type="button" onClick="window.close()">放 弃</button></td>
				                   <td width="34">&nbsp;</td>
				                 </tr>
				               </table>
				             </td>
				           </tr>
				         </table>
			           </td>
			         </tr>
			       </table>
   </div>
   <!--用户账户信息 end-->
    <!--用户权限 start-->
   <div class="tab-pane fade" id="quanxian" style="min-height:680px ;">
   	 <table width="800" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#e6f2f0" height="340" valign="top"> 
			            <table width="100%" border="0" cellspacing="1" cellpadding="3">
		                   <tr> 
						     <td  style="height:20px;line-height:40px;" align="right"></td>
						     <td  align="left"></td>
						   </tr>
		<tr> 
	        <td conspan="2"  align="center" >
	        
	        <table width="630" border="0">
              <tr>
                <td width="34%" style="display:none;"><div align="center">检索权限</div></td>
                <td width="36%"><div align="center">菜单权限</div></td>
              </tr>
              <tr>
                <td valign="top" style="display:none;"><div align="center">



                </div></td>
                <td width="36%" valign="top"><div align="center">
<select id="menuid" name="menuIDs" size="16"  class="form-control" style="width:240px;" multiple>
                      <%
                      	if (b_Admin == true) {
                      			for (int i = 0; i < arrMenuID.length; i++) {

                      				if(arrMenuName[i].indexOf("预警")>-1){
                  				if(com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING)!=null && com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING).equals("1"))
                  						{
                  							out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                  						}
                      				}else{
                      					out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                      				}
                      				
//                      			if (result > 0) 
                      				{
//                      					out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                      				}
                      			}
                      		} else {
                      			for (int i = 0; i < arrMenuID.length; i++) {
                      				if (("," + strAdminMenuInfo).indexOf("," + arrMenuID[i] + ",") > -1) {

                      					
                          				if(arrMenuName[i].indexOf("预警")>-1){
                      						if(com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING)!=null && com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING).equals("1")){
                      							out.println("<option value=" + arrMenuID[i] + ">"
                              							+ arrMenuName[i] + "</option>");
                      						}
                          				}else{
                          					out.println("<option value=" + arrMenuID[i] + ">"
                          							+ arrMenuName[i] + "</option>");
                          				}
                      					
//                      				if (result > 0) 
                      					{
//                      						out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                      					}

                      				}
                      			}
                      		}
                      %>
</select>
                </div></td>
                

                
                
              </tr>
            </table>
	        
		  	</td>
          </tr>

	                      <tr> 
	                        <td align="center" colspan="2"> 
	                          <table width="109" border="0" cellspacing="0" cellpadding="0">
	                           <tr> 
				                   <td width="47" height="60"><button class="btn btn-success" type="submit">完 成</button></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><button class="btn btn-info" type="button" onClick="window.close()">放 弃</button></td>
				                   <td width="34">&nbsp;</td>
				                 </tr>
	                          </table>
	                        </td>
	                      </tr>
	                    </table>
                      </td>
                    </tr>
                  </table>
   </div>
   <!--用户权限 end-->
   
   <!--管理员 start-->
   <table id="admin" style="display:none"  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff"  bordercolorlight="#088EB5">
			  <tr> 
			    <td bgcolor="#088EB5"> 
			       <table width="800" border="1" cellspacing="10" cellpadding="0">
			           <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
			         <tr> 
			           <td bgcolor="#e6f2f0" height="340" valign="top"> 
			             <table width="100%" border="0" cellspacing="1" cellpadding="3">
                          <tr>
						      <td width="40%" align="right">管理员状态：</td>
                              <td width="60%" align="left">
							  <input  id="adminstate1" type="radio" name="AdminState" value="1" onClick="toAdmin(1);">
                              <label for="adminstate1" style="cursor:hand">开通</label>
                              <input id="adminstate0" type="radio" name="AdminState" value="0" checked onClick="toAdmin(0);">
                              <label for="adminstate0" style="cursor:hand">未开通</label></td>
						  </tr>
						   <tr> 
						     <td width="40%" align="right">企业名称：</td>
						     <td width="60%" align="left"><input name="chrEnterpriseName" type="text" disabled>
						     </td>
						   </tr>				   
						   
						   <!--tr> 
						     <td width="40%" align="right">最大检索数：</td>
						     <td width="60%" align="left"><input name="intMaxSearchCount" type="text" disabled>
						     </td>
						   </tr-->
						   <tr> 
						     <td width="40%" align="right">最大一级导航数：</td>
						     <td width="60%" align="left"><input name="intMaxNavCount" type="text" disabled>
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">最多可建的用户数：</td>
						     <td width="60%" align="left"><input name="intMaxUserCount" type="text" disabled>
						     </td>
						   </tr>
				           <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                 <tr> 
				                   <td width="47" height="60"><button class="btn btn-success" type="submit">完 成</button></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><button class="btn btn-info" type="button" onClick="window.close()">放 弃</button></td>
				                   <td width="34">&nbsp;</td>
				                 </tr>
				               </table>
				             </td>
				           </tr>
				         </table>
			           </td>
			         </tr>
			       </table>
			     </td>
			   </tr>
</table>
  <!--管理员 end--> 
   
    </div>
   <!--tabend-->
    </form> 
</body>
</html>
<%
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>
<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>