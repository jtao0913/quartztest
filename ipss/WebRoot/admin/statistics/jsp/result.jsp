<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../../../head.jsp"%>
<%@ include file="../../../zljs/comm/config.jsp"%>

<%
	LoginConfig loginConfig; //�û���ǰ��¼����
	String username = null;
	WASUser wUser = null;
	int intUserID = 0;

	loginConfig = (LoginConfig) session.getAttribute("loginconfig");
	if (loginConfig == null) {
		throw new WASException("���ĵ�¼�Ѿ�ʧЧ��");
	}

	username = loginConfig.getLoginInfo().getUserName();
	wUser = loginConfig.getLoginInfo().getUser();
	intUserID = wUser.getID();

	String strAdminName = username;
	//out.println("strAdminName------>"+strAdminName);
	int adminID = intUserID;
	//out.println(adminID+"<br>");
	//**********************ȡ�ù���ԱID�������ڴ�id���û���ʾ����*****************************
%>
<%
	String year_from = request.getParameter("year1");
	String month_from = request.getParameter("month1");
	String day_from = request.getParameter("day1");
	String year_to = request.getParameter("year2");
	String month_to = request.getParameter("month2");
	String day_to = request.getParameter("day2");
	String strPageNumber = request.getParameter("pagenumber");
	String time_from = year_from + "-" + month_from + "-" + day_from + " 00:00:00";
	String time_to = year_to + "-" + month_to + "-" + day_to + " 23:59:59";

	String operation = request.getParameter("operation");
	String userName = request.getParameter("userName");
	if (userName == null) {
		userName = "";
	} else {
		userName = new String(userName.getBytes("8859_1"), "GBK");
	}
	//out.println("userName------>"+userName);
	/*
	 //����userName��һ�´��û���adminID
	 int adminID1=UserManage.getAdminID(userName);
	 if(adminID!=adminID1)
	 {
	 //System.out.println(adminID+"---"+adminID1+"---"+userName);
	 return;
	 }
	 */
	int pageCount = 10;
	int pageNumber = 1;
	int count = 0;
	int pageTotals = 0;
	if (strPageNumber != null) {
		pageNumber = Integer.parseInt(strPageNumber);
	}//ben 2006-08-21 14:08:01 ����ר��-ȫ������ CN200410014265.3 ��5ҳ 
	StatsManage statsmanage = new StatsManage();

	//out.println(adminID+"<br>");
	//setMulti(String time_from,String time_to,String operation,String userName,int pageCount,int pageNumber,int adminID)
	statsmanage.setMulti(time_from, time_to, operation, userName,pageCount, pageNumber, adminID);
	String userNames[] = statsmanage.getUserNames();
	String visitTimes[] = statsmanage.getVisitTimes();
	String visitIPs[] = statsmanage.getVisitIPs();
	String operationAlls[] = statsmanage.getOperationAlls();
	count = statsmanage.getCount();
	if (count == 0 || count == 1) {
		pageTotals = 1;
	}
	if (count > 1) {
		pageTotals = (count - 1) / pageCount + 1;
	}
%>
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0 ; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css" type="text/css">
<style type="text/css">
<!--
.style1 {color: #666666}
-->
</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td align="right">
		<table width="487" height="25" border="0" cellpadding="0"
			cellspacing="0" background="../../images/biaotibg_list.gif"
			class="14r">
			<tr>
				<td width="505" align="right" valign="top"><span class="14r">��
				�� �� �� ͳ �� �� �� </span></td>
				<td width="11" valign="top">&nbsp;</td>
				<td width="24" valign="top">&lt;&lt;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellpadding="0"
	cellspacing="0" bgcolor="#EBEBEB">
	<tr>
		<td align="center" valign="top">
		<table width="100%" bordercolordark="#ffffff"
			bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
			<tr align="center">
				<td colspan="10" nowrap>
				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					bordercolorlight="#4787b8" bordercolordark="#FFFFFF">
					<tr>
						<td>
						<div align="center"><strong>���</strong></div>
						</td>
						<td>
						<div align="center"><strong>�û���</strong></div>
						</td>
						<td height="30">
						<div align="center"><strong>����ʱ��</strong></div>
						</td>
						<td>
						<div align="center"><strong>����IP</strong></FONT></div>
						</td>
						<td height="30">
						<div align="center"><strong>����</strong></div>
						</td>
					</tr>
					<%
								for (int i = 0; i < pageCount
								&& i < (count - pageCount * (pageNumber - 1)); i++) {
					%>
					<tr>
						<td nowrap>
						<div align="center"><%=i + 1%></div>
						</td>
						<td nowrap>
						<div align="center"><%=userNames[i]%></div>
						</td>
						<td nowrap height="26">
						<div align="center"><%=visitTimes[i]%></div>
					  </td>
						<td nowrap height="26">
						<div align="center"><%=visitIPs[i]%></div>
					  </td>
						<td nowrap height="26">
						<div align="center"><%=operationAlls[i]%></div>
					  </td>
					</tr>
					<%
					}
					%>
					<tr>
						<td height="50" colspan="5">
						<div align="center">
						<p>��<%=pageTotals%>ҳ<%=count%>�� <%
						if (pageNumber == 1) {
						%> 
						  <span class="style1">��ҳ ��һҳ</span>						  
						  <%
						} else {
						%> <a
							href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&operation=<%=operation%>&userName=<%=userName%>&pagenumber=1">��ҳ</a>
						<a
							href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&operation=<%=operation%>&userName=<%=userName%>&pagenumber=<%=pageNumber-1%>">��һҳ</a>
						<%
							}
							if (pageNumber == pageTotals) {
						%> 
						<span class="style1">��һҳ βҳ</span>						
						<%
						} else {
						%> <a
							href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&operation=<%=operation%>&userName=<%=userName%>&pagenumber=<%=pageNumber+1%>">��һҳ</a>
						<a
							href="result.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&operation=<%=operation%>&userName=<%=userName%>&pagenumber=<%=pageTotals%>">βҳ</a>
						<%
						}
						%> ��<%=pageNumber%>ҳ</p>
						<p></p>
						<table>
						<tr><td><div align="center">
                          <input  type="button" name="Submit" value="����ͳ�ƽ��" onClick="javascript:openModalwin()" <%if(count==0){%>disabled<%}%>>
                        </div></td><td><input type="submit" name="Submit" value="  ��  ��  "
							onClick="window.location.href='statsourcelist.jsp'"></td></tr>
						</table>
						
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<form name="Outline" method="post" action="download.jsp" target="_blank">
<input type="hidden" name="operation" value="">
<input type="hidden" name="userName" value="">
<input type="hidden" name="time_from" value="">
<input type="hidden" name="time_to" value="">
<input type="hidden" name="zipfile" value="">
</form>

</body>
</html>
<script>
function openModalwin()
{ 
	document.Outline.zipfile.value="yes";
	document.Outline.operation.value='<%=operation%>';
	document.Outline.userName.value='<%=userName%>';
	document.Outline.time_from.value='<%=time_from%>';
	document.Outline.time_to.value='<%=time_to%>';
	document.Outline.submit();
} 
</script>