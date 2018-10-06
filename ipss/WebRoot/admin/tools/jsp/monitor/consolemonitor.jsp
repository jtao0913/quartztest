<%@ page contentType="text/html; charset=GBK" errorPage="../../../jsp/error.jsp"%>
<%@ include file="../../../inc/head.jsp" %>
<%
	//清掉Jsp页面缓存
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	
	//设置参数
	int siteID = 0;
	ConPool conPool = null;
	String userName = null;
	String userPassword = null;
	String strAbortURL = "connect.jsp";
	String strRetryURL = "consolemonitor.jsp";
	String strErrorFrom = "tools/jsp/monitor/consolemonitor.jsp"; //定义错误来源
	String strPowerCheckMethodName = "getManageLogSourceGrant"; //定义执行权限验证所使用的方法

	try //统一异常处理
	{
%>
		<!--判断管理员是否已经登录-->
		<%@ include file="../../../inc/checkuser.jsp" %>
		<!--判断管理员是否具有管理的权限-->
		<%@ include file="../../../inc/checkpower.jsp" %>
<%
		MapLoginusers mapLoginusers = (MapLoginusers)application.getAttribute("mapLoginusers");
		if (mapLoginusers == null)
		{
			mapLoginusers = new MapLoginusers();
			application.setAttribute("mapLoginusers",mapLoginusers);
		}
		
		UserMessage userMessage1 = (UserMessage)session.getAttribute("userMessage");//当前用户
		if (userMessage1 == null)
		{
			throw new  WASException("5000#未登录或者登录超时#UserMessage#未登录或者登录超时（session为空或者session超时）");
		}
		
		//System.out.println("----------------------------get UserMessage sucess");
		if (!userMessage1.getUserState())//检验用户状态
		{
		   userMessage1.setMapLoginUser(mapLoginusers);
		   userMessage1.removeUserFromLoginusers();
		   session.removeAttribute("userMessage");
		   throw new WASException("600#当前登录无效#UserMessage#由于非法登录或者被管理员拒绝登录");
		}
		
		//System.out.println("----------------------------get site message sucess");
		Enumeration enumUsers = mapLoginusers.getUsers();	//获取当前所有用户列表
%>
<html>
<head>
<title>TRS内容分发服务器（CDS） V4.5</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0 ; charset=GBK">
<meta http-equiv="refresh" content="15;URL=">
<link rel="stylesheet" href="../../../css/style.css">
<link rel="stylesheet" href="../../../css/cds_style.css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">登 录 用 户 列 表</span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
          	<table width="100%" height="4" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          		<tr>
          			<td height="4"></td>
          		</tr>
          	</table>
            <table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="7%" align="left" valign="top"><img src="../../../images/tl_list.gif" width="20" height="28"></td>
                <td width="93%">
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="center" align="left">
          	当前共有<%=mapLoginusers.userQuantity()%>个用户登录管理台
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="../../../help/tools_jsp_monitor_consolemonitor.htm" onClick="javaScript:event.returnValue=false;window.open('../../../help/tools_jsp_monitor_consolemonitor.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
        <tr> 
          <td height="20" align="right">
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
      <table  cellspacing=0 cellpadding="0"  bordercolordark=#ffffff width="100%" bordercolorlight="#4787b8" border="1">
    <TR bgcolor="#4787b8" align="center"> 
      <TD><b><font color="#FFFFFF">用户ID</font></b></TD>
      <TD><b><font color="#FFFFFF">用户名</font></b></TD>
      <TD><b><font color="#FFFFFF">登录IP</font></b></TD>
      <TD><b><font color="#FFFFFF">登录时间</font></b></TD>
      <TD><b><font color="#FFFFFF">说明</font></b></TD>
      <TD><b><font color="#FFFFFF">状态</font></b></TD>
      <TD><b><font color="#FFFFFF">操作</font></b></TD>
    </TR>
    <% 
		while (enumUsers.hasMoreElements())
		{
			
			UserMessage userMessage = (UserMessage)enumUsers.nextElement();//取出对应
			//System.out.println("---------------------------- User ID is "+userMessage.getUserID());
			//System.out.println("---------------------------- User ID is "+userMessage.getUserID());
			out.print("<TR>\n");
			out.print("<TD  align=\"center\">"+userMessage.getUserID()+"</TD>\n");
			out.print("<TD  align=\"center\"><A HREF=\"/admin/usermanager/jsp/updateuser.jsp?id="+userMessage.getUserID()+"\" target=\"_blank\">"+userMessage.getUserName()+"</A></TD>\n");
			out.print("<TD  align=\"center\">"+userMessage.getUserIP()+"</TD>\n");
			out.print("<TD  align=\"center\">"+userMessage.getLoginTime()+"</TD>\n");
			String Memo = "&nbsp;";
			if (!userMessage.getUserMemo().equals(""))
			{
				Memo = userMessage.getUserMemo();
			}
			out.print("<TD  align=\"center\">"+Memo+"</TD>\n");
			String State = "可用";
			if (!userMessage.getUserState())
			{
				State ="禁止";
			}
			out.print("<TD  align=\"center\">"+State+"</TD>\n");
			out.print("<TD  align=\"center\"><A HREF=\"signuser.jsp?sid="+userMessage.getSessionId()+"\">更改用户状态</A></TD>\n");
			out.print("</TR>\n");
		}
%>
  </table>
    </td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg1_list.gif">
  <tr> 
    <td width="58%" valign="top">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%
	}
	catch(WASException wase)
	{
		wase.setAbortURL(strAbortURL);    //设置放弃时回到用户列表页
		wase.setRetryURL(strRetryURL);    //设置重试时回到新建用户页
		session.setAttribute("was_exception",wase);  
		throw wase;  
	}
	catch(Exception e)
	{
		// 统一异常处理 处理错误部分
		WASException wase = new WASException("604#内部错误#consolemonitor.jsp#"+e.getMessage()); //构造新的WASException对象
		wase.setAbortURL(strAbortURL);    //设置放弃时回到用户列表页
		wase.setRetryURL(strRetryURL);    //设置重试时回到新建用户页
		session.setAttribute("was_exception",wase);   //将新的异常对象保存到session中，以便在报错页error.jsp中获得
		throw wase;  
	}
	finally
	{
	}
%>