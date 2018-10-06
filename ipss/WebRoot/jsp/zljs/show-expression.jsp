<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<head>
<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>我的历史表达式-<%=website_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	
</head>

<body>

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

<script src="<%=basePath%>/analyse/json2.js"></script>


<form class="form-horizontal" id="searchForm" name="searchForm" method="post" target="_blank">
<input type="hidden" id="synonymous" name="synonymous" value="0">
<input type="hidden" id="strWhere" name="strWhere">
<input type="hidden" name="savesearchword" value="0">
<input type="hidden" id="strChannels" name="strChannels">
<input type="hidden" id="expid" name="expid">
<input type="hidden" id="expsearch" name="expsearch">
</form>

<script type="text/javascript">
function getDetail(strSource, strAn) {
	document.detail.strSources.value = strSource;
	document.detail.strWhere.value = "申请号=" + strAn;
	document.detail.submit();
}

function submitDataToSearch(expression,sources){
//alert(expression);
//alert(sources);
	$('#searchForm #strWhere').val(expression);
	$('#searchForm #strChannels').val(sources);
	
	document.searchForm.target="_blank";
	document.searchForm.action="<%=basePath%>overviewSearch.do?area=cn";
	document.searchForm.submit();
}
</script>


	<div class="container">
		<div class="row">
			<div class="span12">
				<!--span10 -->
				<table style="width: 100%"
					class="table table-striped table-bordered table-hover ">
					<tr>
						<td colspan="6"
							style="text-align: center; background-color: #f5f5f5; color: #3498db; height: 6px;"><span><strong>我的历史表达式</strong></span></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<div class="container">
      <div class="row">	
		<div class="span12">
			<table style="width:100%;border:2px solid #3498db;background-color: #3498db;color:#ffffff;">
			<tr>
			 <td style="width:6%;text-align:center;">选择</td>
			 <td style="width:33%;text-align:center;">表达式</td>
			 <td style="width:10%;text-align:center;">命中数</td>
			 <td style="width:30%;text-align:center;">检索库</td>
			 <td style="width:12%;text-align:center;">检索时间</td>
			 <td style="width:10%;text-align:center;">操作</td>
			</tr>
			</table>
			<div style="width: 100%;padding-bottom:10px;">


<table id="exptable" class="table table-striped table-bordered table-hover" style="width:100%;margin:0px;padding:0px;font-size:13px;">
</table>
<div style="margin-top:6px;"><span id="seloption"></span> <span  id="exppage" style="float:right;"></span></div>
<script type="text/javascript">
var area = "cnfr";

$(function() {
	$("body").mask("正在初始化，请稍候...");	
	generate_pageinfo(area,1,0);
	$('body').unmask();
});
</script>


			</div>
		</div>		
		
	    </div>
      </div>

<%@ include file="include_exp.jsp"%>



<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>
			
<!--main结束-->	
<%@ include file="include-buttom.jsp"%>

	</BODY>
</HTML>

