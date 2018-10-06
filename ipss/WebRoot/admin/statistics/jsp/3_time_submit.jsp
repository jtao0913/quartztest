<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.usermanage.*"%>
<link href="../../../css/gd.css" rel="stylesheet" type="text/css" ></link>
<%
String userName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));


	//out.println("strAdminName------>"+strAdminName);
	int adminID = intUserID;
	//out.println(adminID+"<br>");
	//**********************取得管理员ID，把属于此id的用户显示出来*****************************
	String year_from = request.getParameter("year1");
	String month_from = request.getParameter("month1");
	String day_from = request.getParameter("day1");
	String year_to = request.getParameter("year2");
	String month_to = request.getParameter("month2");
	String day_to = request.getParameter("day2");
	String strPageNumber = request.getParameter("pagenumber");
	String time_from = year_from + "-" + month_from + "-" + day_from + " 00:00:00";
	String time_to = year_to + "-" + month_to + "-" + day_to + " 23:59:59";
/*	
	out.println("time_from="+time_from+"<br>");
	out.println("time_to="+time_to+"<br>");
	out.println("userName="+userName+"<br>");
	out.println("selscope="+selscope+"<br>");
	out.println("paixu="+paixu+"<br>");
*/
	StatsManage statsmanage=new StatsManage();
	String[][] arrStats=statsmanage.getAreaStatistic(time_from,time_to);
	
	String[] arrAllStats=statsmanage.getAreaStatisticAll(time_from,time_to);
	
if(arrStats!=null){
	//System.out.println("arrStats.length="+arrStats.length);
}else{
	//System.out.println("arrStats is null............");
	out.println("没有检索到符合条件的记录,请<a href='javascript:history.go(-1)'>重新检索</a>");
	return;
}
%>
<table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="100">[ <a href="1_user.jsp">用户统计</a> ]</td>
    <td width="100">[ <a href="2_area.jsp">区域统计</a> ]</td>
    <td width="100">[ <a href="3_time.jsp">时间段统计</a> ]</td>
  </tr>
</table>
<p>

<%if(arrAllStats!=null){%>
<table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF" align="center">
<tr><td>&nbsp;</td><td>中国专利原文打印</td><td>中国专利原文下载</td><td>国外专利文摘打印</td><td>国外专利文摘下载</td></tr>
<tr><td>总计</td>
<%for(int i=0;i<arrAllStats.length;i++){%>
	<td><%=arrAllStats[i]%></td>
<%}%>
</tr>
</table>
<%}%>
<p>

<table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF" align="center">
<tr><td>&nbsp;</td><td>用户数量</td><td>中国专利原文打印</td><td>中国专利原文下载</td><td>国外专利文摘打印</td><td>国外专利文摘下载</td></tr>
<%for(int i=0;i<arrStats.length;i++){%>
<tr>
	<%for(int j=0;j<arrStats[i].length;j++){%>
	<td><%=arrStats[i][j]%></td>
	<%}%>
</tr>
<%}%>
</table>

<p align="center">
<input  type="button" name="Submit" value="导出统计结果" onClick="javascript:openModalwin()">
</p>
<form name="Outline" method="post" action="download.jsp" target="_blank">
<input type="hidden" name="operation" value="area">
<input type="hidden" name="userName" value="">
<input type="hidden" name="time_from" value="">
<input type="hidden" name="time_to" value="">
<input type="hidden" name="zipfile" value="">
</form>
<script>
function openModalwin()
{ 
	document.Outline.zipfile.value="yes";
	document.Outline.userName.value='<%=userName%>';
	document.Outline.time_from.value='<%=time_from%>';
	document.Outline.time_to.value='<%=time_to%>';
	document.Outline.submit();
} 
</script>
