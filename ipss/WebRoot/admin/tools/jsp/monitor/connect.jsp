<%@ page contentType="text/html; charset=GBK"  errorPage="../../../jsp/error.jsp" %>
<%@ include file="../../../inc/head.jsp" %>
<%  
	String strAbortURL = "../../../html/content.html";
	String strRetryURL = "connect.jsp";	  
	String strErrorFrom = "tools/jsp/monitor/connect.jsp"; //���������Դ
	String strPowerCheckMethodName = "getManageAdminGrant"; //����ִ��Ȩ����֤��ʹ�õķ���
	ConPool conPool = null;
	
////////////////////////////////////////////////////////////////////
//�����ǹ���WAS41���ýṹ����
////////////////////////////////////////////////////////////////////
try	//ͳһ�쳣����
{
%>
	<!--�жϹ���Ա�Ƿ��Ѿ���¼-->
	<%@ include file="../../../inc/checkuser.jsp" %>
	<!--�жϹ���Ա�Ƿ���й����Ȩ��-->
	<%@ include file="../../../inc/checkpower.jsp" %>
<%
	WASConfig wasConfig = (WASConfig)application.getAttribute("wasconfig");	//���TRS WAS������Ϣ����
	
	MapConPool mapConPool = wasConfig.getMapConPool();
	if(mapConPool==null)
	{
		out.print("��������Դ���ӻ���ص��б����ڣ�<br>");
		return;
	}	
%>
<html>
<head>
<title>TRS���ݷַ���������CDS�� V4.5</title>
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
          <td width="505" align="right" valign="top"><span class="14r">�� ǰ �� �� �� ��</span></td>
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
          	��ǰ����<%=mapConPool.getConPoolSize()%>�����ӻ����
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
        <td width="5%" nowrap><b><font color="#FFFFFF">���</font></b></td>
        <td width="4%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">ID</font></b></div>
        </td>
        <td width="8%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">��������</font></b></div>
        </td>
        <td width="12%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">���ݿ���</font></b></div>
        </td>
        <td width="8%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">����IP</font></b></div>
        </td>
        <td width="10%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">���������</font></b></div>
        </td>
        <td width="11%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">��С������</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">��ǰ������</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">��ǰ���</font></b></div>
        </td>
        <td width="14%" nowrap> 
          <div align="center"><b><font color="#FFFFFF">˵ ��</font></b></div>
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
	wase.setAbortURL(strAbortURL);    //���÷���ʱ�ص��û��б�ҳ
	wase.setRetryURL(strRetryURL);    //��������ʱ�ص��½��û�ҳ
	session.setAttribute("was_exception",wase);  
	throw wase;  
}
catch(Exception e)
{
	WASException wase = new WASException("604#�ڲ�����#channeleditor_rdb.jsp#"+e.getMessage()); //�����µ�WASException����
	wase.setAbortURL(strAbortURL);    //���÷���ʱ�ص��û��б�ҳ
	wase.setRetryURL(strRetryURL);    //��������ʱ�ص��½��û�ҳ
	session.setAttribute("was_exception",wase);   //���µ��쳣���󱣴浽session�У��Ա��ڱ���ҳerror.jsp�л��
	throw wase;  
}
finally
{
}
%>