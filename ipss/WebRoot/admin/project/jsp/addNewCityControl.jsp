<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
	//清掉Jsp页面缓存
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	
	String  ipMemo=request.getParameter("IPMemo");
	String  ipRange=request.getParameter("IPRange");
	if(ipMemo!=null)
	{
	  ipMemo=new String(ipMemo.getBytes("8859_1"),"GBK");
	  ipRange=new String(ipRange.getBytes("8859_1"),"GBK");
	}
	if(ipMemo==null||ipMemo.equals(""))
	{
	}
	else
	{
	   IPLimit iplimit=new IPLimit();
	   int     addok=iplimit.addNewIPLimit(ipMemo,ipRange);
	   if(addok==-2)
	   {
	     response.sendRedirect("iperror.jsp?act=addsame");
	   }
	   if(addok==-1)
	   {
	     response.sendRedirect("iperror.jsp?act=add");
	   }
	   response.sendRedirect("useCityIPLimit.jsp");
	}
%>
<script>
<!--//
function onCheck()
{
    if(document.addnewcitycontrol.IPMemo.value==""||document.addnewcitycontrol.IPRange.value=="")
	{
	    alert("请将信息填写完整！");
		return false;
	}
	document.addnewcitycontrol.submit();
	return true;
}
//-->
</script>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0 ; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css" type="text/css">

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">城域网控制</span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
          	<table width="100%" height="4" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          		<tr>
          			<td height="4"></td>
          		</tr>
          	</table>
            <table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="7%" align="left" valign="top"><img src="../../images/tl_list.gif" width="20" height="28"></td>
                <td width="93%"> 
                  <table width="350" height="23" border="0" cellpadding="0" cellspacing="0" class="12green">
					<tr> 
                        
                      <td><b>添加城域网控制段</b></td>
                        <td width="68">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="top">
            <table width="361" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr align="left">
              	<td width="20">&nbsp;</td>
              	<td width="236" height="18">&nbsp;
              		
                </td>
                <td width="105" >&nbsp; 
                  
                </td>          
			  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="../../help/project_jsp_listsite.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/project_jsp_listsite.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_list.gif" height="32" border="0"></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
        <tr> 
          <td height="20" align="right" valign="top">
            <table width="220" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
              <tr>       
                <td align="right" valign="top">
                  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td></td>
                    </tr>
                  </table>

                </td>
              </tr>
            </table>
          </td>
          <td height="20">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">
	<form name="addnewcitycontrol" method="get" action="addNewCityControl.jsp">
	 <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="40%" height="25"><div align="right">IP段说明：</div></td>
          <td width="60%" height="25"><input name="IPMemo" type="text" size="50"></td>
        </tr>
        <tr>
          <td height="25"><div align="right">IP段范围：</div></td>
          <td height="25"><input name="IPRange" type="text" size="50"></td>
        </tr>
      </table>
        <p> 
          <input type="submit" name="ok" value="添 加" onClick="onCheck();return false;">
          <input type="reset" name="cancel" value="取 消">
          <input type="button" name="back" value="返 回" onClick="javascript:history.back();">
        </p>
      </form>
	  </td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" background="../../images/bg1_list.gif">
  <tr> 
    <td width="58%" valign="top">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">&nbsp;
            
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top"></td>
  </tr>
</table>
</body>
</html>
