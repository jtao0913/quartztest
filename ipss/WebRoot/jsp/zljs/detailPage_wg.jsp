<!DOCTYPE html>
<html>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.corebiz.search.entity.PatentInfo,com.cnipr.cniprgz.security.SecurityTools" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="detail" uri="/WEB-INF/taglib/detail.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="java.net.*"%>

<%@ include file="include-head-base.jsp"%>

<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");

//String path = request.getContextPath();
String type = "tif";
String dbName = (String)request.getAttribute("dbName");
if (dbName.contains("wgzl")) {
	type = "jpg";
}

PatentInfo patentinfo = ((PatentInfo)request.getAttribute("patentInfo"));
//out.println("TifDistributePath="+patentinfo.getTifDistributePath());

String tifServerURL = DataAccess.getProperty("PicServerURL");
String GBServerURL = DataAccess.getProperty("GBServerURL");
String pi_title = ((PatentInfo)request.getAttribute("patentInfo")).getTi();
if (pi_title == null) {
	pi_title = "";
} else {
	pi_title = pi_title.replace("<font color=red>", "").replace("</font>", "");
	pi_title = pi_title.replace("<font style='color:red'>", "").replace("</font>", "");
}
//System.out.println(pi_title);

String userId = "";
if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null){
	userId = ((String)request.getSession().getAttribute(Constant.APP_USER_ID));
}

String strWhere = (String)request.getAttribute("strWhere");
//String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
String hangye = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");

String showPIC = DataAccess.get("showPIC")==null?"1":DataAccess.get("showPIC");
%>
		
		<script type="text/javascript">
			var sRoot = "<%=basePath%>";
			var tifServerURL = "<%=tifServerURL%>";
			function MoveTo1(pageIndex){
				document.getElementById("simFlag").value="";
				document.detailSearchForm.action="<%=basePath%>detailSearch.do?method=detailSearch";
				document.detailSearchForm.target="_self";
				
				document.detailSearchForm.index.value = pageIndex-1;
				document.detailSearchForm.submit();
			}
						
			var patentList = "[{an:'${requestScope.patentInfo.an}',sectionName:'${requestScope.dbName}'," 
			+ "ti:'${requestScope.patentInfo.ti}',pic:'${requestScope.patentInfo.pic}',"
			+ "agt:'${requestScope.patentInfo.agt}',countryCode:'${requestScope.patentInfo.countryCode}'," 
			+ "tifDistributePath:'${requestScope.patentInfo.tifDistributePath}',pages:'${requestScope.patentInfo.pages}'}]";
			
			function Download()
			{
				document.downloadOrPrint.patentList.value = '${requestScope.patentInfo.an}';				
				//0:Excel文件
				//1:专利数据文件
				var strDownFileType = 0;
				document.downloadOrPrint.downtype.value = strDownFileType;
				
				document.downloadOrPrint.downloadcol.value = "申请（专利）号,名称,主分类号,分类号,申请（专利权）人,发明（设计）人,公开（公告）日,公开（公告）号,专利代理机构,代理人,申请日,地址,摘要,国省代码";
				
				document.downloadOrPrint.action = "<%=basePath%>downloadAbstract.do";				
				document.downloadOrPrint.submit();
			}
			
			//智能检索--相似检索
  
 
			$().ready(function(){
			});


			function downloadPDF() {
				//var tifInfos = "BOOKS/FM/2000/20000105/97180597.0,92,CN97180597.0";
				var tifInfos = "<%=patentinfo.getTifDistributePath().replace("\\","/")%>"+","+"<%=patentinfo.getPages()%>"+","+"<%=patentinfo.getAn()%>";

$("body").mask("正在生成下载文件，请稍候...");
						
						$.ajax({
							url : '<%=basePath%>createPDFZip.do',
							type : 'POST',
							data : {
								'tifInfos' : tifInfos,
//								'pictype' : '1'
								'pictype' : <%=showPIC%>
							},
							success : function(jsonresult) {
$("body").unmask();

								$.dialog({
									id : "winlogin",
									bgcolor : "#FFF",
									width : "200px",
									title : '下载',
									max : false,
									min : false,
									content : "<div style='line-height:22px;'>资源获取成功，<a href="
										+ "<%=basePath%>downloadZipfile.do?fileName=" + jsonresult
										+ ">[这里]</a>进行下载 !</div>"
								});

							},
							error : function() {
								//$("body").unmask();
							}
						});		
				}
		</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=pi_title %></title>
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

