<%@ page language="java" import="com.trs.usermanage.UserManage" pageEncoding="utf-8"%>

<script type="text/javascript">
//window.onload = function(){
$(function() {
//alert("window.onload....");
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
		url : "<%=basePath%>showHangyelist.do?timeStamp=" + new Date(),
		data : {
			'parentid' : '0',
			'intType' : '1'
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			alert(jsonresult);
//			$("#username").attr("value","guest");//清空内容 
//			$("#password").attr("value","123456");
		
		}
	})
});
</script>

<table style="width:750px;height:350px" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
<table style="width:90%;height:20px" border="0" cellpadding="3" cellspacing="3">
<tr>
<td width="440" id="strPath"></td>
<td width="130" nowrap><div align="right">

<a href="<%=basePath%>admin/hangye/detail.jsp?action=newnode&id=<%=intParentID%>&intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=intParentID%>&intType=<%=intType%>" target="mainFrame">		  
<img src="images/createfile.gif" width="16" height="16" border="0"> 增加节点</a>

</div>
</td>
</tr>
</table>
      
  <table style="width:750px;height:20px" border="0" cellspacing="3" id="hangyelist">
  <tr bgcolor="#C2C6DA">
  	<td width="46" align="center"><span class="style10">顺序号</span></td>
    <td width="460">&nbsp;<span class="style10">名 称</span></td>
    <td width="40"><div align="center"><span class="style10">类 型</span></div></td>
    <td width="40"><div align="center">

<table border="0">
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
	<td>
      <table style="height:20px" border="0">
          <tr>
            <td width="40px" height="20px" align="center">
<a href="<%=basePath%>admin/hangye/detail.jsp?action=editnode&id=<%=intTradeID%>&intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=intParentID%>&intType=<%=intType %>" target="mainFrame">			
			<img src="<%=basePath%>admin/hangye/images/edit_profile.gif" width="16px" height="16px" border="0" >
</a></td>
            <td width="40" align="center">
<img src="<%=basePath%>admin/hangye/images/delete.gif" style="cursor:hand" width="16px" height="16px" border="0" onClick="del_affirm(<%=intTradeID%>,'<%=strTradeName%>')">
</td></tr>
      </table>
    </td>
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