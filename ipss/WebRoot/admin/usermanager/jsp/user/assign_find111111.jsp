<%@ page contentType="text/html; charset=utf-8" errorPage="../common/error.jsp"%>

<link href="../../../css/dataUpdate.css" rel="stylesheet" type="text/css" ></link>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	background-color: menu;
}
.style3 {font-size: 12px}
-->
td{font-size:13px;font-family: Arial}
</style>
<link href="../css/dataUpdate.css" rel="stylesheet" type="text/css" ></link>
<%

String strAdminName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

int adminID=intUserID;
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
%>
<title>分配行业信息权限</title>
<body>

<table width="96%" align="center">
  <tr><td align="center">
<fieldset><legend></legend>
<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><div align="center">
        请输入用户名：<input type="text" name="userName" value="" style="width:260">
        
		</div>
	</td>
	<tr>
	</tr>
    <td>
	<div align="center">
        <input type="submit" name="button1" value=" 查找 " onClick="javascript:returnValue();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" name="Submit" value=" 关闭 " onClick="window.close()">
    </div></td>
  </tr>
</table>
</fieldset>
</td></tr></table>
</body>
<script>
function returnValue(){
		var obj = window.dialogArguments;
		var retValue = document.all.userName.value;
		retValue = retValue.replace(/(^\s*)|(\s*$)/g, "");
		if(retValue==""){
			alert("请输入用户名");
			return false;
		}else{
			obj.value = retValue;
		}
		//window.location.href="distribute_hangye.jsp";
	window.returnValue = retValue;
	window.close();
}
</script>