<!-- WPA Button Begin 
<script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODE3ODI4MV8zOTkyNDNfNDAwMTg4MDg2MF8"></script>
 WPA Button End -->

<!-- 
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/com_2/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>common/mask/mask.js"></script>
<SCRIPT type=text/javascript src="<%=basePath%>common/mask/lhgdialog.min.js?skin=chrome"></SCRIPT>


<STYLE type="text/css" media="all">
@import "<%=basePath%>jsp/window/thickbox.css";
</STYLE>

<SCRIPT type="text/javascript" src="<%=basePath%>jsp/window/thickbox-compressed.js"></SCRIPT>

<script src="<%=basePath%>common/tu/js/jquery.fancybox.pack.js"></script>
<script type="text/javascript">
$(".fancybox").fancybox();
</script>
 -->
	
<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
<link rel="stylesheet" type="text/css" href="css/ie.css">
<![endif]-->

	</head>
<!-- 高级预警 -->
		<form name="seniorAlarm" action="<%=DataAccess.getProperty("seniorAlarmAddr") %>" method="post">
			<input type="hidden" name="an"
				value="${requestScope.patentInfo.an }">
			<input type="hidden" name="pn"
				value="${requestScope.patentInfo.pnm}">
			<input type="hidden" name="uid"
				value="2015">
			<input type="hidden" name="uname"
				value="cnipr">
			<input type="hidden" name="pwd"
				value="[7c4a8d09ca3762af61e59520943dc26494f8941b]">
		</form>
	
		<form name="downloadOrPrint" action="" method="post">
			<input type="hidden" name="patentList">
			<input type="hidden" name="downloadcol">
			<input type="hidden" name="downtype">
			<input type="hidden" name="area" id="area" value="cn">
		</form>


 	 <!-- 法律状态预警接口 form -->
		<form action="<%=basePath%>jsp/simplewarn/law-warn-create.jsp" name="lawalarmForm" id="lawalarmForm" method="post" target="_top">
		  <input type="hidden" name="uid" value="${sessionScope.userid}">
		  <input type="hidden" name="uname" value="${sessionScope.username}">
		  <input type="hidden" name="an"
				value="${requestScope.patentInfo.an }">
			<input type="hidden" name="pn"
				value="${requestScope.patentInfo.pnm}">
		  <input type="hidden" name="channels" value="${requestScope.strChannels}">
		  <input type="hidden" name="pwd" value="${sessionScope.userpwd}"> 
		  <input type="hidden" name="name" value="${requestScope.patentInfo.ti }">		  
		</form>
		

		<form name='legalStatusForm' method='post' target='_blank'
			action="<%=basePath%>search.do?method=viewLegalStatus&strAn=${requestScope.patentInfo.an}" onSubmit="javascript:window.open('','','resizable=yes,width=580,height=320,top=0,scrollbars=yes')">
		</form>
