var expObj = {};

function checkSearchField(){
	//alert("checkSearchField");
		var channelIds = "";
		
		var channelArray = $('input[name="strdb"]:checked').each(function(){
			var attrValue = $(this).val();
			if(attrValue!=null && attrValue!=""){
				channelIds += attrValue+",";
			}
		});
	//alert(channelIds);
		
		if(channelIds == null || channelIds == ""){
			alert("请选择专利频道");
			return;
		}
		
		channelIds = channelIds.substring(0,channelIds.length-1);
		var expAreaText = $('#txtComb').val();
		if(expAreaText == null || expAreaText == ""){
			alert("表达式不能为空");
			return;
		}
	//alert(expAreaText);

		//判断是否保存表达式
		var saveExpcheck = "";
		if($('#savesearchword').attr("checked")){
			saveExpcheck = "ON";
		}else{
			saveExpcheck = "0";
		}
	//alert("6666");
	/*
		$('body').overView({
			strSources:channelIds,
			strWhere:expAreaText,
			saveExpcheck:saveExpcheck,
			//overViewUrl:ctx+'/search/doOverviewSearch'
			overViewUrl:ctx+'/doOverviewSearch.do'
		});
	*/
		document.searchForm.strSources.value=channelIds;
		document.searchForm.strWhere.value=expAreaText;
		document.searchForm.savesearchword.value=saveExpcheck;
		document.searchForm.submit();
		
		//$("#searchForm").submit();

	}

/**
 * 用户表达是刷新,采用默认值
 **/
function freashUserExp(){
	$.httpProxy.request({
		requestType:'POST',
		requestUrl:ctx + "/search/json/getUserHistoryExp",
		responseCallback:drawingHistoryExp
	});
}

/**
 * 用户表达是刷新,自定义的值
 **/
function freashUserExpByParam(param){
	$.httpProxy.request({
		requestType:'POST',
		requestUrl:ctx + "/search/json/getUserHistoryExp",
		requestData:param,
		responseCallback:drawingHistoryExp
	});
	$('#expData').unmask();
}

/**
 * 渲染页面历史表达式组件
 * @param data  用户历史表达式数据
 */
function drawingHistoryExp(data) {
	if (data.rCode == "100000") {
		var tempText = "";
		$(data.data.result)
				.each(
						function(i) {
							var titleTemp = this.title;
							var tempkey = this.uuid+'strWhere';
							tempText += '<tr><td><input type="checkbox" name="expKey" value="'
									+ this.uuid + '" /><input type="hidden" value="'+this.trsExp+'"  id="'+tempkey+'" /></td>';
							if (titleTemp.length > 30) {
								titleTemp = titleTemp.substring(0, 30) + "...";
							}
							var channelNameTemp = this.channelName;
							if (channelNameTemp.length > 20) {
								channelNameTemp = channelNameTemp.substring(0, 20) + "...";
							}
							tempText += '<td><a href="javascript:showTitleExp(\''+this.uuid+'\');">'
									+ titleTemp
									+ '</a></td><td><a href="javascript:showExpChannel(\''+this.channelName+'\');">'
									+ channelNameTemp
									+ '</a></td><td>'
									+ this.hitCount
									+ '</td><td>'
									+ this.createDate
									+ '</td><td align="center" >&nbsp;&nbsp;<a href="javascript:editExp(\''+this.uuid+'\',\''+this.channelId+'\');">编辑</a>&nbsp;&nbsp;'
									+'<a href="javascript:searchPatents(\''+this.uuid+'\',\''+this.channelId+'\');">检索</a></td></tr>';
						});
		$('#expData').html(tempText);
	}
	$('#maxPage').val(data.data.pageTotal);
	$('#currentModel').html('第<input type="text" value="'+data.data.pageNo+'" id="pageInput" style="width:50px;margin-bottom:0px;"/>/共'+data.data.pageTotal+'页');
	$('#pageInput').bind('keydown', function(event) {
		var event = arguments.callee.caller.arguments[0] || window.event;//消除浏览器差异  
		if (event.keyCode == 13) {
			var param = {};
			var pageInput = parseInt($('#pageInput').val());
			var maxPage = parseInt($('#maxPage').val());
			if(pageInput <= 0){
				param.currentPage = 1;
			}else if(pageInput >= maxPage){
				param.currentPage = maxPage;
			}else{
				param.currentPage = pageInput;
			}
			freashUserExpByParam(param);
		}
	});
}


/**
 * 用户表达式删除Model
 */
function deleteExpModel(expKey,expText){
	$('#deleteExpModel').modal('show');
	$('#deleteNameId').html(expText);
	expObj.expKey = expKey;

}

/**
 * 用户表达式批量删除
 */
function deleteExpBatch(){
	var expKeys = "";
	$('input[name="expKey"]:checked').each(function(){
		expKeys +=this.value+","
	});
	if(expKeys !=null &&expKeys!=""){
			deleteExpModel(expKeys.substring(0,expKeys.length-1),"批量删除操作");
	}else{
		alert("请选择需要删除的数据");
	}
}

/**
 * 用户表达式删除请求
 */
function deleteExpRequest(){
	$('#expData').mask('正在删除');
	$.httpProxy.request({
		requestType:'POST',
		requestUrl:ctx + "/search/json/auth/deleteUserExp",
		requestData : {'expKey':expObj.expKey},
		responseCallback:deleteCallBack
	});
	
}

function deleteCallBack(){
	$('#deleteExpModel').modal('hide');
	expObj = {};
	var param = {};
	param.currentPage = parseInt($('#pageInput').val());
	freashUserExpByParam(param);
}

/**
 * 用户表达式编辑
 * @param expKey
 * @param expText
 */
