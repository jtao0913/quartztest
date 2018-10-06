<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">


<script src="${ctx}/common/com_2/js/jquery-1.12.0.min.js"></script>
<link rel="stylesheet" href="${ctx}/industryIPCtree/zTreeStyle3.5/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>

<style>
.tablecss2 {
	border: #C0C0C0 1px solid;
	border-collapse: collapse;
	margin: 0px;
	width: 100%;
}

.tablecss2 td {
	BORDER-BOTTOM: #C0C0C0 1px solid;
	BORDER-right: #C0C0C0 1px solid;
	padding: 4px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {	
// 		getAllIPC();
		loadTreeData();
	});
	var pageIndex_ComCode = 0;    //公司代码页面索引初始值   
	var pageSize_ComCode = 8;
	var splitpageFlag=0;
	var rowid=0;
	var flh="";
	function xz(){
		var flhs = $("#flhs").val();
		if(flhs==""){
			alert("请选择分类号！");
			return;
		}
		parent.$("#<%=request.getParameter("textId")%>").val(flhs);
		self.parent.getChildVlues("#<%=request.getParameter("textId")%>", flhs);
		self.parent.tb_remove();
	}
	function closeBox() {
		self.parent.tb_remove();
	}

	function qk() {
		flh = '';
		document.getElementById("flhs").value='';
	}

	/***********************改为组件树的结构形式********************************/
	var treeSetting = {
		treeId : "zTree",
		view : {
// 			showIcon: false,
			showTitle: true
		},
		callback : {
			beforeExpand : zTreeBeforeExpand,
			onClick: zTreeOnClick
		}
	};
	
	function zTreeOnClick(event, treeId, treeNode) {
	    var flhs = $('#flhs').val();
	    if(flhs.indexOf(treeNode.ipc+"%")!=-1){
			alert("已经选择此分类号！");
		}else{
			if(flhs!=null && ""!=flhs){
				flhs=flhs+" or "+treeNode.ipc+"%";
			}else{
				flhs=treeNode.ipc+"%";
			}
			document.getElementById("flhs").value=flhs;
		}
	    
	    
	};
	function zTreeBeforeExpand(treeId, treeNode) {
	    loadChildData(treeNode);
	    return true;
	};
	function loadTreeData(){
		$.ajax({
			   type: "GET",
			   url: "../corp/json/queryIpcBaseNode",
			   success: function(data){
			     	initTree(data);
			   }
		});
	}
	function initTree(data){
		treeObj = $.fn.zTree.init($("#ipc4all"), treeSetting, data);
	}
	
	function loadChildData(treeNode){
		var successData ;
		$.ajax({
			   type: "GET",
			   url: "../corp/json/queryIpcChildNode",
			   data: {'ipc':treeNode.ipc},
			   success: function(data){
				   successData =  data;
				   if(data!=null){
					   $.each(data, function(i){
						   treeObj.addNodes(treeNode, this);
					   });
				   }
			   }
		});
	}
	
	function queryIpc(){
		var ipcQueryCond = $('#ipcQueryCond').val();
		if(!ipcQueryCond){
			alert("请输入查询条件！");
			return;
		}
		var queryType = $('input[name="qType"]:checked').val();
		$('#ipc4cond').show();
		$.ajax({
			   type: "GET",
			   url: "../corp/json/getIpcByCode",
			   data: {'condition':ipcQueryCond,'from':pageIndex_ComCode*pageSize_ComCode,'to':(pageIndex_ComCode+1)*pageSize_ComCode,'queryType':queryType},
			   success: function(data){
				   successData =  data;
				   treeObj = $.fn.zTree.init($("#ipc4all"), treeSetting, data.results);
				   zTreeOnBuildSuccess(data.total);
			   }
		});
	}
	
	function zTreeOnBuildSuccess(treeCount) {
		if(splitpageFlag==0){
			splitpageFlag=1;
			$("#splitpage1").pagination(treeCount, {
			    callback: pageselectCallback_CodeCom,  
			    prev_text: '上一页',       // 上一页按钮里text
			    next_text: '下一页',       // 下一页按钮里text
			    items_per_page: pageSize_ComCode,  // 显示条数
			    num_display_entries: 6,    // 连续分页主体部分分页条目数
			    num_edge_entries: 2        // 两侧首尾分页条目数
			}); 
		}
	};
	function pageselectCallback_CodeCom(page_index, jq) {
		if(page_index!=pageIndex_ComCode){
			pageIndex_ComCode = page_index;
			queryIpc();
		}
		return false;
	}
