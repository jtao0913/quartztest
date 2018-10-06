<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<head>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><%=website_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->

<%
String area = (String)session.getAttribute("area");
area="fr";

String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null){
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
}
String userID = (String)session.getAttribute("userid");

int treeType = request.getParameter("treeType")==null?0:Integer.parseInt(request.getParameter("treeType"));
String type = "";
if(treeType==0){
	type="ipc";
}else if(treeType==4){
	type="gmjj";
}else if(treeType==5){
	type="address";
}
//System.out.println("treeType="+treeType);

com.trs.usermanage.UserManage usermanage = new com.trs.usermanage.UserManage();
String strTradeInfoSel = usermanage.getUserTradeInfoByUserID(Integer.parseInt(userID),treeType);

//String[] arrSelTrade = null;
String selTrade = "";
if(strTradeInfoSel!=null&&!strTradeInfoSel.equals("")){
//	arrSelTrade = (strTradeInfoSel.split("#")[2]).split("[$]");
	selTrade = strTradeInfoSel.split("#")[2];
}
int ABSTBatchCount = (Integer) request.getSession().getAttribute("ABSTBatchCount");

int shixiao = 0;
if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){
	shixiao = 1;
}
//System.out.println("selTrade="+selTrade);
//selTrade=766$767$768$770$771$794$784$796$797$798$805$803$807$808$809$811$812$813$814$750$751$752$755$756$757$758$
//selTrade="766";

String jumpNavID = request.getParameter("jumpNavID");
if(jumpNavID!=null&&!jumpNavID.equals("")){
	if(("$"+selTrade).indexOf("$"+jumpNavID+"$")>-1){
		selTrade = jumpNavID;
	}
}
if(treeType==5){
	selTrade = jumpNavID;
}

String nodePid = request.getParameter("nodePid");
if(nodePid==null||nodePid.equals("")){
	nodePid = "0";
}
//System.out.println(jumpNavID+"----"+nodePid);

String translate = (String)application.getAttribute("translate");
%>
<%
String _action = "";
//0:tif;1:png
String showPIC = DataAccess.get("showPIC")==null?"1":DataAccess.get("showPIC");
/*
if(showPIC.equals("1")){
	_action = "createPNGZip.do";
}else{
	_action = "createTIFFZip.do";
}*/
_action = "createPDFZip.do";
%>
</head>

<body>

<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<%@ include file="/jsp/zljs/include-head-secondsearch.jsp"%>

<script src="<%=basePath%>js/hyjs-jieguo.js"></script>

<%@ include file="../jsp/zljs/include-head-jiansuo.jsp"%>

<div style="width: 1124px;margin: 0 auto;min-height:630px\9;min-height:630px; font-family:Verdana,Arial,Helvetica,AppleGothic,sans-serif;">
	<div class="row-fluid" style="padding-top: 20px;">
	<!--span3左-->
	<div class="span3">

				<div class="bs-docs-example">
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#home" data-toggle="tab">行业导航</a></li>
						<li class=""><a href="#profile" data-toggle="tab">结果筛选</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade active in" id="home">
							<!-- mytree -->
							<div
								style="overflow: hidden; background: none repeat scroll 0% 0% rgb(245, 245, 245); border-radius: 4px 4px 4px 4px; box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.05) inset;">
								<ul class="ztree" id="zTreee"
									style="min-height: 680px; font-size: 12px; background-color: #fefefe;"></ul>
							</div>
							<!-- end mytree -->
						</div>
						<div class="tab-pane fade" id="profile">
							<!-- include -->


							<!-- end include  -->
						</div>


					</div>
				</div>
	</div>
			
	<%@ include file="../jsp/zljs/include-jieguo.jsp"%>
	</div>
</div>

		<!-- 分析系统接口 form -->
		<form action="<%=DataAccess.getProperty("analyseSystemAddr")%>" name="piasform" method="post" target="_blank">
		  <input type="hidden" id="searchword" name="searchword" value=""><!--URLEncoder.encode(searchword, "UTF-8")-->
		  <input type="hidden" id="channelid" name="channelid" value=""><!--频道号--> 
		  <input type="hidden" id="extension" name="extension" value=""><!--同义词典，无-->
		  <input type="hidden" id="cizi" name="cizi" value="${requestScope.iOption }"><!--字词-->
		  <input type="hidden" id="securityCode" name="securityCode" value="">
		   <% if(SetupAccess.getProperty(SetupConstant.GAOJIFENXI )!=null && SetupAccess.getProperty(SetupConstant.GAOJIFENXI ).equals("0")){%> 		  	
		  	<input type="hidden" name="basic" value="1">
		  <% }%>
		</form>
		
		
		
		<!-- 定期预警接口 form -->
		<form action="<%=basePath%>jsp/simplewarn/warn-create.jsp" name="warningForm" method="post" target="_blank">
		  <input type="hidden" name="uid" value="${sessionScope.userid}">
		  <input type="hidden" name="uname" value="${sessionScope.username}">
		  <input type="hidden" id="channels" name="channels" value="">
		  <input type="hidden" name="pwd" value="${sessionScope.userpwd}">
		  <input type="hidden" id="area" name="area" value="">
		  <input type="hidden" id="exp" name="exp" value="">		  
		</form>


