<!DOCTYPE html>
<html>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.corebiz.search.entity.PatentInfo,com.cnipr.cniprgz.security.SecurityTools" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="detail" uri="/WEB-INF/taglib/detail.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="java.net.*"%>

<%@ include file="include-head-base.jsp"%>

<%
String pictype = "tif";
String dbName = (String)request.getAttribute("dbName");
if (dbName!=null&&dbName.contains("wgzl")) {
	pictype = "jpg";
}

PatentInfo patentinfo = ((PatentInfo)request.getAttribute("patentInfo"));

//out.println(patentinfo.getAb());

String tifServerURL = DataAccess.getProperty("PicServerURL");
String GBServerURL = DataAccess.getProperty("GBServerURL");
String pi_title = ((PatentInfo)request.getAttribute("patentInfo")).getTi();
if (pi_title == null) {
	pi_title = "";
} else {
	pi_title = pi_title.replace("<font color=red>", "").replace("</font>", "");
	pi_title = pi_title.replace("<font style='color:red'>", "").replace("</font>", "");	
}

String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");

String userId = "";
if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
{
	userId = ((String)request.getSession().getAttribute(Constant.APP_USER_ID));	
}

String strWhere = (String)request.getAttribute("strWhere");
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//System.out.println("hangye="+hangye);
%>
<head>
<style type="text/css">
p{
     text-indent:2em;    /*每个P段落，首行空出两个空格，即缩进两个字符*/
}
	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=pi_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	
<script type="text/javascript" src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>

<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet"/>
<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet"/>
<link href="<%=basePath%>common/tu/css/fancybox.css" rel="stylesheet" />
<link href="<%=basePath%>industryIPCtree/zTreeStyle3.5/zTreeStyle.css" rel="stylesheet">

<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/com_2/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>common/mask/mask.js"></script>
<SCRIPT type=text/javascript src="<%=basePath%>common/mask/lhgdialog.min.js?skin=chrome"></SCRIPT>

<script type="text/javascript">
String.prototype.replaceAll  = function(s1,s2){
	return this.replace(new RegExp(s1,"gm"),s2);
}

function getPicURL() {}
		
		var sRoot = "<%=basePath%>";
		var tifServerURL = "<%=tifServerURL%>";
		function MoveTo1(pageIndex){
//				document.getElementById("simFlag").value="";
//				document.detailSearchForm.sqFlag.value="N";
			document.detailSearchForm.action="<%=basePath%>detailSearch.do?method=detailSearch";
			document.detailSearchForm.strSources.value="${requestScope.strSources}";
			document.detailSearchForm.target="_self";
			document.detailSearchForm.index.value = pageIndex-1;
			document.detailSearchForm.submit();
		}

		function MoveTo(pageIndex){
//			alert(pageIndex);
			if(pageIndex>5000000){
				showexp("下一条已超过第500万条专利");
				return;
			}
			
//			$("#detailSearchForm #strWhere").val("##"+escape($("#detailSearchForm #strWhere").val()));			
			$("#detailSearchForm #strWhere").val("##"+escape("<%=strWhere%>"));			
			
			$("#detailSearchForm #strSources").val("${requestScope.strSources}");
			$("#detailSearchForm #index").val(pageIndex-1);
			$("#detailSearchForm").attr("target","_self");
			$("#detailSearchForm").attr("action","<%=basePath%>detailSearch.do");
			$("#detailSearchForm").submit();
		}
