<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<head>

<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>专家检索【CNIPA】-<%=website_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

<style type="text/css">
body {font-size: 14px;}
</style>
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->

<!-- 智能检索类库导入 -->


<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>

</head>

<body>
<!--导航-->

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

<script src="<%=basePath%>/analyse/json2.js"></script>
<%
if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>                   
                      <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>

<%}}
 %>
<script type="text/javascript">
function channelChecked_sx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){   
         if(o[i] == obj){   
              obj.checked = true;   
         }else{   
              o[i].checked = false;   
         }
    }
}

function channelChecked_yx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){   
         if(o[i] == obj){   
              obj.checked = true;   
         }else{   
              o[i].checked = false;   
         }   
    }    
}

function channelChecked(){

<% if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.SHIXIAOSEARCH)){%>
	document.getElementById("sxChannel").checked = false;
<%} }%>

<% if(SetupAccess.getProperty(SetupConstant.EFFECTLIB)!=null && SetupAccess.getProperty(SetupConstant.EFFECTLIB).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.EFFECTLIB)){%>
	document.getElementById("yxChannel").checked = false;
<%} }%>
}
</script>
<%@ include file="include-head-secondsearch.jsp"%>

<%String type = "cnlogic";%>
<%@ include file="include-head-jiansuo.jsp"%>
			
<!--分类结束-->
<div style="width:1120px;margin: auto;">
 <div style="height:15px;"></div>
 <div style="margin: auto;"><font style="font-size:14px;font-weight: bold;color:#666;padding-left:8px;">专家检索【CNIPA】</font></div>  
<form class="form-horizontal" id="searchForm" name="searchForm" action="<%=basePath%>overviewSearch.do?area=cn"
			method="post" target="_self">
			<input type="hidden" id="area" name="area" value="cn">
			<input type="hidden" id="synonymous" name="synonymous" value="1">
			<input type="hidden" name="channelid">
			<input type="hidden" id="presearchword" name="presearchword" value="<%=request.getAttribute("presearchword") %>">
			<input type="hidden" id="strWhere" name="strWhere">
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE">
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iHitPointType" value="115">
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" value="<%=request.getAttribute("trsLastWhere") %>">
			<input type="hidden" id="strChannels" name="strChannels">
			<input type="hidden" id="obj_expid" name="obj_expid">
			<input type="hidden" id="expsearch" name="expsearch">
   
   <!--国别选择-->
   <!-- 
        <div style="height:15px;"></div>
		                 <ol class="inline long">
										<li><label class="checkbox"> <input
												name="channelId" id="invention" type="checkbox" value="FMZL"
												checked="checked">中国发明公开
										</label></li>
										<li><label class="checkbox"> <input
												name="channelId" id="newDemo" type="checkbox" value="SYXX"
												checked="checked">中国实用新型
										</label></li>
										<li><label class="checkbox"> <input
												id="outDesign" name="channelId" type="checkbox" value="WGZL"
												checked="checked">中国外观设计 
										</label></li>
										<li><label class="checkbox"> <input
												type="checkbox" id="authorization" name="channelId"
												value="FMSQ">中国发明授权 </label></li>
							</ol>
							<ol class="inline text-warning">
								<li><label class="checkbox"> <input type="checkbox"
										value="" id="selectAll">全选库 </label></li>
							</ol>
							 -->
						    <!--国别选择结束-->
						    
	<div style="height:15px;"></div>
		<ol class="inline long">			    
		<c:forEach var="channel" items="${requestScope.channelTag}">			
			<li><label style="width:105px;cursor:hand" class="checkbox">
			<!-- 
			<img style="width:30px;margin-bottom:5px" class="img-responsive " src="images/cn/${channel.intChannelID}.png">
			 -->
			<input type="checkbox"  onclick="channelChecked();" value1="${channel.intChannelID}" value="${channel.chrTRSTable}" alt="${channel.chrTRSTable}" name="strdb" 
			${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>			
		</c:forEach>
		<!-- 
		<li style="float:right;"><label for="c4" style="cursor:hand"><input type="checkbox" name="savesearchword" value="ON" id="c4"
								   CHECKED style="cursor:hand">　保存检索表达式</label></li>
		 -->
		 
<% if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){%>
		<%
//		if(strItemGrant.contains(SetupConstant.SHIXIAOSEARCH))
		{%>
		<li><label style="width:105px;cursor:hand" class="checkbox">
		<input type="checkbox" value="34,35,36" name="strdb" id="sxChannel"  
		<%if( request.getAttribute("channelId")!=null && request.getAttribute("channelId").equals("34,35,36") ) out.print("checked"); %>
			 style="cursor:hand" onclick="channelChecked_sx(this);">
				失效专利
		</label></li>
<%}}%>
		 
		</ol>


