<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.trs.usermanage.*,com.trs.usermanage.UserManage"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>

<%@ include file="../../../../jsp/zljs/include-head-base.jsp"%>

<%
int intType=1; 
String intTypeStr = request.getParameter("intType");
if(intTypeStr!=null)
{
	try{
		intType = Integer.parseInt(intTypeStr);
	}catch(Exception e)
	{
		e.printStackTrace();
	}
}

int assignUserID = 0;
try{
	String strAdminName= (String)request.getSession().getAttribute("username");
	int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));
//	System.out.println(request.getParameter("assignUserID"));
	
	assignUserID = Integer.parseInt(request.getParameter("assignUserID"));
	
int adminID=intUserID;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
UserManage usermanage=new UserManage(adminID);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String modified_userID=request.getParameter("modified_userID");
String modified_userTrade=request.getParameter("modified_userTrade");

//out.println(modified_userID+"<br>");
//out.println(modified_userTrade+"<br>");

int tradeType = 1;//行业分类导航是1，专题数据库是3
if(modified_userID!=null && !modified_userID.equals("") && modified_userTrade!=null && !modified_userTrade.equals("")){	
//	int intRet = usermanage.assignHangye(adminID,Integer.parseInt(modified_userID),modified_userTrade,tradeType);
	int intRet = usermanage.assignHangye(adminID,assignUserID,modified_userTrade,tradeType);
	if(intRet==1){
//out.println("修改成功");
%>
<script>alert("修改成功");</script>
<%
	}
	if(intRet==-1){
//out.println("修改失败");
%>
<script>alert("修改失败");</script>
<%
	}
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
String sUserName=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"username");

String userTradeInfo=usermanage.getUserTradeInfoByUserID(assignUserID,tradeType);
//out.println("userTradeInfo="+userTradeInfo);
if(userTradeInfo==null || userTradeInfo.equals("")){
%>
<script>
alert("无此用户");
window.close();
</script>
<%
	return;
}

String strTradeInfoSel="";

boolean b_Admin=false;
if(strAdminName.equals("admin")){b_Admin=true;}
String[] arrTradeInfo=usermanage.getTradeInfoByAdmin(b_Admin,intType);

/*
if(arrUserInfo!=null){
	for(int i=0;i<arrUserInfo.length;i++){
		System.out.println(arrUserInfo[i].split("#")[0]+";"+arrUserInfo[i].split("#")[1]+arrUserInfo[i].split("#")[2]+"<br>");
	}
}
*/
%>
<title>分配行业信息权限</title>
<body>

<script>window.name="hangye";</script>

<table width="95%" align="center">
<tr><td align="center">
<fieldset><legend></legend>

<form name="form1" method="post" action="assignhangye.do" target="hangye">
<input type="hidden" name="username" value="<%=sUserName%>">
<input type="hidden" name="modified_userID">
<input type="hidden" name="modified_userTrade">
<input type="hidden" id="assignUserID" name="assignUserID" value="<%=assignUserID%>">

<table width="95%" border="0" height="128px" cellpadding="3" cellspacing="3">
<tr valign="top">
    <td width="12%">
     <div align="center">
        <select name="userlist" size="12" onChange="changeUser()" multiple="multiple"  style="width:120px;height:200px">
		<%
		if(userTradeInfo!=null && !userTradeInfo.equals("")){
//			for(int i=0;i<arrUserInfo.length;i++)
			{
				String userID=userTradeInfo.split("#")[0];
				String userName=userTradeInfo.split("#")[1];
				String userTrade=userTradeInfo.split("#")[2];
				
				if(userID.equals(assignUserID+"")){
					out.println("<option value='"+userID+"' selected=\"selected\">"+userName+"</option>");
				}else{
					out.println("<option value='"+userID+"'>"+userName+"</option>");
				}
			}
		}
		%>
        </select>
		</div>
	</td>
	<td width="88%">