/*
		function JumpTo(){
			var jumpPage = document.getElementById("txtJumpPageNumber").value;
			var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数    
		    if (!re.test(jumpPage)) {
				alert("请输入数字！");
				return;
		    }
				
			if (jumpPage <= 0) {
				MoveTo(0);
			} else if (jumpPage<=${requestScope.page.pageCount}) {
				MoveTo(jumpPage - 1);
			} else {
				MoveTo(${requestScope.page.pageCount} - 1);
			}
		}
*/			
		var patentList = "[{an:'${requestScope.patentInfo.an}',sectionName:'${requestScope.dbName}'," 
							+ "ti:'${requestScope.patentInfo.ti}',pic:'${requestScope.patentInfo.pic}',"
							+ "agt:'${requestScope.patentInfo.agt}',countryCode:'${requestScope.patentInfo.countryCode}'," 
							+ "tifDistributePath:'${requestScope.patentInfo.tifDistributePath}',pages:'${requestScope.patentInfo.pages}'}]";
			
		function Print()
		{
		  	var theDate =new Date();
			var random=theDate.getTime();
			var inargs = new Array("PRINT");
			var strHeight = "350";	
			var searchType = "0";
			var returnval = window.showModalDialog("<%=basePath%>jsp/zljs/SelectPDColumn_CN.jsp?rd="+random+"&t="+searchType+"&dt=PRINT",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
			if(returnval != null)
			{
				var strReturnValue = returnval[1];
				document.downloadOrPrint.patentList.value = patentList;
				document.downloadOrPrint.downloadcol.value = strReturnValue;
				document.downloadOrPrint.action="<%=basePath%>print.do?method=abstractPrint&area=0";
				document.downloadOrPrint.target="_blank";
				document.downloadOrPrint.submit();
			}
		}

	function Download()
	{
//		document.downloadOrPrint.target="_self";
//		var patentList = getPatentList();		
//		alert(patentList);
//		alert('${requestScope.patentInfo.an}');
		document.downloadOrPrint.patentList.value = '${requestScope.patentInfo.an}';
		
		//0:Excel文件
		//1:专利数据文件
		var strDownFileType = 0;
		document.downloadOrPrint.downtype.value = strDownFileType;
		
		document.downloadOrPrint.downloadcol.value = "申请（专利）号,名称,主分类号,分类号,申请（专利权）人,发明（设计）人,公开（公告）日,公开（公告）号,专利代理机构,代理人,申请日,地址,摘要,国省代码";
		
		document.downloadOrPrint.action = "<%=basePath%>downloadAbstract.do";				
		document.downloadOrPrint.submit();
	}

			function viewPub(searchSource){
				document.viewPubForm.action="<%=basePath%>search.do?method=detailSearch";
				document.viewPubForm.strSources.value=searchSource;
				document.viewPubForm.strWhere.value="申请号="+jQuery.trim($("#appNo").html());
				document.viewPubForm.sqFlag.value="Y";
				document.viewPubForm.action="<%=basePath%>search.do?method=detailSearch";
				document.viewPubForm.target="_blank";
				document.viewPubForm.submit();
			}			
			
			function callbackShowFamily(msg){
				if(msg!=""){
					var content = "<p><table>";
					var arr = msg.split(",");
					
					for(var i=0;i<arr.length;i++){
						var channel = arr[i].substring(0,2)+"patent";
						content += "<tr><td>" + arr[i] + "</td></tr>";
					}
					content += "</table>";
					//alert(content);
					div_tzzl.innerHTML = content;
					
				}else{
					div_tzzl.innerHTML = "<p>本专利没有同族专利项";
				}
				//alert(msg);
			}
</script>
		
		
<script language="javascript">
  var loadimg='<%=basePath%>images/loading.gif'; //加载时的loading图片
  loadimg='<img src="'+loadimg+'">'; //加载时的loading图片
  
  function showPage(tabId, url){
//alert(tabId+"........."+url);	  
    $('#maintab a[href="#'+tabId+'"]').tab('show'); //显示点击的tab页面
//  alert($('#'+tabId).html());
	if($('#'+tabId).html().length<20)
	{ // 当tab页面内容小于20个字节时ajax加载新页面
		$('#'+tabId).html('<br>'+loadimg+' 页面加载中，请稍后...'); //设置页面加载时的loading图片
//		$('#'+tabId).load(url); //ajax加载页面

		var text = "";
		$.ajax({
//		alert("5555");	
			type : "GET",
			url : "<%=basePath%>" + "/" + url + "&" + new Date(),
//			data : {
//				'favoritepatents' : params.favoritepatents,
//				'totalPages' : params.totalPages
//			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
//alert(jsonresult);
//				$('#myModal').modal('hide');
				$('#'+tabId).html($.trim(jsonresult));
			}
		});
	}
}

function show_FTXML(tabId){
alert("show_FTXML");
$('#maintab a[href="#'+tabId+'"]').tab('show'); // 显示点击的tab页面
alert("55555");
alert($('#'+tabId).html());
}
</script>
</head>


<body style="background-color: #e6f2f0;">


<div class="row-fluid mycolor">
	<div style="width:950px;height:40px;margin: auto;">

		<%if(areacode!=null&&areacode.equals("041")&&!hangye.equals("")){%>
			<a href="<%=basePath%>index_<%=hangye%>.jsp"><img src="client/neimeng/images/hangye/<%=hangye%>_logo.png"></a>
		<%}else{ %>			
			<a href="<%=basePath%>"><img src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/x_logo.png"></a>
		<%} %>

	</div>
