<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.fenye.Page,com.cnipr.corebiz.search.entity.PatentInfo"%>

<head>
<%@ include file="include-head.jsp"%>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>专家检索【中国】-<%=website_title%></title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
	<meta name="description" content="<%=website_title%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />

	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
	<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>
	
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->
	</head>
	<body>
	


<form id="searchForm" name="searchForm"  method="post" target="_self">
	<input type="hidden" id="wap" name="wap" value="1"/>
	<input type="hidden" id="area" name="area" value="cn">
	<input type="hidden" id="strWhere" name="strWhere">
	<input type="hidden" id="strSources" name="strSources">
</form>

<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img  src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>	
<!--顶部显示-->

<!--命令行检索-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="col-xs-12" style="line-height:20px;text-align: left;color:#666666;">
			<strong>命令行检索</strong>
		</div>
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	 </div>
</div>
<!--命令行检索-->
	
<!--库选择-->
<div class="container" style="color:#666666;margin-top:-10px;">
	<div class="row">
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="14" name="strdb" checked style="cursor:hand">发明</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="15" name="strdb" checked style="cursor:hand">新型</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="16" name="strdb" checked style="cursor:hand">外观</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="17" name="strdb"  style="cursor:hand">授权</label>
			</center>
		</div>
	</div>
</div>
<!--库选择-->

   <div class="container">
    <div style="height:10px;"></div>
	<!--命令行框-->
	<div class="row">
		<div class="col-xs-12">
			<div class="btn-group">
				<a class="btn mycolor_bor" href="javascript:addItems(' and ');">and</a>
				<a class="btn mycolor_bor" href="javascript:addItems(' or ');">or</a>
				<a class="btn mycolor_bor" href="javascript:addItems(' not ');">not</a>
				<a class="btn mycolor_bor" href="javascript:addItems('=');">=</a>
				<a class="btn mycolor_bor" href="javascript:addItems('%');">%</a>
				<a class="btn mycolor_bor" href="javascript:addItems('(');">(</a>
				<a class="btn mycolor_bor" href="javascript:addItems(')');">)</a>
			</div>
		</div>
		<div class="col-xs-12">
			<textarea class="form-control" id="txtComb" name="txtComb" rows="5"></textarea>
		</div>
		<div class="col-xs-12">
			<div style="height:8px;"></div>
			<center>
				<input type="submit" value="检索" class="btn inline btn-primary" onClick="searchexp()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="清除" class="btn inline btn-warning" onClick="clearPageData()" />
			</center>
		</div>
	</div>
   <!--命令行框-->
   <div style="height:30px;"></div>
 <!--字段选择-->
  <div class="row">
  	    <div class="col-xs-12">
  	    <table style="width: 100%"
				class="table table-striped table-bordered table-hover ">
				<tr>
					<td style="width:40%;"><span class="searchColumn" column="名称"
						title="将‘名称’字段添加到逻辑区域">名 称</span>
					</td>
					<td><span class="searchColumn" column="摘要"
						title="将‘摘要’字段添加到逻辑区域">摘 要</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="主权项"
						title="将‘主权项’字段添加到逻辑区域">主 权 项</span>
					</td>
					<td><span class="searchColumn" column="分类号"
						title="将‘分类号’字段添加到逻辑区域">分 类 号</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="主分类号"
						title="将‘主分类号’字段添加到逻辑区域">主 分 类 号</span>
					</td>
					<td><span class="searchColumn" column="申请号"
						title="将‘申请（专利）号’字段添加到逻辑区域">申请号</span>
					</td>
				</tr>
				<tr>	
					<td><span class="searchColumn" column="申请日"
						title="将‘申请日’字段添加到逻辑区域">申 请 日</span>
					</td>
					<td><span class="searchColumn" column="公开（公告）号"
						title="将‘公开（公告）号’字段添加到逻辑区域">公开（公告）号</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="国际公布"
						title="将‘国际公布’字段添加到逻辑区域">国 际 公 布</span>
					</td>
					<td><span class="searchColumn" column="申请（专利权）人"
						title="将‘申请（专利权）人’字段添加到逻辑区域">申请（专利权）人</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="地址"
						title="将‘地址’字段添加到逻辑区域">地 址</span>
					</td>
					<td><span class="searchColumn" column="发明（设计）人"
						title="将‘发明（设计）人’字段添加到逻辑区域">发明（设计）人</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="优先权"
						title="将‘优先权’字段添加到逻辑区域">优 先 权</span>
					</td>
					<td><span class="searchColumn" column="专利代理机构"
						title="将‘专利代理机构’字段添加到逻辑区域">专利代理机构</span>
					</td>
				</tr>
				<tr>	
					<td><span class="searchColumn" column="代理人"
						title="将‘代理人’字段添加到逻辑区域">代 理 人</span>
					</td>
					<td><span class="searchColumn" column="公开（公告）日"
						title="将‘公开（公告）日’字段添加到逻辑区域">公开（公告）日</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="颁证日"
						title="将‘颁证日’字段添加到逻辑区域">颁 证 日</span>
					</td>
					<td><span class="searchColumn" column="国省代码"
						title="将‘国省代码’字段添加到逻辑区域">国 省 代 码</span>
					</td>
				</tr>
				<tr>
					<td><span class="searchColumn" column="权利要求书"
						title="将‘权利要求书’字段添加到逻辑区域">权利要求书</span>
					</td>
					<td><span class="searchColumn" column="说明书"
						title="将‘说明书’字段添加到逻辑区域">说 明 书</span>
					</td>
				</tr>
			</table>	
  	    </div>
		</div>		
	<!--字段选择-->
 
