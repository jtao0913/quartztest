<%@ page language="java" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<%=basePath%>/industryIPCtree/zTreeStyle3.5/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=basePath%>/industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>

<%
//int treeType = request.getParameter("treeType")==null?4:Integer.parseInt(request.getParameter("treeType"));
//treeType = 4;
%>
<script type="text/javascript">
var addImgCount = 0;
var expendNodeUrl = "";
var treeObj;
var params = {};
var targetNodeUrl = "/getTreeNode.do?timeStamp=" + new Date();
// 缓存频道的数据信息
var cahceChannel = {};
var isLoading = false;
var clickCnOption = 2;
var initClickNode = '#zTreee_2_a';
var boot_node_tid = "#zTreee_1";
cn_cookie_key = "vm_script_cnode";
var ctx = '${pageContext.request.contextPath}';

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
	var treeType = $("#treeType").val();
	//alert(treeType);
	
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : '',
			'parentId' : treeNode.id,
			'treeType' : treeType
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
	return;
};
function removeHoverDom(treeId, treeNode) {
	if (addImgCount == 1) {
		$('span').remove('.img-cn-own');
		addImgCount = 0;
	}
};
function zTreeOnClick1(event, treeId, treeNode) {
	//alert(treeId);
	//alert(treeNode.classname);	
	window.parent.document.getElementById("txt_G").value=treeNode.classname;
	return;
}

function zTreeOnClick(event, treeId, treeNode) {
    var flhs = $('#flhs').val();
    
//alert(flhs+"---"+treeNode.classname);
    
    if(flhs!=null && ""!=flhs && flhs.indexOf(treeNode.classname+"")!=-1){
		alert("已经选择此号！");
	}else{
		if(flhs!=null && ""!=flhs){
			flhs=flhs+" or "+treeNode.classname+"";
		}else{
			flhs=treeNode.classname+"";
		}
//		document.getElementById("flhs").value=flhs;
		$('#flhs').val(flhs);
	}	    
};

function cacheNodeData() {
	params.strWhere = $('#selectexp').val();
	params.quadraticText = '';
	params.cacheQuadraticText = '';
	params.channelId = $('#selectdbs').val();
	params.option = $('#selectoption').val();
}
function initRequestData(nodeId, language,currentPage) {
	//$('body').mask('请等待...');
	params = {
		nodeId : nodeId,
		language : language,
		sortMethod : '-公开（公告）日',
		filterChannel : '',
		currentPage : currentPage, // 默认显示第一页信息
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
//init_tree(4);
});
	
function init_tree(){
	var tnodeId = $('#nodeId').val();
	var tnodePid = $('#nodePid').val();
	if (tnodePid == null || tnodePid == "") {
		tnodePid = "0";
	}
	var treeType = $("#treeType").val();
	
	//alert(treeType);
	
	initClickNode = '#zTreee_73_span';
	//targetNodeUrl = ctx + "/node/json/getDiyNodes?timeStamp=" + new Date();
	targetNodeUrl = ctx + "/getTreeNode.do?timeStamp=" + new Date();
	
	//alert("targetNodeUrl="+targetNodeUrl);
	//alert("tnodePid="+tnodePid);
	//alert("tnodeId="+tnodeId);
	
	loadDataFunc(tnodePid,treeType, tnodeId, targetNodeUrl);
	//initTree(zNodes);
};
loadDataFunc = function(parentId, treeType,nodeId, url) {
	//$('body').mask('正在检索');
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'nodeId' : nodeId,
			'parentId' : parentId,
			'treeType' : treeType			
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
//	alert(data);
	treeObj = $.fn.zTree.init($("#zTreee"), setting, data);
	isInitNodeDefault = true;
	// 初始化树节点的检索
	// $(initClickNode).trigger('click');
	// 这里只展开一级节点,获取根节点
//	var bootnode = treeObj.getNodeByTId(boot_node_tid);
//	expandNodeData(bootnode);
	$('body').unmask();
}

	function selectIPCGMJJ(){
		var flhs = $("#flhs").val();
		if(flhs==""){
			alert("请选择分类号！");
			return;
		}
		
		var ipctype = $("#ipctype").val();
		var treeType = $("#treeType").val();
		
		if(treeType==='0'&&ipctype==='mainipc'){
			$("#cnexpModal #txt_G").val(flhs);
		}else if(treeType==='0'&&ipctype==='frmainipc'){
			$("#frexpModal #txt_G").val(flhs);
		}else if(treeType==='0'&&ipctype==='ipc'){
			$("#cnexpModal #txt_H").val(flhs);
		}else if(treeType==='0'&&ipctype==='fripc'){
			$("#frexpModal #txt_H").val(flhs);
		}else if(treeType==='4'){
			$("#cnexpModal #txt_T").val(flhs);
		}
		
		$('#ipcgmjjModal').modal('hide');
	}

	function _selectGMJJ(){
		var flhs = $("#flhs").val();
		if(flhs==""){
			alert("请选择GMJJ分类号！");
			return;
		}		
		parent.$("#<%=request.getParameter("textId")%>").val(flhs);
		//self.parent.getChildVlues("#txt_G", flhs);
		//self.parent.tb_remove();
		$('#gmjjModal').modal('hide');
	}
	function qk() {
		flh = '';
		document.getElementById("flhs").value='';
	}