</div>

<div class="container" style="width:950px;line-height:40px;">
		<span style="float:right;margin-top:4px;"><input name="button" class="btn btn-default" type="button" onClick="javascript:window.close();" value="关闭窗口"></span>
</div>

<div class="container" style="width:950px;background-color: #ffffff;margin:auto;padding:8px;">
	<div style="width:934px;margin: auto;">
	 <div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group" id="maintab">
		  <a class="btn btn-default mycolor_bor" href="#jiben" data-toggle="tab"><span class="glyphicon glyphicon-list-alt" title="基本信息"> 基本信息</span></a>

<%
String cnAbXML = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnAbXML");
cnAbXML = (cnAbXML==null||cnAbXML.equals(""))?"0":cnAbXML;
%>
		  
<a class="btn btn-default mycolor_bor" href="#falv" data-toggle="tab" onclick='showPage("falv","viewLegalStatus.do?strAn=${requestScope.patentInfo.an}")'><span class="glyphicon glyphicon-check" title="法律状态"> 法律状态</span></a>
<a class="btn btn-default mycolor_bor" href="#xinxi" data-toggle="tab"><span class="glyphicon glyphicon-th-list" title="信息查询"> 信息查询</span></a>
<a class="btn btn-default mycolor_bor" href="#tif" data-toggle="tab"><span class="glyphicon glyphicon-book" title="图形全文" > 图形全文</span></a>

<%
if(cnAbXML.equals("1")){
	String DraPages = patentinfo.getDraPages();
	DraPages = (DraPages==null||DraPages.equalsIgnoreCase(""))?"0":DraPages;	
%>
<a class="btn btn-default mycolor_bor" href="#ft" data-toggle="tab"><span class="glyphicon glyphicon-font" title="说明书"> 说明书</span></a>
<a class="btn btn-default mycolor_bor" href="#clm" data-toggle="tab"><span class="glyphicon glyphicon-font" title="权利要求书"> 权利要求书</span></a>
<%if(!DraPages.equals("0")){%>
 <!-- 
 <a class="btn btn-default mycolor_bor" href="#dra" data-toggle="tab"><span class="glyphicon glyphicon-font" title="说明书附图"> 说明书附图</span></a>
 -->
<%}}%>

		  <!-- 
		  <a class="btn btn-default mycolor_bor" href="#futu" data-toggle="tab"><span class="glyphicon glyphicon-picture" title="代码化附图"> 代码化附图</span>		
		  </a> -->
		  <!-- 
		  <a class="btn btn-default mycolor_bor" href="#"><span class="glyphicon glyphicon-print" title="打印文摘"> 打印文摘</span>		
		  </a> -->
		  
<%
if(false){
if(cnAbXML.equals("1") && patentinfo.getSqTifPath() != null && !patentinfo.getSqTifPath().equals("") && patentinfo.getSectionName() != null && !patentinfo.getSectionName().startsWith("wgzl"))
{				
	String section = patentinfo.getSectionName();
	if (patentinfo.getSectionName().startsWith("fmzl") || patentinfo.getSectionName().startsWith("fmsq"))
		section = "fmsq_ab,fmsq_ft";

	if(SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW)!=null && SetupAccess.getProperty(SetupConstant.DAIMAHUAVIEW).equals("1"))
	{
		if ( patentinfo.getPages() != null && !patentinfo.getPages().equals("1") && !patentinfo.getPages().equals("0") 
				&& patentinfo.getSectionName().contains("_ab")==false)
		
%>
<a class="btn btn-default mycolor_bor" ><span class="glyphicon glyphicon-font" title="代码化" onClick='document.ViewXML.channel.value="<%=section%>";document.ViewXML.submit();'> 授权代码化</span></a>
<%	
	}
}
}
%>

<%
			String pn = ((PatentInfo)request.getAttribute("patentInfo")).getPn();
//			取前缀国家
			String co = pn.substring(0,2);
//			取（）中的字符
			int i1 = pn.indexOf("(");
			int i2 = pn.indexOf(")");
			String check = "";
			if(i1>0&&i2>0){
				check = pn.substring((i1+1),i2);
			}
//			取删除（）和前缀中的字符
			String num1 = pn.replace(co,"");
			String num2 = num1.replace(check,"");
			String num3 = num2.replace("(","");
			String num = num3.replace(")","");
