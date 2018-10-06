<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>
<html>
<head>
<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>专家检索【港澳台及国外】-<%=website_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->
    

</head>
<body>
<!--导航-->

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

<%@ include file="include-head-secondsearch.jsp"%>

<%String type = "frlogic";%>
<%@ include file="include-head-jiansuo.jsp"%>

   
<div style="width:1120px;margin: auto;">
<div style="height:15px;"></div>
<div style="margin: auto;"><font style="font-size:14px;font-weight: bold;color:#666;padding-left:8px;">专家检索【港澳台及国外】</font></div>	
<form class="form-horizontal" id="searchForm" name="searchForm" action="<%=basePath%>overviewSearch.do?method=overviewSearch&area=fr"
			method="post" target="_self">
			<input type="hidden" id="area" name="area" value="fr">
			<input type="hidden" id="presearchword" name="presearchword" value="<%=request.getAttribute("presearchword") %>">
			<input type="hidden" id="strWhere" name="strWhere">
			<input type="hidden" name="strSortMethod" id="strSortMethod" value="RELEVANCE">
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iHitPointType" value="115">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" id="searchKind" name="searchKind" value="tableSearch">
			<input type="hidden" id="strChannels" name="strChannels">
			<input type="hidden" id="expid" name="expid">
			<input type="hidden" id="expsearch" name="expsearch">
<base target="_self">


<%@ include file="include-fr-channel.jsp"%>

<input type="hidden" value="" name="strSources">
<input type="hidden" name="searchChannel" value=""> 


  <!--专家模式开始-->
      <!--表格逻辑框开始-->
  <div class="row-fluid">
  	    <div class="span3">
  	    <table style="width: 100%"
				class="table table-striped table-bordered table-hover ">
				<tr>
					<td><span class="searchColumn" column="名称"
						title="将‘名称’字段添加到逻辑区域">名称</span>
					</td>
					<td><span class="searchColumn" column="名称,摘要"
						title="将‘名称,摘要’字段添加到逻辑区域">名称,摘要</span>
					</td>
				</tr>
				<tr>	
					<td><span class="searchColumn" column="分类号"
						title="将‘分类号’字段添加到逻辑区域">分类号</span>
					</td>
					<td><span class="searchColumn" column="摘要"
						title="将‘摘要’字段添加到逻辑区域">摘要</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="主分类号"
						title="将‘主分类号’字段添加到逻辑区域">主分类号</span>
					</td>
					<td><span class="searchColumn" column="申请号"
						title="将‘申请号’字段添加到逻辑区域">申请号</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="申请日"
						title="将‘申请日’字段添加到逻辑区域">申请日</span>
					</td>
					<td><span class="searchColumn" column="公开（公告）日"
						title="将‘公开（公告）日’字段添加到逻辑区域">公开（公告）日</span>
					</td>
				</tr>
				<tr>
                    <td><span class="searchColumn" column="公开（公告）号"
						title="将‘公开（公告）号’字段添加到逻辑区域">公开（公告）号</span>
					</td>
					<td><span class="searchColumn" column="申请（专利权）人"
						title="将‘申请（专利权）人’字段添加到逻辑区域">申请（专利权）人</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="优先权"
						title="将‘优先权’字段添加到逻辑区域">优先权</span>
					</td>
					<td><span class="searchColumn" column="发明（设计）人"
						title="将‘发明（设计）人’字段添加到逻辑区域">发明（设计）人</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="同族专利项"
						title="将‘同族专利项’字段添加到逻辑区域">同族专利项</span>
					</td>
					<td>
					</td>
				</tr>
			</table>	
  	    </div>
		<div class="span9 clearfix">
			<table style="width:100%;border:2px solid #3498db;background-color: #3498db;color:#ffffff;">
			<tr>
			 <td style="width:6%;text-align:center;">选择</td>
			 <td style="width:33%;text-align:center;">表达式</td>
			 <td style="width:10%;text-align:center;">命中数</td>
			 <td style="width:30%;text-align:center;">检索库</td>
			 <td style="width:12%;text-align:center;">检索时间</td>
			 <td style="width:10%;text-align:center;">操作</td>
			  </tr>
			</table>
			
			<div style="width: 100%;padding-bottom:10px;">
<table id="exptable" class="table table-striped table-bordered table-hover" style="width:100%;margin:0px;padding:0px;font-size:13px;">
</table>
<div style="margin-top:6px;"><span id="seloption"></span> <span  id="exppage" style="float:right;"></span></div>
<script type="text/javascript">
var area = "fr";

$(function() {
	$("body").mask("正在初始化，请稍候...");	
	generate_pageinfo(area,1,0);
	$('body').unmask();
});
</script>

			</div>
		</div>		
		</div>
