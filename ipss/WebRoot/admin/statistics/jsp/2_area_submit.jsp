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
out.println("time_from="+time_from);
out.println("<br>");
out.println("time_to="+time_to);
*/
	int pageCount=request.getParameter("pageCount")==null?1:Integer.parseInt(request.getParameter("pageCount"));
	int CountPerPage = 20;
	int pageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int count = 0;
	int pageTotals = 0;
	if (strPageNumber != null) {
		pageNumber = Integer.parseInt(strPageNumber);
	}//ben 2006-08-21 14:08:01 发明专利-全文下载 CN200410014265.3 第5页 
	
String selectScope=request.getParameter("selectScope")==null?"all":request.getParameter("selectScope");
String all_area_user=request.getParameter("all_area_user")==null?"":request.getParameter("all_area_user");
String time_span=request.getParameter("time_span")==null?"":request.getParameter("time_span");

if(selectScope.equals("all") && adminID!=1){
	selectScope="area";
	all_area_user=adminID+"";
}
/*
	out.println("time_from="+time_from+"<br>");
	out.println("time_to="+time_to+"<br>");
	out.println("selectScope="+selectScope+"<br>");
	out.println("all_area_user="+all_area_user+"<br>");
	out.println("time_span="+time_span+"<br>");
*/

	StatsManage statsmanage=new StatsManage();
	String[][] arrStats=statsmanage.getTimeStatistic(time_from,time_to,selectScope,all_area_user,time_span,CountPerPage,pageNumber,adminID,false);

	String[] arrAllStats=statsmanage.getTimeStatisticAll(time_from,time_to,selectScope,all_area_user,time_span);
	
if(arrStats!=null){
	//System.out.println("arrStats.length="+arrStats.length);
}else{
	//System.out.println("arrStats is null............");
	out.println("没有检索到符合条件的记录,请<a href='javascript:history.go(-1)'>重新检索</a>");
	return;
}
	pageCount=statsmanage.getIntCount();
	
//out.println("pageCount="+pageCount+"<br>");
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
<tr><td>&nbsp;</td><td>中国专利原文打印</td><td>中国专利原文下载</td><td>国外专利文摘打印</td><td>国外专利文摘下载</td></tr>
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
<input type="hidden" name="operation" value="time">
<input type="hidden" name="userName" value="">
<input type="hidden" name="time_from" value="">
<input type="hidden" name="time_to" value="">
<input type="hidden" name="selectScope" value="">

<input type="hidden" name="all_area_user" value="">
<input type="hidden" name="time_span" value="">

<input type="hidden" name="zipfile" value="">
</form>
<script>
function openModalwin()
{ 
	document.Outline.zipfile.value="yes";
	document.Outline.userName.value='<%=userName%>';
	document.Outline.time_from.value='<%=time_from%>';
	document.Outline.time_to.value='<%=time_to%>';
	document.Outline.selectScope.value='<%=selectScope%>';
	document.Outline.all_area_user.value='<%=all_area_user%>';
	document.Outline.time_span.value='<%=time_span%>';
	document.Outline.submit();
} 
</script>

<p>&nbsp;</p>
<table align="center">
<tr><td colspan="4"><div align="center">共<%=pageCount%>页，第<%=pageNumber%>页</div></td></tr>
<tr>
<td>
<%if(pageCount==1 || pageNumber==1){%>
[首&nbsp;页]
<%}else{%>
<a href="3_time_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&all_area_user=<%=all_area_user%>&selectScope=<%=selectScope%>&time_span=<%=time_span%>&pageNumber=1">[首&nbsp;页]</a>
<%}%>
</td>
<td>
<%if(pageCount==1 || pageNumber==1){%>
[上一页]
<%}else{%>
<a href="3_time_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&all_area_user=<%=all_area_user%>&selectScope=<%=selectScope%>&time_span=<%=time_span%>&pageNumber=<%=(pageNumber-1)%>">[上一页]</a>
<%}%>
</td>
<td>
<%if(pageCount==pageNumber || pageCount==1){%>
[下一页]
<%}else{%>
<a href="3_time_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&all_area_user=<%=all_area_user%>&selectScope=<%=selectScope%>&time_span=<%=time_span%>&pageNumber=<%=(pageNumber+1)%>">[下一页]</a>
<%}%>
</td>
<td>
<%if(pageCount==pageNumber || pageCount==1){%>
[尾&nbsp;页]
<%}else{%>
<a href="3_time_submit.jsp?year1=<%=year_from%>&month1=<%=month_from%>&day1=<%=day_from%>&year2=<%=year_to%>&month2=<%=month_to%>&day2=<%=day_to%>&all_area_user=<%=all_area_user%>&selectScope=<%=selectScope%>&time_span=<%=time_span%>&pageNumber=<%=pageCount%>">[尾&nbsp;页]</a>
<%}%>
</td>
</tr>
</table>