%>
		  
		  <a class="btn btn-default mycolor_bor"><span class="glyphicon glyphicon-download" title="下载文摘" onClick="javascript:Download()"> 下载文摘</span>		
		  </a>	
	    </div>
	 </div>
   </div>
   
   
		<form name="downloadOrPrint" action="<%=basePath%>downloadAbstract.do" method="post">
			<input type="hidden" name="onepatent" value="1">
			<input type="hidden" name="patentList">
			<input type="hidden" name="downloadcol">
			<input type="hidden" name="downtype">
			<input type="hidden" name="area" id="area" value="cn">
		</form>
		
		<form name="PatentInfo">
			<input type="hidden" name="strUrl" value="">
			<input type="hidden" name="strAPO" value="">
			<input type="hidden" name="strTI" value="">
			<input type="hidden" name="strIPC" value="">
			<input type="hidden" name="strANN" value="">
			<input type="hidden" name="strPage" value="">
			<input type="hidden" name="strSavePath" value="">
		</form>

		<form name="detailSearchForm" id="detailSearchForm" action="<%=basePath%>detailSearch.do" method="post"
			target="_self">
			<input type="hidden" name="strWhere" id="strWhere"
				value="${requestScope.strWhere}">
			<input type="hidden" name="strChannels" id="strChannels"
				value="${requestScope.strChannels}">
			<input type="hidden" name="strSources" id="strSources"
				value="${requestScope.strSources }">
			<input type="hidden" name="strSortMethod"
				value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols" value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType"
				value="${requestScope.iHitPointType }">
			<input type="hidden" name="bContinue"
				value="${requestScope.bContinue }">
			<input type="hidden" name="index" id="index">
			<input type="hidden" name="area" id="area" value="cn">
			<input type="hidden" name="dateLimit" id="dateLimit" value="">
			<input type="hidden" name="appNum" id="appNum"  value="">
			<input type="hidden" name="simFlag" id="simFlag"  value="">
			<input type="hidden" name="apdRange" id="apdRange"  value="">
			<input type="hidden" name="sqFlag" id="sqFlag"  value="">
			<input type="hidden" name="singledb" id="singledb"  value="${requestScope.patentInfo.sectionName}">
		</form>
		
		<form name="viewPubForm"
			action="<%=basePath%>search.do?method=detailSearch" method="post"
			target="_self">
			<input type="hidden" name="strWhere"
				value="${requestScope.strWhere }">
			<input type="hidden" name="strChannels"
				value="${requestScope.strChannels}">
			<input type="hidden" name="strSources" id="strSources"
				value="${requestScope.strSources }">
			<input type="hidden" name="strSortMethod"
				value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols"
				value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType"
				value="${requestScope.iHitPointType }">
			<input type="hidden" name="bContinue"
				value="${requestScope.bContinue }">
			<input type="hidden" name="index">
			<input type="hidden" name="area" value="cn">
			<input type="hidden" name="dateLimit" id="dateLimit" value="">
			<input type="hidden" name="appNum" id="appNum"  value="">
			<input type="hidden" name="simFlag" id="simFlag"  value="">
			<input type="hidden" name="apdRange" id="apdRange"  value="">
			<input type="hidden" name="sqFlag" id="sqFlag"  value="">
			<input type="hidden" name="singledb" id="singledb"  value="${requestScope.patentInfo.sectionName}">
		</form>

		<form name='legalStatusForm' method='post' target='_blank'
			action="<%=basePath%>viewLegalStatus.do?method=viewLegalStatus&strAn=${requestScope.patentInfo.an}" onSubmit="javascript:window.open('','','resizable=yes,width=580,height=320,top=0,scrollbars=yes')">
		</form>
		
		<form name="viewInstructionForm" action="<%=basePath%>showPIC.do?method=viewDocument" method="post" target="_blank">
			<input type="hidden" name="strUrl" value="${requestScope.patentInfo.tifDistributePath}">
			<input type="hidden" name="strChannels"	value="${requestScope.strChannels}">
			<input type="hidden" name="strAn" value="${requestScope.patentInfo.an}">
			<input type="hidden" id="an" name="an" value="${requestScope.patentInfo.an}">
			<input type="hidden" name="ti" value="${requestScope.patentInfo.ti }">
			<input type="hidden" name="totalPages" value="${requestScope.patentInfo.pages}">
			<input type="hidden" name="strIPC"	value="${requestScope.patentInfo.pic }">
			<input type="hidden" name="strANN"	value="${requestScope.patentInfo.pa }">
			<input type="hidden" name="dbName"	value="${requestScope.dbName }">
			<input type="hidden" name="pictype"	value="<%=pictype%>">
			<input type="hidden" name="FTS" value="">
		</form>
		 <% if(strItemGrant.contains(SetupConstant.DAIMAHUAVIEW)){%>
		<form name="ViewXML" action="<%=basePath%>showXML.do" target="_blank" method="post">
			<input type="hidden" id="an" name="an" value="${requestScope.patentInfo.an}">
			<input type="hidden" name="channel" value="${requestScope.dbName}">
			<input type="hidden" name="pd" value="${requestScope.patentInfo.pd }">
			<input type="hidden" name="CLM_Page" value="${requestScope.patentInfo.clmPages }">
			<input type="hidden" name="DES_Page" value="${requestScope.patentInfo.desPages }">
			<input type="hidden" name="DRA_Page" value="${requestScope.patentInfo.draPages }">
			<input type="hidden" name="strPage" value="${requestScope.patentInfo.pages }">
			<input type="hidden" name="strUrl" value="${requestScope.patentInfo.tifDistributePath}">
			<input type="hidden" name="strTI" value="${requestScope.patentInfo.ti }">
			<input type="hidden" name="pages" value="${requestScope.patentInfo.pages }">
		</form>
		<%} %>


