<%@ page contentType="text/html; charset=utf-8" errorPage="../common/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
     String strGroupID=request.getParameter("groupid");
	 int    intGroupID=Integer.parseInt(strGroupID);
	 GroupManage groupmanage=new GroupManage(intGroupID);
	 Grant  grant=new Grant();
	 grant.setAll();
	 int    count=0;
	 count=grant.getCount();
	 String strGrantNames[]=grant.getGrantNames();
	 int    intGrantIDs[]=grant.getGrantIDs();
	 String strGroupName=groupmanage.getGroupName();
	 String strGroupMemo=groupmanage.getGroupMemo();
	 String strGroupGrants[]=groupmanage.getGroupGrants();
	 int    intItemGrants[]=groupmanage.getItemGrants();
%>

<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<SCRIPT language="javascript">
<!--
function checkform()
{
	var s = document.all.form1.groupname.value;
	if( s.charAt(0)==" "||s=="" || s.length>128)
	{
		alert("组名不能为空,<128字符并且组名前不能有空格！");
		document.all.form1.groupname.focus();
		return false; 
	}
	
	form1.submit();
}
-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/was_07.gif">
<table width="100%" border="1" cellspacing="0" cellpaddint="0" bgcolor="#EBEBEB" bordercolorlight="#4787B8" bordercolordark="#FFFFFF">
 <form name="form1" method="post" action="updategroupsubmit.jsp" onSubmit="return checkform()";>
 <input type="hidden" name="groupid" value="<%=strGroupID%>">
	<tr bgcolor="#4787B8">
	  <td align="center" colspan="2" height="25"><span class="14r" style="color:#FFFFFF">修改用户组：<%=strGroupName%></span>
	  </td>
	</tr>
	<tr> 
      <td align="right">用户组名称：</td>
      <td nowrap><input type="text" name="groupname" size="15" value="<%=strGroupName%>">(<font color="red">*</font>请给出 128 字符以内的字符串)
      </td>
    </tr>
    <tr >
      <td align="right" valign="middle">用户组权限：</td>
      <td><select size="16" multiple name="opers" style="width=360">
	 <%
	    for(int i=0;i<count;i++)
		{
	 %>
        <option value="<%=intGrantIDs[i]%>" <%for(int j=0;j<intItemGrants.length;j++) if(intItemGrants[j]==intGrantIDs[i]) out.println("selected");%>><%=strGrantNames[i]%></option>
	 <%
	    }
	 %>
      </select></td>
    </tr>
    <tr > 
      <td align="right" width="30%" valign="top">用户组说明：</td>
      <td><textarea name="memo" cols="35" rows="3"><%=strGroupMemo%></textarea>
      </td>
    </tr>
    <tr height="20"> 
      <td align="center" colspan="2">
        <a onclick="javascript:checkform();" style="cursor:hand;"><img src="../../../images/ok_blue.gif" border="0"></a>
        <a onclick="javascript:self.close();" style="cursor:hand;"><img src="../../../images/cancel_blue.gif" border="0"></a>
		<a href="../../../help/usermanager_jsp_group_updategroup.jsp" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_updategroup.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_blue.gif" border="0"></a>
	  </td>
    </tr>
  </form>
</table>
</center>
</body>
</html>