<base target="_self"/>



  <!--专家模式开始-->
  <div class="row-fluid">
  	    <div class="span3">
  	    <table style="width: 100%"
				class="table table-striped table-bordered table-hover ">
				<tr>
					<td style="width:40%;"><span class="searchColumn" column="名称,摘要"
						title="将‘名称,摘要’字段添加到逻辑区域">名称,摘要</span>
					</td>
					<td><span class="searchColumn" column="名称,摘要,主权项"
						title="将‘名称,摘要,主权项’字段添加到逻辑区域">名称,摘要,主权项</span>
					</td>
				</tr>
				<tr>
					<td style="width:40%;"><span class="searchColumn" column="名称"
						title="将‘名称’字段添加到逻辑区域">名称</span>
					</td>
					<td><span class="searchColumn" column="名称,摘要,权利要求书"
						title="将‘名称,摘要,权利要求书’字段添加到逻辑区域">名称,摘要,权利要求书</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="摘要"
						title="将‘摘要’字段添加到逻辑区域">摘要</span>
					</td>
					<td><span class="searchColumn" column="主权项"
						title="将‘主权项’字段添加到逻辑区域">主权项</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="主分类号"
						title="将‘主分类号’字段添加到逻辑区域">主分类号</span>
					</td>
					<td><span class="searchColumn" column="分类号"
						title="将‘分类号’字段添加到逻辑区域">分类号</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="地址"
						title="将‘地址’字段添加到逻辑区域">地址</span>
					</td>
					<td><span class="searchColumn" column="申请号"
						title="将‘申请（专利）号’字段添加到逻辑区域">申请（专利）号</span>
					</td>
				</tr>
				
				<tr>
					<td><span class="searchColumn" column="国省代码"
						title="将‘国省代码’字段添加到逻辑区域">国省代码</span>
					</td>
					<td><span class="searchColumn" column="国民经济代码"
						title="将‘国民经济代码’字段添加到逻辑区域">国 民 经 济 代 码</span>
					</td>
				</tr>
				
				<tr>	
					<td><span class="searchColumn" column="申请日"
						title="将‘申请日’字段添加到逻辑区域">申请日</span>
					</td>
					<td><span class="searchColumn" column="公开（公告）号"
						title="将‘公开（公告）号’字段添加到逻辑区域">公开（公告）号</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="国际公布"
						title="将‘国际公布’字段添加到逻辑区域">国际公布</span>
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
					<td><span class="searchColumn" column="代理人"
						title="将‘代理人’字段添加到逻辑区域">代理人</span>
					</td>
					<td><span class="searchColumn" column="专利代理机构"
						title="将‘专利代理机构’字段添加到逻辑区域">专利代理机构</span>
					</td>
				</tr>
				<tr>	
					<td><span class="searchColumn" column="权利要求书"
						title="将‘权利要求书’字段添加到逻辑区域">权利要求书</span>
					</td>
					<td><span class="searchColumn" column="公开（公告）日"
						title="将‘公开（公告）日’字段添加到逻辑区域">公开（公告）日</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="说明书"
						title="将‘说明书’字段添加到逻辑区域">说明书</span>
					</td>
					<td><span class="searchColumn" column="最新法律状态"
						title="将‘最新法律状态’字段添加到逻辑区域">最新法律状态</span>
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
var area = "cn";

$(function() {
	$("body").mask("正在初始化，请稍候...");	
	generate_pageinfo(area,1,0);
	$('body').unmask();
});
</script>
		    
			</div>
		</div>
		
		
		
		</div>

     
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
			<textarea id="txtComb" name="txtComb" rows="5" style="width: 99%; margin-bottom: 0px;"></textarea>
			<div class="pull-right" id="saveDiv">
			
			<input type="button" value="检索" class="btn inline btn-primary" onClick="javascript:searchsaveexp('<%=basePath%>','cn')" />
			<!-- 
			<input type="button" value="检索" class="btn inline btn-primary" onClick="javascript:submitDataToSearch()" />
			-->
			<input type="button" value="清除" class="btn inline btn-warning" onClick="clearPageData();"/>
			</div>
		</div>
<!--专家模式结束-->
</form>

<%@ include file="include_exp.jsp"%>


</div>

<%@ include file="include-buttom.jsp"%>



</BODY>
</HTML>

<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>
<script type="text/javascript" src="<%=basePath%>js/SimpleTable.js"></script>


<script type="text/javascript">
		/*
		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
//				return false;
			}
		});
		*/
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
				//alert($(this).attr("column"));
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


<!--专家模式开始-->

<link href="<%=basePath%>common/expert/style.css" rel="stylesheet"/>


<!--专家模式结束-->
   