<%       //专利号
			String an = patentinfo.getAn();
			//取前缀国家
			String cn=an.substring(0,2);
			//去掉前缀
			String sqh = an.replace(cn,"");
			String sqh_ = sqh.replace(".", "");
			//申请(专利权)人
			String pa = patentinfo.getPa();			
			
			String flzt_info = patentinfo.getFlzt();
			String _flzt_info = "";
			
			if(flzt_info!=null&&!flzt_info.equalsIgnoreCase("null")) {
				if(flzt_info.equals("在审")){
					_flzt_info = ("&nbsp;<span class=\"label label-info\">在审</span>");
				}else if(flzt_info.equals("无效")){
					_flzt_info = ("&nbsp;<span class=\"label label-default\">无效</span>");
				}else if(flzt_info.equals("有效")){
					_flzt_info = ("&nbsp;<span class=\"label label-success\">有效</span>");
				}else{
					_flzt_info = ("&nbsp;<span class=\"label label-default\">"+flzt_info+"</span>");
				}
			}
   %>
   
<!--tabstart-->
<div class="tab-content">
<!--基础信息 tabstart-->
<div class="tab-pane fade in active" id="jiben">
      	<!--标题 start-->
		<div style="width:934px;padding:8px;background-color: #ffffff;margin: auto;display: inline-block;color:#009999;font-weight:bold;">
		<h4>${requestScope.patentInfo.ti} <span class="label label-success">${requestScope.patentInfo.estype}</span> <%=_flzt_info%></h4>
		</div>
		<!--标题 end-->
		
		<div style="background-color: #ffffff;margin: auto;">
		
		<!-- 
		<detail:toolBar area="cn" patentInfo="${requestScope.patentInfo}" wggb="${requestScope.wggb}"></detail:toolBar>
		-->
		 
			<!--基本著录项 start-->
			<table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">申请（专利）号:</td>
					<td class="table_35">										
					<%
					String ShowBase64 = (String)application.getAttribute("ShowBase64");
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5) {
					%>
					<img id="validateImg" src="data:image/png;base64,${requestScope.patentInfo.anbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.an}
					<%}%>
					</td>

					<td class="table_15">申请日:</td>
					<td class="table_35">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5) {
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.adbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.ad}
					<%}%>
					</td>
				</tr>
				<tr>
					<td class="table_15"><% if ( !dbName.contains("fmsq")) {%>公开（公告）号
									<%} else { %>授权（公告）号 <%} %>:</td>
					<td class="table_35">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5){
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.pnmbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.pnm}
					<%}%>
					</td>
					<td class="table_15"><% if ( !dbName.contains("fmsq")) {%>公开（公告）日
									<%} else { %>授权（公告）日<%} %>:</td>
					<td class="table_35">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5){
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.pdbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.pd}
					<%}%>
					</td>
				</tr>
				<tr>
					<td class="table_15">申请（专利权）人:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pa}
					</td>
