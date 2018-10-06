<!DOCTYPE html>
<html>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.corebiz.search.entity.PatentInfo" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="detail" uri="/WEB-INF/taglib/detail.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*,java.util.regex.*"%>
<%@ page import="java.net.*"%>

<%@ include file="include-head-base.jsp"%>

<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");

String type = "tif";
String db = (String)request.getAttribute("dbName");
if (db.contains("wgzl")) {
	type = "jpg";
}

String pi_title = ((PatentInfo)request.getAttribute("patentInfo")).getTi();
if (pi_title == null) {
	pi_title = "";
} else {	
	pi_title = pi_title.replace("<font color=red>", "").replace("</font>", "");
	pi_title = pi_title.replace("<font style='color:red'>", "").replace("</font>", "");	
}

PatentInfo patentinfo = (PatentInfo)request.getAttribute("patentInfo");

String strWhere = (String)request.getAttribute("strWhere");
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");

String translate = (String)application.getAttribute("translate");


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=pi_title %></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet">
	<link href="<%=basePath%>common/expert/xmlHttpRequest.js" rel="stylesheet">
	<link href="<%=basePath%>common/tu/css/fancybox.css" rel="stylesheet" />
	
	</head>
		<!--

		<style>

		body,td,tr,li {font-size:10pt; font-family:宋体}
		a{text-decoration:underline;color:#0000ff}
		a:link{text-decoration:underline;color:#0000ff}
		a:visited {text-decoration:underline;color:#0000ff}
		a:hover {color:#EBA007;text-decoration:underline}
		
		</style>
		
		<script type='text/javascript' src='<%=basePath%>dwr/engine.js'></script>
		<script type='text/javascript' src='<%=basePath%>dwr/util.js'></script>
		<script type='text/javascript' src='<%=basePath%>dwr/interface/FamilyFunc.js'></script>
		-->
		
		<script type="text/javascript">
			var sRoot = "<%=basePath%>";
		
			var patentList = "[{an:'${requestScope.patentInfo.an}',sectionName:'${requestScope.dbName}'," 
				+ "ti:'${requestScope.patentInfo.ti}',pic:'${requestScope.patentInfo.pic}',"
				+ "agt:'${requestScope.patentInfo.agt}',countryCode:'${requestScope.patentInfo.countryCode}'," 
				+ "tifDistributePath:'${requestScope.patentInfo.tifDistributePath}',pages:'${requestScope.patentInfo.pages}'}]";
		
			function MoveTo1(pageIndex){
				document.detailSearchForm.index.value = pageIndex-1;
				document.detailSearchForm.submit();
			}

			function MoveTo(pageIndex){
//				alert(pageIndex);
				if(pageIndex>5000000){
					showexp("下一条已超过第500万条专利");
					return;
				}
//				$("#detailSearchForm #strWhere").val("##"+escape($("#detailSearchForm #strWhere").val()));
				$("#detailSearchForm #strWhere").val("##"+escape("<%=strWhere%>"));
				$("#detailSearchForm #strSources").val("${requestScope.strSources}");
				$("#detailSearchForm #index").val(pageIndex-1);
				$("#detailSearchForm").attr("target","_self");
				$("#detailSearchForm").attr("action","<%=basePath%>detailSearch.do");
				$("#detailSearchForm").submit();
			}
			
			function JumpTo(){
				var jumpPage = document.getElementById("txtJumpPageNumber").value;

				var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数    
			    if (!re.test(jumpPage)) {
					alert("请输入数字！");
					return;
			    }
				
				if (jumpPage <= 0) {
					MoveTo(0);
				} else if (jumpPage <= ${requestScope.page.pageCount}) {
					MoveTo(jumpPage - 1);
				} else {
					MoveTo(${requestScope.page.pageCount} - 1);
				}
			}
			
			function Print()
			{
			  	var theDate =new Date();
				var random=theDate.getTime();
				var inargs = new Array("PRINT");
				var strHeight = "350";	
				var searchType = "1";
				var returnval = window.showModalDialog("<%=basePath%>jsp/zljs/SelectPDColumn_FR.jsp?rd="+random+"&t="+searchType+"&dt=PRINT",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
				if(returnval != null)
				{
					var strReturnValue = returnval[1];
					document.downloadOrPrint.patentList.value = patentList;
					document.downloadOrPrint.downloadcol.value = strReturnValue;
					document.downloadOrPrint.action="<%=basePath%>print.do?method=abstractPrint&area=1";
					document.downloadOrPrint.target="_blank";
					document.downloadOrPrint.submit();
				}
			}

			function Download()
			{
				document.downloadOrPrint.patentList.value = '${requestScope.patentInfo.an}';				
				//0:Excel文件
				//1:专利数据文件
				var strDownFileType = 0;
				document.downloadOrPrint.downtype.value = strDownFileType;
				
				document.downloadOrPrint.downloadcol.value = "申请号,专利号,名称,主分类号,分类号,申请（专利权）人,发明（设计）人,公开（公告）日,公开（公告）号,专利代理机构,代理人,申请日,地址,摘要";
				
				document.downloadOrPrint.action = "<%=basePath%>downloadAbstract.do";				
				document.downloadOrPrint.submit();
			}
			
			function Download1()
			{
			  	var theDate =new Date();
				var random=theDate.getTime();
				var inargs = new Array("DOWN");
			
				var strHeight = "465";
				var modelWin="/jsp/zljs/SelectPDColumn_FR.jsp";		
				var searchType = "1";
				
				var returnval = window.showModalDialog("<%=basePath%>jsp/zljs/SelectPDColumn_FR.jsp?checkedRecordNum=1&rd="+random+"&t="+searchType+"&dt=DOWN",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:360px;center:yes;resizable:no;help:no;status:no;scroll:no");
				if(returnval != null)
				{
					var strDataFormat = returnval[0];	
					document.downloadOrPrint.action="<%=basePath%>download.do?method=downloadAbstract&area=1";
					document.downloadOrPrint.target="_self";
					if(strDataFormat=="xml"){
					
						document.downloadOrPrint.patentList.value = patentList;
						var strReturnValue = returnval[1];
						var strDownFileType = returnval[2];
			
						document.downloadOrPrint.downloadcol.value = strReturnValue;
						document.downloadOrPrint.downtype.value = strDownFileType;
						document.downloadOrPrint.submit();			
					}	
				}
			}


			function getDetail(strSource, strAn) {
				document.detail.strSources.value = strSource;
				document.detail.strWhere.value = "申请号=" + strAn;
				document.detail.submit();
			}
			
			function callbackShowFamily(msg){
				//alert(msg);
				
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
			
			function translate()
			{
				$("body").mask("正在翻译，请稍候...");

				$.ajax({
					type : "GET",
//						url : "/" + contextPath + "/expdeleteExp.do?timeStamp=" + new Date(),
					url : "translate.do?timeStamp=" + new Date(),					
					contentType : "application/json;charset=UTF-8",
					success : function(jsonresult) {
//						alert(jsonresult);						
						var _arr = jsonresult.split("\\n");
//						alert(_arr[0]);
//						alert(_arr[1]);
						$("#patent_name_en_0").html("译文:"+_arr[0]);
						if(_arr.length==2){
							$("#patent_name_en_1").html("译文:\r\n"+_arr[1]);
						}
						$("body").unmask();
					}
				})				
			}
		</script>
		
		
		<form name="downloadOrPrint" action="<%=basePath%>downloadAbstract.do" method="post">
			<input type="hidden" id="patentList" name="patentList">
			<input type="hidden" id="downloadcol" name="downloadcol">
			<input type="hidden" id="downtype" name="downtype">
			<input type="hidden" name="area" id="area" value="fr">
		</form>

		<form id="detailSearchForm" name="detailSearchForm" action="<%=basePath%>detailSearch.do" method="post" target="_self">
			<input type="hidden" name="strWhere" id="strWhere" value="${requestScope.strWhere}">
			<input type="hidden" name="strSources" id="strSources" value="${requestScope.strSources }">
			<input type="hidden" name="strSynonymous" id="strSynonymous" value="${requestScope.strSynonymous}">
			<input type="hidden" name="strSortMethod" id="strSortMethod" value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols" id="strDefautCols" value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" id="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" id="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType" id="iHitPointType" value="${requestScope.iHitPointType }">
			<input type="hidden" name="bContinue" id="bContinue" value="${requestScope.bContinue }">
			<input type="hidden" name="index" id="index">
			<input type="hidden" name="area" id="area" value="fr">
		</form>

<form name="detail" action="<%=basePath%>favorite.do?method=getDetail" method="post" target="_blank">
<input type="hidden" name="strWhere">
<input type="hidden" name="strSources">
</form>

		<form name="viewInstructionForm"
			action="http://192.168.3.177:8080/WebReader/pages/flashReader.jsp" method="post"
			target="_blank">
			<input type="hidden" name="strUrl"
				value="${requestScope.patentInfo.tifDistributePath}">
			<input type="hidden" name="strAn"
				value="${requestScope.patentInfo.an }">
			<input type="hidden" name="totalPages"
				value="${requestScope.patentInfo.pages }">
			<input type="hidden" name="dbName"
				value="${requestScope.dbName }">
			<input type="hidden" name="pictype"
				value="<%=type%>">
		</form>
		
		
		
		<form name="reportForm" id="reportForm"
			action="<%=basePath%>search.do?method=reportSearch" method="post"
			target="_blank">
			<input type="hidden" name="strWhere" value="申请号=(${requestScope.patentInfo.an })" />
			<input type="hidden" name="strChannels"		value="${requestScope.strChannels}" />
			<input type="hidden" name="strSources" id="strSources"		value="${requestScope.strSources }" />
			<input type="hidden" name="strSortMethod"	value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols"	value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType"	value="${requestScope.iHitPointType }">
			<input type="hidden" name="bContinue"value="${requestScope.bContinue }">
			<input type="hidden" name="dbName"	value="${requestScope.dbName }">
			<input type="hidden" name="index">
			<input type="hidden" name="strAn" value="${requestScope.patentInfo.an }">
			<input type="hidden" name="area" value="fr">
			<input type="hidden" name="dateLimit" id="dateLimit" value="">
			<input type="hidden" name="appNum" id="appNum"  value="">
			<input type="hidden" name="simFlag" id="simFlag"  value="">
			<input type="hidden" name="apdRange" id="apdRange"  value="">
			<input type="hidden" name="sqFlag" id="sqFlag"  value="">
			<input type="hidden" name="singledb" id="singledb"  value="${requestScope.patentInfo.sectionName}">
		</form>
		
		
		<!-- 公知公用分析 -->
		<form name="gzgyAnalyse" action="<%=DataAccess.getProperty("gzgyAnalyseURL") %>" method="post" target="_blank">
			<input type="hidden" name="ap"
				value="${requestScope.patentInfo.an }">
			<input type="hidden" name="pn"
				value="${requestScope.patentInfo.pnm}">
 
			<input type="hidden" name="remote" value="guangdong">

		</form>
		<script type="text/javascript">
		//FamilyFunc.getFamily("${requestScope.patentInfo.an}", callbackShowFamily);
		</script>
		
		<input type="hidden" id="family" value="${requestScope.patentInfo.family}">
			<input type="hidden" id="area" value="fr">
			<input type="hidden" id="sqDate" value="${requestScope.patentInfo.ad}">
			<input type="hidden" id="sqName" value="${requestScope.patentInfo.ti}">
			<input type="hidden" id="sqID" value="${requestScope.patentInfo.an}"}">
		<script type="text/javascript">
		//FamilyFunc.getFamily("${requestScope.patentInfo.an}", callbackShowFamily);
		function picQuery() {
			var picwin = window.open("<%=basePath%>jsp/zljs/subForward.jsp","同族专利","width=500,height=500,scrollbars=yes,resizable=yes,location=no,menubar=no,titlebar=no,toolbar=no,status=no,z-look=yes");
			picwin.focus();
		}
		</script>

<body style="background-color: #e6f2f0;">
<div class="row-fluid mycolor">
	<div style="width:950px;height:40px;margin: auto;">

		<%if(areacode!=null&&areacode.equals("041")&&!hangye.equals("")){%>
			<a href="<%=basePath%>index_<%=hangye%>.jsp"><img style="height:40px" src="client/neimeng/images/hangye/<%=hangye%>_logo.png"></a>
		<%}else{ %>			
			<a href="<%=basePath%>index.jsp"><img  src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/x_logo.png"></a>
		<%} %>

	</div>
</div>
<div class="container" style="width:950px;line-height:40px;">
		<span>此次检索共命中 ${requestScope.page.pageCount} 条记录，当前为第  ${requestScope.page.pageIndex + 1} 条</span>
						
		<n:page pageCount="${requestScope.page.pageCount}"
							pageIndex="${requestScope.page.pageIndex+1}"></n:page>
							
		<span style="float:right;margin:4px;"><input name="button" class="btn btn-default" type="button" onClick="javascript:window.close();" value="关闭窗口"></span>
</div>
<%
			String pn = ((PatentInfo)request.getAttribute("patentInfo")).getPn();
//			取前缀国家
			String co=pn.substring(0,2);
//			取（）中的字符
			int i1=pn.indexOf("(");
			int i2=pn.indexOf(")");
			String check="";
			if(i1>0&&i2>0){
				check=pn.substring((i1+1),i2);
			}
//			取删除（）和前缀中的字符
			String num1 = pn.replace(co,"");
			String num2 = num1.replace(check,"");
			String num3 = num2.replace("(","");
			String num = num3.replace(")","");
%>
<div class="container" style="width:950px;background-color: #ffffff;margin: auto;padding:8px;">
	<div style="width:934px;margin: auto;">
	 <div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group">
		  <a class="btn btn-default mycolor_bor" href="#jiben" data-toggle="tab"><span class="glyphicon glyphicon-list-alt" title="基本信息"> 基本信息</span>		
		  </a>
		   <a class="btn btn-default mycolor_bor"  href="http://worldwide.espacenet.com/publicationDetails/originalDocument?CC=<%=co %>&NR=<%=num %><%=check %>&KC=<%=check %>&FT=D" target="_blank"><span class="glyphicon glyphicon-book" title="说明书全文"> 说明书全文</span>		
		  </a>
		   <a class="btn btn-default mycolor_bor"  href="http://worldwide.espacenet.com/publicationDetails/description?CC=<%=co %>&NR=<%=num %><%=check %>&KC=<%=check %>&FT=D" target="_blank"><span class="glyphicon glyphicon-book" title="代码化全文"> 代码化全文</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="http://worldwide.espacenet.com/publicationDetails/inpadoc?CC=<%=co %>&NR=<%=num %><%=check %>&KC=<%=check %>&FT=E" target="_blank"><span class="glyphicon glyphicon-check" title="法律状态"> 法律状态</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="http://worldwide.espacenet.com/publicationDetails/citedDocuments?CC=<%=co %>&NR=<%=num %><%=check %>&KC=<%=check %>&FT=D" target="_blank"><span class="glyphicon glyphicon-th-list" title="引证文献"> 引证文献</span>
		  </a>
		  <a class="btn btn-default mycolor_bor" href="http://worldwide.espacenet.com/publicationDetails/inpadocPatentFamily?CC=<%=co %>&NR=<%=num %><%=check %>&KC=<%=check %>&FT=D" target="_blank"><span class="glyphicon glyphicon-print" title="同族专利"> 同族专利</span>
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#"><span class="glyphicon glyphicon-download" title="下载文摘" onClick="javascript:Download()"> 下载文摘</span>		
		  </a>	
	    </div>
	 </div>
   </div>
 <!--tabstart-->
 <div class="tab-content">
 	 <!--基础信息 tabstart-->
   <div class="tab-pane fade in active" id="jiben">
      	<!--标题 start-->
		<div style="width:934px;padding:8px;background-color: #ffffff;margin: auto;display: inline-block;color:#009999;font-weight:bold;">
			
			<h5 style="font-size:14px;font-weight:bold;">
			<span>[${requestScope.patentInfo.estype}]</span>
			<span id="ti">${requestScope.patentInfo.ti}</span>
			<span id="patent_name_en_0"></span>
			<%if(translate.equals("1")){ %>
			<span class="btn btn-warning btn-xs" onclick="javascript:translate();">翻译</span>
			<%} %>
			
			<a onclick="javascript:translate();">翻译111</a>
			</h5>
			
		</div>
		<!--标题 end-->
		
		<div style="background-color: #ffffff;margin: auto;">
			<!--基本著录项 start-->
			<table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">申 请 号:</td>
					<td class="table_35">${requestScope.patentInfo.an}</td>
					<td class="table_15">申 请 日:</td>
					<td class="table_35">${requestScope.patentInfo.ad}</td>
				</tr>
				<tr>
					<td class="table_15">公开(公告)号:</td>
					<td class="table_35"> ${requestScope.patentInfo.pnm}</td>
					<td class="table_15">公开（公告）日:</td>
					<td class="table_35"> ${requestScope.patentInfo.pd}</td>
				</tr>
				<tr>
					<td class="table_15">专 利 号:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pn}</td>
				</tr>
				<tr>
					<td class="table_15">申请(专利权)人:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pa}</td>
				</tr>
				<tr>
					<td class="table_15">发明(设计)人:</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pin}</td>
				</tr>
				<tr>
					<td class="table_15">主分类号:</td>
					<td class="table_35" id=ipc>${requestScope.patentInfo.pic}</td>
					<td class="table_15">优 先 权:</td>
					<td class="table_35">${requestScope.patentInfo.pr}</td>
				</tr>
				<tr>
					<td class="table_35" colspan="4"><span class="glyphicon glyphicon-chevron-down" style="color:#666666;"> </span><a onClick="return click_a('divOne_1')" style="cursor:pointer;color:#f9a126;font-weight: bold;"> 查看其它著录项</a></td>
				</tr>
			</table>
			<div id="divOne_1" style="display:none;margin-top:-10px;">
				<table class="table table-condensed" style="font-size:13px;">
					<tr>
						<td class="table_15">分类号:</td>
						<td class="table_35" colspan="3">${requestScope.patentInfo.sic}</td>
					</tr>
					<tr>
						<td class="table_15">欧洲分类号:</td>
						<td class="table_35" colspan="3">${requestScope.patentInfo.sec}</td>
					</tr>
					<tr>
						<td class="table_15">欧洲主分类号:</td>
						<td class="table_35">${requestScope.patentInfo.pec}</td>
						<td class="table_15">分案申请号:</td>
						<td class="table_35">${requestScope.patentInfo.dan}</td>
					</tr>
					<tr>
						<td class="table_15">同族专利项:</td>
						<td class="table_35" colspan="3">${requestScope.patentInfo.family}</td>
					</tr>
					<tr>
						<td class="table_15">专利引证:</td>
						<td class="table_35" colspan="3"><detail:yzBar scyyzzlList="${requestScope.scyyzzlList}" scyyzfzlList="${requestScope.scyyzfzlList}" sqryzzlList="${requestScope.sqryzzlList}" scybyzzlList="${requestScope.scybyzzlList}" sqrbyzzlList="${requestScope.sqrbyzzlList}"></detail:yzBar></td>
					</tr>

				</table>
			</div>
			<!--基本著录项 end-->
			
			<!--摘要 start-->
			<div class="row">
				<div class="col-md-6" style="padding-left:30px;">
				  摘要：
					<P id="ab"><%=patentinfo.getAb().trim().replace("<p>","").replace("</p>","")%></P>
					<P id="patent_name_en_1"></P>
						
				</div>
				<div class="col-md-6">
				   <%
				   //out.println(SetupAccess.getProperty(SetupConstant.FRZHAIYAOPIC47));
				   //out.println("<br>");
				   //out.println(((PatentInfo)request.getAttribute("patentInfo")).getAbPicPath());				   
				   
				   if(SetupAccess.getProperty(SetupConstant.FRZHAIYAOPIC47)!=null && 
										SetupAccess.getProperty(SetupConstant.FRZHAIYAOPIC47).equals("1")) {%>


<%
//out.println(patentinfo.getAbPicPath());

					String imgurl = patentinfo.getAbPicPath().equals(DataAccess.getProperty("PicServerURL")+"//foreignimage/")?basePath+"/common/tu/ganlan_pic1.gif":patentinfo.getAbPicPath();
					out.println("<a class=\"fancybox\" rel=\"group\" href=\""+imgurl+"\">");
					out.println("<img class=\"img-responsive\" style=\"max-height:300px;\" src=\""+patentinfo.getAbPicPath()+"\" complete=\"complete\" onerror=\"javascript:this.src='"+basePath+"/common/tu/ganlan_pic1.gif';\"/>");
					out.println("</a>");
%>



										<%}%>
										
										

				</div>
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
					<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-picture" style="color:#f9a126;"> </span> 说明书全文</td>
				</tr>
			</table>
   </div>
   <!--TIF图形全文 end-->
   <!--法律状态 start-->
   <div class="tab-pane fade" id="falv" style="min-height:680px ;">
   	
   </div>
   <!--法律状态 end-->
    <!--信息查询 start-->
   <div class="tab-pane fade" id="xinxi" style="min-height:680px ;">
      <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-th-list" style="color:#f9a126;"> </span> 信息查询</td>
				</tr>
	  </table>
	  <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">事务性公告:</td>
					<td class="table_35"><a href="http://search.sipo.gov.cn/sipo/zljs/AffairResult.jsp?searchword=%c9%ea%c7%eb%ba%c5%3d201510654132.0%25">点击链接查看</a></td>
					<td class="table_15">收费信息查询:</td>
					<td class="table_35"><a href="http://app.sipo.gov.cn:8080/searchfee/searchfee_action.jsp?sqh=201510654132.0">点击链接查看</a></td>
				</tr>
				<tr>
					<td class="table_15">通知书发文信息查询:</td>
					<td class="table_35" colspan="3"><a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/notice/searchnotice_result.jsp?sqh=201510654132.0">点击链接查看</a></td>
				</tr>
				<tr>
					<td class="table_15">退信信息检索:</td>
					<td class="table_35" colspan="3"><a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/quitletter/searchquitletter_result.jsp?sqh=201510654132.0">点击链接查看</a></td>
				</tr>
				<tr>
					<td class="table_15">专利证书发文查询:</td>
					<td class="table_35" colspan="3"><a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/certificate/searchcertificate.jsp?sqh=200310118506.4">点击链接查看</a></td>
				</tr>
			</table>
			<table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">百度网页搜索:</td>
					<td class="table_35" colspan="3"><a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=%E5%B9%BF%E4%B8%9C%E6%96%B0%E5%AE%9D%E7%94%B5%E5%99%A8%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&rsv_pq=83ec833200083829&rsv_t=ece21X1c%2B3%2FQbHffU0EQoAJ0ZegA8w2rk1w7pft%2F6BACFg8h7hrzsPVYWdo&rsv_enter=1">广东新宝电器股份有限公司</a></td>
				</tr>
				<tr>
					<td class="table_15">百度学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.baidu.com/s?wd=%E4%B8%80%E7%A7%8D%E5%9F%BA%E4%BA%8E%E9%98%B4%E9%98%B3%E6%A3%9A%E4%B8%80%E4%BD%93%E5%8C%96%E7%9A%84%E5%85%89%E4%BC%8F%E6%97%A5%E5%85%89%E6%B8%A9%E5%AE%A4%E5%A4%A7%E6%A3%9A%E5%8F%8A%E5%BB%BA%E9%80%A0%E6%96%B9%E6%B3%95&rsv_bp=0&tn=SE_baiduxueshu_c1gjeupa&rsv_spt=3&ie=utf-8&f=8&rsv_sug2=1&sc_f_para=sc_tasktype%3D%7BfirstSimpleSearch%7D&rsv_n=2">一种基于阴阳棚一体化的光伏日光温室大棚及建造方法</a></td>
				</tr>
				<tr>
					<td class="table_15">好搜网页搜索:</td>
					<td class="table_35" colspan="3"><a href="http://www.haosou.com/s?ie=utf-8&shb=1&src=home_hao&q=%E5%B9%BF%E4%B8%9C%E6%96%B0%E5%AE%9D%E7%94%B5%E5%99%A8%E8%82%A1%E4%BB%BD%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8">广东新宝电器股份有限公司</a></td>
				</tr>
				<tr>
					<td class="table_15">好搜学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.haosou.com/s?ie=utf-8&shb=1&src=360sou_home&q=%E4%B8%80%E7%A7%8D%E5%9F%BA%E4%BA%8E%E9%98%B4%E9%98%B3%E6%A3%9A%E4%B8%80%E4%BD%93%E5%8C%96%E7%9A%84%E5%85%89%E4%BC%8F%E6%97%A5%E5%85%89%E6%B8%A9%E5%AE%A4%E5%A4%A7%E6%A3%9A%E5%8F%8A%E5%BB%BA%E9%80%A0%E6%96%B9%E6%B3%95">一种基于阴阳棚一体化的光伏日光温室大棚及建造方法</a></td>
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
<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>
<script src="<%=basePath%>common/mask/mask.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
function translate1()
{	
	$("body").mask("正在翻译，请稍候...");
	
	var ipc = $("#ipc").html();
	var ti = $("#ti").html();
	var ab = $("#ab").html();

	$.ajax({
		type : "GET",
//			url : "/" + contextPath + "/expdeleteExp.do?timeStamp=" + new Date(),
		url : "translate.do?timeStamp=" + new Date(),
		
		data : {
			'ipc' : ipc,
			'ti' : ti,
			'ab' : ab,
			'totalPages' : 0
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//				alert(jsonresult);
				
				var _arr = jsonresult.split("\\n");
//				alert(_arr[0]);
//				alert(_arr[1]);
				$("#patent_name_en_0").html("译文:"+_arr[0]);
				if(_arr.length==2){
					$("#patent_name_en_1").html("译文:\r\n"+_arr[1]);
				}
/*
			if(jsonresult=="OK"){
				showexp("删除成功");

//						var tr=obj.parentNode.parentNode;
//						var tbody=tr.parentNode;
//						tbody.removeChild(tr);

				generate_pageinfo(area,1,0);
			}else{
				showexp("删除失败");
			}
			*/
			$("body").unmask();
		}
	})
	
}

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