<!-- 物理库 -->
		<form  action="<%=SetupAccess.getProperty("physicalurl")%>/db/mgr/create"  name="physicalForm"   id="physicalForm" method="post" target="_blank">
		  <input type="hidden" name="uid" value="${sessionScope.userid}">
		  <input type="hidden" name="strSources" value="<%=dbName %>">	 
		  <input type="hidden" name="strWhere" value="<%=URLEncoder.encode("申请号="+patentinfo.getAn(), "UTF-8") %>"> 
		  <input type="hidden" name="orgstrWhere" value="<%=("申请号="+patentinfo.getAn()) %>"> 
		  <input type="hidden" name="securityKey" value="<%= SecurityTools.getSecurityCode("申请号="+patentinfo.getAn()+userId) %>">  		  
		</form>
		
		

		<form name="viewInstructionForm"
			action="<%=basePath%>showTIF.do?method=viewDocument" method="post"
			target="_blank">
			<input type="hidden" name="strUrl">
			<input type="hidden" name="strChannels"
				value="${requestScope.strChannels}">
			<input type="hidden" name="strAn"
				value="${requestScope.patentInfo.an }">
			<input type="hidden" name="ti"
				value="${requestScope.patentInfo.ti }">
			<input type="hidden" name="totalPages">
			<input type="hidden" name="strIPC"
				value="${requestScope.patentInfo.pic }">
			<input type="hidden" name="strANN"
				value="${requestScope.patentInfo.pa }">
			<input type="hidden" name="dbName"
				value="${requestScope.dbName }">
			<input type="hidden" name="pictype"
				value="<%=type%>">
			<input type="hidden" name="strCurPage">
			<input type="hidden" name="FTS" value="">
		</form>



	<% if(SetupAccess.getProperty(SetupConstant.VIEWGB)!=null 
										   && SetupAccess.getProperty(SetupConstant.VIEWGB).equals("1")){%>
								 [<a href="#" onClick="$('#ViewGB').submit();">浏览公报</a>]
								 <%} %>
								 
	 <% if(SetupAccess.getProperty(SetupConstant.DETAILXIANGSISEARCH)!=null && SetupAccess.getProperty(SetupConstant.DETAILXIANGSISEARCH).equals("1")){%>
				<% if(strItemGrant.contains(SetupConstant.DETAILXIANGSISEARCH)){%>				
	[<a onClick="simSearch()" style="cursor: hand">相似检索</a>]
	&nbsp;
	<input type="radio" name="apd" value="0" checked="checked">全部范围
	<input type="radio" name="apd" value="1">新颖性检索
	<input type="radio" name="apd" value="2">侵权性检索
	<%} }%>
	 <% if(SetupAccess.getProperty(SetupConstant.AUTOINDEX)!=null && SetupAccess.getProperty(SetupConstant.AUTOINDEX).equals("1")){%>
				<% if(strItemGrant.contains(SetupConstant.AUTOINDEX)){%>				
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" id="autoIndex" value="查看自动标引">
		<%} } %>
		
		<% if(SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB)!=null && SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB).equals("1")){%>
							 	 <input type="button" onClick="javascript:$('#physicalForm').submit();return false;" style="cursor:hand" value="加入物理库"/>
								 <%} %>
								 
		 <% if(SetupAccess.getProperty(SetupConstant.DETAILSEARCHREPORT)!=null && SetupAccess.getProperty(SetupConstant.DETAILSEARCHREPORT).equals("1")){%>
							       <% if(strItemGrant.contains(SetupConstant.DETAILSEARCHREPORT)){%>
								<input type="button" onClick="$('#reportForm').submit();"  value="检索报告"> 
								<%} }%>
				 <% if(SetupAccess.getProperty(SetupConstant.VIEWWGGB )!=null && SetupAccess.getProperty(SetupConstant.VIEWWGGB).equals("1")){%>
							       <% if(strItemGrant.contains(SetupConstant.VIEWWGGB)){%>
								<input type="button" onClick="$('#ViewWGGB').submit();"  value="外观公报"> 
					<%} }%>
			
			  <% if(SetupAccess.getProperty(SetupConstant.LAWWARN)!=null && SetupAccess.getProperty(SetupConstant.LAWWARN).equals("1")){%>
							       <% if(strItemGrant.contains(SetupConstant.LAWWARN)){%>
							    <input type="button" id="lawwarnbutton" onClick="document.lawalarmForm.submit();" value="加入法律状态预警">
			<%} }%>

			
			
	<!-- 
	&nbsp;&nbsp;
	<input type="button" id="alarm" onclick="document.seniorAlarm.submit();" value="加入高级预警">
	 -->



<Script language="JavaScript">


function switchMenu(){
	if (SwitchArraw.innerText==3){
		SwitchArraw.innerText=4
		document.all("navi_td").style.display="none"
	}
	else{
		SwitchArraw.innerText=3
		document.all("navi_td").style.display=""
	}
}


function setCookie()
{
	var strCookieName = "WGShowCookies=";
	document.cookie = strCookieName+SwitchArraw.innerText;
}

</Script>

<body style="background-color: #e6f2f0;">
<div class="row-fluid mycolor">
	<div style="width:950px;height:40px;margin: auto;">		
		<%if(areacode!=null&&areacode.equals("041")&&!hangye.equals("")){%>
			<a href="<%=basePath%>index_<%=hangye%>.jsp"><img style="height:40px" src="client/neimeng/images/hangye/<%=hangye%>_logo.png"></a>
		<%}else{ %>			
			<a href="<%=basePath%>index.jsp"><img src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/x_logo.png"></a>
		<%} %>
	</div>