<!--
<script type="text/javascript">
$(document).ready(function(){
	$("#pa_imgObj").attr("src","<%=basePath%>patentDetailImage?item=pa");
})
</script>
-->
				</tr>
				<tr>
					<td class="table_15">发明（设计）人:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pin}</td>
				</tr>
				<tr>
					<td class="table_15">地址:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.ar}</td>
				</tr>
				<tr>
					<td class="table_15">主分类号:</td>
					<td class="table_35">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&(patentinfo.getSic().equals(patentinfo.getPic()))){
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.picbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.pic}
					<%}%>
					
					</td>
					<td class="table_15">国省代码:</td>
					<td class="table_35">${requestScope.patentInfo.co}</td>
				</tr>
				<tr>
					<td class="table_35" colspan="4"><span class="glyphicon glyphicon-chevron-down" style="color:#666666;"> </span><a onClick="return click_a('divOne_1')" style="cursor:pointer;color:#f9a126;font-weight: bold;"> 查看其它著录项</a></td>
				</tr>
			</table>
			<div id="divOne_1" style="display:none;margin-top:-10px;">
				<table class="table table-condensed" style="font-size:13px;">
					<tr>
						<td class="table_15">分类号:</td>
						<td class="table_35" colspan="3">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&(patentinfo.getSic().equals(patentinfo.getPic()))){
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.sicbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.sic}
					<%}%>
						
						</td>
					</tr>
					<tr>
						<td class="table_15">专利代理机构:</td>
						<td class="table_35" colspan="3">${requestScope.patentInfo.agc}</td>
					</tr>
					<tr>
						<td class="table_15">代理人:</td>
						<td class="table_35">${requestScope.patentInfo.agt}</td>
						<td class="table_15">国际公布:</td>
						<td class="table_35">${requestScope.patentInfo.ipn}</td>
					</tr>
					<tr>
						<td class="table_15">进入国家日期:</td>
						<td class="table_35">${requestScope.patentInfo.den}</td>
						<td class="table_15">国际申请:</td>
						<td class="table_35"> ${requestScope.patentInfo.ian}</td>
					</tr>
					<tr>
						<td class="table_15">优先权:</td>
						<td class="table_35">${requestScope.patentInfo.pr}</td>
						<td class="table_15">分案申请号:</td>
						<td class="table_35">${requestScope.patentInfo.dan}</td>
					</tr>
					<tr>
						<td class="table_15">颁证日:</td>
						<td class="table_35">${requestScope.patentInfo.ipd}</td>
						<td class="table_15">范畴分类:</td>
						<td class="table_35">${requestScope.patentInfo.fcic}</td>
					</tr>

				</table>
			</div>
			<!--基本著录项 end-->
			
			<!--摘要 start-->
			<div class="row">

<%
String cnAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnAbfigure");
cnAbfigure = (cnAbfigure==null||cnAbfigure.equals(""))?"1":cnAbfigure;
%>
				<div class="col-md-6" style="padding-left:30px;">
					<P>摘要：
						<br>
						
						${requestScope.patentInfo.ab}
						
</P>

<%
if(!cnAbfigure.equals("1")){
%>
</div>
<div class="col-md-6" style="padding-left:30px;">
<%
}
%>

					<P>主权项：
						<br>${requestScope.patentInfo.cl}
					</P>

				</div>
				

<%
//String cnAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnAbfigure");
//cnAbfigure = (cnAbfigure==null||cnAbfigure.equals(""))?"1":cnAbfigure;
if(cnAbfigure.equals("1")){
%>
				<div class="col-md-6">

<%
//out.println(patentinfo.getAbPicPath());
					String imgurl = patentinfo.getAbPicPath().equals(DataAccess.getProperty("PicServerURL")+"//foreignimage/")?basePath+"/common/tu/ganlan_pic1.gif":patentinfo.getAbPicPath();
					out.println("<a class=\"fancybox\" rel=\"group\" href=\""+imgurl+"\">");
					out.println("<img class=\"img-thumbnail img-responsive\" style=\"max-height:300px;\" src=\""+patentinfo.getAbPicPath()+"\" complete=\"complete\" onerror=\"javascript:this.src='"+basePath+"/common/tu/ganlan_pic1.gif';\"/>");
					out.println("</a>");
%>


				</div>
<%}%>
				
			</div>
			<hr>
			
			<!--摘要 end-->
		</div>
   </div>
    <!--基础信息 end-->
     <!--TIF图形全文 start-->
   <div class="tab-pane fade" id="tif" style="min-height:680px ;">
      <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-picture" style="color:#f9a126;"> </span> 图形全文</td>
				</tr>
	  </table>
			
