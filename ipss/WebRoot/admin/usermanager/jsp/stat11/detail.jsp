<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List" %>
<%@ page import="com.cnipr.cniprgz.func.stat.*" %>
<% String path = request.getContextPath(); %>
<%
	StatFunc statFunc = new StatFunc(); 
	String userName = request.getParameter("userName");
	String realName = statFunc.getRealName(userName);
	String startYear = request.getParameter("startYear");
	String startMonth = request.getParameter("startMonth");
	String endYear = request.getParameter("endYear");
	String endMonth = request.getParameter("endMonth");
	java.util.Date now = new java.util.Date();
	java.text.SimpleDateFormat formatYear = new java.text.SimpleDateFormat("yyyy");
	java.text.SimpleDateFormat formatMonth = new java.text.SimpleDateFormat("MM");
	if(endYear==null || "".equals(endYear)){
		endYear = formatYear.format(now);
	}
	if(endMonth==null || "".equals(endMonth)){
		endMonth = formatMonth.format(now);
	}
	if(startYear==null || "".equals(startYear)){
		startYear = "2011";
	}
	if(startMonth==null || "".equals(startMonth)){
		startMonth = "01";
	}
	List<StatBean> resultList = statFunc.statDetail(userName, startYear+"-" + startMonth,endYear+"-"+endMonth);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lhgdialog/lhgcore.lhgdialog.min.js"></script>
<script type="text/javascript">
	function exportTable(){
		var url = '<%=basePath%>download.do?method=statTableDownload&userName=<%=userName%>&t=1&n=';
		var input1;
		var input2;
		var input3;
		var input4;
		$.dialog({
			title:'选择数据范围',
			lock:true,
			background:'#000000',
			opacity: 0.5,
			max: false,
			min: false,
			content:'<div><p>开始时间：<select>' +
			'<option value="2012">2012</option>' +
			'<option value="2011">2011</option>' +
			'<option value="2010">2010</option>' +
			'<option value="2009">2009</option>' +
			'<option value="2008">2008</option>' +
			'</select> 年 <select>' +
			'<option value="01">1</option>' +
			'<option value="02">2</option>' +
			'<option value="03">3</option>' +
			'<option value="04">4</option>' +
			'<option value="05">5</option>' +
			'<option value="06">6</option>' +
			'<option value="07">7</option>' +
			'<option value="08">8</option>' +
			'<option value="09">9</option>' +
			'<option value="10">10</option>' +
			'<option value="11">11</option>' +
			'<option value="12">12</option>' +
			'</select> 月 </p><br>'+
			'<p>结束时间：<select>' +
			'<option value="2012">2012</option>' +
			'<option value="2011">2011</option>' +
			'<option value="2010">2010</option>' +
			'<option value="2009">2009</option>' +
			'<option value="2008">2008</option>' +
			'</select> 年 <select>' +
			'<option value="01">1</option>' +
			'<option value="02">2</option>' +
			'<option value="03">3</option>' +
			'<option value="04">4</option>' +
			'<option value="05">5</option>' +
			'<option value="06">6</option>' +
			'<option value="07">7</option>' +
			'<option value="08">8</option>' +
			'<option value="09">9</option>' +
			'<option value="10">10</option>' +
			'<option value="11">11</option>' +
			'<option value="12">12</option>' +
			'</select> 月</p></div>',
			init:function(){
				input1=this.DOM.content[0].getElementsByTagName('select')[0];
				input2=this.DOM.content[0].getElementsByTagName('select')[1];
				input3=this.DOM.content[0].getElementsByTagName('select')[2];
				input4=this.DOM.content[0].getElementsByTagName('select')[3];
			},
			ok:function(){
				var check1 = input1.value+""+input2.value;
				var check2 = input3.value+""+input4.value;
				if(check1>check2){
					alert('时间范围错误');
					return false;
				}
				var startTime = input1.value+"-"+input2.value;
				var endTime = input3.value+"-"+input4.value;
				
				url = url+"&startTime="+startTime+"&endTime="+endTime;
				window.location.href=url;
			},
			
			okVal:'确定'
		});
	}
