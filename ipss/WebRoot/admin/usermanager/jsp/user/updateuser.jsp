<!DOCTYPE html>
<html>

<%@ include file="../../../../jsp/zljs/include-head-base.jsp"%>

<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.cnipr.cniprgz.authority.user.IPCheckUtils" %>
<%@ page import="com.trs.usermanage.GroupManage,com.trs.usermanage.AreaManage,com.trs.usermanage.UserManage,java.util.Arrays"%>
<%
	try {
		String strAdminName = (String) request.getSession().getAttribute("username");

		int intAdminID = Integer.parseInt((String) request.getSession().getAttribute("userid"));

		int intType = 1;
		String intTypeStr = request.getParameter("intType");
		if (intTypeStr != null) {
			try {
				intType = Integer.parseInt(intTypeStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		UserManage adminmanage = new UserManage(intAdminID);
		adminmanage.getAdministratorInfo();
		//如果是管理员intAdministerState为1，就直接到ipr_navtable表中取行业信息列表
		//如果是普通用户，到ipr_user_nav表取行业信息列表
		GroupManage groupmanage = new GroupManage();
		groupmanage.setMulti();
		int groupIDs[] = groupmanage.getGroupIDs();
		String groupNames[] = groupmanage.getGroupNames();

		adminmanage.getMenuInfo();
		int[] arrMenuID = adminmanage.getMenuIDs();
		String[] arrMenuName = adminmanage.getMenuNames();

		boolean b_Admin = false;
		if (strAdminName.equals("admin")) {
			b_Admin = true;
		}

		String[] arrTradeInfo = adminmanage.getAllTradeInfo(3);

		String strAdminMenuInfo = adminmanage.getMenuInfoByUserID();
		/*
		 for(int i=0;i<arrTradeInfo.length;i++){
		 out.println(arrTradeInfo[i]+"<br>");
		 }
		 */

		//out.println(arrTradeInfo);
		//*************************************************************
		/*
		 GroupManage groupmanage=new GroupManage();
		 groupmanage.setMulti();
		 int     groupIDs[]=groupmanage.getGroupIDs();
		 String  groupNames[]=groupmanage.getGroupNames();
		 */
		String strUserID = request.getParameter("userID");
		int intUserID = Integer.parseInt(strUserID);

		UserManage usermanage = new UserManage(intUserID);
		/*
		 String[] arrTradeInfoSel = usermanage.getTradeInfoByUser();
		 String strTradeInfoSel = usermanage.getTradeInfoSel();
		 if(strTradeInfoSel==null){
		 strTradeInfoSel="";
		 }
		 */
		int tradeType = 3;//行业分类导航是1，专题数据库是3
		String strTradeInfoSel = usermanage.getUserTradeInfoByUserID(
				intUserID, tradeType);

		String[] arrSelTrade = null;
		if (strTradeInfoSel != null && !strTradeInfoSel.equals("")) {
			arrSelTrade = (strTradeInfoSel.split("#")[2]).split("[$]");
		}

		//out.println(strTradeInfoSel+"<br>");
		//strTradeInfoSel="1,1#";
		/*****************************************************************/
		/*
		 Grant  grant=new Grant();
		 grant.setAll();
		 int    count=0;
		 count=grant.getCount();
		 String strGrantNames[]=grant.getGrantNames();
		 int    intGrantIDs[]=grant.getGrantIDs();
		 String strUserGrants=usermanage.getItemGrant();
		 */
		//out.println(strUserGrants);
		String[] arrAreaInfoAll = AreaManage.getAreaInfo(1);
		String[] arrAreaInfo = AreaManage.getAreaInfo(intAdminID);
		//out.println(intUserID);

		/*****************************************************************/

		int adminIDs[] = usermanage.getAdministratorIDs();
		String adminNames[] = usermanage.getAdministratorNames();

		//UserManage usermanage=new UserManage(intUserID);
		String strMenuIDSel = usermanage.getMenuIDsByUserID() == null ? ""
				: usermanage.getMenuIDsByUserID();
		strMenuIDSel = "," + strMenuIDSel;
		//out.println(strMenuIDSel+"<br>");
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		String userName = usermanage.getUserName();
		//out.println("updateuser.jsp------->userName="+userName);		

		String realName = usermanage.getRealName();
		String eMail = usermanage.getEmail();
		String phone = usermanage.getPhone();
		String mobile = usermanage.getMobile();
		String fax = usermanage.getFax();
		String department = usermanage.getDepartment();
		String address = usermanage.getAddress();
		String registerTime = usermanage.getRegisterTime();
		String currentCardTime = usermanage.getCurrentCardTime();
		String expireTime = usermanage.getExpireTime();
		int maxLogin = usermanage.getMaxLogin();
		int chCount = usermanage.getCHCount();
		int frCount = usermanage.getFRCount();
		String lastVisitTime = usermanage.getLastVisitTime();
		String lastVisitIP = usermanage.getLastVisitIP();
		int userState = usermanage.getUserState();
		int groupID = usermanage.getGroupID();
		String adminMemo = usermanage.getAdminMemo();
		String defaultIP = usermanage.getDefaultIP();

		String MerchantID = usermanage.getMerchantID();
		String MAC = usermanage.getMAC();
		String IPAdress = usermanage.getIPAdress();
		int AdministerID = usermanage.getAdministerID();

		//MerchantID=(rs.getString("chrMerchantID")==null)? "":rs.getString("chrMerchantID");
		String Herbal_Name = (usermanage.getHerbal_Name() == null) ? ""
				: usermanage.getHerbal_Name();
		//		int Herbal_DataBase=(usermanage.getHerbal_DataBase()==0)?0:usermanage.getHerbal_DataBase();
		int Herbal_DataBase = usermanage.getHerbal_DataBase();

		int intIPLimit = usermanage.getIPLimit();

		int intAdministerState = usermanage.getAdministerState();
		String chrEnterpriseName = usermanage.getEnterpriseName();
		int intMaxSearchCount = usermanage.getMaxSearchCount();
		int intMaxNavCount = usermanage.getMaxNavCount();
		int intMaxUserCount = usermanage.getMaxUserCount();

		int intAnalyseState = usermanage.getAnalyseState();
		int intAnalyseNumUpperlimit = usermanage.getAnalyseNumUpperlimit();
		
		int intUserAreaID = usermanage.getUserAreaID();
		//System.out.println("1111111111111111111");

		String strNumberPerPage = String.valueOf(usermanage.getNumberPerPage());
		String strABSTBatchCount = String.valueOf(usermanage.getABSTBatchCount());
		String strDownloadedCount = String.valueOf(usermanage.getDownloadedCount());

		if (defaultIP == null) {
			defaultIP = "%";
		}
%>

<SCRIPT language="javascript">
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
	if( document.form1.UserName.value=='')
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
	
	if(document.form1.Password.value!=""&&document.form1.Password.value.length < 6)
	{
		alert("密码不能少于6位，请重新输入");
		//document.form1.Password.focus();
		return false;	
	}
	if(document.form1.rePassword.value!=""&&document.form1.rePassword.value.length < 6)
	{
		alert("确认密码不能少于6位，请重新输入");
		//document.form1.rePassword.focus();
		return false;	
	}
	//if(document.form1.defaultip.value.length <= 0)
	//{
		//alert("集团用户IP地址不能为空，请重新输入,% 默认为所有IP");
		//document.form1.defaultip.focus();
		//return false;	
	//}
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
	//alert(now);
	//alert(year);
	//alert(month)
	//alert(date);
	//alert(strNow);
	
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
if(vDate<=strNow)
{
	alert("请调整过期时间");
	return false;
}
//**********************************************
var herbal=document.getElementById("herbal");
//alert(herbal.value);
for (var i = 0; i < document.all.menuIDs.options.length; i++) {
	if(document.all.menuIDs.options[i].selected && document.all.menuIDs.options[i].text.indexOf("中药")>-1){
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
/*
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
*/
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
function change()
{
//document.form1.opers_selectall.disabled=false;
//document.form1.opers.disabled=false;
//document.form1.groupid.disabled=false;
	document.form1.menuIDs.disabled=false;
//	document.form1.TradeList.disabled=false;
}
function nochange()
{
//document.form1.opers_selectall.disabled=true;
//document.form1.opers.disabled=true;
//document.form1.groupid.disabled=true;
	document.form1.menuIDs.disabled=true;
//	document.form1.TradeList.disabled=true;
}

</script>
<title>检索服务平台后台管理 </title>
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

<body bgcolor="#FFFFFF" text="#000000" style="padding:30px;" >
<div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group">
		  <a class="btn btn-default mycolor_bor" href="#yiban" data-toggle="tab"><span title="用户一般信息"> 用户一般信息</span>		
		  </a>
		   <a class="btn btn-default mycolor_bor" href="#fujia" data-toggle="tab"><span title="用户附加信息"> 用户附加信息</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#zhanghu" data-toggle="tab"><span title="用户账户信息"> 用户账户信息</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#quanxian" data-toggle="tab"><span title="用户权限"> 用户权限</span>		
		  </a>
		  <%
		  	if (strAdminName.equals("admin")) {
		  %>
		  <a class="btn btn-default mycolor_bor" href="#guanli" data-toggle="tab"><span  title="管理员权限"> 管理员权限</span>		
		  </a>
		  <%
		  	}
		  %>		
	    </div>
	 </div>
   </div>	
	<!--tabstart-->
	<form name="form1" role="form" method="post" action="updateusersubmit.do" onSubmit="return checkform();">
		<input type="hidden" name="userid" value="<%=strUserID%>">
    <div class="tab-content">
    	<!--用户一般信息 start-->
   <div class="tab-pane fade in active" id="yiban" style="min-height:420px;width:800px;">
   <table width="800" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#e6f2f0" height="360" valign="top"> 
   	<table  width="100%" border="0"  cellspacing="1" cellpadding="3">
   	                       <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">用 户 名：</td>
						     <td width="60%"  align="left"><input name="UserName" class="form-control input-sm" style="width:160px;" type="text" value="<%=userName%>">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">用户真名：</td>
						     <td width="60%" align="left"><input name="RealName" class="form-control input-sm" style="width:160px;" type="text" value="<%=realName%>">
							  
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
						     <td width="60%" align="left"><input name="Password" class="form-control input-sm" style="width:160px;" type="password" <%if (userName.equals("guest")) {%>disabled<%}%>>
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%"  style="height:35px;line-height:35px;" align="right">确认密码：</td>
						     <td width="60%"  align="left"><input name="rePassword" class="form-control input-sm" style="width:160px;" type="password" <%if (userName.equals("guest")) {%>disabled<%}%>>
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
						   <!--tr> 
						     <td colspan="2" align="center"><a href="cardlist.jsp?userID=<%=strUserID%>">用户充值卡列表</a></td>
						   </tr-->
				         </table>
				         </td>
				           </tr>
				         </table> 
   </div>
   <!--用户一般信息 end-->
   <!--用户附加信息 start-->
   <div class="tab-pane fade" id="fujia" style="min-height:420px ;">
   <table width="800" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#e6f2f0" height="360" valign="top"> 
   	<table width="100%" border="0" cellspacing="1" cellpadding="3">
   	                      <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">电话号码：</td>
						     <td width="60%" align="left"><input name="Phone" class="form-control input-sm" style="width:160px;" type="text" value="<%=phone%>"> 
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">手机号码：</td> 
						     <td width="60%" align="left"><input name="Mobile" class="form-control input-sm" style="width:160px;" type="text" value="<%=mobile%>">   
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%"  style="height:35px;line-height:35px;" align="right">传真号码：</td>
						     <td width="60%" align="left"><input name="Fax" class="form-control input-sm" style="width:160px;" type="text" value="<%=fax%>">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">电子邮件：</td>
						     <td width="60%" align="left"><input name="Email" class="form-control input-sm" style="width:160px;" type="text" value="<%=eMail%>"> 
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" style="height:35px;line-height:35px;" align="right">通信地址：</td>
						     <td width="60%" align="left"><input name="Address" class="form-control input-sm" style="width:160px;" type="text" value="<%=address%>"> 
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" style="height:35px;line-height:35px;" align="right">工作单位：</td>
						     <td width="60%" align="left"><input name="Department" class="form-control input-sm" style="width:160px;" type="text" value="<%=department%>">
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
   <div class="tab-pane fade" id="zhanghu" style="min-height:420px ;">
   	 <table width="800" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#e6f2f0" height="360" valign="top"> 
                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                          <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
                          <tr style='display:none'>
                            <td width="40%" align="right">地区用户：</td>
                            <td  width="60%" align="left">
                            <!--input type="text" name="defaultip" value="<%=defaultIP%>">（用户绑定IP时有效）-->
							  <select name="intUserAreaID" style='display:none'>
									<option value="0">不选择</option>
									<%
										if (arrAreaInfo != null) {
												for (int i = 0; i < arrAreaInfo.length; i++) {
													//System.out.println(arrAreaInfo[i]);
													//System.out.println(arrAreaInfo[i].split("#")[0]);
													//System.out.println(arrAreaInfo[i].split("#")[1]);																		
													String areaID = arrAreaInfo[i].split("#")[0];
													String areaName = arrAreaInfo[i].split("#")[1];

													if ((intUserAreaID + "").equals(areaID)) {
									%>
									<option value="<%=areaID%>" selected><%=areaName%></option>
									<%
										} else {
									%>
									<option value="<%=areaID%>"><%=areaName%></option>
									<%
										}
												}
											}
									%>
								</select>
                            </td>
                          </tr>

<tr style="display:none;">
<td align="right">第三方平台IP：</td>
<td><input id="ipaddress" name="IPAdress" type="text" value="<%=IPAdress%>"></td>
</tr>
<!--
<tr class="gray">
  <td align="right" style="height:35px;line-height:35px;">限制访问IP地址(%代表不限制，IP地址由“，”隔开)：</td>
  <%String limitIP = IPCheckUtils.getUserLimitIP(userName);%>
  <td ><textarea name="limitIP" class="form-control" style="width:260px;" cols="30" rows="3"><%=limitIP%></textarea></td>
</tr>
-->
<tr><td width="40%" align="right" style="height:35px;line-height:35px;">用户所属管理员：</td>
<td  width="60%" align="left">
			<%
				if (!strAdminName.equals("admin")) {
			%>
	        <select name="administerID"  disabled class="form-control input-sm" style="width:90px;">
			<%
				} else {
			%>
			<select name="administerID"  class="form-control input-sm" style="width:90px;">
			<%
				}
					for (int i = 0; i < adminIDs.length; i++) {
						//			  if(adminNames[i].equals(strAdminName))
						if (adminIDs[i] == AdministerID) {
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
                            <td width="40%" align="right" style="height:35px;line-height:35px;">单次文摘批量下载总限制数：</td>
                            <td><input id="ABSTBatchCount" name="ABSTBatchCount" type="text" value="<%=strABSTBatchCount%>" onchange="checkField(this.value)">条
                            <B>（<font color="red">此项不得超过5000条</font>）</b>
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
                      			<%
                      				String year = expireTime.substring(0, 4);
                      				String month = expireTime.substring(5, 7);
                      				String day = expireTime.substring(8, 10);
                      			%>
                         <input class="Wdate form-control input-sm" name="SDate" style="width:160px;" type="text" value="<%=year%>-<%=month%>-<%=day%>">
				    </td>
				    </tr>
<tr style='display:none'> 
    <td width="40%" align="right">中药检索平台用户名:</td>
    <td width="60%" align="left"><input id="herbal" name="herbal_name" type="text" value="<%=Herbal_Name%>"></td>
</tr>

<!--
						<tr>	
                            <td width="40%" align="right" style="height:35px;line-height:35px;">最大登录数：</td>
                              <td width="60%" align="left"><input name="MaxLogin" class="form-control input-sm" style="width:160px;" type="text" value="<%=maxLogin%>"> 
                              </td>
                          </tr>
-->
                          <!--tr> 
                            <td width="40%" align="right">每页显示记录数：</td>
                              <td width="60%" align="left"><input name="NumberPerPage" type="text" value="<%=strNumberPerPage%>"> 
                              </td>
                          </tr-->
                          <input name="NumberPerPage" type="hidden" value="<%=strNumberPerPage%>">
                          <tr style="display:none;"> 
                            <td width="40%" align="right">国内权限：</td>
                            <td width="60%" align="left"><input name="AllMoney" type="text" value="<%=chCount%>" disabled>件
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">增加国内权限：</td>
                            <td width="60%" align="left"><input name="Count_in" type="text" value="0">
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">国外权限：</td>
                            <td width="60%" align="left"><input name="AllMoney" type="text" value="<%=frCount%>"  disabled>件
                            </td>
                          </tr>
                          <tr style="display:none;"> 
                            <td width="40%" align="right">增加国外权限：</td>
                            <td width="60%" align="left"><input name="Count_out" type="text" value="0">
                            </td>
                          </tr>

                          <tr style="display:none;"> 
                            <td width="40%" align="right">今年已经下载文摘数：</td>
                            <td width="60%" align="left"><input name="DownloadedCount" type="text" value="<%=strDownloadedCount%>">
                            </td>
                          </tr>
						  
                          <tr style="display:none">
						    <td width="40%" align="right">开通IP限制功能：</td>
                            <td width="60%" align="left">
							<input type="radio" name="IPLimit" value="1" id="as1" <%if (intIPLimit == 1)
					out.print("checked");%>>
                            <label for="as1" style="cursor:hand">限制
                            <input type="radio" name="IPLimit" value="0" id="as0" <%if (intIPLimit == 0)
					out.print("checked");%>>
                            <label for="as0" style="cursor:hand">不限制
							</td>
						  </tr>
						  
                          <tr>
						      <td width="40%" align="right">用户状态：</td>
                            <td width="60%" align="left">
							<input type="radio" name="UserState" value="1" <%if (userState == 1)
					out.print("checked");%> id="us1">
                            <label for="us1" style="cursor:hand">开通</label>
                            <input type="radio" name="UserState" value="0" <%if (userState == 0)
					out.print("checked");%> id="us0">
                            <label for="us0" style="cursor:hand">未开通</label>
							  </td>
						  </tr>
						  
                          <tr>
						    <td width="40%" align="right">开通专利分析功能：</td>
                            <td width="60%" align="left">
							<input type="radio" name="AnalyseState" value="1" <%if (intAnalyseState == 1)
					out.print("checked");%> id="as1">
                            <label for="as1" style="cursor:hand">开通
                            <input type="radio" name="AnalyseState" value="0" <%if (intAnalyseState == 0)
					out.print("checked");%> id="as0">
                            <label for="as0" style="cursor:hand">不开通
							</td>
						  </tr>
						  <!--
                          <tr>
						    <td width="40%" align="right">专利分析条数上限：</td>
                            <td width="60%" align="left">
							<input id="AnalyseNumUpperlimit" name="AnalyseNumUpperlimit" type="text" value="<%=intAnalyseNumUpperlimit%>">
							</td>
						  </tr>
						  -->
                          <tr> 
                            <td width="40%" align="right">管理员修改备注：</td>
                            <td width="60%" align="left"><textarea name="CMemo" class="form-control" style="width:160px;" cols="30" rows="3"><%=adminMemo%></textarea>
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
   <div class="tab-pane fade" id="quanxian" style="min-height:420px ;">
   	<table width="800" border="1" cellspacing="0" cellpadding="0">
   	               
                    <tr> 
                      <td bgcolor="#e6f2f0" height="360" valign="top"> 
			            <table width="100%" border="0" cellspacing="1" cellpadding="3">
		                    <tr> 
						     <td style="height:20px;line-height:40px;" ></td>
						     <td></td>
						   </tr>
		<tr><td colspan="2" align="center" > <table width="560" border="0">
              <tr>
                <td height="30" colspan="3">
				  <div align="center" style="padding-bottom:10px">
				      <input id="c1" type="radio" name="mendgroup" value="1" onClick="change();">
				      <label for="c1" style="cursor:hand">修改用户权限</label>
                      <input id="c2" type="radio" name="mendgroup" value="0" checked onClick="nochange();">

                      <label for="c2" style="cursor:hand">不修改用户权限</label>
                      
				    </div></td>
                </tr>
             
              <tr>
              <!-- 
                <td valign="top" style="display:none;">
<select name="groupid" size="16" style="width:150px;" id="changegroup" disabled>
			<%for (int i = 0; i < groupIDs.length; i++) {%>
                 <option value="<%=groupIDs[i]%>" <%if (groupIDs[i] == groupID)
						out.println("selected");%>><%=groupNames[i]%></option>
            <%}%>
</select> 
                </td>
               -->
                
                <td width="50%" valign="top"><div align="center">
                  <select name="menuIDs" size="16" style="width:260px;" class="form-control" multiple disabled>
                      <%
                      	//System.out.println(strMenuIDSel);

                      		if (arrMenuID != null && arrMenuID.length > 0) {
                      			for (int i = 0; i < arrMenuID.length; i++) {
                      				//System.out.println(arrMenuID[i]);
                      				if (("," + strAdminMenuInfo).indexOf("," + arrMenuID[i] + ",") > -1 || b_Admin == true) {
                      					//int[] ku = { 5000, 5010, 6000, 2500, 3500, 1000, 1000, 2000, 5015, 1005, 1010, 1015, 1020, 1600, 5026, 5035, 7000, 70000, 15001 };
                      					//Arrays.sort(ku); //首先对数组排序
                      					//int result = Arrays.binarySearch(ku, arrMenuID[i]); //在数组中搜索是否含有5
                      					//System.out.println(result); //这里的结果是 3 

                      					if(arrMenuName[i].indexOf("预警")>-1){
                      				if(com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING)!=null && com.cnipr.cniprgz.commons.SetupAccess.getProperty(com.cnipr.cniprgz.commons.SetupConstant.DINGQIYUJING).equals("1"))
										{
                          						if (strMenuIDSel.indexOf("," + arrMenuID[i] + ",") > -1) {
                          							out.println("<option value=" + arrMenuID[i] + " selected>" + arrMenuName[i] + "</option>");
                          						} else {
                          							out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                          						}
                      						}
                      					}else{
                      						if (strMenuIDSel.indexOf("," + arrMenuID[i] + ",") > -1) {
                      							out.println("<option value=" + arrMenuID[i] + " selected>" + arrMenuName[i] + "</option>");
                      						} else {
                      							out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                      						}
                      					}
                      					
                      					/*
                      					//if (result > 0) 
                      					{
                      						if (strMenuIDSel.indexOf("," + arrMenuID[i] + ",") > -1) {
                      							out.println("<option value=" + arrMenuID[i] + " selected>" + arrMenuName[i] + "</option>");
                      						} else {
                      							out.println("<option value=" + arrMenuID[i] + ">" + arrMenuName[i] + "</option>");
                      						}
                      					}
                      					*/
                      					
                      					
                      				}
                      			}
                      		}
            

/*
        	java.util.List<com.cnipr.cniprgz.entity.MenuInfo> almenu = com.cnipr.cniprgz.dao.MenuDAO.getAllMenuInfo();
			
			String usermenu = ","+(String)session.getAttribute("userMenu");
			
			java.util.Iterator<com.cnipr.cniprgz.entity.MenuInfo> it = almenu.iterator();
	        while(it.hasNext()){
	            com.cnipr.cniprgz.entity.MenuInfo menuinfo = (com.cnipr.cniprgz.entity.MenuInfo)it.next();
	            
	            if(usermenu.indexOf("," + menuinfo.getIntMenuID()+ ",")>-1){
	            	out.println("<option value=" + menuinfo.getIntMenuID() + " selected>" + menuinfo.getChrMenuName() + "</option>");
	            }else{
	            	out.println("<option value=" + menuinfo.getIntMenuID() + ">" + menuinfo.getChrMenuName() + "</option>");
	            }	            
	        }
*/
                      %>
                  </select>
                </div></td>
               <!-- 
               <td width="50%" valign="top"><div align="center">
                  <select name="TradeList" size="16" multiple style="width:180px;" class="form-control" disabled>
                      <%
                      	if (arrTradeInfo != null) {
                      			for (int i = 0; i < arrTradeInfo.length; i++) {
                      				//String NavID=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf("_"));
                      				//String NavName=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(",")+1);

                      				String strPreNavInfo = arrTradeInfo[i].substring(0,
                      						arrTradeInfo[i].indexOf(";"));
                      				String strNavInfo = arrTradeInfo[i]
                      						.substring(arrTradeInfo[i].indexOf(";") + 1);

                      				if (arrSelTrade != null) {
                      					String str = "<option value='" + strPreNavInfo
                      							+ "'";
                      					for (int n = 0; n < arrSelTrade.length; n++) {
                      						if (arrSelTrade[n].equals(strPreNavInfo)) {
                      							str += " selected ";
                      						}
                      					}
                      					str += ">" + strNavInfo + "</option>";

                      					out.println(str);
                      				} else {
                      					out.println("<option value='" + strPreNavInfo
                      							+ "'>" + strNavInfo + "</option>");
                      				}
                      			}
                      		}

                      %>
                  </select>
                </div></td>
                 -->
                
                
                
              </tr>
            </table>
            </td></tr>

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
    <!--管理员权限 start-->
   <div class="tab-pane fade" id="guanli" style="min-height:420px ;">
   	<table width="800" border="1" cellspacing="10" cellpadding="0">
			         <tr> 
			           <td bgcolor="#e6f2f0" height="360" valign="top"> 
			             <table width="100%" border="0" cellspacing="1" cellpadding="3">
			             <tr> 
						     <td width="40%" style="height:20px;line-height:40px;" align="right"></td>
						     <td width="60%"  align="left"></td>
						   </tr>
                          <tr>
 						      <td width="40%" align="right">管理员状态：</td>
                              <td width="60%" align="left">
						<input id="adminstate1" type="radio" name="AdminState" value="1" <%if (intAdministerState == 1) {%>checked<%}%> onClick="toAdmin(1);">
                        <label for="adminstate1" style="cursor:hand">开通</label>
						<input id="adminstate0" type="radio" name="AdminState" value="0" <%if (intAdministerState == 0) {%>checked<%}%> onClick="toAdmin(0);">
                        <label for="adminstate0" style="cursor:hand">未开通</label>
							  </td>
						  </tr>
						  
						   <tr> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">企业名称：</td>
						     <td width="60%" align="left"><input name="chrEnterpriseName" class="form-control input-sm" style="width:160px;" type="text" value="<%=chrEnterpriseName%>" <%if (intAdministerState == 0) {%>disabled<%}%>>
						     </td>
						   </tr>

						   <tr style='display:none'> 
						     <td width="40%" align="right">地区管理员：</td>
						     <td width="60%" align="left">
													  <select name="intAdminAreaID">
															<option value="0">不选择</option>
															<%
																String areaID = "";
																	String areaName = "";

																	//System.out.println(arrAreaInfo);

																	if (arrAreaInfo != null && arrAreaInfo.length > 0) {
																		for (int i = 0; i < arrAreaInfo.length; i++) {
																			areaID = arrAreaInfo[i].split("#")[0];
																			areaName = arrAreaInfo[i].split("#")[1];
															%>
															<!--option value="<%=areaID%>"><%=areaName%></option-->
															<%
																}
																	}

																	String areaIDAll = "";
																	String areaNameAll = "";
																	if (arrAreaInfoAll != null && arrAreaInfoAll.length > 0) {
																		for (int i = 0; i < arrAreaInfoAll.length; i++) {
																			areaIDAll = arrAreaInfoAll[i].split("#")[0];
																			areaNameAll = arrAreaInfoAll[i].split("#")[1];
																			if (areaID.equals(areaIDAll)) {
															%>
															<option value="<%=areaIDAll%>" selected><%=areaNameAll%></option>
															<%
																} else {
															%>
															<option value="<%=areaIDAll%>"><%=areaNameAll%></option>
															<%
																}
																		}
																	}
															%>
								</select>
						     </td>
						   </tr>		

						   <tr style="display:none"> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">最大一级导航数：</td>
						     <td width="60%" align="left"><input name="intMaxNavCount" class="form-control input-sm" style="width:160px;" type="text" value="<%=intMaxNavCount%>" <%if (intAdministerState == 0) {%>disabled<%}%>>
						     </td>
						   </tr>
						   <tr style="display:none"> 
						     <td width="40%" style="height:35px;line-height:35px;" align="right">最多可建的用户数：</td>
						     <td width="60%" align="left"><input name="intMaxUserCount" class="form-control input-sm" style="width:160px;" type="text" value="<%=intMaxUserCount%>" <%if (intAdministerState == 0) {%>disabled<%}%>>
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
   <!--管理员权限 end-->
    </div>
   <!--tabend-->
</form>


</body>
</html>
<%
	} catch (Exception ex) {
		System.out.println(ex.toString());
	}
%>
<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>