function editExp(expKey,expChannels){
	expObj = {};
	$("input[name='channelId']").attr("checked", false);
	var channelArray = expChannels.split(',');
	for(var i = 0;i<channelArray.length;i++){
		$('input[value="'+channelArray[i]+'"]').attr('checked',true);
	}
	if(channelArray.length == 26){
		$('#selectAll').attr("checked", true);
	}else{
		$('#selectAll').attr("checked", false);
	}
	var expText = $('#'+expKey+"strWhere").val();
	$('#txtComb').val(expText);
	$('#saveDiv').hide();
	$('#updateDiv').show();
	$('#expLists').slideUp('normal');
	expObj.expKey = expKey;
}
function cancelUpdate(){
	$('#updateDiv').hide();
	$('#saveDiv').show();
	$('#expLists').slideDown('normal');
}

function updateExp(){
	var channelIds = "";
	var channelArray = $('input[name="channelId"]:checked').each(function(){
		var attrValue = $(this).val();
		if(attrValue!=null && attrValue!=""){
			channelIds += attrValue+",";
		}
	});
	if(channelIds == null || channelIds == ""){
		alert("请选择专利频道");
		return;
	}
	channelIds = channelIds.substring(0,channelIds.length-1);
	var expAreaText = $('#txtComb').val();
	if(expAreaText == null || expAreaText == ""){
		alert("表达式不能为空");
		return;
	}
	$.httpProxy.request({
		requestType:'POST',
		requestUrl:ctx + "/search/json/auth/updateUserExp",
		requestData : {'channelIds':channelIds,'expAreaText':expAreaText,'expKey':expObj.expKey},
		responseCallback : updateUserExpCallback
	});
}

function updateUserExpCallback(data){
	if(data.rCode == "100000"){
		freashUserExp();
	}else{
		alert(data.rmsg);
	}
	$('#updateDiv').hide();
	$('#saveDiv').show();
	$('#expLists').slideDown('normal');
}
/**
 * 用户表达式查看
 * @param text
 */
function showTitleExp(uuidkey){
	$('#showModelTitle').html('表达式名称');
	$('#showModelBody').html($('#'+uuidkey+'strWhere').val());
	$('#showExpModel').modal('show');
}

/**
 * 用户表达式频道查看
 * @param text
 */
function showExpChannel(text){
	$('#showModelTitle').html('检索数据库');
	$('#showModelBody').html(text);
	$('#showExpModel').modal('show');
}
/**
 * 页面清除
 */
function clearPageData(){
	$('#txtComb').val('');
}

/**
 * 表达式检索
 */
function searchPatents(expKey,expChannels){
	var expText = $('#'+expKey+"strWhere").val();
	$('body').overView({
		strSources:expChannels,
		strWhere:expText,
		overViewUrl:ctx+'/search/doOverviewSearch'
	});
}

/**
 * 检索字段检查
 */


/**
 * 表达式导出
 */
function expExport(){
	var expKeys = "";
	$('input[name="expKey"]:checked').each(function(){
		expKeys +=this.value+","
	});
	if(expKeys !=null &&expKeys!=""){
		$("body").mask('正在导出');
		$.ajax({
			url : ctx + '/search/json/auth/exportUserExp',
			type : 'POST',
			data : {
				'expKeys' : expKeys.substring(0,expKeys.length-1)
			},
			success : function(json) {
				$("body").unmask();
				if (json.rCode == '100000') {
					var html = "<div style='line-height:22px;'>资源获取成功，<a href="
							+ ctx + "/download/downloadFile?" + json.data
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
			},
			error : function() {
				$("body").unmask();
				alert(json.rmsg);
			}
		});
	}else{
		alert("请选择导出的表达式");
	}
}

/**
 * 表达式合并
 * @param flag
 */
function combinExp(flag){
	var expKeys = "";
	var count = 0;
	$('input[name="expKey"]:checked').each(function(){
		expKeys +=this.value+",";
		count += 1;
	});
	if(expKeys !=null && expKeys !=""){
		if(count < 2){
			alert("请选择至少两个表达式进行合并操作");
			return;
		}
		$("#expData").mask("正在合并...");
		expKeys = expKeys.substring(0,expKeys.length-1);
		$.httpProxy.request({
			requestType:'POST',
			requestUrl:ctx + "/search/json/auth/combinUserExp",
			requestData:{'expKeys':expKeys,'flag':flag},
			responseCallback:combinCallback
		});
	}else{
		alert("请选择要合并的表达式");
	}
}

function combinCallback(data){
	$("#expData").unmask();
	if(data.rCode == "100000"){
		freashUserExp();
	}else{
		alert("您选择的合并表达式未能检索出数据，合并失败！请从新选择");
	}
}

/**
*	保存用户表达式
*   @param channelIds  表达式关联频道
*   @param expAreaText 表达式
**/
function addUserExp(expAreaText){
	var channelIds = "";
	var channelArray = $('input[name="channelId"]:checked').each(function(){
		var attrValue = $(this).val();
		if(attrValue!=null && attrValue!=""){
			channelIds += attrValue+",";
		}
	});
	if(channelIds == null || channelIds == ""){
		alert("请选择专利频道");
		return;
	}
	channelIds = channelIds.substring(0,channelIds.length-1);
	$.httpProxy.request({
		requestType:'POST',
		requestUrl:ctx + "/search/json/auth/addUserExp",
		requestData : {'channelIds':channelIds,'expAreaText':expAreaText},
		responseCallback : addUserExpCallback
	});
}
/*
 * 生成表达式回调函数
 */
function addUserExpCallback(data){
	if(data.rCode == "100000"){
		freashUserExp();
	}else{
		alert(data.rmsg);
	}
}
