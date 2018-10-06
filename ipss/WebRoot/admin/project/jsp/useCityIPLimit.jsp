<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%@ page import="com.trs.usermanage.*"%>
<%
	//清掉Jsp页面缓存
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	
	IPLimit iplimit=new IPLimit(1);
	String  ipRanges[]=iplimit.getIPRanges();
	String  ipMemos[]=iplimit.getIPMemos();
	int     count=iplimit.getCount();
	
%>
	
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
                        <td>&nbsp;</td>
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
          <td width="96%" height="32" align="right"><a href="updateproject.jsp?type=1" onClick="javaScript:event.returnValue=false;window.location='addNewCityControl.jsp';"><img src="../../images/xjxm.gif" height="32" border="0"></a><a href="../../help/project_jsp_listsite.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/project_jsp_listsite.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_list.gif" height="32" border="0"></a></td>
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
      <table width="100%" bordercolordark="#ffffff" bordercolorlight="#4787B8" border="1" cellpadding="0" cellspacing="0">
        	<tr bgcolor="#4787B8" align="center"> 
        	  <td width="7%" height="2" ><font color="#FFFFFF"><b>序 号</b></font></td>
		  	  <td width="15%" height="2" ><font color="#FFFFFF"><b>IP段说明</b></font></td>
		  	  <td width="58%" height="2" ><font color="#FFFFFF"><b>IP范围</b></font></td>
	          <td width="10%" height="2" ><font color="#FFFFFF"><b>维 护</b></font></td>
	          <td width="10%" height="2" ><font color="#FFFFFF"><b>删 除</b></font></td>
           	</tr>
               <%
                for(int i=0;i<count;i++)
                {
               %>
		<tr bgcolor="" align="center"> 
		  <td width="7%"><ol start=<%=i+1%>><li>&nbsp;</td>
	          <td height="15" width="15%"><%=ipMemos[i]%></td>
                  <td width="58%" height="25" align="center"><%=ipRanges[i]%></td>
	          <td width="10%" height="2" ><a href="a" onclick="javaScript:event.returnValue=false;if(confirm('真的要修改指定项目的配置信息吗?')){window.location='mendCityControl.jsp?IPMemo=<%=ipMemos[i]%>';}" ><img src="../../images/icon_edit.gif" border="0" style="cursor:hand;"></A></td>
	          <td height="25" width="10%"><a  href="a" onclick="javaScript:event.returnValue=false;if(confirm('真的要删除指定的项目吗?')){window.location='deleteCityControl.jsp?ipMemo=<%=ipMemos[i]%>';}" ><img src="../../images/icon_edit.gif" border="0" style="cursor:hand;"></A></td>
               </tr>
              <%
               }
              %>
      </table>
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