<!-- 
	<input type="hidden" id="selectdbs" value="" />
	<input type="hidden" id="selectexp" value="" />
	<input type="hidden" id="selectoption" value="" />
	<input type="hidden" id="search" value="" />
	<input type="hidden" id="securityCode" value="" />
	<input type="hidden" id="recordCount" value="" />	
-->
	<input type="hidden" id="industryFlag" value="${industryFlag}" />
	<input type="hidden" id="nodeId" value="${nodeId}" />
	<input type="hidden" id="nodePid_" value="${nodePid}" />
	
<input type="hidden" id="nodePid" value="<%=nodePid%>" />
<input type="hidden" id="searchType" value="2" />
<input type="hidden" id="overviewtree" value="1"/>

</body>

<script type="text/javascript">
//预警
			function warning() {
//				alert($('#search').val());
//				alert($('#selectdbs').val());
//				alert($('#area').val());
				var exp = $("#selectexp").val();
//alert(exp);
				if(exp.indexOf("公开（公告）日")>=0){
//					alert("表达式含有公开公告日，无法进行预警！");
					showexp("表达式含有“公开公告日”，无法进行预警！")
					return ;
				}else{
					document.warningForm.channels.value = $('#selectdbs').val();
//					document.getElementById("alarmform").channels.value = $('#selectdbs').val();
//					alert(document.warningForm.channels.value);				
					document.warningForm.exp.value = $('#URLEncoderWhere').val();
					document.warningForm.area.value = $('#area').val();
				    document.warningForm.submit();
				}
			}
</script>

<script type="text/javascript">
var addImgCount = 0;
var expendNodeUrl = "";
var treeObj;
var params = {};
var targetNodeUrl = "<%=basePath%>getTreeNode?timeStamp=" + new Date();
//缓存频道的数据信息
var cahceChannel = {};
var isLoading = false;
var clickCnOption = 2;
var initClickNode = '#zTreee_2';
var boot_node_tid = "#zTreee_1";
cn_cookie_key = "vm_script_cnode";
//var ctx = '${pageContext.request.contextPath}';
var ctx = "<%=basePath%>";

function setCookieCache(temText) {
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = cn_cookie_key + "=" + escape(temText) + ";expires=" + exp.toGMTString();
}

function getCookieCache() {
	var arr, reg = new RegExp("(^| )" + cn_cookie_key + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

function deleteCookieCache() {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getCookieCache(cn_cookie_key);
	if (cval != null)
		document.cookie = cn_cookie_key + "=" + cval + ";expires="
				+ exp.toGMTString();
}

var setting = {
	//treeId : "zTreee",
	view : {
		addHoverDom : addHoverDom,
		removeHoverDom : removeHoverDom
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "pId",
			rootPId: ""
		}
	},
	callback : {
		onClick : zTreeOnClick,
		beforeExpand:zTreeBeforeExpand
	}
};

function zTreeBeforeExpand(treeId, treeNode) {
	expandNodeData(treeNode);
	return true;
};
function expandNodeData(treeNode) {
//alert("expandNodeData........."+targetNodeUrl);
//alert(targetNodeUrl);
//alert(treeNode.id);
	var treeType = "<%=treeType%>";
	var selTrade = "<%=selTrade%>";

	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : '',
			'parentId' : treeNode.id,
			'treeType' : treeType,
			'selTrade' : selTrade
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
//				alert(data);
//				alert($.parseJSON(data));
//				alert(eval("("+data+")"));
				
				//data = eval("("+data+")");
				data= $.parseJSON(data);
				
				treeObj.removeChildNodes(treeNode);
				$.each(data, function(i) {
					treeObj.addNodes(treeNode, this);
				});
			}
		}
	});
};
/*
 * 鼠标悬浮事件
 */
