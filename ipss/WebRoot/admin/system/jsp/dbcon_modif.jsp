<%@ page contentType="text/html; charset=GBK"  errorPage="../../jsp/error.jsp" %>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<% 
	//��������Դ����
	String ip  = "";//
	String Password = "";//
	int    Port = 0;//
	String User = "";//
	
	TRSSource trssource=new TRSSource(1);
		
	//��ȡ����Դ��Ϣ
	ip = trssource.getTRSServer();//����ԴIP
	Password = trssource.getTRSServerPass();	//����Դ�û�����
	Port = trssource.getTRSServerPort();	//����ԴPort
	User = trssource.getTRSServerUser();//����Դ�û���
	
%>	
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css">
</head>		

<script language="JavaScript" src="../js/checkcon.js"></script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="91%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td valign="top">
      <table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="97%" align="right">
            <table width="316" height="25" border="0" cellpadding="0" cellspacing="0" background="../../images/biaotibg_nolist.gif" class="14r">
              <tr> 
                <td width="505" align="right" valign="top"><span class="14r">ά �� �� �� Դ</span></td>
                <td width="11" valign="top">&nbsp;</td>
                <td width="24" valign="top">&lt;&lt;</td>
              </tr>
            </table>
          </td>
          <td width="3%" align="right">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../images/topbg_nolist.gif">
        <tr> 
          <td width="5%"><img src="../../images/topl_nolist.gif" width="20" height="29"></td>
          <td width="94%" align="right">
            <table width="267" height="29" border="0" cellpadding="0" cellspacing="0" class="12hb">
              <tr> 
              	<td>&nbsp;</td>
                <td width="89" id="idbutton2" align="right" valign="top">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr> 
                      <td align="center" valign="bottom"><a href="../../help/system_jsp_dbcon_modif.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/system_jsp_dbcon_modif.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_nolist.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="1%" align="right"><img src="../../images/topr_nolist.gif" height="29"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
        <tr>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
          <td width="98%">
            <table width="100%" border="1" cellspacing="10" cellpadding="0">
              <form name="form1" method="post" action="dbcon_update.jsp">
              <tr> 
                <td bgcolor="#E3E5E3" valign="top" align="center"> 
                  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                      <tr> 
                        <td align="right">TRS���ݿ������IP��</td>
                        <td>
                          <input type="text" name="ip" size="20" maxlength="20" value="<%=ip%>">
                        </td>
                      </tr>
                      <tr> 
                        <td align="right">TRS���ݿ�������˿ڣ�</td>
                        <td> 
                          <input type="text" name="conport" size="5" maxlength="5" value="<%=Port %>">
                        </td>
                      </tr>
                      <tr> 
                        <td align="right">TRS��¼�û�����</td>
                        <td> 
                          <input type="text" name="conusername" size="20" value="<%=User %>">
                        </td>
                      </tr>
                      <tr> 
                        <td align="right">TRS��¼�û����룺</td>
                        <td> 
                          <input type="password" name="conpassword" size="21" maxlength="22" value="<%=Password %>">
                        </td>
                      </tr>
                      <tr> 
                        <td align="center" colspan="2"><font color="red">������Դ�����޸���С�Ĳ���</font></td>
                      </tr>
                      <tr> 
                        <td align="center" colspan="2"> 
                          <img src="../../images/wancheng.gif" style="cursor:hand"  width="47" height="20" onclick="return checkmodcon();"> 
                          <img src="../../images/reset.gif" style="cursor:hand"  width="47" height="20" onclick="window.form1.reset();"> 
                          <img src="../../images/fangqi.gif" style="cursor:hand"  width="47" height="20" onclick="javaScript:window.close();"> 
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
               </form>
             </table>
          </td>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="23" border="0" cellpadding="0" cellspacing="0" background="../../images/topb_nolist.gif">
        <tr> 
          <td width="27%"><img src="../../images/bl_nolist.gif" width="20" height="23"></td>
          <td align="right"><img src="../../images/br_nolist.gif" width="21" height="23"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
