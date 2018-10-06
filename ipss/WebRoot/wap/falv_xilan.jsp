<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<%@ page import="com.cnipr.cniprgz.commons.fenye.Page"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
  
<%@ include file="include-head.jsp"%>
<title>检索概览-<%=website_title%></title>
	
<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>

<script type="text/javascript">
function MoveTo(pageIndex){
	document.lawStatusSearchForm.pageIndex.value = pageIndex;
	document.lawStatusSearchForm.submit();
}
			
function JumpTo(){
	var jumpPage = document.getElementById("txtJumpPageNumber").value;
			
	if (jumpPage <= 0) {
		MoveTo(0);
	} else if (jumpPage <= ${requestScope.lawpage.pageCount} ) {
		MoveTo(jumpPage - 1);
	} else {
		MoveTo(${requestScope.lawpage.pageCount} - 1);
	}
}

function nextPage(pageIndex){
//	alert("pageIndex="+pageIndex);
	var strWhere = $("#flztSearchForm #strWhere").val();
	
	strWhere=encodeURI(strWhere);
	strWhere=encodeURI(strWhere);
	
	document.flztSearchForm.action = "<%=basePath%>waplegalStatusSearch.do?wap=1&pageIndex="+pageIndex+"&strWhere="+strWhere;
//	document.lawStatusSearchForm.pageIndex.value = pageIndex;
	$("#flztSearchForm #pageIndex").val(pageIndex);
	document.flztSearchForm.submit();
}
	
function formSubmit()
{
	document.flztSearchForm.action = "<%=basePath%>waplegalStatusSearch.do?wap=1";
	document.flztSearchForm.submit();
}
</script>

<%
Page nav = new Page();
nav = (Page)request.getAttribute("lawpage");

int pageCount = 0;
int pageIndex = 0;

pageCount = (nav.getPageCount()==null||nav.getPageCount().equals(""))?0:Integer.parseInt(nav.getPageCount());
pageIndex = (nav.getPageIndex()==null||nav.getPageIndex().equals(""))?0:Integer.parseInt(nav.getPageIndex());

//System.out.println("pageCount="+pageCount);
//System.out.println("pageIndex="+pageIndex);
String strWhere = (String)request.getAttribute("strWhere");
%>
</head>
<body>

<form class="form-horizontal" method="post" id="flztSearchForm" name="flztSearchForm" >
<input type="hidden" id="wap" name="wap" value="1"/>
<input type="hidden" id="strWhere" name="strWhere" value="${requestScope.strWhere}">
<input type="hidden" id="pageIndex" name="pageIndex">
</form>
<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>	
<!--顶部显示-->

<!--筛选结果-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="col-xs-12" style="line-height: 30px;">
			共计(${requestScope.totalRecord})条
		</div>
	</div>
</div>
<!--筛选结果-->


<c:forEach var="legalStatusInfo" items="${requestScope.legalStatusInfoList}" varStatus="status">
<!--单条记录 start-->
	<div class="container dantiao">
		<div class="row">
			<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
			   border-left:0;"></div>
		</div>
		<div class="row">
			<div class="col-xs-12">申请号: ${legalStatusInfo.strAn}</div>
		</div>
		<div class="row">
			<div class="col-xs-12">法律状态公告日: ${legalStatusInfo.strLegalStatusDay}</div>
		</div>
		<div class="row">
			<div class="col-xs-12">法律状态: ${legalStatusInfo.strLegalStatus}</div>
		</div>
		<div class="row">
			<div class="col-xs-12">法律状态信息: ${legalStatusInfo.strStatusInfo}</div>
		</div>
	</div>
<!--单条记录 end-->
</c:forEach>


<!--下一页-->
<div class="container" style="line-height:40px;margin-top:10px;">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<!--
	<center>
		<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:MoveTo('1');" value="第一页">&nbsp;<input class="btn btn-default" name="PrevPage" type="button" onClick="javascript:MoveTo('1');" value="上一页">&nbsp;<input class="btn btn-default" name="NextPage" type="button" value="下一页" onClick="javascript:MoveTo('3');">
	-->
		
		
	<center>
<%
//out.println("pagecount="+pagecount);
//out.println("pageindex="+pageindex);

		if (pageIndex == 1) {
%>
			<input class="btn btn-default" name="FirstPage" type="button" value="第一页">&nbsp;
			<input class="btn btn-default" name="PrevPage" type="button" value="上一页">&nbsp;
<%
		} else {
%>
			<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:nextPage('1');" value="第一页">&nbsp;
			<input class="btn btn-default" name="PrevPage" type="button" onClick="javascript:nextPage('<%=(pageIndex - 1)%>');" value="上一页">&nbsp;
<%
		}
%>
		
		
		
<%
		if (pageIndex==pageCount) {
%>
			<input class="btn btn-default" name="NextPage" type="button" value="下一页">&nbsp;
			<input class="btn btn-default" name="FirstPage" type="button" value="尾&nbsp;&nbsp;页">
<%
		} else {
%>
			<input class="btn btn-default" name="NextPage" type="button" onClick="javascript:nextPage('<%=(pageIndex + 1)%>');" value="下一页">&nbsp;
			<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:nextPage('<%=pageCount%>');" value="尾&nbsp;&nbsp;页">
<%
		}
%>


	</center>		
		
		
</div>
<!--下一页-->
<div style="height:40px;"></div>

<%@ include file="include-bottom.jsp"%>

	</body>
</html>
