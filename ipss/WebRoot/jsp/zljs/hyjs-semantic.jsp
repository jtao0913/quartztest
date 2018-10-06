<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>法律状态检索【中国】-<%=website_title%></title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
	<meta name="description" content="<%=website_title%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->



<!-- 智能检索类库导入 -->

</head>

<!--导航-->

<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<%@ include file="include-head-secondsearch.jsp"%>

<script language="javascript">
function formSubmit(){
//	document.semanticSearchForm.action="<%=basePath %>pretoJsonOverView.do?area=cn";
//	document.semanticSearchForm.submit();
	
	var strWhere = $("#semanticSearchForm #strWhere_ori").val();
//	strWhere = strWhere.replace("","");
	
//	var punctuation = "“”，,'\"\\-()（）+=!！@#$￥%……^&*×；;";
	var punctuation = "：[]～∶％/“”，,'\"\\-()（）+=!！@#$￥%……^&*×；;";
	var arr = punctuation.split("");
//	var reg="/"+arr[i]+"/g";

//	var reg = /'/g;	
//	for(var i=0;i<arr.length;i++) {}

	strWhere = strWhere.replace(/'/g, " ");
	strWhere = strWhere.replace(/\"/g, " ");

	var regRN = /\r\n/g;
	strWhere  = strWhere.replace(regRN," ");
	
	var regR = /\r/g;
	var regN = /\n/g;
	strWhere = strWhere.replace(regR," ").replace(regN," ");
	
//alert(strWhere);

	$("#semanticSearchForm #strWhere").val("主权项语义,摘要语义+='"+strWhere+"'");
//	$("#semanticSearchForm #strWhere").val("关键词='"+strWhere+"'");
	$("#semanticSearchForm").attr("action","<%=basePath %>pretoJsonOverView.do?area=cn");
    $("#semanticSearchForm").submit();
/*
	var str='aabbccaa';
	var reg=/aa/g;
	str=str.replace(reg,'dd');
*/

}
</script>


<body>
	


   <div style="width:1120px;margin: auto;">
 	 <!--表格检索-->
		<div class="row-fluid">
			<div style="height:15px;"></div>

			<form class="form-horizontal" method="post" id="semanticSearchForm" name="semanticSearchForm" enctype="multipart/form-data" action="<%=basePath %>toJsonOverView.do?area=cn">
			<input type="hidden" id="strSources" name="strSources" value="14,15">
			<input type="hidden" id="strWhere" name="strWhere">
			
			<br />
			<div class="row-fluid">
				<div class="span2">
					<strong style="color:#333;font-size:14px;">语义检索：</strong><span style="color:#999;font-size:12px;"><br />可以输入一个公开号 CN105549259A，或者一个申请号CN201610112692.8来进行检索
<br />也可以输入一段技术信息文字 (如权利要求 : "一种显示面板...")来检索</span>
				</div>
				<div class="span10">
					<textarea id="strWhere_ori" name="strWhere_ori" cols="50" rows="8" style="width:100%; margin-bottom: 0px;"></textarea>
				</div>
				
				
			</div>
			<div style="height:20px;"></div>
			<div class="row-fluid">
			    <div class="span2"></div>
				<div class="span10">
				    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<button class="btn btn-warning" type="button" onClick="javascript:formSubmit();"><i class="icon-search icon-white"></i>&nbsp;检 索</button>
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<button class="btn btn-success" type="reset"><i class="icon-repeat icon-white"></i>&nbsp;重 置</button>
				</div>
			</div>
		</form>
		
				</div>
			<!--表格检索结束-->
</div>


<%@ include file="include-buttom.jsp"%>

	</body>
</html>
