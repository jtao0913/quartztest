<%@ page language="java" pageEncoding="UTF-8"%>

<input type="hidden" id="nodePid" value="<%=nav_parentId%>"/>

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
//				data = eval("("+data+")");
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
//	params.filterChannel="";

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
//alert(treeNode.id+"---"+treeNode.cnTrsExp);
		
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
	}else {
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

function initRequestData(nodeId,language,currentPage) {
//$('body').mask('请等待...');
//alert("initRequestData.....");
//alert(params.filterChannel);
//alert(params.selectexp);
//alert(params.selectdbs);
	params.searchType="1";
	params.nodeId=nodeId;
	params.language=language;
	params.sortMethod='-公开（公告）日';
	params.currentPage=currentPage;
	params.totalPages=0;
	
	params.filterexp="";
	$('#filterexp').val("");	
	$('#filter').html("");
	
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
	$('#searchType').val("1");
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
//			params.filterChannel="";
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
	
//alert("tnodePid="+tnodePid);
	
	var treeType = "<%=treeType%>";
	var jumpNavID = "<%=jumpNavID%>";
	
	if(jumpNavID!=""&&jumpNavID!="0"&&jumpNavID!=0&&jumpNavID>0)
	{
//		tnodePid = jumpNavID;
		tnodeId = jumpNavID;
	}
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
//alert("tnodeId="+tnodeId);

	loadDataFunc(tnodePid,treeType, tnodeId, targetNodeUrl);
	//initTree(zNodes);
});
loadDataFunc = function(parentId, treeType,nodeId, url) {
//	alert("selTrade="+"<%=selTrade%>");
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

	var treeType = "<%=treeType%>";
//alert("hangye="+hangye);
//alert("treeType="+treeType);
var jumpNavID = "<%=jumpNavID%>";
//alert("jumpNavID="+jumpNavID);

//	if(type!="ipc"&&type!="gmjj"){
	if(treeType=="5"
//			||treeType=="1"||treeType=="3"
			){
		if(hangye!=""||jumpNavID!=""){
			var bootnode = treeObj.getNodeByTId("#zTreee_1");
//			expandNodeData(bootnode);
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