<%@ page language="java" import="java.util.*,com.trs.usermanage.*,com.trs.usermanage.UserManage" pageEncoding="utf-8"%>

<%
int intAdminId = Integer.parseInt((String)request.getSession().getAttribute("userid"));

String name="";
String strSequenceNum="";
String Expression="";
String FRExpression="";
String memo="";

String strPath = null;
int intParentID = 0;
int intID = 0;

//String intType = request.getParameter("intType");
	if(intType==null  || intType.equals(""))
		intType = "1";
	
String doing = "";
Hangye _hangye=new Hangye();

try{
if ((request.getParameter("parentid") == null|| request.getParameter("parentid").equals(""))
//	&& (request.getParameter("id") == null|| request.getParameter("id").equals(""))
	&& (request.getParameter("select") == null|| request.getParameter("select").equals(""))
	&& (request.getParameter("delete") == null|| request.getParameter("delete").equals("")))
{
	strPath="<a href=\"list.jsp?parentid=0&intType="+intType+"\">根节点</a>";
	intParentID = 0;
}
else
{
	if (request.getParameter("parentid") != null && !request.getParameter("parentid").equals(""))
	{//导航条的request
		int int0 = Integer.parseInt(request.getParameter("parentid"));
		strPath="<a href=\"list.jsp?parentid=0&intType="+intType+"\" onClick=\"flushmainfr()\">根节点</a>" + " \\ " + _hangye.getPath(int0,intAdminId,Integer.parseInt(intType));
		intParentID=int0;
	}	
}
}catch(Exception ex){
	out.println("List.jsp err1....>"+ex.toString());
}

String strmsg="";
String[] arrEnterpriseInfo=UserManage.getEnterpriseInfo(intAdminId);
String chrEnterpriseName=arrEnterpriseInfo[0];
int intMaxSearchCount=Integer.parseInt(arrEnterpriseInfo[1]);
int intMaxNavCount=Integer.parseInt(arrEnterpriseInfo[2]);
int intMaxUserCount=Integer.parseInt(arrEnterpriseInfo[3]);

String[] arr=_hangye.getTradeList(intParentID,intAdminId,Integer.parseInt(intType));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'list.jsp' starting page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body,button, input, select, textarea,h1 ,h2, h3, h4, h5, h6 ,p{ font-family: Microsoft YaHei,'宋体' , Tahoma, Helvetica, Arial, "\5b8b\4f53", sans-serif;}
	td{
		font size:12px;
	}
	div{
		font size:12px;
	}
	A:link {text-decoration:none;}
	A:visited {text-decoration:none;}
	A:active {text-decoration:none;}
	A:hover {text-decoration:none;}
	.style10 {font-size: 12px; font-family: Arial; font-weight: bold; }
	.style11 {font-size: 12px}
	body {
		margin-top: 0px;
	}
	</style>
	<script>
	function flushmainfr()
	{parent.window.mainFrame.location.href="detail.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&intType=<%=intType%>";}
	
	</script>
  </head>
  
<body>
   <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
<table width="90%" border="0" cellpadding="3" cellspacing="3">
<tr>
<td width="440"><%=strPath%></td>
<td width="130" nowrap><div align="right">
<!-- 
<%if(intParentID==0 && ((arr==null && intMaxNavCount==0) || (arr!=null && arr.length>=intMaxNavCount))){%>
<a href=javascript:alert("您已经无权新建行业导航！");><img src="<%=basePath%>admin/hangye/images/createfile.gif" width="16" height="16" border="0"> 增加节点</a>
<%}else{%>
<%}%>
-->
<a href="<%=basePath%>admin/hangye/detail.jsp?action=newnode&id=<%=intParentID%>&intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=intParentID%>&intType=<%=intType %>" target="mainFrame">		  
<img src="images/createfile.gif" width="16" height="16" border="0"> 增加节点</a>
</div>
</td>
</tr>
</table>

<table width="90%" border="0" cellspacing="3">
<tr bgcolor="#C2C6DA">
  	<td width="46" align="center"><span class="style10">顺序号</span></td>
    <td width="460">&nbsp;<span class="style10">名 称</span></td>
    <td width="40"><div align="center"><span class="style10">类 型</span></div></td>
    <td width="40"><div align="center">

<table width="80" border="0">
  <tr>
    <td width="40"><div align="center" class="style10">编 辑</div></td>
    <td width="40"><div align="center" class="style10">删 除</div></td>
  </tr>
</table>	
</div>
</td>
</tr>
  
<%
try{
	//String[] arr=hangye.getTradeList(intParentID,intAdminId);
	if(arr==null || arr.length==0){
		return;
	}

	String intTradeID="";
	String strTradeName="";

	String sColor = "";
	int tt=0;
			
//	while (rs0.next()) {
	for(int i=0;i<arr.length;i++){
		String[] arrItem=arr[i].split(",");
		intTradeID=arrItem[0];
		strTradeName=arrItem[1];
		strSequenceNum=arrItem[2];

		tt=tt+1;
		if((int)(tt%2) == 0)
			sColor = "#F0F5FF";
		else
			sColor = "#FFFFFF";
			
		boolean fileType = _hangye.has_child(Integer.parseInt(intTradeID),intAdminId);
%>				
<tr bgColor="<%=sColor%>">
<td align="center"><%=strSequenceNum%></td>
<td height="24">
<a href="<%=basePath%>admin/hangye/list.jsp?parentid=<%=intTradeID%>&intType=<%=intType%>" onClick="flushmainfr()"><%=strTradeName%></a></td>
    <td><div align="center">
	<%	
	if (fileType){
	%>
	<img src="<%=basePath%>admin/hangye/images/folder.gif" width="16px" height="16px"></div></td>
    <%
	}else{
	%>
	<img src="<%=basePath%>admin/hangye/images/file.gif" width="16px" height="16px"></div></td>
	<%
	}
	%>
	<td><div align="center">
      <table width="60" border="0">
          <tr>
            <td width="40px" height="20px" align="center">
<a href="<%=basePath%>admin/hangye/detail.jsp?action=editnode&id=<%=intTradeID%>&intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=intParentID%>&intType=<%=intType %>" target="mainFrame">			
			<img src="<%=basePath%>admin/hangye/images/edit_profile.gif" width="16px" height="16px" border="0" >
</a></td>
            <td width="40" align="center">
<img src="<%=basePath%>admin/hangye/images/delete.gif" style="cursor:hand" width="16px" height="16px" border="0" onClick="del_affirm(<%=intTradeID%>,'<%=strTradeName%>')">
</td></tr>
      </table>
    </div></td>
</tr>    
<%			
}
}catch(Exception ex){
	out.println("List.jsp err2....>"+ex.toString());
}
%>
</table>
	</td>
  </tr>
</table>
</body>
</html>

<script>
function del_affirm(id,name)
{
	var info="您确认要删除“"+name+"”节点么？";
//var info="您确认要删除此节点么？";
	var con;
	con=confirm(info);
	if(con==true)
	{
		parent.window.mainFrame.location.href = '<%=basePath%>deleteNode.do?action=deletenode&intType=<%=intType%>&id='+id;
//this.location.href = 'list.jsp?parentid='+id;
	}
}
</script>