<div></div>
										
	<div class="jumbotron">
	
	
<%
//String TifDistributePath = (patentInfo.getTifDistributePath()==null&&patentInfo.getSqTifPath()!=null)?patentInfo.getSqTifPath().replaceAll("SD","FM").replaceAll("SQ","FM"):patentInfo.getTifDistributePath();
//String intPatentPages = (patentInfo.getPages()==null&&patentInfo.getSqTifPages()!=null&&Integer.parseInt(patentInfo.getSqTifPages())>0)?patentInfo.getSqTifPages():patentInfo.getPages();

int responseCode = com.cnipr.cniprgz.func.search.SearchFunc.testTIF(patentinfo.getTifDistributePath());
if(responseCode==404){
	out.println("系统中无本专利说明书");	
}else{
%>
        <p><a href="javascript:

        			document.viewInstructionForm.strUrl.value='<%=patentinfo.getTifDistributePath() %>';
					document.viewInstructionForm.totalPages.value='<%=patentinfo.getPages()%>';
					document.viewInstructionForm.submit()" class="btn btn-lg btn-info"><i
					class="icon-repeat icon-white"></i>&nbsp;立即查看说明书全文</a>

<%
}

responseCode = com.cnipr.cniprgz.func.search.SearchFunc.testTIF(patentinfo.getSqTifPath());
if(responseCode==404){
	//out.println("系统中无本专利审定、授权说明书");	
}else{
if(patentinfo.getSqTifPath() != null && !patentinfo.getSqTifPath().equals("") && patentinfo.getSectionName() != null && !patentinfo.getSectionName().startsWith("wgzl"))
{				
	String section = patentinfo.getSectionName();
	if (patentinfo.getSectionName().startsWith("fmzl") || patentinfo.getSectionName().startsWith("fmsq")){
		section = "fmsq_ab,fmsq_ft";
	}
%>				
<a href="javascript:document.viewInstructionForm.strUrl.value='<%=patentinfo.getSqTifPath().replaceAll("\\\\", "/")%>';
					document.viewInstructionForm.totalPages.value='<%=patentinfo.getSqTifPages()%>';
					document.viewInstructionForm.submit()" class="btn btn-lg btn-success"><i
										class="icon-repeat icon-white"></i>&nbsp;立即查看审定、授权说明书全文</a>

<%}
}
%>


      </div>
										
   </div>
   <!--TIF图形全文 end-->
   <!--法律状态 start-->
   <div class="tab-pane fade" id="falv" style="min-height:680px;">
   	
   </div>
   
	<div class="tab-pane fade" id="ft" style="min-height:680px;">
	<table class="table table-condensed" style="font-size:13px;">
		<tr>
			<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-font" style="color:#f9a126;"> </span> 说明书</td>
		</tr>
	</table>
	<div class="row" style="padding:12px;">
		<div class="col-md-9"><P><%=patentinfo.getFt().trim()%></P> </div>
        <div class="col-md-3 imgbox"><%=patentinfo.getFtDra()%></div>
	</div>
	</div>
   
   <div class="tab-pane fade" id="clm" style="min-height:680px;">
   
   <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-font" style="color:#f9a126;"> </span> 权利要求书</td>
				</tr>
	</table>
	<div class="row" style="padding:12px;">
				<div class="col-md-10"><P> <%=patentinfo.getClm()%></P> </div>
                <div class="col-md-2 imgbox"></div>
	</div>
	</div>

    <!--信息查询 start-->
   <div class="tab-pane fade" id="xinxi" style="min-height:680px;">
      <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-th-list" style="color:#f9a126;"> </span> 信息查询</td>
				</tr>
	  </table>
	  <table class="table table-condensed" style="font-size:13px;">	  
				<tr>
					<td class="table_15">引证文献:</td> 
					<td class="table_35"><font style="color:#ff6600;">去欧专局查看</font> <a href="http://worldwide.espacenet.com/publicationDetails/citedDocuments?CC=<%=co%>&NR=<%=num%><%=check%>&KC=<%=check%>&FT=D"  target="_blank">点击链接</a></td>
					<td class="table_15">同族专利:</td>
					<td class="table_35"><font style="color:#ff6600;">去欧专局查看</font> <a href="http://worldwide.espacenet.com/publicationDetails/inpadocPatentFamily?CC=<%=co%>&NR=<%=num%><%=check%>&KC=<%=check%>&FT=D"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">收费信息查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/searchfee/searchfee_action.jsp?sqh=<%=sqh %>"  target="_blank">点击链接</a></td>
				</tr>
	  			<!-- 
				<tr>
					<td class="table_15">引证文献:</td> 
					<td class="table_35"><font style="color:#ff6600;">去欧专局查看</font> <a href="http://worldwide.espacenet.com/publicationDetails/citedDocuments?CC=<%=co%>&NR=<%=num%><%=check%>&KC=<%=check%>&FT=D"  target="_blank">点击链接</a></td>
					<td class="table_15">同族专利:</td>
					<td class="table_35"><font style="color:#ff6600;">去欧专局查看</font> <a href="http://worldwide.espacenet.com/publicationDetails/inpadocPatentFamily?CC=<%=co%>&NR=<%=num%><%=check%>&KC=<%=check%>&FT=D"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">事务性公告:</td>
					<td class="table_35"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://search.sipo.gov.cn/sipo/zljs/AffairResult.jsp?searchword=%c9%ea%c7%eb%ba%c5%3d<%=sqh %>%25"  target="_blank">点击链接</a></td>
					<td class="table_15">收费信息查询:</td>
					<td class="table_35"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/searchfee/searchfee_action.jsp?sqh=<%=sqh %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">通知书发文信息查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/notice/searchnotice_result.jsp?sqh=<%=sqh %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">退信信息检索:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/quitletter/searchquitletter_result.jsp?sqh=<%=sqh %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">专利证书发文查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/certificate/searchcertificate.jsp?sqh=<%=sqh %>"  target="_blank">点击链接</a></td>
				</tr>
				 -->
			</table>
			
