<%@ page contentType="text/html;charset=utf-8" import="com.trs.usermanage.*,com.trs.usermanage.UserManage"%>

<%
try{

//out.println("intGroupID="+intGroupID);

String strAdminName="admin";

int intUserID = 1;
int intGroupID = 9;

UserManage.getAdministratorInfo();
int adminIDs[]=UserManage.getAdministratorIDs();
String adminNames[]=UserManage.getAdministratorNames();	

int intType=1;
String intTypeStr = request.getParameter("intType");
if(intTypeStr!=null    )
{
	try{
		intType = Integer.parseInt(intTypeStr);
	}catch(Exception e)
	{
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
	GroupManage groupmanage=new GroupManage();
	groupmanage.setMulti();
	int     groupIDs[]=groupmanage.getGroupIDs();
	String  groupNames[]=groupmanage.getGroupNames();
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	String[] arrAreaInfo=AreaManage.getAreaInfo(intUserID);
	
	UserManage usermanage=new UserManage(intUserID);
//如果此管理员是普通管理员，则看到ipr_navtable中此管理员的所有菜单项
	boolean b_Admin=false;
	if(strAdminName.equals("admin")){b_Admin=true;}
//out.println(strAdminName+"<br>");
//out.println(b_Admin+"<br>");
	String[] arrTradeInfo=usermanage.getTradeInfoByAdmin(b_Admin,intType);
	
	String strAdminMenuInfo = usermanage.getMenuInfoByUserID();
//out.println(strAdminMenuInfo+"<br>");
	
	usermanage.getMenuInfo();
    int[] arrMenuID=usermanage.getMenuIDs();
    String[] arrMenuName=usermanage.getMenuNames();

//取出来的是ipr_navtable中的intID,chrName

	java.util.Date Now = new java.util.Date();
	String strExpTime = request.getParameter("SDate");
	//if (strExpTime<=Now)
	if(true)
	{
		//response.sendRedirect("../common/error1.jsp?");
	}
%>
<SCRIPT language=javascript src="../../js/user.js"></SCRIPT>
<SCRIPT language=javascript src="../../js/datepicker.js"></SCRIPT>
<LINK href="../../css/datepicker.css" type=text/css rel=stylesheet>

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
if(vDate<=strNow)
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
		if(document.all.menuIDs.options[i].text=="|─行业分类导航"){
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
function hide1()
{
	document.all.basic.style.visibility="visible";
	document.all.idbutton1.background='../../../images/topbutl_7_nolist.gif'
	document.all.basic.style.display="block";
	
	document.all.wasbasic.style.visibility="hidden";
	document.all.idbutton2.background='../../../images/topbut_7_nolist.gif'
	document.all.wasbasic.style.display="none";
	
	document.all.wascount.style.visibility="hidden";
	document.all.idbutton3.background='../../../images/topbut_7_nolist.gif'
	document.all.wascount.style.display="none";

	document.all.group.style.visibility="hidden";
	document.all.idbutton4.background='../../../images/topbut_7_nolist.gif'
	document.all.group.style.display="none";
		
	document.all.admin.style.visibility="hidden";
	document.all.idbutton5.background='../../../images/topbut_7_nolist.gif'
	document.all.admin.style.display="none";
	
	return true;
}
function hide2()
{
	document.all.basic.style.visibility="hidden";
	document.all.idbutton1.background='../../../images/topbut_7_nolist.gif'
	document.all.basic.style.display="none";
	
	document.all.wasbasic.style.visibility="visible";
	document.all.idbutton2.background='../../../images/topbutl_7_nolist.gif'
	document.all.wasbasic.style.display="block";
	
	document.all.wascount.style.visibility="hidden";
	document.all.idbutton3.background='../../../images/topbut_7_nolist.gif'
	document.all.wascount.style.display="none";
	
	document.all.group.style.visibility="hidden";
	document.all.idbutton4.background='../../../images/topbut_7_nolist.gif'
	document.all.group.style.display="none";
		
	document.all.admin.style.visibility="hidden";
	document.all.idbutton5.background='../../../images/topbut_7_nolist.gif'
	document.all.admin.style.display="none";
	return true;
}
function hide3()
{
	document.all.basic.style.visibility="hidden";
	document.all.idbutton1.background='../../../images/topbut_7_nolist.gif'
	document.all.basic.style.display="none";
	
	document.all.wasbasic.style.visibility="hidden";
	document.all.idbutton2.background='../../../images/topbut_7_nolist.gif'
	document.all.wasbasic.style.display="none";
	
	document.all.wascount.style.visibility="visible";
	document.all.idbutton3.background='../../../images/topbutl_7_nolist.gif'
	document.all.wascount.style.display="block";

	document.all.group.style.visibility="hidden";
	document.all.idbutton4.background='../../../images/topbut_7_nolist.gif'
	document.all.group.style.display="none";

	document.all.admin.style.visibility="hidden";
	document.all.idbutton5.background='../../../images/topbut_7_nolist.gif'
	document.all.admin.style.display="none";
	
	return true;
}


function hide4()
{
	document.all.basic.style.visibility="hidden";
	document.all.idbutton1.background='../../../images/topbut_7_nolist.gif'
	document.all.basic.style.display="none";
	
	document.all.wasbasic.style.visibility="hidden";
	document.all.idbutton2.background='../../../images/topbut_7_nolist.gif'
	document.all.wasbasic.style.display="none";
	
	document.all.wascount.style.visibility="hidden";
	document.all.idbutton3.background='../../../images/topbut_7_nolist.gif'
	document.all.wascount.style.display="none";
	
	document.all.group.style.visibility="visible";
	document.all.idbutton4.background='../../../images/topbutl_7_nolist.gif'
	document.all.group.style.display="block";

	document.all.admin.style.visibility="hidden";
	document.all.idbutton5.background='../../../images/topbut_7_nolist.gif'
	document.all.admin.style.display="none";

	return true;
}

function hide5()
{
	document.all.basic.style.visibility="hidden";
	document.all.idbutton1.background='../../../images/topbut_7_nolist.gif'
	document.all.basic.style.display="none";
	
	document.all.wasbasic.style.visibility="hidden";
	document.all.idbutton2.background='../../../images/topbut_7_nolist.gif'
	document.all.wasbasic.style.display="none";
	
	document.all.wascount.style.visibility="hidden";
	document.all.idbutton3.background='../../../images/topbut_7_nolist.gif'
	document.all.wascount.style.display="none";
	
	document.all.group.style.visibility="hidden";
	document.all.idbutton4.background='../../../images/topbut_7_nolist.gif'
	document.all.group.style.display="none";

	document.all.admin.style.visibility="visible";
	document.all.idbutton5.background='../../../images/topbutl_7_nolist.gif'
	document.all.admin.style.display="block";
	
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
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="return hide1();toAdmin(0)">
<table width="91%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td valign="top"> 
      <table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="97%" align="right">
            <table width="316" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_nolist.gif" class="14r">
              <tr> 
                <td width="505" align="right" valign="top"><span class="14r">注 册 用 户</span></td>
                <td width="11" valign="top">&nbsp;</td>
                <td width="24" valign="top">&lt;&lt;</td>
              </tr>
            </table>
          </td>
          <td width="3%" align="right">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../../images/topbg_nolist.gif">
        <tr> 
          <td width="5%"><img src="../../../images/topl_nolist.gif" width="20" height="29"></td>
          <td width="94%" align="right">
            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" class="12hb">
              <tr> 
                <td id="idbutton1" width="122" align="right" valign="top" background="../../../images/topbut_7_nolist.gif">
                  <table width="122" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr>
                      <td align="center" valign="bottom"><a href="stylelist.jsp" style="color:#FF0000" onClick="javaScript:event.returnValue=false;return hide1();">用户一般信息</a></td>
                    </tr>
                  </table>
                </td>
                <td id="idbutton2" width="122" align="right" valign="top" background="../../../images/topbut_7_nolist.gif">
                  <table width="122" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr>
                      <td align="center" valign="bottom"><a href="stylelist.jsp" style="color:#FF0000" onclick="javaScript:event.returnValue=false;return hide2();">用户附加信息</a></td>
                    </tr>
                  </table>
                </td>
            
                <td>&nbsp;</td>
                
              </tr>
            </table></td>
          <td width="1%" align="right"><img src="../../../images/topr_nolist.gif" height="29"></td>
        </tr>
      </table>
      <table width="100%" height="273" border="0" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
	    <form name="form1" method="post" action="register-user-submit.jsp" onSubmit="return checkform();">
        <tr>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
          <td width="98%">
			<table id="basic"  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff"  bordercolorlight="#088EB5">
			  <tr> 
			    <td bgcolor="#088EB5"> 
			       <table width="100%" border="1" cellspacing="10" cellpadding="0">
			         <tr> 
			           <td bgcolor="#E3E5E3" height="340" valign="top"> 
			             <table width="100%" border="0" cellspacing="1" cellpadding="3">
						   <tr> 
						     <td width="40%" align="right">用 户 名：</td>
						     <td width="60%" align="left"><input name="UserName" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">用户真名：</td>
						     <td width="60%" align="left"><input name="RealName" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
						     <td width="60%" align="left"><input name="Password" type="password"> (请输入密码)
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">确认密码：</td>
						     <td width="60%" align="left"><input name="rePassword" type="password"> (请再输入一遍) 
						     </td>
						   </tr>
				           <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                 <tr> 
				                   <td width="47"><input type="image" src="../../images/wancheng.gif" width="47" height="20"></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><img style="cursor:hand" src="../../images/fangqi.gif" width="47" height="20" onclick="window.close()"></td>
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
			      
			 <table id="wasbasic" style="display:none;" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff"  bordercolorlight="#088EB5">
			   <tr> 
			     <td bgcolor="#088EB5"> 
			       <table width="100%" border="1" cellspacing="10" cellpadding="0">
			         <tr> 
			           <td bgcolor="#E3E5E3" height="340" valign="top"> 
						 <table width="100%" border="0" cellspacing="1" cellpadding="3">
						   <tr> 
						     <td width="40%" align="right">电话号码：</td>
						     <td width="60%" align="left"><input name="Phone" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">手机号码：</td>
						     <td width="60%" align="left"><input name="Mobile" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">传真号码：</td>
						     <td width="60%" align="left"><input name="Fax" type="text">
						     </td>
						   </tr>
						   <tr> 
						     <td width="40%" align="right">电子邮件：</td>
						     <td width="60%" align="left"><input name="Email" type="text">
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" align="right">通信地址：</td>
						     <td width="60%" align="left"><input name="Address" type="text">
						     </td>
						   </tr>
						   <tr> 
						      <td width="40%" align="right">工作单位：</td>
						     <td width="60%" align="left"><input name="Department" type="text" value="">
						     </td>
						   </tr>
				           <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                 <tr> 
				                   <td width="47"><input type="image" src="../../images/wancheng.gif" width="47" height="20"></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><img style="cursor:hand" src="../../images/fangqi.gif" width="47" height="20" onclick="window.close()"></td>
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
			  
			 <table id="wascount" style="display:none;" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff" bordercolorlight="#088EB5">
              <tr> 
                <td > 
                  <table width="100%" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E3E5E3" height="340" valign="top"> 
                        <table width="100%" border="0" cellspacing="1" cellpadding="3">

                          <tr style="display:none;">
                            <td width="40%" align="right">地区用户：</td>
                            <td  width="60%" align="left"><!--input type="text" name="defaultip" value="%">（用户绑定IP时有效） <a href="#" title="比如：是否合法IP，是否该IP已被占用！" onclick="window.open('listip.jsp','_blank','width=250,height=200,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')">验证单个IP能否使用</a> <a href="#" title="(格式如：192.9.200.3;192.9.200.4-192.9.200.10;192.9.100.*)">格式</a-->
                                                          <!--input type="hidden" name="backip" value=""-->
														  <select name="intUserAreaID">
																	<option value="0">不选择</option>
																	<%
																if(arrAreaInfo!=null){
																	for(int i=0;i<arrAreaInfo.length;i++){
																		//System.out.println(arrAreaInfo[i]);
																		//System.out.println(arrAreaInfo[i].split("#")[0]);
																		//System.out.println(arrAreaInfo[i].split("#")[1]);
																	
																		String areaID=arrAreaInfo[i].split("#")[0];
																		String areaName=arrAreaInfo[i].split("#")[1];
																	%>
																	<option value="<%=areaID%>"><%=areaName%></option>
																	<%
																	
																	}
																}
																	%>
															</select>
                            </td>
                          </tr>

<tr style="display:none;">
<td align="right">第三方平台IP：</td>
<td><input id="ipaddress" name="IPAdress" type="text" value=""></td>
</tr>

<tr>
<td width="40%" align="right">用户所属管理员：</td>
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
			if(!strAdminName.equals("admin"))
			{
			%>
	        <select name="administerID" style="width=150" disabled>
			<%
			}
			else{
			%>
			<select name="administerID" style="width=150">
			<%
			}
			for(int i=0;i<adminIDs.length;i++)
			{
//			  if(i==(adminIDs.length-1))
			  if(adminNames[i].equals(strAdminName))
			  {
			%>
			<option value="<%=adminIDs[i]%>" selected><%=adminNames[i]%></option>
			<%			  
			  }
			  else
			  {
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
				    <td width="28%" align="right">过期时间：</td>
                      			<td width="72%" align="left" vAlign=top >
<%
java.util.Date rightNow = new java.util.Date();
%>
<input type="text" name="SDate" value="2088-10-10" />				  
				      </td>
				    </tr>
<tr style='display:none'> 
    <td width="40%" align="right">中药检索平台用户名:</td>
    <td width="60%" align="left"><input id="herbal" name="herbal_name" type="text" value=""></td>
</tr>
					
						<tr>
                            <td width="40%" align="right">最大登录数：</td>
                            <td width="60%" align="left"><input name="MaxLogin" type="text" value="1">
                            </td>
                          </tr>
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
                          <tr style="display:none;"> 
                            <td width="40%" align="right">文摘批量下载量：</td>
                            <td width="60%" align="left"><input name="ABSTBatchCount" type="text" value="0">条/年
                            <BR><B>（<font color="red">此项设定为非0值将开通批量下载功能</font>）</b>
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
                          <!--tr>
						    <td width="40%" align="right">开通专利分析功能：</td>
                            <td width="60%" align="left">
							<input type="radio" name="AnalyseState" value="1" id="as1">
                            <label for="as1" style="cursor:hand">开通
                            <input type="radio" name="AnalyseState" value="0" checked id="as0">
                            <label for="as0" style="cursor:hand">不开通
							</td>
						  </tr-->
						  
						  
                          <tr> 
                            <td width="40%" align="right">管理员修改备注：</td>
                            <td width="60%" align="left"><textarea name="CMemo" cols="30" rows="5"></textarea>
                            </td>
                          </tr>
	                      
						   <tr> 
				             <td align="center" colspan="2"> 
				               <table width="109" border="0" cellspacing="0" cellpadding="0">
				                 <tr> 
				                   <td width="47"><input type="image" src="../../images/wancheng.gif" width="47" height="20"></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><img style="cursor:hand" src="../../images/fangqi.gif" width="47" height="20" onclick="window.close()"></td>
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
			      
              <!--用户组信息-->
              <table id="group" style="display:none;" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff"  bordercolorlight="#088EB5">
          	  <tr> 
                <td > 
                  <table width="100%" border="1" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E3E5E3" height="340" valign="top"> 
			            <table width="100%" border="0" cellspacing="1" cellpadding="3">
		<!--tr>
		<td colspan="2">&nbsp;</td>
		</tr-->
		<tr> 
	        <td conspan="2"  align="center" >
	        
	        <table width="630" border="0">
              <tr>
                <td width="34%"><div align="center">检索权限</div></td>
                <td width="36%"><div align="center">菜单权限</div></td>
                <td width="30%"><div align="center">行业信息权限</div></td>
              </tr>
              <tr>
                <td valign="top"><div align="center">

<%
/*
if(intUserID==1){
	intGroupID
}
*/
%>

<select name="groupid" style="width=150" size="16">
<%
	for(int i=0;i<groupIDs.length;i++)
	{
		if(intUserID==1){
%>
		<option value="<%=groupIDs[i]%>"  <% if(9==groupIDs[i]){%> selected <%} %> ><%=groupNames[i]%></option>
<%
		}else if(intGroupID==groupIDs[i]){
%>
		<option value="<%=groupIDs[i]%>" <% if(9==groupIDs[i]){%> selected <%} %>  ><%=groupNames[i]%></option>
<%
		}
	}
%>
</select>


                </div></td>
                <td width="36%" valign="top"><div align="center">
<select id="menuid" name="menuIDs" size="16" style="width=200" multiple>
                      <%
				if(b_Admin==true)
				{
					for(int i=0;i<arrMenuID.length;i++){
						out.println("<option value="+arrMenuID[i]+">"+ arrMenuName[i] +"</option>");
					}
				}else{
					for(int i=0;i<arrMenuID.length;i++){
						if((","+strAdminMenuInfo).indexOf(","+arrMenuID[i]+",")>-1){
							out.println("<option value="+arrMenuID[i]+">"+ arrMenuName[i] +"</option>");
						}
					}				
				}
				%>
</select>
                </div></td>
                <td width="30%" valign="top"><div align="center">
<select name="TradeList" size="16" multiple style="width=200">
                      <%
						 if(arrTradeInfo!=null){
								 for(int i=0;i<arrTradeInfo.length;i++){
								 	//String NavID=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf("_"));
									//String NavName=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(",")+1);
									String strPreNavInfo=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf(";"));
									String strNavInfo=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(";")+1);
									//out.println("<option selected value="+NavID+">"+NavName+"</option>");
									if(strAdminName.equals("admin")){
										out.println("<option value='"+strPreNavInfo+"'>"+strNavInfo+"</option>");
									}else{
										out.println("<option selected value='"+strPreNavInfo+"'>"+strNavInfo+"</option>");
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
	                              <td width="47"><input type="image" src="../../images/wancheng.gif" width="47" height="20"></td>
	                              <td width="34">&nbsp;</td>
	                              <td width="47"><img style="cursor:hand" src="../../images/fangqi.gif" width="47" height="20" onclick="window.close()"></td>
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



<table id="admin" style="display:none"  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolordark="#ffffff"  bordercolorlight="#088EB5">
			  <tr> 
			    <td bgcolor="#088EB5"> 
			       <table width="100%" border="1" cellspacing="10" cellpadding="0">
			         <tr> 
			           <td bgcolor="#E3E5E3" height="340" valign="top"> 
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
						   <tr style='display:none'> 
						     <td width="40%" align="right">地区管理员：</td>
						     <td width="60%" align="left">
													  <select name="intAdminAreaID">
															<option value="0">不选择</option>
															<%
																if(arrAreaInfo!=null && arrAreaInfo.length>0){
																	for(int i=0;i<arrAreaInfo.length;i++){
																		String areaID=arrAreaInfo[i].split("#")[0];
																		String areaName=arrAreaInfo[i].split("#")[1];
															%>
															<option value="<%=areaID%>"><%=areaName%></option>
															<%
																	}
																}
																	%>
														</select>
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
				                   <td width="47"><input type="image" src="../../images/wancheng.gif" width="47" height="20"></td>
				                   <td width="34">&nbsp;</td>
				                   <td width="47"><img style="cursor:hand" src="../../images/fangqi.gif" width="47" height="20" onclick="window.close()"></td>
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











          </td>
           <td width="1%" bgcolor="A8C5E2">&nbsp;</td>
         </tr>
       </form> 
       </table>
       <table width="100%" height="23" border="0" cellpadding="0" cellspacing="0" background="../../../images/topb_nolist.gif">
        <tr> 
          <td width="27%"><img src="../../../images/bl_nolist.gif" width="20" height="23"></td>
          <td align="right"><img src="../../../images/br_nolist.gif" width="21" height="23"></td>
        </tr>
      </table>
    </td>
   </tr>
</table>
</body>
</html>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>