<select name="TradeList"  size="12"  multiple="multiple" style="width:240px;height:280px">
<%
if(arrTradeInfo!=null){
	for(int i=0;i<arrTradeInfo.length;i++){
//String NavID=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf("_"));
//String NavName=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(",")+1);
									
		String strPreNavInfo=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf(";"));									
		String strNavInfo=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(";")+1);
									
//		System.out.println("userTradeInfo="+userTradeInfo);									
//		System.out.println(strPreNavInfo+"-----------"+strNavInfo);
									
		if(userTradeInfo.indexOf(strPreNavInfo+"$")>-1){
			out.println("<option value='"+strPreNavInfo+"' selected=\"selected\">"+strNavInfo+"</option>");
		}else{
			out.println("<option value='"+strPreNavInfo+"'>"+strNavInfo+"</option>");
		}
	 }
}
%>
</select>

</td>
</tr>
<tr><td colspan="2">
	<div align="center">
        <input type="button" name="button1" value=" 保 存 " onClick="javascript:returnValue();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" name="Submit" value=" 关 闭 " onClick="window.close()">
    </div></td>
</tr>

</table>
</form>
</fieldset>

</td>
</tr>
</table>

 


</body>
<script>
function changeUser(){
	//alert(document.all.userlist.selectedIndex);
	//alert(document.all.userlist.options[document.all.userlist.selectedIndex].title);
	
	var userTrade=document.all.userlist.options[document.all.userlist.selectedIndex].title;
//alert(userTrade);
	for (var i = 0; i < document.all.TradeList.options.length; i++) {
	  		document.all.TradeList.options[i].selected=false;
	}
	for (var i = 0; i < document.all.TradeList.options.length; i++) {
//alert(document.all.TradeList.options[i].value+"$");
	//if (mySelect.options[i].selected){document.write(" mySelect.options[i].text\n")}
		  if(userTrade.indexOf(document.all.TradeList.options[i].value+"$")>-1 ){
		  		document.all.TradeList.options[i].selected=true;
		  }		
	} 
}

function returnValue(){
/*
	var obj = window.dialogArguments;
	var retValue = document.all.userName.value;
	retValue = retValue.replace(/(^\s*)|(\s*$)/g, "");
	if(retValue==""){
		alert("请输入用户名");
		return false;
	}else{
		obj.value = retValue;
	}
*/
//modified_userID
	if(document.all.userlist.options.length>0){
		var selUserID=document.all.userlist.options[document.all.userlist.selectedIndex].value;
		document.all.modified_userID.value=selUserID;
		
		var userTrade="";
		for (var i = 0; i < document.all.TradeList.options.length; i++) {
			//document.all.TradeList.options[i].selected=false;
			if(document.all.TradeList.options[i].selected==true){
				//modified_userTrade
				userTrade+=document.all.TradeList.options[i].value+",";
			}
		}
		document.all.modified_userTrade.value=userTrade;
	}
	document.form1.submit();
//alert("保存成功");
	//window.location.href="distribute_hangye.jsp";
	//window.close();
}
//userlist
//getfirstUserTrade();
function getfirstUserTrade(){
	if(document.all.userlist.options.length>0){
		document.all.userlist.options[0].selected=true;
		var userTrade=document.all.userlist.options[0].title;
//alert("userTrade="+userTrade);
		for (var i = 0; i < document.all.TradeList.options.length; i++) {
				document.all.TradeList.options[i].selected=false;
		}
		for (var i = 0; i < document.all.TradeList.options.length; i++) {
//if (mySelect.options[i].selected){document.write(" mySelect.options[i].text\n")}
//alert(userTrade+"-----"+document.all.TradeList.options[i].value+"$");
			  if(userTrade==document.all.TradeList.options[i].value+"$"){
					document.all.TradeList.options[i].selected=true;
			  }		
		}
	}
}
</script>
<%}catch(Exception ex){
	ex.printStackTrace();
}
%>