<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"  %>
<%@ page import="com.trs.usermanage.*"%>

<%

	//������������ò���
        SMTPSource smtpsource=new SMTPSource(1);	//�ʼ�����������Դ
	String SMTPServer ="";			//SMTP��������ַ
	int    SMTPServerPort =0;		//SMTP�������˿ں�
	String SMTPServerUser ="";		//SMTP��������¼�û���
	String SMTPServerPass = "";  		//SMTP��������¼�û�����
	int    SMTPServerVerify=0;		//SMTP�������Ƿ���Ҫ�û���֤
	String SMTPReplyMailAddress="";		//�ʼ��ظ���ַ

        SMTPServer=smtpsource.getSMTPServer();
        SMTPServerPort=smtpsource.getSMTPServerPort();
        SMTPServerUser=smtpsource.getSMTPServerUser();
        SMTPServerPass=smtpsource.getSMTPServerPass();
        SMTPServerVerify=smtpsource.getSMTPVerify();
        SMTPReplyMailAddress=smtpsource.getSMTPReplyAddress();
%>
<!-- ҳ����� -->
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css">
<script language="javascript">
function copyname()
{
	document.all.sysform.SitePath.value="/"+document.all.sysform.SiteName.value.toLowerCase();
}
</script>
</head>

<script language="JavaScript" src="../js/sysinfocheck.js"></script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="91%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td valign="top">
      <table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="97%" align="right">
            <table width="316" height="25" border="0" cellpadding="0" cellspacing="0" background="../../images/biaotibg_nolist.gif" class="14r">
              <tr> 
                <td width="505" align="right" valign="top"><span class="14r">��Ŀ���Բ�������</span></td>
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
          <td width="94%" align="left">
            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" class="12hb">
              <tr> 
                <td id="idbutton1" width="89" align="right" valign="top" background="../../images/topbutl_nolist.gif">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr>
                      <td align="center" valign="bottom" background="../../images/topbutl_nolist.gif">�ʼ�����������</td>
                    </tr>
                  </table>
                </td>
                <td>&nbsp;</td>
                <td width="89" id="idbutton5" align="right" valign="top">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr> 
                      <td align="center" valign="bottom"><a href="../../help/project_jsp_updateproject.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/project_jsp_updateproject.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_nolist.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="1%" align="right"><img src="../../images/topr_nolist.gif" height="29"></td>
        </tr>
      </table>
      <table width="100%" height="273" border="0" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
        <form name="sysform" method="post" action="updateprojectsubmit.jsp">
        <tr>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
          <td width="98%" valign="top">
            <!--����������ҳ��-->
            <table border="0" cellspacing="2" id="serverconfig" style="display:block;" cellpadding="2" width="100%">
              <tr> 
                 <td align="right" width="50%">SMTP��������ַ��</td>
                 <td colspan="3" align="left"> 
                   <input type="text" name="SMTPServer" size="20" maxlength="128" value="<%=SMTPServer%>">
				 </td>
               </tr>
              <tr> 
                 <td align="right" width="50%">SMTP�������˿ڣ�</td>
                 <td colspan="3" align="left"> 
                   <input type="text" name="SMTPServerPort" size="20" maxlength="128" value="<%=SMTPServerPort%>">
				 </td>
               </tr>
               <tr>
                 <td align="right" width="50%">�ʼ��������ʺţ�</td>
                 <td colspan="3" align="left"> 
                   <input type="text" name="SMTPServerUser" size="20" maxlength="128" value="<%=SMTPServerUser%>">
                 </td>
               </tr>
               <tr> 
                 <td align="right" width="50%">�ʼ����������룺</td>
                 <td colspan="3" align="left"> 
                   <input type="password" name="SMTPServerPass" size="21" maxlength="128" value="<%=SMTPServerPass%>">
                 </td>
               </tr>
               <tr>
                 <td align="right" width="50%">��¼��ʽ��</td>
                 <td width="20%"><input type="radio" name="SMTPServerVerify" value="1" <%if(SMTPServerVerify==1) out.print("checked");%>>��ҪSMTP��֤</td>
                 <td width="17%"><input type="radio" name="SMTPServerVerify" value="2" <%if(SMTPServerVerify==2) out.print("checked");%>>����ҪSMTP��֤</td>
               </tr>
               <tr> 
                 <td align="right" width="50%">�ʼ��ظ���ַ��</td>
                 <td colspan="3" align="left"> 
                   <input type="text" name="SMTPReplyMailAddress" size="21" maxlength="128" value="<%=SMTPReplyMailAddress%>">
                 </td>
               </tr>
               
                <tr> 
                  <td align="center" colspan="4"> 
                    <img src="../images/wancheng.gif" style="cursor:hand"  width="47" height="20" onClick="return docheck();"> 
                    <img src="../images/reset.gif" style="cursor:hand"  width="47" height="20" onclick="window.sysform.reset();"> 
                  </td>
                </tr>
             </table>
          </td>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
        </tr>
        </form>
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