function addHoverDom(treeId, treeNode) {
	//alert("1111");
	if (treeNode.id == "10000") {
		return;
	}

//	alert(treeNode.cnTrsTable);
//	alert(treeNode.cnTrsExp);
/*
	if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
		alert("该节点中文检索库信息不完整，请联系管理员");
		return;
	}
	if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
		alert("该节点的中文表达式不完整，请联系管理员");
		return;
*/
	var flagTemp = $('#industryFlag').val();
	
	var shixiao = $('#shixiao').val();
	
	flagTemp = "1";
	//alert("flagTemp="+flagTemp);
	if (flagTemp != null && flagTemp != "") {
		if (addImgCount == 0) {
			var aObj = $("#" + treeNode.tId + "_a");
/*			
			var appStr = $('<span class="img-cn-own" style="cursor:pointer"><img src="'
					+ ctx
					+ '/industryIPCtree/images/CN.gif" name="CNIMG"/>&nbsp;<img src="'
					+ ctx + '/industryIPCtree/images/FR-en.gif" name="ENIMG"/></span>');
*/
			var appStr = ('<span class="img-cn-own" style="cursor:pointer">');			
			if(treeNode.cnTrsExp !=null && treeNode.cnTrsExp!=""){
				appStr = appStr + '<img src="' + ctx + '/industryIPCtree/images/CN.gif" name="CNIMG"/>';
			}
			if(treeNode.enTrsExp !=null && treeNode.enTrsExp!=""){
				appStr = appStr + '&nbsp;<img src="' + ctx + '/industryIPCtree/images/FR-en.gif" name="ENIMG"/>';
			}
			if(shixiao==1){
				if(treeNode.cnTrsExp !=null && treeNode.cnTrsExp!=""){
					appStr = appStr + '&nbsp;<img src="' + ctx + '/industryIPCtree/images/SX.gif" name="SXIMG"/>';
				}
			}
			appStr = appStr + '</span>';

			if(appStr=='<span class="img-cn-own" style="cursor:pointer"></span>'){
				appStr = '';
			}
			appStr = $(appStr);
			
			$(appStr).insertBefore($('#' + treeNode.tId + '_span'));
			addImgCount = 1;
		}
	}
};
function removeHoverDom(treeId, treeNode) {
	if (addImgCount == 1) {
		$('span').remove('.img-cn-own');
		addImgCount = 0;
	}
};
function zTreeOnClick(event, treeId, treeNode) {
//alert(treeId);
	gloabTitle = treeNode.name;
//alert("treeNode.name="+gloabTitle);
//alert("treeNode.id="+treeNode.id);
	clickKey = treeNode.key;
	if (treeNode.id == "10000" || treeNode.id == "" || treeNode.id == null) {
		return;
	}
	
	clickCnOption = treeNode.cnTrsOption;
	var clickName = $(event.target).attr('name');
//alert(clickName);

//	$('#language').val(clickName);
//	$('#nodeId').val(treeNode.id);
	params.language=clickName;
	params.nodeId=treeNode.id;
	params.secondsearchexp="";
	params.filterChannel="";

if ("ENIMG" == clickName) {
	$('#area').val("en");
	params.language="en";
	$("#downloadmenu #lipdfdownload").remove();
}else if ("CNIMG" == clickName){
	$('#area').val("cn");
	params.language="cn";
	
//	var downloadmenu = $("#downloadmenu");
//	$("#downloadmenu").remove("li[id==lipdfdownload]");//remove可以接受通过参数来选择性的删除符合条件的元素;
	$("#downloadmenu #lipdfdownload").remove();
	$("#downloadmenu").append("<li id='lipdfdownload'><a href='javascript:downloadPDF();'>PDF下载</a></li>");	
}else if ("SXIMG" == clickName){
	$('#area').val("cn");
	params.language="sx";
	
//	var downloadmenu = $("#downloadmenu");
	$("#downloadmenu #lipdfdownload").remove();
	$("#downloadmenu").append("<li id='lipdfdownload'><a href='javascript:downloadPDF();'>PDF下载</a></li>");
}
	//alert($('#language').val());
	//alert($('#nodeId').val());	
	deleteCookieCache();
	
	$('#overViewDiv').html('');	
	//alert(clickName);
	//情况频道缓存
	if ("CNIMG" == clickName) {
		$('#expDiv').hide();
		//保存节点中文的表达式和库信息
		
		if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
			showexp("该节点中文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
			showexp("该节点的中文表达式不完整，请联系管理员");
			return;
		}
		
//		alert(treeNode.cnTrsOption);
		/*
		if(treeNode.cnTrsOption==null || treeNode.cnTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.cnTrsOption);
		}
		*/
		params.selectexp=treeNode.cnTrsExp;
		params.selectdbs=treeNode.cnTrsTable;
		
$('#selectexp').val(treeNode.cnTrsExp);
$('#selectdbs').val(treeNode.cnTrsTable);
		
//		alert($('#selectdbs').val());
//		alert($('#selectexp').val());
		
//		alert(treeNode.id);
		initRequestData(treeNode.id, "CN",1);
		$('#hyzsli').show();
		//$('#contentDiv').show();
		//$('#top-navbar').show();
		//$('#overViewDiv').show();
	} else if ("ENIMG" == clickName) {
		$('#expDiv').hide();
		// 保存节点中文的表达式和库信息
		if(treeNode.enTrsTable==null || treeNode.enTrsTable==""){
			showexp("该节点英文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.enTrsExp==null || treeNode.enTrsExp==""){
			showexp("该节点的英文表达式不完整，请联系管理员");
			return;
		}
		/*
		if(treeNode.enTrsOption==null || treeNode.enTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.enTrsOption);
		}
		*/
//		$('#selectdbs').val(treeNode.enTrsTable);
//		$('#selectexp').val(treeNode.enTrsExp);

		params.selectexp=treeNode.enTrsExp;
		params.selectdbs=treeNode.enTrsTable;
		
$('#selectexp').val(treeNode.enTrsExp);
$('#selectdbs').val(treeNode.enTrsTable);
		
		initRequestData(treeNode.id, "EN",1);
		$('#hyzsli').hide();
		//$('#contentDiv').show();
		//$('#top-navbar').show();
		//$('#overViewDiv').show();
	} else if ("SXIMG" == clickName) {
		$('#expDiv').hide();
		//保存节点中文的表达式和库信息
		
		if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
			showexp("该节点中文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
			showexp("该节点的中文表达式不完整，请联系管理员");
			return;
		}
		
//		alert(treeNode.cnTrsOption);
		/*
		if(treeNode.cnTrsOption==null || treeNode.cnTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.cnTrsOption);
		}
		*/
		params.selectexp=treeNode.cnTrsExp;
		params.selectdbs=treeNode.sxTrsTable;
		
$('#selectexp').val(treeNode.cnTrsExp);
$('#selectdbs').val(treeNode.sxTrsTable);
		
//		alert($('#selectdbs').val());
//		alert($('#selectexp').val());
		
		initRequestData(treeNode.id, "SX",1);
		$('#hyzsli').show();
		//$('#contentDiv').show();
		//$('#top-navbar').show();
		//$('#overViewDiv').show();
	} else {
		$('#expDiv').hide();
		// 保存节点中文的表达式和库信息
		if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
			showexp("该节点中文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
			showexp("该节点的中文表达式不完整，请联系管理员");
			return;
		}
		/*
		if(treeNode.cnTrsOption==null || treeNode.cnTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.enTrsOption);
		}
		*/
//		$('#selectdbs').val(treeNode.cnTrsTable);
//		$('#selectexp').val(treeNode.cnTrsExp);
//		$('#selectoption').val(treeNode.cnTrsOption);

		params.selectexp=treeNode.cnTrsExp;
		params.selectdbs=treeNode.cnTrsTable;
		
$('#selectexp').val(treeNode.cnTrsExp);
$('#selectdbs').val(treeNode.cnTrsTable);
		
		initRequestData(treeNode.id, "CN",1);
		$('#hyzsli').show();
		//$('#contentDiv').show();
		//$('#top-navbar').show();
		//$('#overViewDiv').show();
	}
	cacheNodeData();
}
function cacheNodeData() {
//params.strWhere = $('#selectexp').val();
//params.quadraticText = '';
//params.cacheQuadraticText = '';
//params.channelId = $('#selectdbs').val();
//params.option = $('#selectoption').val();
}

function initRequestData(nodeId, language,currentPage) {
//$('body').mask('请等待...');
//alert("initRequestData.....");
//alert(params.filterChannel);
//alert(params.selectexp);
//alert(params.selectdbs);
	params.searchType="2";
	params.nodeId=nodeId;
	params.language=language;
	params.sortMethod='-公开（公告）日';
	params.currentPage=currentPage;
	params.totalPages=0;
	/*
	params = {
		nodeId : nodeId,
		language : language,
		sortMethod : '-公开（公告）日',
//		filterChannel : $('#currentfilterChannel').val(),
		currentPage : currentPage, // 默认显示第一页信息
		totalPages : 0,
//		selectexp : $('#selectexp').val(),
//		selectdbs : $('#selectdbs').val()
	};
	*/
//这里清空频道缓存
	cahceChannel = {};
	$('#searchType').val("2");
//alert("requestExpData");
	requestExpData(params);
	
//alert("params.nodeId="+params.nodeId);
//alert("params.sortMethod="+params.sortMethod);
//alert("params.filterChannel="+params.filterChannel);
//alert("params.currentPage="+params.currentPage);
//alert("params.quadraticText="+params.quadraticText);
}

function initRequestData_Map(nodeId,_selectexp,_selectdbs) {
	//$('body').mask('请等待...');
	//alert("initRequestData.....");
	//alert(params.filterChannel);
	//alert(params.selectexp);
	//alert(_selectdbs);
			
			params.nodeId=nodeId;
			params.language="CN";
			params.sortMethod='-公开（公告）日';
			params.currentPage="1";
			params.totalPages=0;
			params.filterChannel="";
//			params.selectdbs="14,15,16,17";

			params.selectexp=_selectexp;
			params.selectdbs=_selectdbs;
					
			$('#selectexp').val(_selectexp);
			$('#selectdbs').val(_selectdbs);
			
	//alert($('#selectdbs').val());
		//这里清空频道缓存
			cahceChannel = {};
		//alert("requestExpData");
			requestExpData(params);
	}


$(function() {
	//alert("初始化树");
	$("body").mask("正在初始化，请稍候...");
/*
* 初始化树，parentId = 0
*/
	//var parentId = "0";	
	//deleteCookieCache();
	
	var tnodeId = $('#nodeId').val();
	var tnodePid = $('#nodePid').val();
	if (tnodePid == null || tnodePid == "") {
		tnodePid = "0";
	}
	
	var treeType = "<%=treeType%>";
	
	//alert(treeType);
	
	//initClickNode = '#zTreee_73_span';
	//targetNodeUrl = ctx + "/node/json/getDiyNodes?timeStamp=" + new Date();
	targetNodeUrl = ctx + "/getTreeNode.do?timeStamp=" + new Date();
	
//	alert("tnodePid="+tnodePid);
//	alert("treeType="+treeType);
//	alert("tnodeId="+tnodeId);
//	alert("targetNodeUrl="+targetNodeUrl);

/*
	var navID = $('#navID').val();	
	if(navID!=0&&navID!="0"){
		tnodePid=navID;
	}
*/	
	loadDataFunc(tnodePid,treeType, tnodeId, targetNodeUrl);
	//initTree(zNodes);
});
loadDataFunc = function(parentId, treeType,nodeId, url) {
	//$('body').mask('正在检索');
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : nodeId,
			'parentId' : parentId,
			'treeType' : treeType,
			'selTrade' : '<%=selTrade%>'
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			$("body").unmask();
			if (jsonresult != null) {
				//alert(jsonresult);
				jsonresult = eval("("+jsonresult+")");
				//alert(jsonresult);
				/*
				$("#content").html(""); 
				$('#content').html(jsonresult);
				
				$("#content1").html("");
				$('#content1').html(eval("("+zNodes+")"));
				*/
				//alert(targetNodeUrl + "------" + nodeId + "----" + parentId + "----" + treeType);
				initTree(jsonresult);
			}
		}
	});
};

function initTree(data) {
	treeObj = $.fn.zTree.init($("#zTreee"), setting, data);
	isInitNodeDefault = true;
//初始化树节点的检索
//$(initClickNode).trigger('click');
//这里只展开一级节点,获取根节点
	var hangye = $('#hangye').val();
	var type = $('#type').val();

//alert("hangye="+hangye);

	if(type!="ipc"&&type!="gmjj"){
		if(hangye!=""||jumpNavID!=""){
			

			var bootnode = treeObj.getNodeByTId("#zTreee_1");
			expandNodeData(bootnode);
		}
	}

	$('body').unmask();
}

initPageContextEvent = function() {
	$('.overViewNav ul li').hover(function() {
		$(this).children('ul').show();
	}, function() {
		$(this).children('ul').hide();
	});

	$('.overViewNav ul li').click(function() {
		$(this).children('.subMenu').show();
	}, function() {
		$(this).children('.subMenu').hide();
	});
}
</script>


</html>

<%@ include file="../jsp/zljs/include-buttom.jsp"%>