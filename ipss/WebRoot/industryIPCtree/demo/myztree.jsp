<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<script src="http://10.33.4.79:8080/ipss/js/jquery-1.4.2.min.js"></script>
<link rel="stylesheet" href="http://10.33.4.79:8080/ipss/industryIPCtree/zTreeStyle3.5/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="http://10.33.4.79:8080/ipss/industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>  

<!--
<link rel="stylesheet" href="zTreeStyle.css" type="text/css">
<script type="text/javascript" src="jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="jquery.ztree.core.js"></script>
-->
<body>

<div
	style="width: ${width_warp};margin: 0 auto;min-height:630px\9;min-height:630px;
			font-family:Verdana,Arial,Helvetica,AppleGothic,sans-serif;">
	<div class="row-fluid" style="padding-top: 20px;">
		<div
			style="float: left; width: 25%; overflow: hidden; background: none repeat scroll 0% 0% rgb(245, 245, 245); border-radius: 4px 4px 4px 4px; box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.05) inset;">
			<ul class="ztree" id="zTreee"
				style="min-height: 680px; font-size: 12px; background-color: #fefefe;"></ul>
		</div>
		<div id="contentDiv" style="float: right; width: 74%; display: none;">
			<div class="overViewNav">
				<ul style="float: left;">
					<li class="active"
						style="color: #212121; font-weight: 600; padding-top: 5px; width: 50px;">
						<label class="checkbox" style="width: 30px; color: #999999;"><input
							type="checkbox" value=""
							onclick="selectAllCheckSort(this.checked)">全选</label>
					</li>

					<c:if
						test="${fn:contains(sessionScope.loginUser.modules,'MODULE38') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">
						<li class="dropdown active"><a class="dropdown-toggle"
							data-toggle="dropdown">收藏<s class="nav-sub-underimg"></s> </a>
							<ul class="dropdown-menu">
								<li><a id="saveToTopic">收藏选中</a></li>
								<li><a id="saveAllToTopic">收藏全部</a></li>
							</ul></li>
					</c:if>


					<c:if
						test="${fn:contains(sessionScope.loginUser.modules,'MODULE39') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">
						<li class="dropdown active"><a class="dropdown-toggle"
							data-toggle="dropdown">下载<s class="nav-sub-underimg"></s> </a>
							<ul class="dropdown-menu">
								<li><a href="javascript:downloadZulu();">著录项下载</a></li>
								<li><a href="javascript:downloadTIF();">TIFF图下载</a></li>
								<c:if
									test="${sessionScope.loginUser.permissionId !='PERMISSIONG'}">
									<li><a href="javascript:downloadXML();">代码化下载</a></li>
								</c:if>
						<li><a href="javascript:batchDownload();">著录项批量下载</a>
						</li>
						</ul></li>
				</c:if>
				<%--  					<c:if  --%>
				<%--  						test="${fn:contains(sessionScope.loginUser.modules,'MODULE41') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">  --%>
				<li class="dropdown active"><a class="dropdown-toggle" 
					data-toggle="dropdown">分析预警<s class="nav-sub-underimg"></s>
				</a>
					<ul class="dropdown-menu">
						<c:if test="${fn:contains(sessionScope.loginUser.modules,'MODULE41') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">
							<li><a href="javascript:patentAnalysis();">专利分析</a>
							</li>
						</c:if>
						<!-- <li id="hyzsli"><a href="javascript:hyzsAnalysis();">活跃指数</a></li>  -->

						<c:if test="${fn:contains(sessionScope.loginUser.modules,'MODULE40') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">
							<li><a href="javascript:onListenWarnByNode()">定期预警</a>
							</li>
						</c:if>
					</ul></li>

				<c:if
					test="${fn:contains(sessionScope.loginUser.modules,'MODULE46') || sessionScope.loginUser.permissionId =='PERMISSIONM'}">
					<li><a href="javascript:dbSearchModal()">二次检索</a>
					</li>
				</c:if>
				<li><select class="input-medium" style="width: 100px;"
					id="channels" onchange="channelsChange(this.value);">
				</select></li>
				<li><select class="input-medium" style="width: 100px;"
					onchange="sort(this.value);">
						<option value="-公开（公告）日" selected="selected">按公开日降序</option>
						<option value="RELEVANCE">不排序</option>
						<option value="+公开（公告）日">按公开日升序</option>
						<option value="-申请日">按申请日降序</option>
						<option value="+申请日">按申请日升序</option>
				</select></li>
				<li><select class="input-medium" style="width: 100px;"
					onchange="legalchange(this.value);">
						<option value="" selected="selected">全部(法律状态)</option>
						<option value="10">有效专利</option>
						<option value="20">失效专利</option>
						<option value="30">在审专利</option>
						<option value="21">专利权届满的专利</option>
						<option value="22">在审超期</option>
				</select></li>
				</ul>
			</div>
			<div id="overViewDiv" class="span13"
				style="margin-top: 20px; float: left;"></div>
			<table style="width: 97%; float: right;" id="page-nav">
				<tr>
					<td align="left" width="10%"><a href="javascript:firstPage();"><span
							class="glyphicon glyphicon-step-backward"></span> 首页</a></td>
					<td align="left" width="10%"><a href="javascript:prePage();"><span
							class="glyphicon glyphicon-chevron-left"></span> 上一页</a></td>
					<td align="center" width="60%"><input type="text"
						id="currentPage" />/<span id="totalPagePatents"></span>页 (共<span
						id="patentTotalsCur"></span>条)</td>
					<td align="right" width="10%"><a href="javascript:nextPage();"><span
							class="glyphicon glyphicon-chevron-right"></span> 下一页</a></td>
					<td align="right" width="10%"><a href="javascript:lastPage();"><span
							class="glyphicon glyphicon-step-forward"></span> 尾页</a></td>
				</tr>
			</table>
		</div>
	</div>
