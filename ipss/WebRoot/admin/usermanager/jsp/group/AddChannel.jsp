<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //�û���ǰ��¼����
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("���ĵ�¼�Ѿ�ʧЧ��");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
    String   channelName=request.getParameter("channelName");
	String   trsTable=request.getParameter("trsTable");
	String   channelType=request.getParameter("channelType");
	String   searchset=request.getParameter("searchset");
	String   digestprint=request.getParameter("digestprint");
	String   digestdownload=request.getParameter("digestdownload");
	String   general=request.getParameter("general");
	String   fulltextprint=request.getParameter("fulltextprint");
	String   fulltextdownload=request.getParameter("fulltextdownload");
	String   detail=request.getParameter("detail");
	String   fulltextread=request.getParameter("fulltextread");
	String   lawstatus=request.getParameter("lawstatus");
	String   channelMemo=request.getParameter("channelMemo");
	int      addok=0;
	if(channelName!=null)
	{
	        Resource resource=new Resource();
		int  intChannelType=Integer.parseInt(channelType);
		channelName=new String(channelName.getBytes("8859_1"),"GBK");
		trsTable=new String(trsTable.getBytes("8859_1"),"GBK");
		channelMemo=new String(channelMemo.getBytes("8859_1"),"GBK");
		addok=resource.addNewChannel(channelName,intChannelType,trsTable,channelMemo,searchset,digestprint,digestdownload,general,fulltextprint,fulltextdownload,detail,fulltextread,lawstatus);
	        if(addok==-1)
		{
%>
<jsp:forward page="channelerror.jsp?act=add"/>
<%		}
		if(addok==-2)
		{
%>
<jsp:forward page="channelerror.jsp?act=addsame"/>
<%
		}
		response.sendRedirect("ChannelList.jsp");
	}
%>
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<SCRIPT language="javascript">
<!--
function checkform()
{
	var s = document.all.form1.channelName.value;
	if(s=="")
	{
	   alert("��Դ���Ʋ��ܿգ�");
	   return false;
	}
    if(document.form1.trsTable.value=="")
	{
	   alert("TRS���ܿգ�");
	   return false;
	}
	if(document.form1.searchset.value==""||document.form1.digestprint.value==""||document.form1.digestdownload.value==""||document.form1.general.value==""||document.form1.fulltextprint.value==""||document.form1.fulltextdownload.value==""||document.form1.detail.value==""||document.form1.fulltextread.value==""||document.form1.lawstatus.value=="")
	{
	   alert("�Ʒ����ò���Ϊ�գ�");
	   return false;
	}
	var search_data=document.form1.searchset.value;
	var digestprint=document.form1.digestprint.value;
	var digestdownload=document.form1.digestdownload.value;
	var general=document.form1.general.value;
	var fulltextprint=document.form1.fulltextprint.value;
	var fulltextdownload=document.form1.fulltextdownload.value;
	var detail=document.form1.detail.value;
	var fulltextread=document.form1.fulltextread.value;
	var lawstatus=document.form1.lawstatus.value;
	if(!isdigital(search_data)||!isdigital(digestprint)||!isdigital(digestdownload)||!isdigital(general)||!isdigital(fulltextprint)||!isdigital(fulltextdownload)||!isdigital(detail)||!isdigital(fulltextread)||!isdigital(lawstatus))
	{
	   alert("�ƷѼ۸����Ϊ���֣�");
	   return false;
	}
	document.all.form1.submit();
}

function isdigital(data)
{
  var char;
  for(var i=0;i<data.length;i++)
  {
	char=data.charAt(i);
	if(!('0'<=char&&char<='9'))
	{
		return false;
	}
	else
	{
	    return true;
	}
  }
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
                <td width="505" align="right" valign="top"><b><span class="14r">�� 
                  �� �� Դ</span></b></td>
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
                      <td align="center" valign="bottom"><a href="ChannelList.jsp" style="color:#FF0000">������Դ�����б�</a></td>
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
              <form name="form1" method="get" action="AddChannel.jsp">
                <tr> 
                  <td align="right" width="35%" height="25">��Դ���ƣ�</td>
                  <td> 
                    <input type="text" name="channelName" maxlength="128"size="15">
                    (<font color="red">*</font>) </td>
                </tr>
                <tr> 
                  <td align="right" width="35%" height="25">��ӦTRS���ݱ�<BR></td>
                  <td><input type="text" name="trsTable" maxlength="128"size="15">                    (<font color="red">*</font>)                  </td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle">��Դ���ͣ�</td>
                  <td>                  <select name="channelType">
                    <option selected value="0">����</option>
                    <option value="1">����</option>
                  </select>
                  (<font color="red">*</font>) </td>
                </tr>
				<tr>
                  <td height="25" align="right" valign="middle">Ȩ�޼��Ʒ����ã�</td>
                  <td><table width="100%" border="0">
                      <tr>
                        <td>������
                          <input name="searchset" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>��ժ��ӡ��
                          <input name="digestprint" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>��ժ���أ�
                          <input name="digestdownload" type="text" size="4" value="0">
                          Ԫ</td>
                      </tr>
                      <tr>
                        <td>������
                          <input name="general" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>ȫ�Ĵ�ӡ��
                          <input name="fulltextprint" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>ȫ�����أ�
                          <input name="fulltextdownload" type="text" size="4" value="0">
                          Ԫ</td>
                      </tr>
                      <tr>
                        <td>ϸ����
                          <input name="detail" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>ȫ���Ķ���
                          <input name="fulltextread" type="text" size="4" value="0">
                          Ԫ</td>
                        <td>����״̬��
                          <input name="lawstatus" type="text" size="4" value="0">
                          Ԫ</td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td align="right" width="35%" valign="top">��Դ˵����</td>
                  <td> 
                  <textarea name="channelMemo" cols="35" rows="6"></textarea>
                  </td>
                </tr>
                <tr height="25"> 
                    <td align="center" colspan="2">
                      <a onclick="javascript:checkform();" style="cursor:hand;"><img src="../../../images/ok_blue.gif"></a>
                      <a onclick="javascript:history.go(-1);" style="cursor:hand;"><img src="../../../images/cancel_blue.gif"></a>
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
