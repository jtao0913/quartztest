<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,com.cnipph.util.LogStatVO,com.cnipr.cniprgz.dao.DownloadLogDAO" %>
<% 
	String path = request.getContextPath();
	int allcount=0;
	if(request.getAttribute("allCounts")!=null){
		allcount=Integer.parseInt(request.getAttribute("allCounts").toString());
	}
	int allPages=(allcount+10-1)/10;
	String currnetPage=request.getParameter("currnetPage");
	String fromtime="";
	if(request.getParameter("fromtime")!=null){
		fromtime=request.getParameter("fromtime");
	}
	
	String totime="";
	if(request.getParameter("totime")!=null){
		totime=request.getParameter("totime");
	}
	
	String username="";
	if(request.getParameter("username")!=null){
		username=request.getParameter("username");
	}
	
	String str="";
	if((!"".equals(fromtime)&&fromtime!=null)&&(!"".equals(totime)&&totime!=null)){
		str+=" and (ipr_download_stat.visittime>='"+fromtime+" 00:00:00' and  ipr_download_stat.visittime<='"+totime+" 23:59:59') ";
	}
	DownloadLogDAO dldao=new DownloadLogDAO();
	String type=request.getParameter("type");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath() %>/lhgcalendar/lhgcore.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/lhgcalendar/lhgcalendar.js"></script>
<style type="text/css">
*{font-size: 12px;margin: 0;}
a{text-decoration: none;color: #000;}
a:hover{text-decoration: underline;}
select{border: 1px #cacaca solid;}
</style>
<title>统计管理</title>
<script type="text/javascript">
	function _page(currnetPage){
		document.getElementById("currnetPage").value=currnetPage;
		document.pageForm.submit();
	}
	function _clear(){
		document.getElementById("c4").value="";
		document.getElementById("c5").value="";
		document.getElementById("username").value="";
		document.getElementById("currnetPage").value="";
	}
	function _search(){
		var fromtime=document.getElementById("c4").value;
		var totime=document.getElementById("c5").value;
		if(fromtime!=''){
			if(totime==""){
				alert("请填写时间段！");
				return;
			}
		}
		if(totime!=''){
			if(fromtime==""){
				alert("请填写时间段！");
				return;
			}
		}
		document.getElementById("currnetPage").value="";
		document.pageForm.submit();
		
	}
	function _all(){
		//alert(document.getElementById("c4").value);
		document.getElementById("type").value="all";
		document.pageForm.submit();
	}
</script>
</head>
<body>
<%  
	List ll=(List)request.getAttribute("ll");
%>
<form method="post" name="pageForm" action="<%=request.getContextPath() %>/servlet/LogStatServlet">
<input type="hidden" name="currnetPage" id="currnetPage" value="">
<input type="hidden" name="type" id="type" value="">
<table>
<tr>
<td>用户名：</td>
<td colspan="2"><input id="username" value="<%=username %>" name="username" type="text"></td>
<td>时间：</td>
<td colspan="2"><input name="fromtime" value="<%=fromtime %>" readonly type="text" id="c4"/><img align="absmiddle" src="<%=request.getContextPath() %>/lhgcalendar/images/date.gif" onclick="J.calendar.get({id:'c4'});"/>--<input value="<%=totime %>" name="totime" readonly type="text" id="c5"/><img align="absmiddle" src="<%=request.getContextPath() %>/lhgcalendar/images/date.gif" onclick="J.calendar.get({id:'c5'});"/></td>
<td><input type="button" onclick="_search();" value="查询"><input type="button" onclick="_clear();" value="清空"><input type="button" onclick="_all();" value="汇总"></td>
</tr>
</table>
<%
	if("all".equals(type)){
%>

<table cellspacing="0" bordercolordark="#ffffff" width="96%" bordercolorlight="#4787b8" border="1"  style="margin-left: 5px;">
	<tr bgcolor="#4787b8"> 
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>中国专利说明书打印</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>中国专利说明书下载</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>中国专利著录项打印</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>中国专利著录项下载</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>国外专利著录项打印</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>国外专利著录项下载</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>访问次数</b></font></td>
	    </tr>
		
		<tr>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"4","cn",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"3","cn",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"2","cn",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"1","cn",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"2","fr",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"1","fr",str) %></td>
	      <td width="15%" align="center" ><%=dldao.getUserStat(null,"0","",str) %></td>
	      
	    </tr>
</table>
<table width="96%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4" style="margin-left: 5px;">
  <tr> 
    <td width="58%">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
                   &nbsp;
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap style="padding-right: 10px;">
       	<a href="<%=basePath%>servlet/ExportStatServlet?type=all&username=<%=username %>&fromtime=<%=fromtime %>&totime=<%=totime %>">导出表格</a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</table>

<%		
	}else{
%>
<table cellspacing="0" bordercolordark="#ffffff" width="96%" bordercolorlight="#4787b8" border="1"  style="margin-left: 5px;">
	<tr bgcolor="#4787b8"> 
	      <td width="6%" align="center" ><font color="#FFFFFF"><b>用户名</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>中国专利说明书打印</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>中国专利说明书下载</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>中国专利著录项打印</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>中国专利著录项下载</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>国外专利著录项打印</b></font></td>
	      <td width="13%" align="center" ><font color="#FFFFFF"><b>国外专利著录项下载</b></font></td>
	      <td width="12%" align="center" ><font color="#FFFFFF"><b>访问次数</b></font></td>
	    </tr>
		<%
			for(int a=0;a<ll.size();a++){
  				LogStatVO svo=(LogStatVO)ll.get(a);
		%>
		<tr>
	      <td width="6%" align="center" ><%=svo.getUsername() %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"4","cn",str) %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"3","cn",str) %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"2","cn",str) %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"1","cn",str) %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"2","fr",str) %></td>
	      <td width="13%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"1","fr",str) %></td>
	      <td width="12%" align="center" ><%=dldao.getUserStat(svo.getUserid(),"0","",str) %></td>
	    </tr>
	    <%
	    	}
	    %>
</table>
<table width="96%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4" style="margin-left: 5px;">
  <tr> 
    <td width="58%">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
                    <table width="217" cellspacing="0" border="0" cellpadding="0">
		      		  <tr>
		      		    <td width="54" height="18"><a href="javascript:_page('1');">首页</a></td>
		                <td width="54">
		               	  <%
						  	if("1".equals(currnetPage)){
						  		out.println("<span class=\"style1\">上一页</span>");
						  	}else{
						  %>
						  	<a href="javascript:_page('<%=Integer.parseInt(currnetPage)-1 %>');">上一页</a>
						  <%
						  	}
						  %>
		                </td>
		                <td width="54">
		                <%
						  	if(currnetPage.equals(String.valueOf(allPages))){
						  		out.println("<span class=\"style1\">下一页</span>");
						  	}else{
						  %>
						  		<a href="javascript:_page('<%=Integer.parseInt(currnetPage)+1 %>');">下一页</a>
						  <%		
						  	}
						  %>
		                </td>
		                <td width="55"><a href="javascript:_page('<%=allPages %>');">尾页</a></td>
		      		  </tr>
		      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap style="padding-right: 10px;">
       	<a href="<%=basePath%>servlet/ExportStatServlet?username=<%=username %>&fromtime=<%=fromtime %>&totime=<%=totime %>">导出表格</a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</table>
<%
	}
%>

</form>
</body>
</html>