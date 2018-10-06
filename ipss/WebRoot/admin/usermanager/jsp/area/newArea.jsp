<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
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

String action =request.getParameter("action")==null?"":request.getParameter("action");
String title = "";
String para2=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"para2");
String para3=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"para3");

		if(action.equals("new")){
			title = "新建地区";
		}
		if(action.equals("edit")){
			title = "编辑地区";
		}		

%>
<title><%=title%></title>
<body>

<table width="96%" align="center">
  <tr><td align="center">
<fieldset><legend></legend>
<table width="100%" border="0" cellpadding="3" cellspacing="3">
  <tr>
    <td><div align="center">
        <%
if(action.equals("edit")){
%>
        地区名称：<input type="text" name="areaName" value="<%=para2%>" style="width:260"><br>
		地区备注：<textarea name="areaMemo" cols="30" rows="4" style="width:260"><%=para3%></textarea>
<%}%>
<%
if(action.equals("new")){
%>
        地区名称：<input type="text" name="areaName" style="width:260"><br>
		地区备注：<textarea name="areaMemo" cols="30" rows="4" style="width:260"></textarea>
<%}%>
    </div></td>
  </tr>
  <tr>
    <td>
	<div align="center">
        <input type="button" name="button1" value=" 确定 " onClick="javascript:returnValue();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" name="Submit" value=" 关闭 " onClick="window.close()">
    </div></td>
  </tr>
</table>
</fieldset>
</td></tr></table>

<p>&nbsp;</p>
</body>
<script>
function returnValue(){
	var action ="<%=action%>";
	//alert(document.all.ResourceName.value);
	var retValue="";
	
	var obj = window.dialogArguments;
	if(action=="new" || action=="edit"){
		retValue = document.all.areaName.value;
		retValue = retValue.replace(/(^\s*)|(\s*$)/g, "");
		if(retValue==""){
			alert("请填写地区名称");
			return false;
		}else{
			obj.areaName.value = retValue;
		}
		
		retValue = document.all.areaMemo.value;
		retValue = retValue.replace(/(^\s*)|(\s*$)/g, "");
		obj.areaMemo.value = retValue;
	}
	//window.returnValue = rArgs;
	window.close();
}
</script>