</div>
 
<div class="container" style="width:950px;line-height:40px;">
		<span style="float:right;margin-top:4px;"><input name="button" class="btn btn-default" type="button" onClick="javascript:window.close();" value="关闭窗口"></span>
</div>

<%       //专利号
			String an = ((PatentInfo)request.getAttribute("patentInfo")).getAn();
			//取前缀国家
			String cn=an.substring(0,2);
			//去掉前缀
			String num = an.replace(cn,"");
			String sqh = an.replace(cn,"");
			String sqh_ = sqh.replace(".", "");
			//申请(专利权)人
			String pa = ((PatentInfo)request.getAttribute("patentInfo")).getPa();
%>

<div class="container" style="width:950px;background-color: #ffffff;margin: auto;padding:8px;">
	<div style="width:934px;margin: auto;">
	 <div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group" id="maintab">
		  <a class="btn btn-default mycolor_bor" href="#jiben" data-toggle="tab"><span class="glyphicon glyphicon-list-alt" title="基本信息"> 基本信息</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#falv" data-toggle="tab" onclick='showPage("falv","viewLegalStatus.do?strAn=${requestScope.patentInfo.an}")'><span class="glyphicon glyphicon-check" title="法律状态"> 法律状态</span>		
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#xinxi" data-toggle="tab"><span class="glyphicon glyphicon-th-list" title="信息查询"> 信息查询</span>		
		  </a>
		  <!-- 
		  <a class="btn btn-default mycolor_bor" href="#"><span class="glyphicon glyphicon-print" title="打印文摘"> 打印文摘</span>		
		  </a>
		   -->
		  <a class="btn btn-default mycolor_bor"><span class="glyphicon glyphicon-download" title="下载文摘" onClick="javascript:Download()"> 下载文摘</span>
		  </a>
		   
		  <a class="btn btn-default mycolor_bor"><span class="glyphicon glyphicon-download" title="下载pdf" onClick="javascript:downloadPDF()"> 下载PDF</span>
		  </a>
		  
	    </div>
	 </div>
   </div>
<%
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
 <div class="tab-content" style="overflow:hidden">
 	 <!--基础信息 tabstart-->
   <div class="tab-pane fade in active" id="jiben">
      	<!--标题 start-->
		<div style="width:934px;padding:8px;background-color: #ffffff;margin: auto;display: inline-block;color:#009999;font-weight:bold;">
			<h4>${requestScope.patentInfo.ti} <span class="label label-success">${requestScope.patentInfo.estype}</span> <%=_flzt_info%></h4>
		</div>
		<!--标题 end-->

		<div style="background-color: #ffffff;margin: auto;">
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
					<img id="validateImg" src="data:image/png;base64,${requestScope.patentInfo.adbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.ad}
					<%}%>
</td>
				</tr>
				<tr>
					<td class="table_15">公开（公告）号:</td>
					<td class="table_35">
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5) {
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.pnmbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.pnm}
					<%}%>
					
					</td>
					<td class="table_15">公开（公告）日:</td>
					<td class="table_35">
					
					<%
					if(ShowBase64!=null&&ShowBase64.equals("1")&&Math.random()>0.5) {
					%>
					<img src="data:image/png;base64,${requestScope.patentInfo.pdbase64}"/>
					<%}else{%>
					${requestScope.patentInfo.pd}
					<%}%>
					
					</td>
				</tr>
				<tr>
					<td class="table_15">申请（专利权）人</td>
					<td class="table_35" colspan="3">${requestScope.patentInfo.pa}</td>
				</tr>
				<tr>
					<td class="table_15">发明（设计）人</td>
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
						<td class="table_35">${requestScope.patentInfo.ian}</td>
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
				<div class="col-md-12" style="padding-left:30px;">
					<P>简要说明：
						${requestScope.patentInfo.ab}
						</P>
				</div>
				<div class="col-md-12 ">



