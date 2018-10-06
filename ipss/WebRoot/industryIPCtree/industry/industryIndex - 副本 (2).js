var addImgCount = 0;
var expendNodeUrl = "";
var treeObj;
var params = {};
var targetNodeUrl = "/node/json/getDiyNodes?timeStamp=" + new Date();
// 缓存频道的数据信息
var cahceChannel = {};
var isLoading = false;
var clickCnOption = 2;
var initClickNode = '#zTreee_2_a';
var boot_node_tid = "#zTreee_1";
cn_cookie_key = "vm_script_cnode";

// $('body').mask('加载中...');
var staticTableSearch = '<div class="row-fluid"><div class="span12"><ol class="inline long">'
'<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="FMZL_FT" checked="checked">发明专利</label></li>'
'+<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="SYXX_FT" checked="checked">中国实用新型</label></li>'
'+<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="WGZL_AB" checked="checked">中国外观设计</label></li>'
'+<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="FMSQ_FT" >中国发明授权</label></li>'
'+<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="TWPATENT">中国台湾专利</label></li>'
'+<li><label class="checkbox"> <input name="channelId" id="invention" type="checkbox" value="HKPATENT">香港特区</label></li>'
'+</ol></div></div>';
var setting = {
	treeId : "zTreeh",
	view : {
		addHoverDom : addHoverDom,
		removeHoverDom : removeHoverDom
	},
	callback : {
		onClick : zTreeOnClick,
		beforeExpand:zTreeBeforeExpand
	}
};
$(function() {
	/*
	 * 初始化树，parentId = 0
	 */
	// var parentId = "0";
	deleteCookieCache();
	var tnodeId = $('#nodeId').val();
	var tnodePid = $('#nodePid').val();
	if (tnodePid == null || tnodePid == "") {
		tnodePid = "0";
	}
	var industryFlag = $('#industryFlag').val();
	if (industryFlag == "0") {
		initClickNode = '#zTreee_2_a';
		targetNodeUrl = ctx + "/node/json/getNodes?timeStamp=" + new Date();
		loadDataFunc(tnodePid, tnodeId, targetNodeUrl);
	} else if (industryFlag == "1") {
		initClickNode = '#zTreee_73_span';
		targetNodeUrl = ctx + "/node/json/getDiyNodes?timeStamp=" + new Date();
	
		loadDataFunc(tnodePid, tnodeId, targetNodeUrl);
	} else if (industryFlag == "2") {
		if (tnodeId != null && tnodeId != "") {
			initClickNode = '#zTreee_1_a';
		} else {
			initClickNode = '#zTreee_2_a';
		}
		targetNodeUrl = ctx + "/node/json/getDiyqxNodes?timeStamp="
				+ new Date();
		loadDataFunc(tnodePid, tnodeId, targetNodeUrl);
	}else if (industryFlag == "3"){
		if(tnodeId!=null && tnodeId!=""){
			initClickNode = '#zTreee_1_a';
		}else{
			initClickNode = '#zTreee_2_a';
		}
		targetNodeUrl = ctx + "/node/json/getBaseNodes?timeStamp="+new Date();
		loadDataFunc(tnodePid,tnodeId, targetNodeUrl);
	}
	
	$('#saveToTopic,#saveAllToTopic').click(function() {
		if (this.id == 'saveAllToTopic') {
			// 收藏全部专利
			
			if(params.ptotal>200){
				alert("已经超过收藏的最大总数200条");
				$('body').unmask();
				return;
			}
			saveCollectFlag = 1;
		} else {
			saveCollectFlag = 0;
			var patents = $("input[name='recordno']:checked").val();
			if (patents == null || patents == "") {
				alert("请勾选需要收藏的选择专利");
				return;
			}
		}
		getTopicsRequest();
	});
	// 保存收藏内容
	$('#saveCollectBtn').click(function() {
		$('body').mask('正在提交');
		$('#collectModal').modal('hide');
		var topicId = $('input[name="topicRadio"]:checked').val();
		var topicName = "";
		if (saveCollectFlag == 0) {
			var sysids = "";
			$("input[name='recordno']:checked").each(function() {
				sysids += $(this).attr("sysid") + ",";
			});
			if (sysids == null || sysids == "") {
				return;
			}
			// 取得topicName
			if (topicId == "" || topicId == null) {
				topicName = $('#newTopicName').val();
			}
			$.ajax({
				type : "POST",
				url : ctx + "/auth/json/saveTopics",
				data : {
					'sysids' : sysids,
					'topicId' : topicId,
					'topicName' : topicName
				},
				dataType : 'json',
				success : function(data) {
					if (data.rCode == "100000") {
						alert('收藏成功');
					} else {
						alert('收藏失败,请联系管理员');
					}
					$('body').unmask();
				},
				error : function() {
					alert('收藏失败,请联系管理员');
				}
			});
		} else {
			if (topicId == "" || topicId == null) {
				topicName = $('#newTopicName').val();
			}
			params.topicId = topicId;
			params.topicName = topicName;
			params.cacheStrWhere = params.strWhere;
//			params.strWhere+=params.strWhere+params.statuscode;
			$.ajax({
				type : "POST",
				url : ctx + "/auth/json/saveAllTopics?timeStamp=" + new Date(),
				data : params,
				dataType : 'json',
				success : function(data) {
					if (data.rCode == "100000") {
						alert('收藏成功');
					} else {
						alert('收藏失败,请联系管理员');
					}
					$('body').unmask();
				},
				error : function() {
					alert('收藏失败,请联系管理员');
				}
			});
			params.strWhere = params.cacheStrWhere;
			params.cacheStrWhere = '';
//			params.strWhere = $('#selectexp').val();
		}
	});
	initPageContextEvent();
});
$('#currentPage').bind('keypress', function(event) {
	if (event.keyCode == "13") {
		var inputPage = $('#currentPage').val();
		if (!isNaN(inputPage)) {
			goPage();
		}
	}
});
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