</div>
<div style="height:60px;"></div>

<%@ include file="include-bottom.jsp"%>

</body>
</html>
<!--专家模式开始-->
<script type="text/javascript" src="<%=basePath%>common/expert/expertSearch.js"></script>

<script type="text/javascript">

$("input:checkbox").bind('click',function(event){
//$("div").html("Event: " + event.type);
//	$(this).attr("type","checkbox");
	$(this).attr("checked",!($(this).attr("checked")));
});

$("#clear1").bind('click',function(event){
	$("input[type='text']").val("");
});

function mytrim(str)
{
     return str.replace(/(^\s*)|(\s*$)/g, "");
}

function searchexp(){
	strdbValid();
		
	var strWhere = $("#txtComb").val();
	strWhere = $.trim(strWhere);
//	strWhere = mytrim(strWhere);	
	
	var strSources = $.trim($('#searchForm #strSources').val());
//	channels = $.trim(channels);
	
//alert("strWhere="+strWhere);
//alert("strSources="+strSources);
	
   	if(strWhere==''){//如果检索条件为空,返回错误
   		alert("请输入检索表达式");
   		return false;
   	}
   	
	strWhere=encodeURI(strWhere);
	strWhere=encodeURI(strWhere);
		
	if(strWhere!=""&&strSources!=""){
//		alert(document.searchForm.strWhere.value);
//		alert(document.searchForm.strChannels.value);
		document.searchForm.action="<%=basePath%>wappretoJsonOverView.do?wap=1&area=cn&strWhere="+strWhere+"&strSources="+strSources;
//		$("#searchForm #strChannels").val(channels);
//		$("#searchForm #strWhere").val(expcontent);
		$("#searchForm").submit();
	}
}

	function strdbValid(){
//alert("11111");
//var checkedLength=0;
		var strSources = "";
		$("input[name='strdb']").each(function(){		 
//alert($(this).val() + "-----" + $(this).attr("checked"));

			if($(this).attr("checked")){
//				checkedLength++;
				if(strSources!=""){
					strSources += ",";
				}
				strSources += $(this).val();
			}
		});
		 
		
//		alert("strSources="+strSources);
		if(strSources==""){
			alert("请选择检索库");
			return false;
		}else{
			$('#searchForm #strSources').val(strSources);
			return true;
		}

	}
</script>

<script type="text/javascript">

		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
				return false;
			}
		});
		$(function() {
			$(".searchColumn").click(function() {
				var col = $(this).attr("column") + "";
				var field = document.getElementById("txtComb");
				insertAtCursor(field, col);
			});
		
/*
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
*/
		});

	</script>
<!--专家模式结束-->
   