<%
String cnAbfigure = com.cnipr.cniprgz.commons.DataAccess.getProperty("cnAbfigure");
cnAbfigure = (cnAbfigure==null||cnAbfigure.equals(""))?"1":cnAbfigure;
if(cnAbfigure.equals("1")){
%>
					
					
<ul class="thumbnails" style="margin-left:0px">
<%
	java.util.ArrayList<String> imagePubPathList = new java.util.ArrayList<String>();
	imagePubPathList = (java.util.ArrayList<String>)request.getAttribute("ThumbnailImagePubPathList");

	java.util.Iterator<String> iter = imagePubPathList.iterator();
	while(iter.hasNext())
	{
		String imagePubPath = (String)iter.next();
//		out.println(imagePubPath);
%>
<li style="margin-left: 0px;float:left; list-style-type:none;">
	<div class="thumbnail" style="width:150px;height:150px;margin-left:10px">
		<a class="fancybox" rel="group" href="<%=imagePubPath%>">
			<img src="<%=imagePubPath%>" class="zoomin" alt="" style="width:150px;height:150px;">
		</a>
	</div>
</li>
<%				
	}
%>
</ul>

<%}%>



<script language="Javascript">
function dyniframesize(iframename) {
  var pTar = null;
  if (document.getElementById){
    pTar = document.getElementById(iframename);
  }
  
  if (pTar && !window.opera){
    //begin resizing iframe
    pTar.style.display="block"
    if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
      //ns6 syntax
	  pTar.height = pTar.contentDocument.body.offsetHeight;
    }
    else if (pTar.Document && pTar.Document.body.scrollHeight){
      //ie5+ syntax
      pTar.height = pTar.Document.body.scrollHeight;
    }
  }
}
</script>
				</div>
			</div>
			<hr>
			<!--摘要 end-->
		</div>
   </div>
    <!--基础信息 end-->
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
					<td class="table_15">收费信息查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/searchfee/searchfee_action.jsp?sqh=<%=num %>"  target="_blank">点击链接</a></td>
				</tr>
	  			<!-- 
				<tr>
					<td class="table_15">事务性公告:</td>
					<td class="table_35"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://search.sipo.gov.cn/sipo/zljs/AffairResult.jsp?searchword=%c9%ea%c7%eb%ba%c5%3d<%=num %>%25"  target="_blank">点击链接</a></td>
					<td class="table_15">收费信息查询:</td>
					<td class="table_35"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/searchfee/searchfee_action.jsp?sqh=<%=num %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">通知书发文信息查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/notice/searchnotice_result.jsp?sqh=<%=num %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">退信信息检索:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/quitletter/searchquitletter_result.jsp?sqh=<%=num %>"  target="_blank">点击链接</a></td>
				</tr>
				<tr>
					<td class="table_15">专利证书发文查询:</td>
					<td class="table_35" colspan="3"><font style="color:#ff6600;">去CNIPA查看</font> <a href="http://app.sipo.gov.cn:8080/sipoaid/jsp/certificate/searchcertificate.jsp?sqh=<%=num %>"  target="_blank">点击链接</a></td>
				</tr>
				 -->
				
			</table>
			<!-- 
			<table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">百度网页搜索:</td>
					<td class="table_35" colspan="3"><a href="https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=<%=pa %>"  target="_blank"><%=pa %></a></td>
				</tr>
				<tr>
					<td class="table_15">百度学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.baidu.com/s?wd=<%=pi_title%>&ie=utf-8"  target="_blank"><%=pi_title%></a></td>
				</tr>
				<tr>
					<td class="table_15">360搜索网页搜索:</td>
					<td class="table_35" colspan="3"><a href="http://www.so.com/s?ie=utf-8&shb=1&src=home_www&q=<%=pa %>"  target="_blank"><%=pa %></a></td>
				</tr>
				<tr>
					<td class="table_15">360学术搜索:</td>
					<td class="table_35" colspan="3"><a href="http://xueshu.so.com/s?ie=utf-8&shb=1&src=360sou_home&q=<%=pi_title%>"  target="_blank"><%=pi_title%></a></td>
				</tr>
			</table>
			 -->
<%
String[] arrPa = pa.split(";");
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
  
  function showPage(tabId, url){
    $('#maintab a[href="#'+tabId+'"]').tab('show'); // 显示点击的tab页面
	    if($('#'+tabId).html().length<20){ // 当tab页面内容小于20个字节时ajax加载新页面
	      $('#'+tabId).html('<br>'+loadimg+' 页面加载中，请稍后...'); // 设置页面加载时的loading图片
	      $('#'+tabId).load(url); // ajax加载页面
	    }
  }
</script>
