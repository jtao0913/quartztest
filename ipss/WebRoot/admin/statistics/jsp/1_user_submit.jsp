<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.usermanage.*"%>
<link href="../../../css/gd.css" rel="stylesheet" type="text/css" ></link>
<%
String strAdminName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

	//out.println("strAdminName------>"+strAdminName);
	int adminID = intUserID;
	//out.println(adminID+"<br>");
	//**********************ȡ�ù���ԱID�������ڴ�id���û���ʾ����*****************************
	String year_from = request.getParameter("year1");
	String month_from = request.getParameter("month1");
	String day_from = request.getParameter("day1");
	String year_to = request.getParameter("year2");
	String month_to = request.getParameter("month2");
	String day_to = request.getParameter("day2");
	String strPageNumber = request.getParameter("pagenumber");
	String time_from = year_from + "-" + month_from + "-" + day_from + " 00:00:00";
	String time_to = year_to + "-" + month_to + "-" + day_to + " 23:59:59";

	String userName = request.getParameter("strUserName");
	if (userName == null) {
		userName = "";
	} else {
		userName = new String(userName.getBytes("8859_1"), "GBK");
	}
	String selectScope = request.getParameter("selectScope");
//out.println("selectScope="+selectScope+"<br>");
	
	int paixu = request.getParameter("paixu")==null?0:Integer.parseInt(request.getParameter("paixu"));
	
	int pageCount=request.getParameter("pageCount")==null?1:Integer.parseInt(request.getParameter("pageCount"));
	int CountPerPage = 20;
	int pageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int count = 0;
	int pageTotals = 0;
	if (strPageNumber != null) {
		pageNumber = Integer.parseInt(strPageNumber);
	}//ben 2006-08-21 14:08:01 ����ר��-ȫ������ CN200410014265.3 ��5ҳ 
	
/*
	out.println("time_from="+time_from+"<br>");
	out.println("time_to="+time_to+"<br>");
	out.println("userName="+userName+"<br>");
	out.println("selscope="+selscope+"<br>");
	out.println("paixu="+paixu+"<br>");
*/
	StatsManage statsmanage=new StatsManage();
	String[][] arrStats=statsmanage.getUserStatistic(time_from,time_to,userName,selectScope,paixu,CountPerPage,pageNumber,adminID,false);

	String[] arrAllStats=statsmanage.getUserStatisticAll(time_from,time_to,userName,selectScope);


if(arrStats!=null){
	//System.out.println("arrStats.length="+arrStats.length);
}else{
	//System.out.println("arrStats is null............");
	out.println("û�м��������������ļ�¼,��<a href='javascript:history.go(-1)'>���¼���</a>");
	return;
}
	pageCount=statsmanage.getIntCount();
	
//out.println("pageCount="+pageCount+"<br>");
%>
<table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="100">[ <a href="1_user.jsp">�û�ͳ��</a> ]</td>
    <td width="100">[ <a href="2_area.jsp">����ͳ��</a> ]</td>
    <td width="100">[ <a href="3_time.jsp">ʱ���ͳ��</a> ]</td>
  </tr>
</table>
<p>

<%if(arrAllStats!=null){%>
<table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF" align="center">
<tr><td>&nbsp;</td><td>�й�ר��ԭ�Ĵ�ӡ</td><td>�й�ר��ԭ������</td><td>����ר����ժ��ӡ</td><td>����ר����ժ����</td></tr>
<tr><td>�ܼ�</td>
<%for(int i=0;i<arrAllStats.length;i++){%>
	<td><%=arrAllStats[i]%></td>
<%}%>
</tr>
</table>
<%}%>
<p>

<table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF" align="center">
<tr><td>&nbsp;</td><td>�й�ר��ԭ�Ĵ�ӡ</td><td>�й�ר��ԭ������</td><td>����ר����ժ��ӡ</td><td>����ר����ժ����</td></tr>
<%for(int i=0;i<arrStats.length;i++){%>
<tr>
	<%for(int j=0;j<arrStats[i].length;j++){%>
	<td><%=arrStats[i][j]%></td>
	<%}%>
</tr>
<%}%>
</table>
  <%
/*
out.println("pageCount="+pageCount+"<br>");
out.println("pageNumber="+pageNumber+"<br>");
*/
%>
<p align="center">
<input  type="button" name="Submit" value=" ����ͳ�ƽ�� " onClick="javascript:openModalwin()">
</p>
<form name="Outline" method="post" action="download.jsp" target="_blank">
<input type="hidden" name="operation" value="user">
<input type="hidden" name="userName" value="">
<input type="hidden" name="time_from" value="">
<input type="hidden" name="time_to" value="">
<input type="hidden" name="selectScope" value="">
<input type="hidden" name="paixu" value="">
<input type="hidden" name="zipfile" value="">
</form>
<script>
function openModalwin()
{ 
	document.Outline.zipfile.value="yes";
	document.Outline.operation.value='user';
	document.Outline.userName.value='<%=userName%>';
	document.Outline.time_from.value='<%=time_from%>';
	document.Outline.time_to.value='<%=time_to%>';
	document.Outline.selectScope.value='<%=selectScope%>';
	document.Outline.paixu.value='<%=paixu%>';
	document.Outline.submit();
} 
</script>

<table align="center">
<tr><td colspan="4"><div align="center">��<%=pageCount%>ҳ����<%=pageNumber%>ҳ</div></td></tr>
<tr>
<td>
<%if(pageCount==1 || pageNumber==1){%>
[��&nbsp;ҳ]
<%}else{%>
<a href="1_user_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&userName=<%=userName%>&selectScope=<%=selectScope%>&paixu=<%=paixu%>&pageNumber=1">[��&nbsp;ҳ]</a>
<%}%>
</td>
<td>
<%if(pageCount==1 || pageNumber==1){%>
[��һҳ]
<%}else{%>
<a href="1_user_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&userName=<%=userName%>&selectScope=<%=selectScope%>&paixu=<%=paixu%>&pageNumber=<%=(pageNumber-1)%>">[��һҳ]</a>
<%}%>
</td>
<td>
<%if(pageCount==pageNumber || pageCount==1){%>
[��һҳ]
<%}else{%>
<a href="1_user_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&userName=<%=userName%>&selectScope=<%=selectScope%>&paixu=<%=paixu%>&pageNumber=<%=(pageNumber+1)%>">[��һҳ]</a>
<%}%>
</td>
<td>
<%if(pageCount==pageNumber || pageCount==1){%>
[β&nbsp;ҳ]
<%}else{%>
<a href="1_user_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&userName=<%=userName%>&selectScope=<%=selectScope%>&paixu=<%=paixu%>&pageNumber=<%=pageCount%>">[β&nbsp;ҳ]</a>
<%}%>
</td>
</tr>
</table>
