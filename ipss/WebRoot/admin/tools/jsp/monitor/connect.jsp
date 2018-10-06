<%@ page contentType="text/html; charset=GBK"  errorPage="../../../jsp/error.jsp" %>
<%@ include file="../../../inc/head.jsp" %>
<%  
	String strAbortURL = "../../../html/content.html";
	String strRetryURL = "connect.jsp";	  
	String strErrorFrom = "tools/jsp/monitor/connect.jsp"; //定义错误来源
	String strPowerCheckMethodName = "getManageAdminGrant"; //定义执行权限验证所使用的方法
	ConPool conPool = null;
	
////////////////////////////////////////////////////////////////////
//以下是构造WAS41配置结构操作
////////////////////////////////////////////////////////////////////
try	//统一异常处理
{
%>
	<!--判断管理员是否已经登录-->
	<%@ include file="../../../inc/checkuser.jsp" %>
	<!--判断管理员是否具有管理的权限-->
	<%@ include file="../../../inc/checkpower.jsp" %>
<%
	WASConfig wasConfig = (WASConfig)application.getAttribute("wasconfig");	//获得TRS WAS配置信息对象
	
	MapConPool mapConPool = wasConfig.getMapConPool();
	if(mapConPool==null)
	{
		out.print("所有数据源连接缓冲池的列表不存在！<br>");
		return;
	}	
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
          <td width="505" align="right" valign="top"><span class="14r">当 前 连 接 列 表</span></td>
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
          	当前共有<%=mapConPool.getConPoolSize()%>个连接缓冲池
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="../../../help/channel_jsp_channeltree_userlist_temp.htm" onClick="javaScript:event.returnValue=false;window.open('../../../help/channel_jsp_channeltree_userlist_temp.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
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
      <table cellspacing=0 bordercolordark=#ffffff width="100%" bordercolorlight="#4787b8" border="1">
      <tr bgcolor="#4787b8"> 
        <td width="5%" nowrap><b><font color="#FFFFFF">序号</font></b></td>
        <td width="4%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">ID</font></b></div>
        </td>
        <td width="8%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">连接类型</font></b></div>
        </td>
        <td width="12%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">数据库名</font></b></div>
        </td>
        <td width="8%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">连接IP</font></b></div>
        </td>
        <td width="10%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">最大连接数</font></b></div>
        </td>
        <td width="11%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">最小空闲数</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">当前连接数</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">当前活动数</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">说 明</font></b></div>
        </td>
      </tr>
      <%
	ConPool[] oConPools = mapConPool.getConPools();
	if(oConPools!=null && oConPools.length!=0)
	{
		for(int i=0;i<oConPools.length;i++)
		{
			conPool = oConPools[i];
			if(conPool!=null)
			{
			
%>
      <tr align="center"> 
        <td width="5%" nowrap><%=(i+1)%></td>
        <td width="4%" nowrap><%=conPool.getID()%></td>
        <td width="8%" nowrap><%=AdminTools.parseDataSourceType(conPool.getType())%></td>
        <td width="12%" nowrap><%=Util.getNotNull(conPool.getDataSource().getDBName(),1,"&nbsp;")%></td>
        <td width="8%" nowrap><%=conPool.getDataSource().getIP()%></td>
        <td width="10%" nowrap><%=conPool.getDataSource().getMaxConnect()%></td>
        <td width="11%" nowrap><%=conPool.getDataSource().getMinConnect()%></td>
        <td width="14%" nowrap> <%=conPool.getTotleSize()%></td>
        <td width="14%" nowrap><%=conPool.getActiveSize()%></td>
        <td width="14%" nowrap><%=conPool.getDataSource().getMemo() %>&nbsp;</td>
      </tr>
<%
			}
		}
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
	WASException wase = new WASException("604#内部错误#channeleditor_rdb.jsp#"+e.getMessage()); //构造新的WASException对象
	wase.setAbortURL(strAbortURL);    //设置放弃时回到用户列表页
	wase.setRetryURL(strRetryURL);    //设置重试时回到新建用户页
	session.setAttribute("was_exception",wase);   //将新的异常对象保存到session中，以便在报错页error.jsp中获得
	throw wase;  
}
finally
{
}
%>