</script>
<style type="text/css">
*{font-size: 12px;margin: 0;}
a{text-decoration: none;color: #000;}
a:hover{text-decoration: underline;}
</style>
<title>统计管理</title>
</head>
<body>
<form action="" method="post">
<table cellspacing="0" cellpadding="0" width="96%" border="0"  style="margin-left: 5px;">
	<tr>
		<td width="30%" align="center">
			<strong>开始时间：</strong><select name="startYear">
				<option value="2013" <%if("2013".equals(startYear)){ %>selected="selected"<%}%>>2013</option>
				<option value="2012" <%if("2012".equals(startYear)){ %>selected="selected"<%}%>>2012</option>
				<option value="2011" <%if("2011".equals(startYear)){ %>selected="selected"<%}%>>2011</option>
				<option value="2010" <%if("2010".equals(startYear)){ %>selected="selected"<%}%>>2010</option>
				<option value="2009" <%if("2009".equals(startYear)){ %>selected="selected"<%}%>>2009</option>
				<option value="2008" <%if("2008".equals(startYear)){ %>selected="selected"<%}%>>2008</option>
			</select> 年 
			<select name="startMonth">
				<option value="01" <%if("01".equals(startMonth)){ %>selected="selected"<%}%>>1</option>
				<option value="02" <%if("02".equals(startMonth)){ %>selected="selected"<%}%>>2</option>
				<option value="03" <%if("03".equals(startMonth)){ %>selected="selected"<%}%>>3</option>
				<option value="04" <%if("04".equals(startMonth)){ %>selected="selected"<%}%>>4</option>
				<option value="05" <%if("05".equals(startMonth)){ %>selected="selected"<%}%>>5</option>
				<option value="06" <%if("06".equals(startMonth)){ %>selected="selected"<%}%>>6</option>
				<option value="07" <%if("07".equals(startMonth)){ %>selected="selected"<%}%>>7</option>
				<option value="08" <%if("08".equals(startMonth)){ %>selected="selected"<%}%>>8</option>
				<option value="09" <%if("09".equals(startMonth)){ %>selected="selected"<%}%>>9</option>
				<option value="10" <%if("10".equals(startMonth)){ %>selected="selected"<%}%>>10</option>
				<option value="11" <%if("11".equals(startMonth)){ %>selected="selected"<%}%>>11</option>
				<option value="12" <%if("12".equals(startMonth)){ %>selected="selected"<%}%>>12</option>
			</select> 月 
			
		</td>
		<td width="30%">
			<strong>结束时间：</strong><select name="endYear">
				<option value="2013" <%if("2013".equals(endYear)){ %>selected="selected"<%}%>>2013</option>
				<option value="2012" <%if("2012".equals(endYear)){ %>selected="selected"<%}%>>2012</option>
				<option value="2011" <%if("2011".equals(endYear)){ %>selected="selected"<%}%>>2011</option>
				<option value="2010" <%if("2010".equals(endYear)){ %>selected="selected"<%}%>>2010</option>
				<option value="2009" <%if("2009".equals(endYear)){ %>selected="selected"<%}%>>2009</option>
				<option value="2008" <%if("2008".equals(endYear)){ %>selected="selected"<%}%>>2008</option>
			</select> 年 
			<select name="endMonth">
				<option value="01" <%if("01".equals(endMonth)){ %>selected="selected"<%}%>>1</option>
				<option value="02" <%if("02".equals(endMonth)){ %>selected="selected"<%}%>>2</option>
				<option value="03" <%if("03".equals(endMonth)){ %>selected="selected"<%}%>>3</option>
				<option value="04" <%if("04".equals(endMonth)){ %>selected="selected"<%}%>>4</option>
				<option value="05" <%if("05".equals(endMonth)){ %>selected="selected"<%}%>>5</option>
				<option value="06" <%if("06".equals(endMonth)){ %>selected="selected"<%}%>>6</option>
				<option value="07" <%if("07".equals(endMonth)){ %>selected="selected"<%}%>>7</option>
				<option value="08" <%if("08".equals(endMonth)){ %>selected="selected"<%}%>>8</option>
				<option value="09" <%if("09".equals(endMonth)){ %>selected="selected"<%}%>>9</option>
				<option value="10" <%if("10".equals(endMonth)){ %>selected="selected"<%}%>>10</option>
				<option value="11" <%if("11".equals(endMonth)){ %>selected="selected"<%}%>>11</option>
				<option value="12" <%if("12".equals(endMonth)){ %>selected="selected"<%}%>>12</option>
			</select> 月 
		</td>
		<td width="40%">
			<input type="submit" value="统 计">
		</td>
	</tr>
	<tr>
	</tr>
</table>
</form>
<br>
<table cellspacing="0" bordercolordark="#ffffff" width="96%" bordercolorlight="#4787b8" border="1"  style="margin-left: 5px;">
	<caption><strong><span style="font-size: 18px;"><%=realName %> 平台使用情况统计</span></strong></caption>
	<tr bgcolor="#4787b8"> 
	      <td  align="center" width="9%"><font color="#FFFFFF"><b>时间段</b></font></td>
	      <td  align="center" width="6%"><font color="#FFFFFF"><b>会话</b></font></td>
	      <td  align="center" width="6%"><font color="#FFFFFF"><b>查询</b></font></td>
	      <td  align="center" width="8%"><font color="#FFFFFF"><b>查看文摘</b></font></td>
	      <td  align="center" width="10%"><font color="#FFFFFF"><b>中国专利说明书浏览量</b></font></td>
	      <td  align="center" width="10%"><font color="#FFFFFF"><b>发明授权说明书浏览量</b></font></td>
	      <td  align="center" width="10%"><font color="#FFFFFF"><b>实用新型说明书浏览量</b></font></td>
	      <td  align="center" width="10%"><font color="#FFFFFF"><b>外观设计说明书浏览量</b></font></td>
	      <td  align="center" width="8%"><font color="#FFFFFF"><b>国外文摘浏览量</b></font></td>
	      <td  align="center" width="9%"><font color="#FFFFFF"><b>说明书下载</b></font></td>
	      <td  align="center" width="9%"><font color="#FFFFFF"><b>说明书打印</b></font></td>
	    </tr>
	    <% int item1=0,item2=0,item3=0,item4=0,item5=0,item6=0,item7=0,item8=0,item9=0,item10=0; %>
	    <%  
	    	for(int i=0;i<resultList.size();i++){ %>
		<tr <%if(i%2!=0){ %> bgcolor="#F5F9FF" <%} %>>
	      <td align="center"><%=resultList.get(i).getStrTime()%></td>
	      <td align="center"><%=resultList.get(i).getLoginCount()%></td>
	      <td align="center"><%=resultList.get(i).getSearchCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewSQDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewXXDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewWGDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getViewFrCount()%></td>
	      <td align="center"><%=resultList.get(i).getDownloadDocCount()%></td>
	      <td align="center"><%=resultList.get(i).getPrintDocCount()%></td>
	    </tr>
		    <%
		    item1+=resultList.get(i).getLoginCount();
		    item2+=resultList.get(i).getSearchCount();
		    item3+=resultList.get(i).getViewCount();
		    item4+=resultList.get(i).getViewDocCount();
		    item5+=resultList.get(i).getViewSQDocCount();
		    item6+=resultList.get(i).getViewXXDocCount();
		    item7+=resultList.get(i).getViewWGDocCount();
		    item8+=resultList.get(i).getViewFrCount();
		    item9+=resultList.get(i).getDownloadDocCount();
		    item10+=resultList.get(i).getPrintDocCount();
		   }
	    %>
	    <tr>
	    	<td align="center">合计</td>
	    	<td align="center"><%=item1 %></td>
	    	<td align="center"><%=item2 %></td>
	    	<td align="center"><%=item3 %></td>
	    	<td align="center"><%=item4 %></td>
	    	<td align="center"><%=item5 %></td>
	    	<td align="center"><%=item6 %></td>
	    	<td align="center"><%=item7 %></td>
	    	<td align="center"><%=item8 %></td>
	    	<td align="center"><%=item9 %></td>
	    	<td align="center"><%=item10 %></td>
	    </tr>
	    <tr>
	    	<td colspan="11" align="right" style="padding-right: 10px;">
	    		<a href="<%=basePath%>download.do?method=statTableDownload&userName=<%=userName%>&t=1&startTime=<%=startYear+"-"+startMonth%>&endTime=<%=endYear+"-"+endMonth%>">导出表格</a>
	    	</td>
	    </tr>
</table>
</body>
</html>