</script>
</head>



<div style="display:none" id="ipctype"></div>
<div style="display:none" id="treeType"></div>


<div style="width: 650px; height: 600px;overflow:scroll;" class="modal hide fade"
	id="ipcgmjjModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div style="padding:10px;">
	<div class="modal-dialog">
	
		<div class="modal-content">

			<div class="modal-header mycolor" style="padding: 0px 15px;margin-top:20px;background-color: #fff;color:#666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%>
				</h4>
			</div>


			<div class="muted" style="font-size: 12px;margin-top:8px;" id="tips">
				<font style="color: #cc6600;">提示:</font>
				请使用“IPC分类表查询”或浏览“IPC分类”树的方式，选择您所要作为检索条件的IPC分类号，选中的IPC分类号将会自动填写到“专利检索”的“分类号”中，作为检索条件，进行专利信息查询。
				可以多次选择不同的IPC分类号，所选的IPC分类号将以“或”的关系成为检索条件。
			</div>
			<div class="windows_title">
				<strong style="color: #3399cc;">分类号：</strong>
			</div>
			<div class="fenleihao_bg">
				<textarea name="flhs" id="flhs" style="width: 300px;" rows="2"></textarea>
			</div>
			<div class="xuanzhong_div" style="float: left;">
				<button onClick="qk();" class="btn btn-warning">清 空</button>
			</div>
			<div class="xuanzhong_div"
				style="float: left; margin-left: 20px; margin-bottom: 10px;">
				<button onClick="selectIPCGMJJ();" class="btn btn-success">选 中</button>
			</div>
			<div
				style="float: left; width: 95%; overflow: hidden; background: none repeat scroll 0% 0% rgb(245, 245, 245); border-radius: 4px 4px 4px 4px; box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.05) inset;">
				<ul class="ztree" id="zTreee"
					style="min-height: 300px; font-size: 12px; background-color: #fefefe;"></ul>
			</div>
		</div>
	</div>
</div>
</div>

<!-- 
<div style="width: 650px; height: 600px;overflow:scroll;" class="modal hide fade"
	id="gmjjModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
		<div style="padding:10px;">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header mycolor" style="padding: 0px 15px;margin-top:20px;background-color: #fff;color:#666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%>
				</h4>
			</div>


			<div class="muted" style="font-size: 12px;margin-top:8px;">
				<font style="color: #cc6600;">提示:</font>
				国民经济行业分类将国民经济行业划分为门类、大类、中类和小类四级，本分类参照关系表在国民经济行业小类层
				级与国际专利分类构建了对照关系。涉及专利技术的国民经济行业小类共680个，分属于三次产业的7个门类产业。
			</div>
			<div class="windows_title">
				<strong style="color: #3399cc;">国民经济代码：</strong>
			</div>
			<div class="fenleihao_bg">
				<textarea name="flhs" id="flhs" style="width: 300px;" rows="2"></textarea>
			</div>
			<div class="xuanzhong_div" style="float: left;">
				<button onClick="qk();" class="btn btn-warning">清 空</button>
			</div>
			<div class="xuanzhong_div"
				style="float: left; margin-left: 20px; margin-bottom: 10px;">
				<button onClick="selectGMJJ();" class="btn btn-success">选 中</button>


			</div>
			<div
				style="float: left; width: 95%; overflow: hidden; background: none repeat scroll 0% 0% rgb(245, 245, 245); border-radius: 4px 4px 4px 4px; box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.05) inset;">
				<ul class="ztree" id="zTreee"
					style="min-height: 300px; font-size: 12px; background-color: #fefefe;"></ul>
			</div>


		</div>
	</div>
</div>
</div>
 -->