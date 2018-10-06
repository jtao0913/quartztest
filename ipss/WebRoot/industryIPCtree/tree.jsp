<!DOCTYPE html>
<html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="width_warp" value="1020px" />

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="../jsp/zljs/include-head.jsp"%>

<link rel="stylesheet" href="<%=basePath%>industryIPCtree/zTreeStyle3.5/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="<%=basePath%>industryIPCtree/indexSort/indexSort.css" type="text/css">

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
		<div id="expDiv" style="width: 74%; float: right; display: none;">
			<div class="row-fluid" style="border-bottom: 1px solid #999999;"
				id="channelContainer">
				<div class="span12">
					<ol class="inline long">
						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="FMZL_FT" checked="checked">发明专利
						</label>
						</li>
						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="SYXX_FT" checked="checked">中国实用新型
						</label>
						</li>
						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="WGZL_AB" checked="checked">中国外观设计
						</label>
						</li>
						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="FMSQ_FT">中国发明授权 </label>
						</li>

						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="TWPATENT">中国台湾专利 </label>
						</li>
						<li><label class="checkbox"> <input name="channelId"
								id="invention" type="checkbox" value="HKPATENT">香港特区 </label>
						</li>
					</ol>
					<ol class="inline">
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="USPATENT">美国 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="JPPATENT">日本 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="GBPATENT">英国 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="DEPATENT">德国 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="FRPATENT">法国 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="CHPATENT">瑞士 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="EPPATENT">EPO </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="WOPATENT">WIPO </label>
						</li>
					</ol>
					<ol class="inline long">
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="KRPATENT">韩国 </label></li>
						<li><label class="checkbox"> <input id="America"
								name="channelId" type="checkbox" value="RUPATENT">俄罗斯 </label></li>
						<li><label class="checkbox"> <input
								id="SoutheaseAsia" name="channelId" type="checkbox"
								value="ASPATENT">东南亚 </label>
						</li>
						<li><label class="checkbox"> <input
								id="SoutheaseAsia" name="channelId" type="checkbox"
								value="GCPATENT">阿拉伯 </label>
						</li>
						
					</ol>
				</div>
			</div>
			<div class="row-fluid">
				<table style="width: 100%"
					class="table table-striped table-bordered table-hover ">
					<tr>
						<td><span class="searchColumn" column="申请号"
							title="将申请号字段添加到逻辑区域">申 请 号</span></td>
						<td><span class="searchColumn" column="申请日"
							title="将申请日字段添加到逻辑区域">申 请 日</span></td>
						<td><span class="searchColumn" column="公开（公告）号"
							title="将公开（公告）号字段添加到逻辑区域">公开（公告）号</span></td>
						<td><span class="searchColumn" column="公开（公告）日"
							title="将公开（公告）日字段添加到逻辑区域">公开（公告）日</span></td>
						<td><span class="searchColumn" column="名称"
							title="将名称字段添加到逻辑区域">名 称</span></td>
						<td><span class="searchColumn" column="摘要"
							title="将摘要字段添加到逻辑区域">摘 要</span></td>
					</tr>
					<tr>
						<td><span class="searchColumn" column="分类号"
							title="将分类号字段添加到逻辑区域">分 类 号</span></td>
						<td><span class="searchColumn" column="主分类号"
							title="将主分类号字段添加到逻辑区域">主 分 类 号</span></td>
						<td><span class="searchColumn" column="申请（专利权）人"
							title="将申请（专利权）人字段添加到逻辑区域">申请（专利权）人</span></td>
						<td><span class="searchColumn" column="发明（设计）人"
							title="将发明（设计）人字段添加到逻辑区域">发明（设计）人</span></td>
						<td><span class="searchColumn" column="地址"
							title="将地址字段添加到逻辑区域">地 址</span></td>
						<td><span class="searchColumn" column="国省代码"
							title="将国省代码字段添加到逻辑区域">国 省 代 码</span></td>
					</tr>
					<tr>
						<td><span class="searchColumn" column="专利代理机构"
							title="将专利代理机构字段添加到逻辑区域">专利代理机构</span></td>
						<td><span class="searchColumn" column="代理人"
							title="将代理人字段添加到逻辑区域">代 理 人</span></td>
						<%--<td><span class="searchColumn" column="优先权"
							title="将优先权字段添加到逻辑区域">优 先 权</span></td>
						<td><span class="searchColumn" column="同族专利"
							title="将同族专利字段添加到逻辑区域">同 族 专 利</span></td>
						--%><td><span class="searchColumn" column="主权项"
							title="将主权项字段添加到逻辑区域">主 权 项</span></td>
						<td><span class="searchColumn" column="说明书"
							title="将说明书字段添加到逻辑区域">说 明 书</span></td>
					</tr>
					<tr>
						<td><span class="searchColumn" column="权利要求"
							title="将权利要求字段添加到逻辑区域">权 利 要 求</span></td>
						<td colspan="5">&nbsp;</td>
					</tr>
				</table>
			</div>
			<div class="row-fluid ">
				<div class="btn-group">
					<a class="btn btn-middle" href="javascript:addItems(' and ');">and</a><a
						class="btn btn-middle" href="javascript:addItems(' or ');">or</a><a
						class="btn btn-middle" href="javascript:addItems(' not ');">not</a><a
						class="btn btn-middle" href="javascript:addItems(' ( ');">(</a><a
						class="btn btn-middle" href="javascript:addItems(' ) ');">)</a>
				</div>
				<textarea id="expCombArea"
					style="width: 99%; height: 300px; margin-bottom: 0px;"></textarea>
				<div>
					<button type="button" class="btn btn-primary pull-right"
						onclick="searchEditExp();">检索</button>
				</div>
			</div>
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
				<!-- 							<li><a href="javascript:patentAnalysis();">专利分析</a></li> -->
				<%--  					</c:if>  --%>
				<%-- 					<c:if --%>
				<%-- 						test="${fn:contains(sessionScope.loginUser.modules,'MODULE40') || sessionScope.loginUser.permissionId =='PERMISSIONM'}"> --%>
				<!-- 						<li><a href="javascript:onListenWarnByNode()">定期预警</a></li> -->
				<%-- 					</c:if> --%>
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

	<form action="${ctx }/search/doDetailSearch" id="detailForm"
		name="detailForm" method="post" target="_blank">
		<input type="hidden" name="pid" id="pid" />
	</form>
	<form action="${ctx }/search/doOverviewSearch" id="linkOverViewForm"
		name="linkOverViewForm" target="_blank">
		<input type="hidden" name="option" id="sortOption" value="" /> <input
			type="hidden" name="strSources" id="sortSources" value="" /> <input
			type="hidden" name="start" id="starttt" value="" /> <input
			type="hidden" name="strWhere" id="sortWhere" value="" /> <input
			type="hidden" name="strSortMethod" value="-公开（公告）日" />
	</form>
	<form action="${ctx }/search/json/doAnalysisSearch" method="post"
		id="analysisForm" target="_blank">
		<input type="hidden" name="strWhere" id="strWhere" value="" /> <input
			type="hidden" name="strSources" id="strSourcestt" value="" /> <input
			type="hidden" name="option" id="optiontt" value="" />
	</form>
	<form action="http://service.cnipr.com/pias/entry.do" name="piasform"
		id="piasform" method="post" target="_blank">
		<input type="hidden" name="searchword" id="searchWord" value="" />
		<!--URLEncoder.encode(searchword, "UTF-8")-->
		<input type="hidden" name="channelid" id="channelId" value="14,15,16">
		<!--频道号-->
		<input type="hidden" value="guangdong" name="remote">
		<input type="hidden" name="extension" value="">
		<!--同义词典，无-->
		<input type="hidden" name="cizi" value="2">
		<!--字词-->
		<input type="hidden" name="securityCode" id="securityCode" value="" />
		<input type="hidden" name="basic" value="1"> <input
			type="hidden" name="ms" id="pias_ms" value="">
		<!-- 0表示普通用户，1表示非普通用户, 10716表示管理员-->
	</form>
	<input type="hidden" id="selectdbs" value="" /> <input type="hidden"
		id="selectexp" value="" /> <input type="hidden" id="selectoption"
		value="" /> <input type="hidden" id="industryFlag"
		value="${industryFlag }" /> <input type="hidden" id="nodeId"
		value="${nodeId }" /> <input type="hidden" id="nodePid"
		value="${nodePid }" />
	<div class="modal fade" style="width: 600px;" id="db-search-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">二次检索</h4>
					</div>
					<!-- 					<div class="input-prepend input-append"> -->
					<!-- 						<div class="btn-group"> -->
					<!-- 							<select class="input-medium" id="db-search-option"> -->
					<!-- 								<option value="申请号=">申请号</option> -->
					<!-- 								<option value="公开（公告）号=">公开（公告）号</option> -->
					<!-- 								<option value="名称=">名称</option> -->
					<!-- 								<option value="摘要=">摘要</option> -->
					<!-- 								<option value="权利要求书=">权利要求书</option> -->
					<!-- 								<option value="公开（公告）日=">公开（公告）日</option> -->
					<!-- 								<option value="分类号=">分类号</option> -->
					<!-- 								<option value="申请日=">申请日</option> -->
					<!-- 								<option value="发明（设计）人=">发明（设计）人</option> -->
					<!-- 								<option value="申请（专利权）人=">申请（专利权）人</option> -->
					<!-- 								<option value="专利代理机构=">专利代理机构</option> -->
					<!-- 								<option value="代理人=">代理人</option> -->
					<!-- 								<option value="地址=">地址</option> -->
					<!-- 								<option value="国省代码=">国省代码</option> -->
					<!-- 								<option value="同族专利项=">同族专利项</option> -->
					<!-- 							</select> -->
					<!-- 						</div> -->
					<!-- 						<input class="input-xlarge" type="text" value="" -->
					<!-- 							id="db-search-option-text"> -->
					<!-- 					</div> -->
					<div class="label-container-patent" style="padding-top: 15px;">
						<a href="javascript:insertDBtitle('申请号=')"><span class="label">申请号
						</span>
						</a> <a href="javascript:insertDBtitle('公开（公告）号=')"><span
							class="label">公开（公告）号 </span>
						</a> <a href="javascript:insertDBtitle('名称=')"><span class="label">名称
						</span>
						</a> <a href="javascript:insertDBtitle('摘要=')"><span class="label">摘要</span>
						</a> <a href="javascript:insertDBtitle('权利要求书=')"><span
							class="label">权利要求书</span>
						</a> <a href="javascript:insertDBtitle('公开（公告）日=')"><span
							class="label">公开（公告）日</span>
						</a> <a href="javascript:insertDBtitle('分类号=')"><span
							class="label">分类号</span>
						</a> <a href="javascript:insertDBtitle('申请日=')"><span
							class="label">申请日</span>
						</a> <a href="javascript:insertDBtitle('发明（设计）人=')"><span
							class="label">发明（设计）人</span>
						</a> <a href="javascript:insertDBtitle('申请（专利权）人=')"><span
							class="label">申请（专利权）人</span>
						</a> <a href="javascript:insertDBtitle('专利代理机构=')"><span
							class="label">专利代理机构</span>
						</a> <a href="javascript:insertDBtitle('代理人=')"><span
							class="label">代理人</span>
						</a> <a href="javascript:insertDBtitle('地址=')"><span class="label">地址</span>
						</a> <a href="javascript:insertDBtitle('国省代码=')"><span
							class="label">国省代码</span>
						</a>
					</div>

					<div style="padding-top: 15px;">
						<textarea style="width: 95%; resize: none;" id="db-mult-text"></textarea>
					</div>
					<div class="btn-group pull-left">
						<button class="btn" type="button" onclick="insertDBtitle(' AND ')">AND</button>
						<button class="btn" type="button" onclick="insertDBtitle(' OR ')">OR</button>
						<button class="btn" type="button" onclick="insertDBtitle(' ( ')">(</button>
						<button class="btn" type="button" onclick="insertDBtitle(' ) ')">)</button>
					</div>
					<div class="btn-group pull-right">
						<button class="btn btn-primary" type="button"
							onclick="dbSearchNodeData()">
							<i class="icon-search icon-white"></i>&nbsp;检索
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

	<!--

	<input type="hidden" id="user_basic_auth"
		value="${sessionScope.loginUser.permissionId}">
	<script type="text/javascript" src="${ctx }/static/js/mask.js"></script>
	<script type="text/javascript" src="${ctx }/static/js/login/login.js"></script>
	<script type="text/javascript" src="${ctx }/static/js/wran/wran.js"></script>
		<script type="text/javascript"
		src="${ctx }/static/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
	<script type="text/javascript"
		src="${ctx }/static/js/seriallizeForm.js"></script>
		-->
		
	<script type="text/javascript"
		src="<%=basePath%>zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>

	<script type="text/javascript"
		src="<%=basePath%>industry/industryIndex.js"></script>
	<style type="text/css">
.label { /*,.table,.btn*/
	-webkit-border-radius: 0px;
	-moz-border-radius: 0px;
	border-radius: 0px;
}

label.checkbox {
	width: 46px;
}

ol.long label.checkbox {
	min-width: 90px;
}

.p-inline {
	display: inline-block;
	color: #999;
	font-family: "微软雅黑", 'Helvetica Neue', Helvetica, Arial, sans-serif;
	font-size: 12px;
	line-height: 20px;
	padding-left: 5px;
	vertical-align: middle;
	min-width: 220px;
	clear: both;
}

.p-inline a {
	display: inline-block;
	margin: 0 5px;
}

#page-nav {
	background-color: #DDDDDD;
	margin-top: 10px;
}

#page-nav td a {
	text-decoration: none;
	color: #999999;
	font-size: 14px;
	font-weight: bold;
}

#currentPage {
	width: 50px;
	margin: 0px 0px;
	padding: 0px;
}

#page-nav td a:HOVER {
	color: #222222;
}
</style>