var treeObj;
var setting = {
	treeId : "zTreeh",
	edit : {
		enable : true,
		showRenameBtn : false
	},
	view : {
		addHoverDom : addHoverDom,
		selectedMulti : false
	},
	callback : {
		onClick : zTreeOnClick,
		beforeRemove : zTreeBeforeRemove
	}
};
$(function() {
	loadDataFunc("0");
	$("#addNewNodeBtn").click(function() {
		$('#addContent').show();
		$('#editContent').hide();
	});
	$('#editNodeBtn').click(function() {
		$('#editContent').show();
		$('#addContent').hide();
	});
});

var sysGroups;
loadGroupData = function() {
	$.ajax({
		type : "GET",
		url : ctx + '/json/mgrGroup/selectGroups?timeStamp=' + new Date(),
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
				sysGroups = data;
			}
		}
	});
}

function initTree(data) {
	treeObj = $.fn.zTree.init($("#zTreee"), setting, data);
	treeObj.expandAll(true);
	$('body').unmask();
}

loadDataFunc = function(parentId) {
	$('body').mask('正在加载...');
	$.ajax({
		type : "GET",
		url : ctx + '/node/json/getDiyqxNodes?timeStamp=' + new Date(),
		data : {
			'pId' : parentId,
			'id' : ''
		},
		contentType : "application/json;charset=UTF-8",
		success : function(data) {
			if (data != null) {
				initTree(data);
			}
			loadGroupData();
		}
	});
};

/*
 * 鼠标悬浮事件
 */
function addHoverDom(treeId, treeNode) {
	if (treeNode.id == "10000") {
		$('#zTreee_1_remove').hide();
		return;
	}
};

/*******************************************************************************
 * 子节点点击事件
 * 
 * @param event
 * @param treeId
 * @param treeNode
 */
function zTreeOnClick(event, treeId, treeNode) {
	$('#contentDiv').show();
	currentKey = treeNode.id;
	var gloabTitle = treeNode.name;
	var clickKey = treeNode.id;
	currentNode = treeNode;
	currentGroupId = treeNode.groupId;
	if (treeNode.id != "10000") {
		$('#editNodeBtn').show();
		$('#editContent').show();
		$('#addContent').hide();
		$('#newNodeName').val(gloabTitle);
		$('#nodeEditForm #txtCombCn').html(treeNode.cnTrsExp);
		$('#nodeEditForm #txtCombEn').html(treeNode.enTrsExp);
		initCheckBox(treeNode.cnTrsTable, treeNode.enTrsTable);
		refreashGroupByNode(sysGroups, currentGroupId);
	} else {
		$('#editNodeBtn').hide();
		$('#addContent').show();
		$('#editContent').hide();

	}
}

// 初始化节点所属用户
function refreashGroupByNode(data, currId) {
	var tempEditText = '<ol class="inline long">';
	$(data)
			.each(
					function() {
						if (currId.indexOf(this.groupId) >= 0) {
							tempEditText += '<li><label class="checkbox"><input type="checkbox" name="groupId" value="'
									+ this.groupId
									+ '" checked />'
									+ this.groupName + '</label>';
						} else {
							tempEditText += '<li><label class="checkbox"><input type="checkbox" name="groupId" value="'
									+ this.groupId
									+ '" />'
									+ this.groupName
									+ '</label>';
						}
					});
	$('#yonghuzuEdit').html(tempEditText + '</ol>');
}

/**
 * 初始化CHECKBOX
 * 
 * @param cnChannels
 * @param enChannels
 */
function initCheckBox(cnChannels, enChannels) {
	$('#editContent input[name="channelIdEn"]').each(function() {
		var tempVal = $(this).attr('value');
		if (enChannels != null && enChannels != "") {
			if (enChannels.indexOf(tempVal) >= 0) {
				$(this).attr({
					'checked' : true
				});
			}
		}
	});
	$('#editContent input[name="channelIdCn"]').each(function() {
		var tempVal = $(this).attr('value');
		if (cnChannels != null && cnChannels != "") {
			if (cnChannels.indexOf(tempVal) >= 0) {
				$(this).attr({
					'checked' : true
				});
			}
		}
	});
}

/**
 * 新规保存功能
 */
function addNodeInfo() {
	var title = $('#addNodeName').val();
	var channelIdCn = "";
	var channelIdEn = "";
	var cnTextExp = $('#addContent #txtCombCn').val();
	var enTextExp = $('#addContent #txtCombEn').val();
	$('#addContent input[name="channelIdEn"]:checked').each(function() {
		var tempVal = $(this).attr('value');
		channelIdEn += tempVal + ",";
	});
	$('#addContent input[name="channelIdCn"]:checked').each(function() {
		var tempVal = $(this).attr('value');
		channelIdCn += tempVal + ",";
	});

	if (title == null || title == "") {
		alert("请添加节点名称");
		return;
	}
	if (currentKey == null || currentKey == "") {
		alert("请选择添加节点的位置");
		return;
	}
	if ((cnTextExp == null || cnTextExp == "")
			&& (enTextExp == null || enTextExp == "")) {
		alert("中文表达式和英文表达式不能都为空");
		return;
	} else {
		if (cnTextExp != null && cnTextExp != "") {
			if (channelIdCn == null || channelIdCn == "") {
				alert("请选择中文检索库");
				return;
			}
		}

		if (enTextExp != null && enTextExp != "") {
			if (channelIdEn == null || channelIdEn == "") {
				alert("请选择英文检索库");
				return;
			}
		}
	}
	$("body").mask("请等待……");
	var params = $('#nodeInfoForm').serializeForm();
	params.parentId = currentKey;
	$.ajax({
		type : "POST",
		url : ctx + "/node/json/addDiyNodes?timeStamp=" + new Date(),
		data : params,
		success : function(data) {
			$("body").unmask();
			if (data.rCode != "100000") {
				alert(data.rmsg);
			} else {
				addNodeToTree(data.data);
				alert('保存成功');
				$('#nodeInfoForm')[0].reset();
			}
		}
	});
}

/**
 * 
 * @param treeId
 * @param treeNode
 */
function zTreeBeforeRemove(treeId, treeNode) {
	/** 不删除根节点 */
	if (treeNode.id != "10000") {
		if (window.confirm('你确定要删除么？')) {
			$.ajax({
						type : "POST",
						url : ctx + "/node/json/deleteDiyNodes?timeStamp="
								+ new Date(),
						data : {
							'uuid' : treeNode.id
						},
						success : function(data) {
							if (data.rCode != "100000") {
								alert(data.rmsg);
							}
						}
					});
				return true;
			} else {
				return false;
		}
	} else {
		return false;
	}
}

function addNodeToTree(data) {
	var newNode = {
		id : data.uuid,
		pId : data.parentId,
		name : data.title,
		isIsParent : false,
		cnTrsTable : data.cnTrsTable,
		cnTrsExp : data.cnTrsExp,
		enTrsTable : data.enTrsTable,
		enTrsExp : data.enTrsExp
	};
	newNodes = treeObj.addNodes(currentNode, newNode);
}

/**
 * 编辑保存功能
 */
function saveNodeInfo() {
	$("body").mask("请等待……");
	var params = $('#nodeEditForm').serializeForm();
	params.currentKey = currentKey;
	$.ajax({
		type : "POST",
		url : ctx + "/node/json/updateDiyNodes?timeStamp=" + new Date(),
		data : params,
		success : function(data) {
			//			    $("body").unmask();
			loadDataFunc("0");
			alert(data.rmsg);
		}
	});
}
