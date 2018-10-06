<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cnipr.cniprgz.func.stat.*" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>统计管理</title>
</head>
<body>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<%
	    	StatFunc statFunc = new StatFunc(); 
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
	    	 <div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">		
	<%String menuname = "statmanage";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>
        <div class="span10">
         <!--span10 -->
        <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>统计管理</strong></span></td>
				</tr>
           </table>
<div style="padding-left:30px;height:45px;">
<form action="statmanage.do" method="post">
<!-- 
          <select name="statType" style="margin-top:10px;">
			<option value="2" <%if("2".equals(statType)) {%> selected="selected"<%} %>>查询统计</option>
			<option value="3" <%if("3".equals(statType)) {%> selected="selected"<%} %>>查看文摘</option>
		  </select>
 -->
          <select name="statType" style="margin-top:10px;">
            <option value="1" <%if("1".equals(statType)) {%> selected<%} %>>登录统计</option>
			<option value="2" <%if("2".equals(statType)) {%> selected<%} %>>查询统计</option>
			<option value="3" <%if("3".equals(statType)) {%> selected<%} %>>查看文摘</option>
		  </select>
		  
		  
	<input type="hidden" name="pageIndex" value="1">  
	<input type="submit" class="btn btn-default" value="统计">
</form>
</div>
<table class="table table-striped table-bordered table-hover ">
	<tr > 
	      <td width="6%" align="center"><b>序 号</b></td>
	      <td width="24%" align="center"><b>用户名</b></td>
	      <td width="24%" align="center"><b>次数</b></td>
	    </tr>
	    <% 
	    if(resultPage!=null){ 
	    	int start = (currentPage-1) * resultPage.getPageSize();
	    	if(resultPage.getResultList()!=null)
	    	for(int i=0;i<resultPage.getResultList().size();i++){
	    		int count = resultPage.getResultList().get(i).getCount();
	    %>
		<tr>
	      <td width="6%" align="center" ><%=start+i+1%></td>
	      <td width="15%" align="center" ><%if(count>0){%><a href="statdetail.do?t=<%=statType%>&userid=<%=resultPage.getResultList().get(i).getUserID()%>&statrealname=<%=resultPage.getResultList().get(i).getRealName()%>" title="查看明细"><%=resultPage.getResultList().get(i).getRealName()%></a><%}else{%><%=resultPage.getResultList().get(i).getRealName()%><%}%></td>
	      <td width="15%" align="center" ><%=count%></td>
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
		      		    <td width="54" height="18"><%if(currentPage>1) {%><a href="statmanage.do?pageIndex=1&statType=<%=statType%>">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(currentPage>1) {%><a href="statmanage.do?pageIndex=<%=currentPage-1%>&statType=<%=statType%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(currentPage<intPages) {%><a href="statmanage.do?pageIndex=<%=currentPage+1%>&statType=<%=statType%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(currentPage<intPages) {%><a href="statmanage.do?pageIndex=<%=intPages%>&statType=<%=statType%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
		      		  </tr>
		      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap style="padding-right: 10px;">
       	<!-- <a href="<%=basePath%>download.do?method=statTableDownload&&t=<%=statType%>&currentPage=1">导出表格</a> -->
    </td>
  </tr>
</table>
         <!--span10 -->
        </div>
      </div>
</div>
</div>


<!--main结束-->	
<%@ include file="/jsp/zljs/include-buttom.jsp"%>
</body>
</html>