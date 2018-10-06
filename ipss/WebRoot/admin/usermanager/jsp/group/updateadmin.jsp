<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //用户当前登录对象
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("您的登录已经失效！");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
	String strAdminID=request.getParameter("adminid");
	int    intAdminID=Integer.parseInt(strAdminID);
	AdminManage adminmanage=new AdminManage(intAdminID);
	String adminName=adminmanage.getAdministratorName();
	String allowIP=adminmanage.getAllowIP();
	String adminMemo=adminmanage.getAdministratorMemo();
	
	String adminRight=adminmanage.getAdministratorRight();	//取出这个管理员的权限
	String AdminRightItems[];
	AdminRightItems=Tools.splitString(adminRight,",");
	
	AdminRight adminright=new AdminRight();
	int		rightIDs[]=adminright.getIntIDs();
	String	rightNames[]=adminright.getChrRightNames();
	int		count=adminright.getIntCount();
	
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<SCRIPT language="javascript">
<!--
function checkform()
{
	var s = document.all.form1.adminname.value;
	if( s.charAt(0)==" "||s=="" || s.length>128)
	{
		alert("组名不能为空,<128字符并且组名前不能有空格！");
		document.all.form1.adminname.focus();
		return false; 
	}
	
	document.all.form1.submit();
}
-->
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="91%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td valign="top"> 
      <table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="97%" align="right">
            <table width="316" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_nolist.gif" class="14r">
              <tr> 
                <td width="505" align="right" valign="top"><b><span class="14r">添 
                  加 管 理 员 用 户</span></b></td>
                <td width="11" valign="top"><b></b></td>
                <td width="24" valign="top"><b>&lt;&lt;</b></td>
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
            <table width="267" height="29" border="0" cellpadding="0" cellspacing="0" class="12hb">
              <tr> 
              	<td>&nbsp;</td>
                <td id="idbutton1" width="122" align="right" valign="top" onmouseout="javaScript:document.all.idbutton1.background='../../../images/topbut_7_nolist.gif';" onmouseover="javaScript:document.all.idbutton1.background='../../../images/topbutl_7_nolist.gif';">
                  <table width="122" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr>
                      <td align="center" valign="bottom">&nbsp;</td>
                    </tr>
                  </table>
                </td>
                <td width="89" id="idbutton2" align="right" valign="top">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr> 
                      <td align="center" valign="bottom"><a href="../../../help/usermanager_jsp_group_addgroup.jsp" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_addgroup.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_nolist.gif"></a></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
          <td width="1%" align="right"><img src="../../../images/topr_nolist.gif" height="29"></td>
        </tr>
      </table>
      <table width="100%" height="273" border="0" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
        <tr>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
          <td width="98%">
            <table width="100%" border="1" height="100%" cellspacing="0" cellpadding="0" bordercolordark="#ffffff" bordercolorlight="a8c5e2">
              <form name="form1" method="post" action="updateadminsubmit.jsp">
			  <input type="hidden" name="adminid" value="<%=strAdminID%>">
                <tr> 
                  <td align="right" width="35%" height="25">管理员名称：</td>
                  <td> 
                    <input type="text" name="adminname" maxlength="128"size="15" value="<%=adminName%>" <%if(adminName.equals("admin")) {%> readonly="true"<%}%>>
                    (<font color="red">*</font>) </td>
                </tr>
                <tr> 
                  <td align="right" width="35%" height="25">管理员密码：<BR></td>
                  <td><input type="password" name="adminpassword" maxlength="128"size="15">                    (<font color="red">*</font>)                  </td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle">密码确认：</td>
                  <td><input type="password" name="readminpassword" maxlength="128"size="15">
                  (<font color="red">*</font>) </td>
                </tr>
				<tr>
                  <td height="25" align="right" valign="middle">管理员IP地址：</td>
                  <td><input type="text" name="adminIP" maxlength="128"size="15" value="<%=allowIP%>">
                  (<font color="red">*</font>) </td>
                </tr>
<tr>
				 <td align="right" width="35%" valign="top">管理员权限：</td>
				<td>
				<%				
				if(adminName.equals("admin")){
				%>
<select size="6" multiple name="adminRight" style="width=360">
<%
}else
{
%>
<select size="6" multiple name="adminRight" style="width=360">
<%
}	 
	    for(int i=0;i<count;i++)
		{
	 %>
        <option value="<%=rightIDs[i]%>" 
		<%
		for(int j=0;j<AdminRightItems.length;j++) 
		{	if(Integer.parseInt(AdminRightItems[j])==rightIDs[i]) 
				out.println("selected");
		}		
		%>><%=rightNames[i]%>
		</option>
	 <%
	    }
	 %>
</select>
				</td>
				</tr>				
                <tr> 
                  <td align="right" width="35%" valign="top">管理员用户说明：</td>
                  <td> 
                  <textarea name="memo" cols="35" rows="6"><%=adminMemo%></textarea>
                  </td>
                </tr>
                <tr height="25"> 
                    <td align="center" colspan="2">
                      <a onclick="javascript:checkform();" style="cursor:hand;"><img src="../../../images/ok_blue.gif"></a>
                      <a onclick="javascript:window.close();" style="cursor:hand;"><img src="../../../images/cancel_blue.gif"></a>
					</td>
                </tr>
                <tr>
                	<td colspan="2" height="100%"></td>
                </tr>
              </form>
            </table>
          </td>
          <td width="1%" bgcolor="A8C5E2">&nbsp;</td>
        </tr>
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