</script>
</head>

<body>
	<!-- //windows2-->
	<div style="width: 620px;">
		<div class="windows_t_m">
			<div class="windows_t_l"></div>
			<div class="windows_name">IPC分类号</div>
			<div class="windows_t_r"></div>
			<div class="windows_close" onClick="closeBox()">
				<a href="javascript:void(0)"><img
					src="${ctx }/static/images/windows_close.jpg" /> </a>
			</div>
		</div>
		<div class="windows_cet">
			<div class="masg">
				提示:请使用“IPC分类表查询”或浏览“IPC分类”树的方式，选择您所要作为检索条件的IPC分类号，选中的IPC分类号将会自动填写到“专利检索”的“分类号”中，作为检索条件，进行专利信息查询。
				可以多次选择不同的IPC分类号，所选的IPC分类号将以“或”的关系成为检索条件。</div>
			<div class="windows_title">分类号：</div>
			<div class="fenleihao_bg">
				<textarea name="flhs" id="flhs" cols="" rows=""
					onchange="setValue2Flh()"></textarea>
			</div>
			<div class="xuanzhong_div">
				<button onClick="qk();" class="btn">清空</button>
			</div>
			<div class="xuanzhong_div">
				<button onClick="xz();" class="btn">选中</button>
			</div>
			<div class="clear"></div>
			<div class="bod_line"></div>
			<div class="fenleihao_search">
				<ul>
					<li>IPC分类查询:</li>
					<li><input name="qType" type="radio" value="code"
						checked="checked" />
					</li>
					<li>按分类号查询:</li>
					<li><input name="qType" type="radio" value="content" />
					</li>
					<li>按内容查询:</li>
					<li><input name="ipcQueryCond" id="ipcQueryCond" type="text"
						class="fenleihao_input" value="" />
					</li>
					<li>
						<button class="btn" onClick="queryIpc();">查询</button>
					</li>
				</ul>
			</div>
			<div class="clear" style="padding: 10px 0; _display: inline;">
				IPC分类</div>
			<div id="ipc4all" class="ztree"
				style="display: block; PADDING-RIGHT: 10px; OVERFLOW-Y: auto; PADDING-LEFT: 10px; SCROLLBAR-FACE-COLOR: #ffffff; FONT-SIZE: 11pt; PADDING-BOTTOM: 0px; SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; OVERFLOW: auto; WIDTH: 598px; SCROLLBAR-SHADOW-COLOR: #919192; COLOR: blue; SCROLLBAR-3DLIGHT-COLOR: #ffffff; LINE-HEIGHT: 100%; SCROLLBAR-ARROW-COLOR: #919192; PADDING-TOP: 0px; SCROLLBAR-TRACK-COLOR: #ffffff; FONT-FAMILY: 宋体; SCROLLBAR-DARKSHADOW-COLOR: #ffffff; LETTER-SPACING: 1pt; HEIGHT: auto; TEXT-ALIGN: left; background-repeat: no-repeat;">
				<!-- 用树形表格显示 -->
<!-- 				<table id="tbIpcAll" class="tablecss2"> -->
<!-- 				</table> -->
			</div>
			<div id="ipc4cond" style="display: none; width: 598px; HEIGHT: auto;">
				<table class="tablecss2">
					<tr>
						<td>
<!-- 							<table id="tbIpcCond" class="tablecss2"> -->
<!-- 							</table> -->
							<div id="splitpage1" style="display: inline;"></div>
						</td>
					</tr>
				</table>

			</div>

			<div id="ipc4detail" 
				style="display: none; width: 598px; HEIGHT: auto;">
<!-- 				<table id="tbIpc4detail" class="tablecss2"> -->
<!-- 				</table> -->
			</div>
		</div>
	</div>
	<!-- //windows2 end-->
</body>
</html>