<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.cnipr.cniprgz.func.stat.*" %>
<% String path = request.getContextPath(); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
*{font-size: 12px;margin: 0;}
a{text-decoration: none;color: #000;}
a:hover{text-decoration: underline;}
select{border: 1px #cacaca solid;}
</style>
<title>统计管理</title>
</head>
<body>
	    <%  StatFunc statFunc = new StatFunc(); 
	    	String strPage = request.getParameter("pageIndex");
	    	String statType = request.getParameter("statType");
	    	if(statType==null || "".equals(statType)){
	    		statType = "1";
	    	}
	    	int currentPage = 1;
	    	int intPages = 0;
	    	if(strPage!=null && !"".equals(strPage)){
	    		currentPage = Integer.parseInt(strPage);
	    	}
	    	Page<StatBean> resultPage = null;
	    	if("1".equals(statType)){
	    		resultPage = statFunc.loginGroupList(currentPage); 
	    	}else if("2".equals(statType)){
	    		resultPage = statFunc.searchGroupList(currentPage); 
	    	}else if("3".equals(statType)){
	    		resultPage = statFunc.viewGroupList(currentPage); 
	    	}/**
	    	else if("4".equals(statType)){
	    		resultPage = statFunc.searchGroupList(currentPage); 
	    	}else if("5".equals(statType)){
	    		resultPage = statFunc.searchGroupList(currentPage); 
	    	}else if("6".equals(statType)){
	    		resultPage = statFunc.searchGroupList(currentPage); 
	    	}else if("7".equals(statType)){
	    		resultPage = statFunc.searchGroupList(currentPage); 
	    	}else{
	    		resultPage = statFunc.loginGroupList(currentPage); 
	    	}*/
	    	intPages = resultPage.getTotalPage();
	    	 %>
<div style="padding-left: 5px;height: 25px;">
<form action="" method="post">
	统计类型：<select name="statType">
			<option value="1" <%if("1".equals(statType)) {%> selected="selected"<%} %>>登录统计</option>
			<option value="2" <%if("2".equals(statType)) {%> selected="selected"<%} %>>查询统计</option>
			<option value="3" <%if("3".equals(statType)) {%> selected="selected"<%} %>>查看文摘</option>
			<%--
			<option value="4" <%if("4".equals(statType)) {%> selected="selected"<%} %>>专利说明书浏览</option>
			<option value="5" <%if("5".equals(statType)) {%> selected="selected"<%} %>>授权说明书浏览</option>
			<option value="6" <%if("6".equals(statType)) {%> selected="selected"<%} %>>专利说明书下载</option>
			<option value="7" <%if("7".equals(statType)) {%> selected="selected"<%} %>>专利代码化下载</option>
			 --%>
		  </select>&nbsp;&nbsp;&nbsp;
	<input type="hidden" name="pageIndex" value="1">  
	<input type="submit" value="统计">
</form>
</div>
<table cellspacing="0" bordercolordark="#ffffff" width="96%" bordercolorlight="#4787b8" border="1"  style="margin-left: 5px;">
	<tr bgcolor="#4787b8"> 
	      <td width="6%" align="center" ><font color="#FFFFFF"><b>序 号</b></font></td>
	      <td width="24%" align="center" ><font color="#FFFFFF"><b>用户名</b></font></td>
	      <td width="24%" align="center" ><font color="#FFFFFF"><b>访问次数</b></font></td>
	    </tr>
	    <% 
	    if(resultPage!=null){ 
	    	int start = (currentPage-1) * resultPage.getPageSize();
	    	if(resultPage.getResultList()!=null)
	    	for(int i=0;i<resultPage.getResultList().size();i++){
	    %>
		<tr>
	      <td width="6%" align="center" ><%=start+i+1%></td>
	      <td width="15%" align="center" ><a href="detail.jsp?t=<%=statType%>&userName=<%=resultPage.getResultList().get(i).getUserName()%>" title="查看明细"><%=resultPage.getResultList().get(i).getRealName()%></a></td>
	      <td width="15%" align="center" ><%=resultPage.getResultList().get(i).getCount() %></td>
	    </tr>
	    <%	} 
	    }%>
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
		      		    <td width="54" height="18"><%if(currentPage!=1) {%><a href="index.jsp?pageIndex=1">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(currentPage!=1) {%><a href="index.jsp?pageIndex=<%=currentPage-1%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(currentPage!=intPages) {%><a href="index.jsp?pageIndex=<%=currentPage+1%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(currentPage!=intPages) {%><a href="index.jsp?pageIndex=<%=intPages%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
		      		  </tr>
		      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap style="padding-right: 10px;">
       	<a href="<%=basePath%>download.do?method=statTableDownload&&t=<%=statType%>&currentPage=1">导出表格</a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</table>
</body>
</html>