</div>




</body>
</html>

<script type="text/javascript">
var addImgCount = 0;
var expendNodeUrl = "";
var treeObj;
var params = {};
var targetNodeUrl = "/getTreeNode?timeStamp=" + new Date();
// 缓存频道的数据信息
var cahceChannel = {};
var isLoading = false;
var clickCnOption = 2;
var initClickNode = '#zTreee_2_a';
var boot_node_tid = "#zTreee_1";
cn_cookie_key = "vm_script_cnode";

function setCookieCache(temText) {
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = cn_cookie_key + "=" + escape(temText) + ";expires="
			+ exp.toGMTString();
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
//alert(targetNodeUrl);
//alert(treeNode.id);

	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : '',
			'parentId' : treeNode.id
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
				//alert(data);
				data = eval("("+data+")");				
				
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
	var flagTemp = $('#industryFlag').val();
	flagTemp = "1";
	//alert("flagTemp="+flagTemp);	
	//alert("2222");
	if (flagTemp != null && flagTemp != "") {
		//alert("3333");
		if (addImgCount == 0) {
			var aObj = $("#" + treeNode.tId + "_a");
			var appStr = $('<span class="img-cn-own" style="cursor:pointer"><img src="'
					+ ctx
					+ '/industryIPCtree/images/CN.gif" name="CNIMG"/>&nbsp;<img src="'
					+ ctx + '/industryIPCtree/images/FR-en.gif" name="ENIMG"/></span>');
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
	clickKey = treeNode.key;
	if (treeNode.id == "10000" || treeNode.id == "" || treeNode.id == null) {
		return;
	}
	
	clickCnOption = treeNode.cnTrsOption;
	var clickName = $(event.target).attr('name');
	deleteCookieCache();
	
	$('#overViewDiv').html('');
	
	//alert(clickName);
	//情况频道缓存
	if ("CNIMG" == clickName) {
		$('#expDiv').hide();
		//保存节点中文的表达式和库信息
		if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
			alert("该节点中文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
			alert("该节点的中文表达式不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsOption==null || treeNode.cnTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.cnTrsOption);
		}
		$('#selectdbs').val(treeNode.cnTrsTable);
		$('#selectexp').val(treeNode.cnTrsExp);
		
		//alert("1111");
		
		initRequestData(treeNode.id, "CN");
		$('#hyzsli').show();
		$('#contentDiv').show();
	} else if ("ENIMG" == clickName) {
		$('#expDiv').hide();
		// 保存节点中文的表达式和库信息
		if(treeNode.enTrsTable==null || treeNode.enTrsTable==""){
			alert("该节点英文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.enTrsExp==null || treeNode.enTrsExp==""){
			alert("该节点的英文表达式不完整，请联系管理员");
			return;
		}
		if(treeNode.enTrsOption==null || treeNode.enTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.enTrsOption);
		}
		$('#selectdbs').val(treeNode.enTrsTable);
		$('#selectexp').val(treeNode.enTrsExp);
		initRequestData(treeNode.id, "EN");
		$('#hyzsli').hide();
		$('#contentDiv').show();
	} else {
		$('#expDiv').hide();
		$('#hyzsli').show();
		// 保存节点中文的表达式和库信息
		if(treeNode.cnTrsTable==null || treeNode.cnTrsTable==""){
			alert("该节点中文检索库信息不完整，请联系管理员");
			return;
		}
		if(treeNode.cnTrsExp==null || treeNode.cnTrsExp==""){
			alert("该节点的中文表达式不完整，请联系管理员");
			return;
		}
		if(treeNode.enTrsOption==null || treeNode.enTrsOption==""){
			$('#selectoption').val("0");
		}else{
			$('#selectoption').val(treeNode.enTrsOption);
		}
		$('#selectdbs').val(treeNode.cnTrsTable);
		$('#selectexp').val(treeNode.cnTrsExp);
		$('#selectoption').val(treeNode.cnTrsOption);
		initRequestData(treeNode.id, "CN");
		$('#contentDiv').show();
		// $('#contentDiv').hide();
		// $('#expCombArea').val(treeNode.cnTrsExp);
		// $('#expDiv').show();
		// if(isInitNodeDefault){
		// isInitNodeDefault = false;
		// // 保存节点中文的表达式和库信息
		// $('#expDiv').hide();
		// $('#selectdbs').val(treeNode.cnTrsTable);
		// $('#selectexp').val(treeNode.cnTrsExp);
		// $('#selectoption').val(treeNode.cnTrsOption);
		// initRequestData(treeNode.id, "CN");
		// $('#contentDiv').show();
		// }
	}
	cacheNodeData();
}
function initRequestData(nodeId, language) {
	//$('body').mask('请等待...');
	params = {
		nodeId : nodeId,
		language : language,
		sortMethod : '-公开（公告）日',
		filterChannel : '',
		currentPage : 1, // 默认显示第一页信息
		totalPages : 0
	};
	// 这里清空频道缓存
	cahceChannel = {};
	//alert("requestExpData");
	requestExpData(params);
	
//alert("params.nodeId="+params.nodeId);
//alert("params.sortMethod="+params.sortMethod);
//alert("params.filterChannel="+params.filterChannel);
//alert("params.currentPage="+params.currentPage);
//alert("params.quadraticText="+params.quadraticText);
}

$(function() {
	//alert("初始化树");
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
	
	ctx = '${pageContext.request.contextPath}';
	
	//alert(ctx);
	
	initClickNode = '#zTreee_73_span';
	//targetNodeUrl = ctx + "/node/json/getDiyNodes?timeStamp=" + new Date();
	targetNodeUrl = ctx + "/getTreeNode.do?timeStamp=" + new Date();
	
	//alert("targetNodeUrl="+targetNodeUrl);
	
	//alert("tnodePid="+tnodePid);
	//alert("tnodeId="+tnodeId);
	
	loadDataFunc(tnodePid, tnodeId, targetNodeUrl);
	//initTree(zNodes);
});
loadDataFunc = function(parentId, nodeId, url) {
	//$('body').mask('正在检索');
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : nodeId,
			'parentId' : parentId
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
		
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
				initTree(jsonresult);
			}
		}
	});
};

