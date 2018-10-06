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
	<title>号码批量检索【中国】-<%=website_title%></title>
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
function getRandom(min, max){
    var r = Math.random() * (max - min);
    var re = Math.round(r + min);
    re = Math.max(Math.min(re, max), min)
     
    return re;
}

function formSubmit(){
//	document.batchSearchForm.action="<%=basePath %>pretoJsonOverView.do?area=cn";
//	document.semanticSearchForm.submit();

//	var strSources = $("#batchSearchForm #strSources").val();
	
	var area = $("#batchSearchForm #area").val();
	
	if(area=="0"||area==0){		
		$("#batchSearchForm #language").val("cn");
		$("#batchSearchForm #strSources").val("fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft");
	}else{
		$("#batchSearchForm #language").val("fr");
		$("#batchSearchForm #strSources").val("uspatent,gbpatent,aupatent,atpatent,espatent,wopatent,frpatent,hkpatent,itpatent,appatent,aspatent,jppatent,sepatent,capatent,eppatent,rupatent,gcpatent,otherpatent,depatent,krpatent,twpatent,chpatent");
	}
	
	var strWhere = $("#batchSearchForm #strWhere_ori").val();
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
	
	strWhere = strWhere.replace("，", ",");
	strWhere = strWhere.replace("；", ",");
	strWhere = strWhere.replace(";", ",");
	strWhere = strWhere.replace(",", " ");
	
	var arr = strWhere.split(" ");
	
//	alert(arr.length);
	if(arr.length<=5000){
		var random = getRandom(0, 100);	
//		$("#batchSearchForm #strSources").val("18");
		$("#batchSearchForm #strWhere").val("号码批量检索='"+strWhere+"'");
		$("#batchSearchForm").attr("action","<%=basePath%>pretoJsonOverView.do?"+random);
	    $("#batchSearchForm").submit();
	}else{
		alert("批量检索号码数据超过上限5000条专利，请缩小范围，重新进行检索。");
	}
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

			<form class="form-horizontal" method="post" id="batchSearchForm" name="batchSearchForm" enctype="multipart/form-data" action="<%=basePath %>toJsonOverView.do?area=cn">
			<input type="hidden" id="strSources" name="strSources" value="">			
			<input type="hidden" id="language" name="language" value="fr">
			<input type="hidden" id="strWhere" name="strWhere">
			
			<br />
			<div class="row-fluid">
				<div class="span2">
					<strong style="color:#333;font-size:14px;">批量检索：</strong><span style="color:#999;font-size:12px;"><br />可以输入多个号码（例如公开号 CN105549259A，或者申请号CN201610112692.8）来进行批量检索
<br /> (中间用逗号或空格隔开)</span>
				</div>
				<div class="span10">
					<textarea id="strWhere_ori" name="strWhere_ori" cols="50" rows="8" style="width:100%; margin-bottom: 0px;"></textarea>
					
					<input type="radio" name="area" value="0" checked="checked">CNIPA
					<input type="radio" name="area" value="1">国外
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
