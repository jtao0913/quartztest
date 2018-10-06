/************START*****************
 * 概览页面信息链接
 * 公开（公告）号：pubNum
 * 申请日：appDate
 * 公开（公告）日：pubDate
 * 主分类号：ipc
 * 申请（专利权）人：appName
 * **********START****************/

function requestExpData(strWhere) {
	var strChannels = $('#searchForm #strChannels').val();
//	alert(strSources);	
	$("#searchForm").attr("action", "overviewSearch.do?strWhere="+strWhere+"&strChannels="+strChannels+"&area="+$("#searchForm #area").val());		
	$("#searchForm").attr("target", "_blank");
//	$('#searchForm #simpleSearch').val("1");	
	$('#searchForm').submit();
}

function findIpc(ipc) {	
	if (ipc != null && ipc != "") {
//alert(ipc);		
		var strWhere = "";
//		if (ipc != null && ipc != "") {
//			ipc = ipc.replace('/', '\\/').replace('(', "\\(").replace(')', "\\)");
//		}
		strWhere = "分类号=('" + ipc + "')";
//alert(strWhere);
		
		strWhere = encodeURI(strWhere);	
//alert(strWhere);

		requestExpData(strWhere);
	}
}
function treefindIpc(ipc) {
//	alert(ipc);
	
	if (ipc != null && ipc != "") {
		var strWhere = "";
		strWhere = "分类号=('" + ipc + "')";
//		strWhere = encodeURI(strWhere);	
		$('#searchForm #strWhere').val(strWhere);
		
	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.selectdbs);
	    $('#searchForm #strChannels').val(params.selectdbs);	
	    
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
	}
}
function findPubNum(pubNum) {
	if (pubNum != null && pubNum != "") {
		var strWhere = "";
		strWhere = "公开（公告）号=(\'" + pubNum + "\')";
		strWhere = encodeURI(strWhere);
		requestExpData(strWhere);
	}
}

function treefindPubNum(pubNum) {
	if (pubNum != null && pubNum != "") {
		var strWhere = "";
		strWhere = "公开（公告）号=(\'" + pubNum + "\')";
		$('#searchForm #strWhere').val(strWhere);
		
	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.selectdbs);
	    $('#searchForm #strChannels').val(params.selectdbs);	
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
	}
}
function findPubDate(pubDate) {
	if (pubDate != null && pubDate != "") {
		var strWhere = "";
		strWhere = "公开（公告）日=(" + pubDate + ")";
		strWhere = encodeURI(strWhere);	

		requestExpData(strWhere);
	}
}
function treefindPubDate(pubDate) {
//	alert(ipc);
	
	if (pubDate != null && pubDate != "") {
		var strWhere = "";
		strWhere = "公开（公告）日=(" + pubDate + ")";
//		strWhere = encodeURI(strWhere);	
		$('#searchForm #strWhere').val(strWhere);

	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.selectdbs);
	    $('#searchForm #strChannels').val(params.selectdbs);
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
	}
}
function findAppDate(appDate) {
	if (appDate != null && appDate != "") {
		var strWhere = "";
		strWhere = "申请日=(" + appDate + ")";
		strWhere = encodeURI(strWhere);	

		requestExpData(strWhere);
	}
}
function treefindAppDate(appDate) {
//alert(appDate);
	
	if (appDate != null && appDate != "") {
		var strWhere = "";
		strWhere = "申请日=(" + appDate + ")";
//		strWhere = encodeURI(strWhere);	
		$('#searchForm #strWhere').val(strWhere);		
	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.selectdbs);
	    $('#searchForm #strChannels').val(params.selectdbs);		
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
	}
}

function findAppName(appName) {
	if (appName != null && appName != "") {
		var strWhere = "";
		if (appName.indexOf(']') > 0 || appName.indexOf('[')>=0) {
			strWhere = "申请（专利权）人=('"
					+ appName.replace("[", "").replace("]", "") + "')"
		} else {
			strWhere = "申请（专利权）人=('" + appName + "')";
		}
		
//		alert(strWhere);
		strWhere = encodeURI(strWhere);
//		alert(strWhere);
		
		requestExpData(strWhere);
	}
}


/*****************************概览页面信息链接****************END***********************************/