function initTree(data) {
	treeObj = $.fn.zTree.init($("#zTreee"), setting, data);
	isInitNodeDefault = true;
	// 初始化树节点的检索
	// $(initClickNode).trigger('click');
	// 这里只展开一级节点,获取根节点
//	var bootnode = treeObj.getNodeByTId(boot_node_tid);
//	expandNodeData(bootnode);
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

function selectAllCheckSort(objValue) {
	if (objValue == true) {
		$('#overViewDiv').find('input[name="recordno"]:checkbox').attr(
				"checked", true);
	} else {
		$('#overViewDiv').find('input[name="recordno"]:checkbox').attr(
				"checked", false);
	}
}

function showPatentInfo(jsonresult) {
	var text = "";
	
		$.each($(jsonresult),function(index) {
		
		
		//alert(this.pa);
		//alert(this.ab);
		
text = text + '<div class="row-fluid">';
text = text + '<span class="help-inline">';
text = text + '<label style="width: 100%;" class="checkbox">';
text = text + '<span style="font-weight: bold;" id="pindex0"></span>';
text = text + '<input id="aho" title='+this.ti+' name="patent" value="{an:'+this.an+',sectionName:'+this.sectionName+',ti:'+this.ti+',pic:'+this.pic+',agt:"",countryCode:null,tifDistributePath:'+this.tifDistributePath+',pages:'+this.pages+',pd:'+this.pd+',pnm:'+this.pnm+'}" type="checkbox" pnm='+this.pnm+' sysid="#'+this.sectionName+'@'+this.pn+'" pid="'+this.sectionName+'@'+this.pn+'" anpn="'+this.an+'|'+this.pn+'" an='+this.an+'>';
text = text + '<strong style="font-size: 13px;" class="text-info">';
text = text + '<a style="cursor: pointer;" onclick="javascript:getDetail('+this.index+')">'+this.ti+' ('+this.an+') </a>';
text = text + '</strong>';
text = text + '<span class="label label-success">发明</span></label></span>';
text = text + '</div>';
		
text = text + '<div class="row-fluid">';
text = text + '<div style="padding-left: 20px; font-size: 12px;" class="span9">';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <a href="#">'+this.pnm+'</a> </span>';
text = text + '<span class="p-inline">申请日：<a href="#">'+this.pnm+'</a></span></div>';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）日：<a href="#">'+this.pd+'</a></span>';
text = text + '<span class="p-inline">分类号：<a href="#">'+this.sic+'</a></span></div>';
text = text + '<div class="row-fluid"><span class="p-inline"> 申请（专利权）人：<a href="#">['+this.pa+']</a></span></div>';
text = text + '<div style="padding-right: 15px; padding-left: 5px;" class="row-fluid muted">'+this.ab+'</div></div>';
//text = text + '<div class="span3"><a class="fancybox" href="http://pic.cnipr.com:8080/XmlData/FM/20110105/201010175684.0/201010175684.gif" rel="group">';
//text = text + '<img style="max-height: 160px;" onerror="javascript:this.src='http://search.cnipr.com/images/ganlan_pic1.gif';" src="http://pic.cnipr.com:8080/XmlData/FM/20110105/201010175684.0/201010175684.gif" complete="complete"></a></div>';
text = text + '</div>';
							
						});
	//alert(text);
	$('#overViewDiv').html(text + '</table>');
}
// 查询概览信息
function requestExpData(params) {
	$('#currentPage').val(params.currentPage);
	$('#data-process-img').show();
	isLoading = true;
	
	//alert(params.nodeId);
	//alert(params.currentPage);
	//alert(params.language);
	
	$.ajax({
		type : "GET",
		url : "/ipss/toJsonOverView.do?timeStamp=" + new Date(),
		//url : "/toJsonOverView.do",
		data : {
			'nodeId' : params.nodeId,
			'currentPage' : params.currentPage,
			'language' : params.language
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			if (jsonresult != null) {
			
			//alert(jsonresult);
			jsonresult = eval("("+jsonresult+")");	
			//alert(data);
			
			showPatentInfo(jsonresult);
			/*
				showPatentInfo(data.data);
				if (data.data == null || data.data.results == null) {
					$('#data-process-img').hide();
				}
				params.totalPages = data.data.tempTotalPages;
				$('#totalPagePatents').html(params.totalPages);
				// 这里要缓存频道信息
				cahceChannel.sectionInfo = data.data.tempSectionInfo;
				cahceChannel.total = data.data.total;
				if (10 >= data.data.total) {
					$('#data-process-img').hide();
				} else {
					$('#data-process-img').show();
				}
				renderChannel(cahceChannel.sectionInfo, cahceChannel.total);
				params.ptotal = cahceChannel.total;
				$('#patentTotalsCur').html(data.data.total);
				// 为预警信息设置总数
				$('#wranTotal').val(data.data.total);
				*/
			}
			isLoading = false;
			$('body').unmask();
		}
	});
}
</script>