<%
String[] arrPa = pa.split(";");
//<%=URLEncoder.encode((String)request.getAttribute("strWhere"), "UTF-8")
%>
			
			<table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">百度网页搜索:</td>
					<td class="table_35" colspan="3">
					<%
					for(int i=0;i<arrPa.length;i++){
					%>
					<a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=<%=URLEncoder.encode(arrPa[i], "UTF-8")%>"  target="_blank"><%=arrPa[i]%></a>
					<%}%>
					</td>
				</tr>
				<tr>
					<td class="table_15">百度学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.baidu.com/s?wd=<%=URLEncoder.encode(pi_title, "UTF-8")%>&ie=utf-8"  target="_blank"><%=pi_title%></a></td>
				</tr>
				<tr>
					<td class="table_15">360搜索网页搜索:</td>
					<td class="table_35" colspan="3">
					
					<%
					for(int i=0;i<arrPa.length;i++){
					%>
					<a href="http://www.so.com/s?ie=utf-8&shb=1&src=home_www&q=<%=URLEncoder.encode(arrPa[i], "UTF-8")%>"  target="_blank"><%=arrPa[i] %></a>
					<%}%>
					
					</td>
				</tr>
				<tr>
					<td class="table_15">360学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.so.com/s?ie=utf-8&shb=1&src=360sou_home&q=<%=URLEncoder.encode(pi_title, "UTF-8")%>"  target="_blank"><%=pi_title%></a></td>
				</tr>
			</table>
   </div>
   <!--信息查询 end-->
</div>
<!--tabsend-->

</div>

<!--底部展示-->
<%@ include file="include-buttom.jsp"%>
  
	</body>
</html>
<!-- 
<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>
 -->
<script language="javascript" type="text/javascript">
        function click_a(divDisplay)
        {
            if(document.getElementById(divDisplay).style.display != "block")
            {
                document.getElementById(divDisplay).style.display = "block";
            }
            else
            {
                document.getElementById(divDisplay).style.display = "none";
            }
        }
</script>

<script src="<%=basePath%>common/tu/js/jquery.fancybox.pack.js"></script>
<script type="text/javascript">
$(".fancybox").fancybox();
</script>

<script language="javascript">
var loadimg='<%=basePath%>images/loading.gif'; //加载时的loading图片
loadimg='<img src="'+loadimg+'">'; //加载时的loading图片
  
function showPage11(tabId, url){
  $('#maintab a[href="#'+tabId+'"]').tab('show');// 显示点击的tab页面
  if($('#'+tabId).html().length<20){// 当tab页面内容小于20个字节时ajax加载新页面
	  $('#'+tabId).html('<br>'+loadimg+' 页面加载中，请稍后...');// 设置页面加载时的loading图片
	  $('#'+tabId).load(url);// ajax加载页面
  }
}

</script>