　　<!--表格逻辑框结束-->
     
     
     
     <div class="row-fluid ">
			<div class="btn-group">
				<a class="btn btn-middle" href="javascript:addItems(' and ');">and</a><a
					class="btn btn-middle" href="javascript:addItems(' or ');">or</a><a
					class="btn btn-middle" href="javascript:addItems(' not ');">not</a><a
					class="btn btn-middle" href="javascript:addItems('+=');">+=</a><a
					class="btn btn-middle" href="javascript:addItems('=');">=</a><a
					class="btn btn-middle" href="javascript:addItems('\'');">'</a><a
					class="btn btn-middle" href="javascript:addItems('%');">%</a><a
					class="btn btn-middle" href="javascript:addItems(',');">,</a><a
					class="btn btn-middle" href="javascript:addItems('(');">(</a><a
					class="btn btn-middle" href="javascript:addItems(')');">)</a>
				<!-- 
					<span
					id="hid1"><a class="btn btn-middle"
					href="javascript:addItems(' xor ');">xor</a><a
					class="btn btn-middle" href="javascript:addItems(' adj ');">adj</a><a
					class="btn btn-middle" href="javascript:addItems(' equ/10 ');">equ/10</a><a
					class="btn btn-middle" href="javascript:addItems(' xor/10 ');">xor/10</a><a
					class="btn btn-middle" href="javascript:addItems(' pre/10 ');">pre/10</a>
				</span> <a class="btn btn-middle" href="javascript:return;" id="cli1">&gt;&gt;</a>
				 -->
				
			</div>
			<textarea id="txtComb" rows="5"
				style="width: 99%; margin-bottom: 0px;"></textarea>
			<div class="pull-right" id="saveDiv">					
					<input type="button" value="检索" class="btn inline btn-primary" onClick="javascript:searchsaveexp('<%=basePath%>','fr')" />
					<input type="button" value="清除" class="btn inline btn-warning" onClick="clearPageData();"/>
			</div>
		</div>
   <!--专家模式结束-->
 

</form>

<%@ include file="include_exp.jsp"%>

<form name="expForm" action="" method="post" target="_self">
	<input type="hidden" name="expid">
	<input type="hidden" name="state">
	<input type="hidden" name="expName">
	<input type="hidden" name="area" value="fr">
</form>

<%@ include file="include-buttom.jsp"%>

</BODY>
</HTML>


<script type="text/javascript">
function selectAllCheckChannel(objValue) {
	if (objValue == true) {
		$("input[name='strdb']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",true);
//			$(this).checked = true;
			this.checked=true;
		});		
	} else {
		$("input[name='strdb']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",false);
//			$(this).checked = false;
			this.checked=false;
		});	
	}
}
</script>

<!--专家模式开始-->
<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>
<link href="<%=basePath%>common/expert/style.css" rel="stylesheet"/>

<script type="text/javascript">

		$(function() {
			$('body').css({
				'overflow-y' : 'scroll'
			});
			$('#selectAll').change(function() {
				if (this.checked) {
					$('input[name="channelId"]').attr({
						'checked' : true
					});
				} else {
					$('input[name="channelId"]').attr({
						'checked' : false
					});
				}
			});

			$('#allExp').change(function() {
				if (this.checked) {
					$('input[name="expKey"]').attr({
						'checked' : true
					});
				} else {
					$('input[name="expKey"]').attr({
						'checked' : false
					});
				}
			});
			$('#inverSelect').change(function() {
				if (this.checked) {
					$('input[name="channelId"]').each(function() {
						if (this.checked) {
							$(this).attr({
								'checked' : false
							});
						} else {
							$(this).attr({
								'checked' : true
							});
						}
					})
				} else {
					$('input[name="channelId"]').each(function() {
						if (this.checked) {
							$(this).attr({
								'checked' : false
							});
						} else {
							$(this).attr({
								'checked' : true
							});
						}
					})
				}
			});
			$(".searchColumn").click(function() {
				//alert("searchColumn click");
//				var col = $(this).attr("column") + "=";				
				var columnval = $(this).attr("column");
				
				var col = columnval + "=";
				if(columnval.indexOf(",")>-1){
					col = $(this).attr("column") + "+=";
				}
				
				var field = document.getElementById("txtComb");
				insertAtCursor(field, col);
			});
			$("#cli1").click(function() {
				var f = $("#hid1").attr("display");
				var t = $(this).text();
				if (t == '>>') {
					$("#hid1").show();
					$(this).text("<<");
				} else {
					$("#hid1").hide();
					$(this).text(">>");
				}
			});

			//生成表达式事件
			$('#saveExp').click(function() {
				var expAreaText = $('#txtComb').val();
				if (expAreaText != null && expAreaText != "") {
					addUserExp(expAreaText);
				} else {
					alert("表达式不能为空");
				}
			});

			//采用porxy代理插件渲染历史表达式
			freashUserExp();
			$('#backward').click(function() {
				$('#expData').mask('正在提交');
				var param = {};
				var pageInput = parseInt($('#pageInput').val());
				var maxPage = parseInt($('#maxPage').val());
				if (pageInput < maxPage) {
					param.currentPage = pageInput + 1;
				} else {
					param.currentPage = maxPage;
				}
				freashUserExpByParam(param);
			});
			$('#forward').click(function() {
				$('#expData').mask('正在提交');
				var param = {};
				var pageInput = parseInt($('#pageInput').val());
				var maxPage = parseInt($('#maxPage').val());
				if (pageInput - 1 <= 0) {
					param.currentPage = 1;
				} else {
					param.currentPage = pageInput - 1;
				}
				freashUserExpByParam(param);
			});
			$('#first').click(function() {
				freashUserExp();
			});
			$('#refreshBtn').click(function() {
				$('#expData').mask('正在提交');
				var param = {};
				param.currentPage = parseInt($('#pageInput').val());
				freashUserExpByParam(param);
			});
			$('#last').click(function() {
				$('#expData').mask('正在提交');
				var param = {};
				var maxPage = parseInt($('#maxPage').val());
				param.currentPage = maxPage;
				freashUserExpByParam(param);
			});
		});
	</script>
<!--专家模式结束-->
