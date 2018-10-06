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
        String   channelID=request.getParameter("channelID");
        String   channelName=request.getParameter("channelName");
        String   channelName_disp=null;
        String   trsTable=request.getParameter("trsTable");
        String   trsTable_disp=null;
        String   channelType=request.getParameter("channelType");
        int      channelType_disp=0;
        String   channelMemo=request.getParameter("channelMemo");
        String   channelMemo_disp=null;
		String   searchset=request.getParameter("searchset");
		int      searchset_disp=0;
		String   digestprint=request.getParameter("digestprint");
		int      digestprint_disp=0;
		String   digestdownload=request.getParameter("digestdownload");
		int      digestdownload_disp=0;
		String   general=request.getParameter("general");
		int      general_disp=0;
		String   fulltextprint=request.getParameter("fulltextprint");
		int      fulltextprint_disp=0;
		String   fulltextdownload=request.getParameter("fulltextdownload");
		int      fulltextdownload_disp=0;
		String   detail=request.getParameter("detail");
		int      detail_disp=0;
		String   fulltextread=request.getParameter("fulltextread");
		int      fulltextread_disp=0;
		String   lawstatus=request.getParameter("lawstatus");
		int      lawstatus_disp=0;
        int      intChannelID=Integer.parseInt(channelID);
        Resource resource=new Resource();
        if(channelName==null)
        {
           resource.setSingle(intChannelID);
           channelName_disp=resource.getChannelName();
           trsTable_disp=resource.getTRSTable();
           channelType_disp=resource.getChannelType();
           channelMemo_disp=resource.getChannelMemo();
		   searchset_disp=resource.getSearchSet();
		   digestprint_disp=resource.getDigestPrint();
		   digestdownload_disp=resource.getDigestDownload();
		   general_disp=resource.getGeneral();
		   fulltextprint_disp=resource.getFulltextPrint();
		   fulltextdownload_disp=resource.getFulltextDownload();
		   detail_disp=resource.getDetail();
		   fulltextread_disp=resource.getFulltextRead();
		   lawstatus_disp=resource.getLawstatus();
        }
        else
        {
            channelName=new String(channelName.getBytes("8859_1"),"GBK");
            trsTable=new String(trsTable.getBytes("8859_1"),"GBK");
            channelMemo=new String(channelMemo.getBytes("8859_1"),"GBK");
            int  intChannelType=Integer.parseInt(channelType);
            int  mendok=resource.updateChannel(intChannelID,channelName,intChannelType,trsTable,channelMemo,searchset,digestprint,digestdownload,general,fulltextprint,fulltextdownload,detail,fulltextread,lawstatus);
            if(mendok==-2)
            {
%>
<jsp:forward page="channelerror.jsp?act=mendsame"/>
<%
            }
            if(mendok==-1)
            {
%>
<jsp:forward page="channelerror.jsp?act=mend"/>
<%
            }
            response.sendRedirect("ChannelList.jsp");
        }
        

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
	var s = document.all.form1.channelName.value;
	if(s=="")
	{
	   alert("资源名称不能空！");
	   return false;
	}
    if(document.form1.trsTable.value=="")
	{
	   alert("TRS表不能空！");
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
                  加 资 源</span></b></td>
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
                      <td align="center" valign="bottom"><a href="ChannelList.jsp" style="color:#FF0000">返回资源管理列表</a></td>
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
              <form name="form1" method="get" action="mendchannel.jsp">
              <input type="hidden" name="channelID" value="<%=channelID%>">
                <tr> 
                  <td align="right" width="35%" height="25">资源名称：</td>
                  <td> 
                    <input type="text" name="channelName" value="<%=channelName_disp%>" maxlength="128"size="15">
                    (<font color="red">*</font>) </td>
                </tr>
                <tr> 
                  <td align="right" width="35%" height="25">对应TRS数据表：<BR></td>
                  <td><input type="text" name="trsTable" value="<%=trsTable_disp%>" maxlength="128"size="15">                    (<font color="red">*</font>)                  </td>
                </tr>
                <tr>
                  <td height="25" align="right" valign="middle">资源类型：</td>
                  <td>                  <select name="channelType">
                    <option value="0" <%if(channelType_disp==0) out.print("selected");%>>国内</option>
                    <option value="1" <%if(channelType_disp==1) out.print("selected");%>>国外</option>
                  </select>
                  (<font color="red">*</font>) </td>
                </tr>
				<tr>
                  <td height="25" align="right" valign="middle">权限及计费设置：</td>
                  <td><table width="100%" border="0">
                      <tr>
                        <td>检索：
                          <input name="searchset" type="text" size="4" value="<%=searchset_disp%>">
                          元</td>
                        <td>文摘打印：
                          <input name="digestprint" type="text" size="4" value="<%=digestprint_disp%>">
                          元</td>
                        <td>文摘下载：
                          <input name="digestdownload" type="text" size="4" value="<%=digestdownload_disp%>">
                          元</td>
                      </tr>
                      <tr>
                        <td>概览：
                          <input name="general" type="text" size="4" value="<%=general_disp%>">
                          元</td>
                        <td>全文打印：
                          <input name="fulltextprint" type="text" size="4" value="<%=fulltextprint_disp%>">
                          元</td>
                        <td>全文下载：
                          <input name="fulltextdownload" type="text" size="4" value="<%=fulltextdownload_disp%>">
                          元</td>
                      </tr>
                      <tr>
                        <td>细览：
                          <input name="detail" type="text" size="4" value="<%=detail_disp%>">
                          元</td>
                        <td>全文阅读：
                          <input name="fulltextread" type="text" size="4" value="<%=fulltextread_disp%>">
                          元</td>
                        <td>法律状态：
                          <input name="lawstatus" type="text" size="4" value="<%=lawstatus_disp%>">
                          元</td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td align="right" width="35%" valign="top">资源说明：</td>
                  <td> 
                  <textarea name="channelMemo"  cols="35" rows="6"><%=channelMemo_disp%></textarea>
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