loadDataFunc = function(parentId, nodeId, url) {
	$('body').mask('正在检索');
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'id' : nodeId,
			'pId' : parentId
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
				initTree(data);
			}
		}
	});
};

/*
 * 鼠标悬浮事件
 */
function addHoverDom(treeId, treeNode) {
	if (treeNode.id == "10000") {
		return;
	}
	var flagTemp = $('#industryFlag').val();
	if (flagTemp != null && flagTemp != "") {
		if (addImgCount == 0) {
			var aObj = $("#" + treeNode.tId + "_a");
			var appStr = $('<span class="img-cn-own" style="cursor:pointer"><img src="'
					+ ctx
					+ '/static/images/CN.gif" name="CNIMG"/>&nbsp;<img src="'
					+ ctx + '/static/images/FR-en.gif" name="ENIMG"/></span>');
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
function zTreeBeforeExpand(treeId, treeNode) {
	expandNodeData(treeNode);
	return true;
};

function zTreeOnClick(event, treeId, treeNode) {
	gloabTitle = treeNode.name;
	clickKey = treeNode.key;
	if (treeNode.id == "10000" || treeNode.id == "" || treeNode.id == null) {
		return;
	}
	clickCnOption = treeNode.cnTrsOption;
	var clickName = $(event.target).attr('name');
	deleteCookieCache();
	$('#overViewDiv').html('');
	// 情况频道缓存
	if ("CNIMG" == clickName) {
		$('#expDiv').hide();
		// 保存节点中文的表达式和库信息
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

function cacheNodeData() {
	params.strWhere = $('#selectexp').val();
	params.quadraticText = '';
	params.cacheQuadraticText = '';
	params.channelId = $('#selectdbs').val();
	params.option = $('#selectoption').val();
}

/**
 * 点击检索按钮后，对已经编辑的表达式进行检索
 */
function searchEditExp() {
	var channels = "";
	$('#channelContainer').find('input:checked').each(function() {
		channels = channels + this.value + ",";
	});
	var expEdit = $('#expCombArea').val();
}

function hyzsAnalysis() {
	var user_base_auth = $('#user_basic_auth').val();
	if (user_base_auth != null && user_base_auth != "") {
		// 如果是guest用户
		if (user_base_auth == 'PERMISSIONG') {
			if (cahceChannel.total > 50000) {
				alert("分析数据超过最大限制(50000)");
				return;
			}
		} else {
			if (cahceChannel.total > 50000) {
				alert("分析数据超过最大限制(50000)");
				return;
			}
		}
	} else {
		alert("无相关权限");
	}
	var strWhere = $('#selectexp').val();
	var strSources = $('#selectdbs').val();
	$.ajax({
		type : "GET",
		url : ctx + "/search/json/getSecurityCode",
		data : {
			'strWhere' : strWhere,
			'selectdbs' : strSources
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null && data.rCode == "100000") {
				$('#searchWord').val(data.data.analysisWhere);
				$('#securityCode').val(data.data.securityCode);
				$('#channelId').val(data.data.channelSn);
				$('#piasform').attr({
					'action' : 'http://service-pias.cnipr.com/hyzs/entry.do'
				});
				$('#piasform').submit();
			}
		}
	});
}

function patentAnalysis() {
	var user_base_auth = $('#user_basic_auth').val();
	if (user_base_auth != null && user_base_auth != "") {
		// 如果是guest用户
		if (user_base_auth == 'PERMISSIONG') {
			if (cahceChannel.total > 10000) {
				alert("分析数据超过最大限制(10000)");
				return;
			}
			$('#pias_ms').val("0");
		} else if (user_base_auth == 'PERMISSIONM') {
			if (cahceChannel.total > 50000) {
				alert("分析数据超过最大限制(50000)");
				return;
			}
			$('#pias_ms').val("10716");
		} else {
			if (cahceChannel.total > 30000) {
				alert("分析数据超过最大限制(30000)");
				return;
			}
			$('#pias_ms').val("1");
		}
	} else {
		alert("无相关权限");
	}

	var strWhere = $('#selectexp').val();
	var strSources = $('#selectdbs').val();
	$.ajax({
		type : "GET",
		url : ctx + "/search/json/getSecurityCode?timeStamp=" + new Date(),
		data : {
			'strWhere' : strWhere,
			'selectdbs' : strSources
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null && data.rCode == "100000") {
				$('#searchWord').val(data.data.analysisWhere);
				$('#securityCode').val(data.data.securityCode);
				$('#channelId').val(data.data.channelSn);
				$('#piasform').attr({
					'action' : 'http://59.151.93.240/pias/entry.do'
				});
				$('#piasform').submit();
			}
		},
		error : function() {
			alert('表达式过长，请选择下一级菜单');
		}
	});
}

function expandNodeData(treeNode) {
	$.ajax({
		type : "GET",
		url : targetNodeUrl,
		data : {
			'id' : '',
			'pId' : treeNode.id
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
				treeObj.removeChildNodes(treeNode);
				$.each(data, function(i) {
					treeObj.addNodes(treeNode, this);
				});
			}
		}
	});
};

// 查询概览信息
function requestExpData(params) {
	$('#currentPage').val(params.currentPage);
	$('#data-process-img').show();
	isLoading = true;
	$.ajax({
		type : "GET",
		url : ctx + "/search/json/toJsonOverView?timeStamp=" + new Date(),
		data : {
			'nodeId' : params.nodeId,
			'sortMethod' : params.sortMethod,
			'filterChannel' : params.filterChannel,
			'currentPage' : params.currentPage,
			'language' : params.language,
			'industryFlag' : $('#industryFlag').val(),
			'quadraticText' : params.quadraticText
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null && data.data != null) {
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
			}
			isLoading = false;
			$('body').unmask();
		}
	});
}

// 渲染频道
function renderChannel(channels, count) {
	var temText = getCookieCache();
	if (temText == null || temText == "") {
		if (params.filterChannel == null || params.filterChannel == "") {
			temText = '<option value="" selected="selected">全部(' + count
					+ ')</option>';
			$(channels).each(
					function() {
						temText += '<option value="' + this.channelName + '">'
								+ this.sectionName + '(' + this.recordNum
								+ ')</option>';
					});
		} else {
			temText = '<option value="" selected="selected">全部(' + count
					+ ')</option>';
			$(channels).each(
					function() {
						if (params.filterChannel == this.channelName) {
							temText += '<option value="' + this.channelName
									+ '" selected="selected">'
									+ this.sectionName + '(' + this.recordNum
									+ ')</option>';
						} else {
							temText += '<option value="' + this.channelName
									+ '">' + this.sectionName + '('
									+ this.recordNum + ')</option>';
						}
					});
		}
		setCookieCache(temText);
	}
	$('#channels').html(temText);
	refreshChannelede();
}

function refreshChannelede() {
	$('#channels option').each(function() {
		if (this.value == params.filterChannel) {
			$(this).attr({
				'selected' : true
			});
		} else {
			$(this).attr({
				'selected' : false
			});
		}
	});

}

function initRequestData(nodeId, language) {
	$('body').mask('请等待...');
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
	requestExpData(params);
}

function showPatentInfo(data) {
	var text = "请求数据不存在！";
	if (data.message == 'SUCCESS') {
		text = '<table style="width:100%;border-spacing:20px;" class="sorttable">';
		$.each($(data.results),function(index) {
							// 处理分类号
							var ipcStr = ""
							if (this.ipc != null && this.ipc != "") {
								for ( var i = 0; i < this.ipc.length; i++) {
									ipcStr += '<a href="javascript:linkIpc(\''
											+ this.ipc[i] + '\');">'
											+ this.ipc[i] + '</a>';
								}
							}
							// 处理申请人
							var appNameStr = "";
							if (this.applicantName != null
									&& this.applicantName != "") {
								var appNameArray = this.applicantName
										.substring(1,
												this.applicantName.length - 1)
										.split(",");
								for ( var i = 0; i < appNameArray.length; i++) {
									appNameStr += '<a href="javascript:linkAppName(\''
											+ appNameArray[i]
											+ '\');">'
											+ appNameArray[i] + '</a>';
								}
							}

							if (this.patType != "3") {
								text = text
										+ '<tr><td width="80%"><div class="row-fluid" >';
							} else {
								text = text
										+ '<tr><td colspan="2"><div class="row-fluid" >';
							}
							text += '<span class="help-inline"><label class="checkbox" style="width: 100%"><span style="font-weight: bold;">'+((params.currentPage-1)*10+index+1)+'、</span><input type="checkbox" name="recordno" pid="'
									+ this.pid
									+ '" sysid="'
									+ this.sysid
									+ '#'
									+ this.pid
									+ '"  tifvalue="'
									+ this.tifDistributePath
									+ ','
									+ this.pages
									+ ','
									+ this.appNumber
									+ '"  xmlvalue="'
									+ this.pid
									+ ','
									+ this.appNumber
									+ ','
									+ this.pubDate
									+ ','
									+ this.dbName
									+ '"/>'
									+ '<strong class="text-info">';
							if (this.title != null && this.title != "") {
								text += '<a style="cursor: pointer;" onclick="viewDetail(\''
										+ this.pid
										+ '\');" >'
										+ this.title
										+ '('
										+ this.appNumber
										+ ')</a></strong>';
							} else {
								text += '<a style="cursor: pointer;" onclick="viewDetail(\''
										+ this.pid
										+ '\');" >('
										+ this.appNumber + ')</a></strong>';
							}
							if (this.patType == "3") {
								text += '<span class="label label-warning">外观</span>';
							} else if (this.patType == "2"
									|| this.patType == "8") {
								text += '<span class="label label-warning">新型</span>';
							} else if (this.patType == "1"
									|| this.patType == "9") {
								text += '<span class="label label-warning">发明</span>';
							}
							if (this.lprsShow != null && this.lprsShow != "") {
								text += '<span class="label label-success">'
										+ this.statusName + '</span>';
							}
							text += '</label></span></div>'
									+ '<div class="row-fluid"><div class="span13"><div class="row-fluid"><span class="p-inline">公开（公告）号：<a href="javascript:linkPubNum(\''
									+ this.pubNumber
									+ '\');">'
									+ this.pubNumber
									+ '</a></span><span class="p-inline">'
									+ '申请日：<a href="javascript:linkAppDate(\''
									+ this.appDate
									+ '\');">'
									+ this.appDate
									+ '</a></span></div><div class="row-fluid"><span class="p-inline">'
									+ '公开（公告）日：<a href="javascript:linkPubDate(\''
									+ this.pubDate
									+ '\');">'
									+ this.pubDate
									+ '</a></span> <span class="p-inline">分类号：'
									+ ipcStr
									+ '</span></div>'
									+ '<div class="row-fluid"><span class="p-inline" colspan="2"> 申请（专利权）人：'
									+ appNameStr
									+ '</span></div><div class="row-fluid muted" style="padding-right: 15px;">'
									+ '<span class="p-inline">摘要：'
									+ this.abs
									+ '</span></div></div></div>';
							if (this.patType != "3") {
								text += '</div></td><td style="width:19%;"><div style="width:200px;height: 200px;"><img id="pic0" class="zoomin" complete="complete" src="'
										+ this.picUrl
										+ '" '
										+ 'onerror="javascript:this.src=\'http://search.cnipr.com/images/ganlan_pic1.gif\';" '
										+ 'style="max-height: 200px;" name="tifpath"></img></div>';
							} else {
								text += '<ul class="thumbnails">';
								$(this.thumbnailImagePubPathList)
										.each(
												function() {
													text += '<li class="span2" style="margin-left: 0px"><div class="thumbnail" style="width: 100px; height: 100px;">'
															+ '<img src='
															+ this
															+ ' class="zoomin" alt="" style="max-height: 100px;"></div></li>'
												});
								text += '</div></td></ul>';
							}
							text += '</tr>';
						});
	}
	$('#overViewDiv').html(text + '</table>');
	initZoom();
}

/*******************************************************************************
 * START*************************************** 图像方法插件 ，之前写的公用的文件在这里不适用
 */
function initZoom() {
	var htmlStr = '<div id="cnipr-img-lightbox" class="lightbox hide fade"  tabindex="-1" role="dialog" aria-hidden="true">'
			+ '<div class="lightbox-content">' + '<img src="">' +
			// '<div class="lightbox-caption"><p>Your caption here</p></div>'+
			'</div></div>';
	$('body').append(htmlStr);
	$("#overViewDiv").find("img[class*='zoomin']").each(function() {
		$(this).css("cursor", "pointer");
		$(this).click(function() {
			zoominSort(this);
		});
	});
}
function zoominSort(_this, isrc) {
	var srcStr = $(_this).attr('src');
	srcStr = isrc || srcStr;
	if (srcStr.indexOf("WG") > -1)
		srcStr = srcStr.replace("ThumbnailImage", "books");
	$("#cnipr-img-lightbox").find("img").attr("src", srcStr);
	$('#cnipr-img-lightbox').lightbox();
}
// ******************************************END***************************************

/*
 * ***********页面检索字段的链接**********************START*****************************************************
 * 
 * @Param pubNum 公开公告号 @Param pubDate 公开公告日 @Param appDate 申请日 @Param appName
 * 申请（专利权）人 @Param ipc 分类号
 */
function linkPubNum(pubNum) {
	$('#sortOption').val($('#selectoption').val());
	$('#sortSources').val($('#selectdbs').val());
	$('#sortWhere').val('公开（公告）号=（' + pubNum + '）');
	$('#linkOverViewForm').submit();
}

function linkAppDate(appDate) {
	$('#sortOption').val($('#selectoption').val());
	$('#sortSources').val($('#selectdbs').val());
	$('#sortWhere').val('申请日=（' + appDate + '）');
	$('#linkOverViewForm').submit();
}

function linkPubDate(pubDate) {
	$('#sortOption').val($('#selectoption').val());
	$('#sortSources').val($('#selectdbs').val());
	$('#sortWhere').val('公开（公告）日=（' + pubDate + '）');
	$('#linkOverViewForm').submit();
}
function linkAppName(appName) {
	$('#sortOption').val($('#selectoption').val());
	$('#sortSources').val($('#selectdbs').val());
	$('#sortWhere').val('申请（专利权）人=（' + appName + '）');
	$('#linkOverViewForm').submit();
}
function linkIpc(ipc) {
	if (ipc != null && ipc != "") {
		ipc = ipc.replace('/', '\\/').replace('(', "\\(").replace(')', "\\)");
	}
	$('#sortOption').val($('#selectoption').val());
	$('#sortSources').val($('#selectdbs').val());
	$('#sortWhere').val('分类号=（\'' + ipc + '\'）');
	$('#linkOverViewForm').submit();
}
// *************页面检索字段的链接********************END*****************************************************

function viewDetail(pid) {
	$('#pid').val(pid);
	$("#detailForm").submit();
}
function firstPage() {
	params.currentPage = 1;
	$('body').mask('请等待...');
	requestExpData(params);
}
function lastPage() {
	params.currentPage = params.totalPages;
	$('body').mask('请等待...');
	requestExpData(params);
}
function nextPage() {
	if ((params.currentPage + 1) <= params.totalPages) {
		params.currentPage++;
		$('body').mask('请等待...');
		requestExpData(params);

	}
}
function prePage() {
	if (((params.currentPage - 1) <= params.totalPages)
			&& (params.currentPage - 1) > 0) {
		$('body').mask('请等待...');
		params.currentPage--;
		requestExpData(params);
	}
}
function goPage() {
	var inputPage = $('#currentPage').val();
	if (inputPage != null && inputPage != "" && inputPage != params.currentPage) {
		// 判断输入值是否大于最大值
		if (inputPage <= params.totalPages) {
			$('body').mask('请等待...');
			params.currentPage = inputPage;
			requestExpData(params);
		}
	}
}
function channelsChange(selectChannel) {
	$('body').mask("请等待...");
	params.filterChannel = selectChannel;
	$('#overViewDiv').html('');
	requestExpData(params);
}
function sort(sortName) {
	$('body').mask("请等待...");
	params.sortMethod = sortName;
	$('#overViewDiv').html('');
	requestExpData(params);
}

function legalchange(legalchange) {
	$('body').mask("请等待...");
	var newlegalcode = ' AND 专利权状态代码='+legalchange;
	if(legalchange!=null && legalchange!=""){
		//备份当次法律状态变更
		params.statuscode = newlegalcode;
		params.quadraticText = params.cacheQuadraticText+newlegalcode;
	}else{
		params.statuscode = '';
		params.quadraticText = params.cacheQuadraticText;
	}
	$('#overViewDiv').html('');
	requestExpData(params);
}





// 下载js
function downloadZulu() {
	var pids = "";
	$("input[name='recordno']").each(function() {
		if ($(this).attr("checked")) {
			pids += $(this).attr("pid") + ",";
		}
	});
	if (pids != "") {
		pids = pids.substring(0, pids.length - 1);
	} else {
		alert("请选择要下载的记录");
		return;
	}
	downloadZuluRequest(pids);
}
function downloadZuluRequest(pids) {
	downloadpids = pids;
	$('#downloadModal').modal('show');
}
function beginDownload() {
	var checkedItems = "";
	$('#downloadTableInfo input[type="checkbox"]').each(function() {
		if (this.checked) {
			checkedItems += this.value + ",";
		}
	});
	if (checkedItems != "") {
		checkedItems = checkedItems.substring(0, checkedItems.length - 1);
		$('#downloadModal').modal('hide');
		$("body").mask("正在生成下载文件，请稍候...");
		$
				.ajax({
					url : ctx + '/search/json/createZuluxiang',
					type : 'POST',
					data : {
						'pids' : downloadpids,
						'checkedItems' : checkedItems
					},
					success : function(json) {
						$("body").unmask();
						if (json.rCode == '100000') {
							var html = "<div style='line-height:22px;'>资源获取成功，请点击<a href="
									+ ctx
									+ "/download/downloadFile?"
									+ json.data
									+ " target='_blank'>[这里]</a>进行下载 !</div>"
							$.dialog({
								title : '下载',
								max : false,
								lock : true,
								min : false,
								content : html
							});
							return true;

						} else {
							alert(json.rmsg);
						}
					}
				});
	} else {
		$.dialog.alert("请选择要下载的字段名称");
	}
}

// batchZuluxiang
function batchDownload() {
	$('#downloadBatchModal').modal('show');
}

// 这个方法得重新定义
function _download2000() {
	var begin = $("#_begin").val();
	var end = $("#_end").val();

	// var downloadenab=$("#downloadenab").attr("checked");
	var r = /^\+?[0-9][0-9]*$/;
	if (!r.test(begin) || !r.test(end)) {
		alert("输入件数错误，请重新输入！");
		return false;
	} else if (begin <= 0 || end <= 0) {
		alert("请输入大于0的数字！");
		return false;
	} else if ((end - begin) < 0) {
		alert("结束标记应大于开始标记！");
		return false;
	} else {
		var checkedItems = "";
		$("#downloadBatchTableInfo input[name='downloadColumn']").each(
				function() {
					if ($(this).attr("checked")) {
						checkedItems += $(this).val() + ",";
					}
				})
		if (checkedItems != "") {
			checkedItems = checkedItems.substring(0, checkedItems.length - 1);
			params.begin = begin-1;
			params.end = end;
			params.checkedItems = checkedItems;
			if (checkAuth(begin, end)) {
				$('#downloadBatchModal').modal('hide');
			} else {
				return false;
			}
			params.cacheStrWhere = params.strWhere;
			params.strWhere+=params.strWhere+params.statuscode;
			var industryFlag = $('#industryFlag').val();
			params.industryFlag = industryFlag;
			$("body").mask("正在生成下载文件，请稍候...");
			$
					.post(
							ctx + '/search/json/downloadByNodeId',
							params,
							function(json) {
								$("body").unmask();
								if (json.rCode == '100000') {
									var html = "<div style='line-height:22px;'>资源获取成功，请点击<a href="
											+ ctx
											+ "/download/downloadFile?"
											+ json.data
											+ " target='_blank'>[这里]</a>进行下载 !</div>"
									$.dialog({
										title : '下载',
										max : false,
										min : false,
										lock : true,
										content : html
									});
									return true;
								} else {
									alert(json.rmsg);
									return false;
								}
							});
			 params.strWhere=params.cacheStrWhere;
			 params.cacheStrWhere = '';
		} else {
			$.dialog({
				title : '温馨提示',
				content : '请选择下载的字段',
				lock : true,
				icon : 'face-sad.png',
				max : false,
				min : false,
				cancel : true,
				cancelVal : '关闭'
			});
		}
	}
}

function checkAuth(start, end) {
	var dCount = parseInt(end) - parseInt(start);
	var texttip = "您的检索结果为0，请您重新检索后下载。";
	var user_base_auth = $('#user_basic_auth').val();
	if (user_base_auth != null && user_base_auth != "") {
		if (user_base_auth == 'PERMISSIONG') {// guest用户
			texttip = "你所在的权限组最多下载50条。请重新进行筛选";
			if (dCount <= 0) {
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			} else if (dCount > 50) {
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			}
		} else if (user_base_auth == 'PERMISSIONM') { // 管理员
			if (dCount <= 0) {
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			} else if (dCount > 3000) {
				texttip = "你所在的权限组最多下载3000条。请重新进行筛选";
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			}
		} else {
			if (dCount <= 0) {
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			} else if (dCount > 2000) {
				texttip = "你所在的权限组最多下载2000条。请重新进行筛选";
				$.dialog({
					title : '温馨提示',
					content : texttip,
					lock : true,
					icon : 'face-sad.png',
					max : false,
					min : false,
					cancel : true,
					cancelVal : '关闭'
				});
				return false;
			}
		}
	}
	return true;
}

function downloadTIF() {
	var tifInfos = "";
	$("input[name='recordno']").each(function(i) {
		if ($(this).attr("checked")) {
			tifInfos += $(this).attr("tifvalue") + ";";
		}
	});

	if (tifInfos == "") {
		alert("请勾选您需要下载的专利后点击下载。");
		return;
	}
	$("body").mask("正在生成下载文件，请稍候...");
	$.ajax({
		url : ctx + '/search/json/createTIFFZip',
		type : 'POST',
		data : {
			'tifInfos' : tifInfos
		},
		success : function(json) {
			$("body").unmask();
			if (json.rCode == '100000') {
				var html = "<div style='line-height:22px;'>资源获取成功，<a href="
						+ ctx + "/download/downloadFile?" + json.data
						+ " target='_blank'>[这里]</a>进行下载 !</div>";
				$.dialog({
					title : '下载',
					max : false,
					min : false,
					content : html
				});
				return true;
			} else {
				alert(json.rmsg);
			}
		},
		error : function() {
			$("body").unmask();
			alert(json.rmsg);
		}
	});
}
function downloadXML() {
	var patInfos = "";
	$("input[name='recordno']").each(function(i) {
		if ($(this).attr("checked")) {
			patInfos += $(this).attr("xmlvalue") + ";";
		}
	});

	if (patInfos == "") {
		alert("请勾选您需要下载的专利后点击下载。");
		return;
	}
	$("body").mask("正在生成下载文件，请稍候...");
	$.post(ctx + '/search/json/codingDownload', {
		patInfos : patInfos
	}, function(json) {
		$("body").unmask();
		if (json.rCode == '100000') {
			var html = "<div style='line-height:22px;'>资源获取成功，请点击<a href="
					+ ctx + "/download/downloadFile?" + json.data
					+ " target='_blank'>[这里]</a>进行下载 !</div>"
			$.dialog({
				title : '下载',
				max : false,
				min : false,
				lock : true,
				content : html
			});
		} else {
			alert(json.rmsg);
		}
	});
}
function getTopicsRequest() {
	$
			.ajax({
				type : "POST",
				url : ctx + "/auth/json/getTopics",
				dataType : 'json',
				success : function(data) {
					if (data.rCode == "100000") {
						var topicText = '<tr><td>选择</td><td>专题库名称</td><td>专利数</td>';
						if (data.data != null) {
							$(data.data)
									.each(
											function(i) {
												topicText += '<tr><td><input type="radio" name="topicRadio" value="'
														+ this.id
														+ ','
														+ this.aid
														+ '"></td><td>'
														+ this.topicname
														+ '</td><td>'
														+ this.patentcnt
														+ '</td></tr>'
											});
							$('#topicTable').html(topicText);
						}
						$('#collectModal').modal('show');
					} else if (data.rCode == "110000") {
						$('#loginModal').modal('show');
					}
				}
			});
}

//预警
function onListenWarnByNode(){
	if(params.statuscode!=null && params.statuscode!=''){
		$('#wranWhere').html(params.strWhere+params.statuscode);
	}else{
		$('#wranWhere').html(params.strWhere);
	}
	$('#addWarnModal').modal('show');
}

function dbSearchModal() {
	$("#db-search-modal").modal('show');
}
function dbSearchNodeData() {
	var inText = $('#db-mult-text').val();
	if(inText!=null && inText!=""){
		params.strWhere = params.strWhere+inText;
	}
	if(params.quadraticText!=null && params.quadraticText!=""){
		params.quadraticText += inText;
	}else{
		params.quadraticText = inText;
	}
	//二次检索字段备份表达式
	params.cacheQuadraticText +=inText;
	$('#selectexp').val(params.strWhere);
	$("#db-search-modal").modal('hide');
	$('body').mask('加载中...');
	$('#overViewDiv').html('');
	deleteCookieCache();
	requestExpData(params);
}

function insertDBtitle(textTem) {
	var field = document.getElementById("db-mult-text");
	insertAtCursor(field, textTem);
}

function addItems(item) {
	var field = document.getElementById("expCombArea");
	insertAtCursor(field, item);
}
$(".searchColumn").click(function() {
	var col = $(this).attr("column") + "=";
	var field = document.getElementById("expCombArea");
	insertAtCursor(field, col);
});
function insertAtCursor(myField, myValue) {
	// IE support
	if (document.selection) {
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
		sel.select();
		// MOZILLA/NETSCAPE support
	} else if (myField.selectionStart || myField.selectionStart == '0') {
		var startPos = myField.selectionStart;
		var endPos = myField.selectionEnd;
		// save scrollTop before insert
		var restoreTop = myField.scrollTop;
		myField.value = myField.value.substring(0, startPos) + myValue
				+ myField.value.substring(endPos, myField.value.length);
		if (restoreTop > 0) {
			// restore previous scrollTop
			myField.scrollTop = restoreTop;
		}
		myField.focus();
		myField.selectionStart = startPos + myValue.length;
		myField.selectionEnd = startPos + myValue.length;
	} else {
		myField.value += myValue;
		myField.focus();
	}
}

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