<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
	 Grant  grant=new Grant();
	 grant.setAll();
	 int    count=0;
	 count=grant.getCount();
	 String strGrantNames[]=grant.getGrantNames();
	 int    intGrantIDs[]=grant.getGrantIDs();
%>
<html>
<head>
<title>TRS内容分发服务器（CDS） V4.5</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
	var selectgrant=false;
	for (i=0;i<document.all.opers.length;i++)
   {
	if(document.all.opers[i].selected == true)
	{
	   selectgrant=true;
	}
   }
   if(selectgrant==false)
   {
       alert("至少要选择一个权限");
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
                  加 用 户 组</span></b></td>
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
                <td id="idbutton1" width="122" align="right" valign="top" background="../../../images/topbut_7_nolist.gif" onmouseout="javaScript:document.all.idbutton1.background='../../../images/topbut_7_nolist.gif';" onmouseover="javaScript:document.all.idbutton1.background='../../../images/topbutl_7_nolist.gif';">
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
              <form name="form1" method="post" action="addgroupsubmit.jsp">
                <tr> 
                  <td align="right" width="35%" height="25">用户组名称：</td>
                  <td> 
                    <input type="text" name="groupname" maxlength="128"size="15">(<font color="red">*</font>请给出 128 字符以内的字符串)
                  </td>
                </tr>
<Script>
function selectall()
{
for (i=0;i<document.all.opers.length;i++)
{
	document.all.opers[i].selected = true;
}
}
</Script>
                <tr> 
                  <td align="right" width="35%" height="25">用户组权限：<BR><BR><input type="button" value="全选" onclick="selectall();"></td>
                  <td> 
                   <select size="16" multiple name="opers" style="width=360">
	 <%
	    for(int i=0;i<count;i++)
		{
	 %>
        <option value="<%=intGrantIDs[i]%>"><%=strGrantNames[i]%></option>
	 <%
	    }
	 %>
      </select>
                  </td>
                </tr>
                <tr> 
                  <td align="right" width="35%" valign="top">用户组说明：</td>
                  <td> 
                  <textarea name="memo" cols="35" rows="6"></textarea>
                  </td>
                </tr>
                <tr height="25"> 
                    <td align="center" colspan="2">
                      <a onclick="javascript:checkform();" style="cursor:hand;"><img src="../../../images/ok_blue.gif"></a>
                      <a onclick="javascript:self.close();" style="cursor:hand;"><img src="../../../images/cancel_blue.gif"></a>
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

