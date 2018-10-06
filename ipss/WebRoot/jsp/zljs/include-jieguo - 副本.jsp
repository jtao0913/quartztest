<%@ page language="java" pageEncoding="UTF-8"%>

<form id="showDetail" name="showDetail"
			action="<%=basePath%>detailSearch.do?method=detailSearch" method="post"
			target="_blank">
			<input type="hidden" name="strWhere">
			<input type="hidden" name="strSources" id="strSources">
			<input type="hidden" name="strChannels">
			<input type="hidden" name="strSortMethod">
			<input type="hidden" name="strDefautCols">
			<input type="hidden" name="strStat">
			<input type="hidden" name="iOption">
			<input type="hidden" name="iHitPointType">
			<input type="hidden" name="bContinue">
			<input type="hidden" name="index">
			<input type="hidden" name="filterChannel">
			<input type="hidden" name="area">
			
			<input type="hidden" id="treeType" name="treeType" value="<%=treeType%>">
			<input type="hidden" id="nodeId" name="nodeId">
			<input type="hidden" id="selectexp" name="selectexp">
			<input type="hidden" id="secondsearchexp" name="secondsearchexp">
			<input type="hidden" id="selectdbs" name="selectdbs">
			<input type="hidden" id="language" name="language">			
</form>

<form name="download" action="" method="post" target="_self">
			<input type="hidden" id="ABSTBatchCount" name="ABSTBatchCount" value="<%=ABSTBatchCount%>">
			<input type="hidden" name="patentList">
			<input type="hidden" name="downloadcol">
			<input type="hidden" name="downtype">
			<input type="hidden" name="isbatchdownload">
			<input type="hidden" name="downloadStart">
			<input type="hidden" name="downloadAmount">			
			
			<input type="hidden" name="area" id="area">
			<input type="hidden" name="strChannel" id="strChannel">
			<input type="hidden" name="searchKind" value="${requestScope.searchKind}">
			<input type="hidden" name="strChannels" id="strChannels" value="${requestScope.strChannels }">
			<input type="hidden" name="strSynonymous" value="${requestScope.strSynonymous }">
			<input type="hidden" name="strWhere" id="strWhere" value="${requestScope.strWhere }">
			<input type="hidden" name="strSources" id="strSources" value="${requestScope.strSources }">
			<input type="hidden" name="strSortMethod" value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols" value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType" id="iHitPointType" value="${requestScope.iHitPointType}">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" name="pageIndex">
			<input type="hidden" name="secondOrFilter">
			<input type="hidden" name="trsLastWhere" id="trsLastWhere" value="${requestScope.trsLastWhere}">
			<input type="hidden" id="filterChannel" name="filterChannel" value="${requestScope.filterChannel }">						
		</form>
		
		<form id="searchForm" name="searchForm" action="<%=basePath%>overviewSearch.do" method="post" target="_self">
			<input type="hidden" name="area" id="area">
			<input type="hidden" name="strChannel" id="strChannel">
			<input type="hidden" name="searchKind" id="searchKind" value="${requestScope.searchKind }">
			<input type="hidden" name="strChannels" id="strChannels" value="${requestScope.strChannels }">
			<input type="hidden" name="strSynonymous" value="${requestScope.strSynonymous }">
			<input type="hidden" name="strWhere" id="strWhere" value="${requestScope.strWhere }">
			<input type="hidden" name="strSources" id="strSources" value="${requestScope.strSources }">
			<input type="hidden" name="strSortMethod" value="${requestScope.strSortMethod }">
			<input type="hidden" name="strDefautCols" value="${requestScope.strDefautCols }">
			<input type="hidden" name="strStat" value="${requestScope.strStat }">
			<input type="hidden" name="iOption" value="${requestScope.iOption }">
			<input type="hidden" name="iHitPointType" id="iHitPointType" value="${requestScope.iHitPointType }">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" name="pageIndex">
			<input type="hidden" name="secondOrFilter">
			<input type="hidden" name="trsLastWhere" id="trsLastWhere" value="${requestScope.trsLastWhere }">
			<input type="hidden" id="filterChannel" name="filterChannel" value="${requestScope.filterChannel }">
		</form>


<div id="contentDiv" style="float: right; width: 74%; ">

<div id="mapDiv">
<%
//out.println("treeType="+treeType);
if(treeType==5){
%>
<%@ include file="../../map/ningbo.jsp"%>
<%}%>
</div>

<div id="top-navbar" name="top-navbar" style="display: none;" class="navbar navbar-inverse">

<strong>
					<div class="navbar-inner" style="background-image: none;background-repeat:no-repeat;filter: none;background-color: #ffffff;border: 0px;border-bottom:0px solid #5cc0cd;">
						<div class="container">
							<div class="nav-collapse collapse">
								<ul class="nav">
											<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;color:#666;font-size:13px; ">下载 <b class="w_caret"></b> </a>
												<ul id="downloadmenu" class="dropdown-menu" >
													<li><a href="javascript:Download();">著录项下载</a></li>
													<li><a data-toggle="modal" data-target="#downloadBatchModal">著录项批量下载</a></li>
												</ul>
											</li>											


											
											<% if(SetupAccess.getProperty(SetupConstant.FENXI)!=null && SetupAccess.getProperty(SetupConstant.FENXI).equals("1")){%>
													    <% 
													    //if(strItemGrant.contains(SetupConstant.FENXI))
													    {%>
											<li>
											<a href="#" style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" id="bt_analyse">统计分析</a>
											</li>
														<%} %>
											<%} %>
											<% if(SetupAccess.getProperty(SetupConstant.DINGQIYUJING)!=null && SetupAccess.getProperty(SetupConstant.DINGQIYUJING).equals("1")){%>
												 	 <% 
												 	 //if(strItemGrant.contains(SetupConstant.DINGQIYUJING))
												 	 {
												 	 %>
											<li><a href="#" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" onClick="javascript:warning();"><font style="color:#666;font-size:13px;">专利预警</font></a></li>
													<%} %>
											<%}%>
											
											<%if((","+(String)session.getAttribute("userMenu")).indexOf(",3500,")>-1){%>
											<li><a href="#" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;"  id="piaslink" onClick="javascript:preSaveFavorite();"><font style="color:#666;font-size:13px;">加入收藏</font></a></li>
											<%}%>
											
									<li class="active" style="padding-top:10px; color: #ffffff; font-weight: 600; padding-left: 10px;">
										<label class="checkbox" style="width:30px"><input id="chkall" type="checkbox" value="" onClick="selectAllCheckSort(this.checked)"><font style="color:#666;font-size:13px;">全选</font></label>
									</li>
									
									<li><a href="javascript:dbSearchModal()" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="piaslink"><font style="color:#666;font-size:13px;">二次检索</font></a></li>
									
									<li>
										<select class="input-medium" style="width:150px;" id="sectionInfos" onChange="channelsChange(this.value);"></select>
									</li>
								</ul>




		<input type="hidden" name="translate" id="translate" value="<%=translate%>">
		<input type="hidden" name="type" id="type" value="<%=type%>">
		<input type="hidden" name="hangye" id="hangye" value="<%=hangye%>">
		
		<input type="hidden" name="jumpNavID" id="jumpNavID" value="<%=jumpNavID%>">
		
		<input type="hidden" name="nodeId" id="nodeId">
		<input type="hidden" name="shixiao" id="shixiao" value="<%=shixiao%>">
		
		<input type="hidden" name="RecordCount" id="RecordCount">
		<input type="hidden" name="selectexp" id="selectexp">
		<input type="hidden" name="selectdbs" id="selectdbs">
		<input type="hidden" name="SecurityCode" id="SecurityCode">
		<input type="hidden" name="URLEncoderWhere" id="URLEncoderWhere">
		<input type="hidden" name="area" id="area">
		
		<input type="hidden" name="unfilterTotalCount" id="unfilterTotalCount">
		
		
								<ul class="nav pull-right" id="pageinfo">
									<li></li>
									<!-- 
									<s:select name="selpagerecord" list="#{'10':'10','30':'30','50':'50'}" value="#request.pagerecord" onchange="changepagerecord()" theme="simple" cssStyle="width: 50px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;"></s:select>
									</li>
									<li>
											<select class="input-medium" onChange="#" style="width: 112px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;">
												<option value="-公开（公告）日" >按公开日降序</option>
												<option value="RELEVANCE" selected="selected">按相似度排序</option>
												<option value="+公开（公告）日" >按公开日升序</option>
												<option value="-申请日" >按申请日降序</option>
												<option value="+申请日" >按申请日升序</option>
											</select>		
									</li>
									-->									
								</ul>
							</div>
						</div>
					</div>
					</strong>
			</div>
			
			<div id="overViewDiv" class="span13" style="margin-top: 20px; float: left; display: none;"></div>

		</div>

<script type="text/javascript">
function getDetail(index){
	//alert("index="+index);

	//alert($('#selectexp').val());
	//alert("area="+$('#area').val());
	//alert("selectexp="+$('#selectexp').val());
	//alert("selectdbs="+$('#selectdbs').val());			
		
	//$('#selectdbs').val(treeNode.cnTrsTable);
	//$('#selectexp').val(treeNode.cnTrsExp);
	//var area = $('#area').val();
	//alert(document.searchForm.strWhere.value);
	/*
	document.showDetail.area.value = $('#area').val();
	document.showDetail.strWhere.value = $('#selectexp').val();
	document.showDetail.strSources.value = $('#selectdbs').val();
	document.showDetail.index.value = index;
	//document.showDetail.submit();
	*/

    document.showDetail.area.value = params.language;
    document.showDetail.strWhere.value = "id="+index;//escape(params.selectexp);
		      
//		    if(params.filterChannel!=""){
    if(params.filterChannel!=""&&params.filterChannel!="null"&&params.filterChannel!="NULL"&&params.filterChannel!=undefined&&params.filterChannel!="undefined"){
	   	document.showDetail.strSources.value = params.filterChannel;
    }else{
  		document.showDetail.strSources.value = params.selectdbs;
  	}
    document.showDetail.index.value = index;
		      
    document.showDetail.nodeId.value = params.nodeId;
    document.showDetail.selectexp.value = params.selectexp;
    document.showDetail.secondsearchexp.value = encodeURIComponent(params.secondsearchexp);
    document.showDetail.selectdbs.value = params.selectdbs;
    document.showDetail.filterChannel.value = params.filterChannel;
    document.showDetail.language.value = params.language;
		      
//alert("dbs="+params.selectdbs);      
    document.showDetail.submit();
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

function channelsChange(selectChannel) {
	var selectChannelCount = $("#sectionInfos").find("option:selected").attr("alt");
	
	if(selectChannelCount!="0"){
//	alert(params.nodeId);
		$('body').mask("请等待...");
		params.currentPage = "1";
		params.filterChannel = selectChannel;
//		$('#selectdbs').val(selectChannel);
//		$('#currentfilterChannel').val(selectChannel);		
		
		$('#overViewDiv').html('');
		requestExpData(params);
	//	alert("1111");
		$('#pageEnterBtn').val('1');
	//	alert("2222");
	}
}

function treefindAppName(appName) {
//alert(appName);
	
	if (appName != null && appName != "") {
		var strWhere = "";

		if (appName.indexOf(']') > 0 || appName.indexOf('[')>=0) {
			strWhere = "申请（专利权）人=('" + appName.replace("[", "").replace("]", "") + "')"
		} else {
			strWhere = "申请（专利权）人=('" + appName + "')";
		}
		
		$('#searchForm #strWhere').val(strWhere);
		
	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.selectdbs);
	    $('#searchForm #strChannels').val(params.selectdbs);
		$('#searchForm #simpleSearch').val("1");
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
	}
}

//查询概览信息
function requestExpData(params) {
//alert($('#area').val());
//alert($('#selectexp').val());			      
//alert($('#selectdbs').val());

//alert(params.language);
//alert(params.xAxis);
//alert(params.selectexp);
	
//$('#currentPage').val(params.currentPage);
	$('#data-process-img').show();
	isLoading = true;
	
$('body').mask('正在检索');
//alert('<%=treeType%>');
//alert(params.selectexp);
//alert("selectdbs="+params.selectdbs);
//alert(params.filterChannel);
//alert(params.currentPage);
//alert(params.language);
	var searchType = $('#searchType').val();	
	
	$.ajax({
		type : "GET",
		url : "toJsonOverView.do?timeStamp=" + new Date(),
		//url : "/toJsonOverView.do",
		data : {			
			'searchType' : searchType,
			'treeType' : '<%=treeType%>',
			'xAxis' : params.xAxis,
			'nodeId' : params.nodeId,
			'selectexp' : params.selectexp,
			'secondsearchexp' : encodeURIComponent(params.secondsearchexp),			
			'selectdbs' : params.selectdbs,
			'filterChannel' : params.filterChannel,
			'currentPage' : params.currentPage,
			'language' : params.language
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			if (jsonresult != null&&jsonresult != "") {
				//processJsonresult(jsonresult,1);				
				if(searchType===1){
					processJsonresult(jsonresult,2);
				}else{
//					alert(0);
					processJsonresult(jsonresult,0);//第二次参数为0代表overview，为1代表tree
				}			
			}else{
				$('#top-navbar').hide();
				$('#overViewDiv').hide();
				showexp("此次检索无结果，请检查检索表达式");
			}
			
			
			/*
			if(searchType==0||searchType==1){
				if(params.xAxis==='PATTYPE'&&map_data_single!=null){
					showOverviewPattypeSection(map_data_single);
				}else{
					
					if(overview_tree===2){
						$('#collapse_1').html("");
						if($('#collapse1').hasClass('in')){
							$('#collapse1').collapse('hide');
						}
					}					
				}
			}
			*/
			isLoading = false;
			$('body').unmask();
		}
	});
}

function processJsonresult(jsonresult, overview_tree){
	//alert("processJsonresult="+divno);
	//jsonresult = eval("("+jsonresult+")");
	//alert(jsonresult.overviewResponse);
		var jsonarray= $.parseJSON(jsonresult);
	//alert(jsonarray);

		var patentInfoList;
		var RecordCount;
		var lastestFlztInfo;
		var channelInfo;
		var strWhere;
		var sectionInfos;
		var unfilterTotalCount;
		var SecurityCode;
		var URLEncoderWhere;
		/*
		var map_applicant;
		var map_inventor;
		var map_ipc;
		var map_flzt;
		var map_pdyear;	
	*/
		var map_data_single;
	//alert(params.xAxis);
		$.each(jsonarray, function (n, result)
		{
	//alert(result.overviewResponse.sectionInfos);
			patentInfoList = result.overviewResponse.patentInfoList;
			
			map_data_single = result.overviewResponse.map_data_single;
			
			sectionInfos = result.overviewResponse.sectionInfos;
			/*
			for(key in map_data_single){
				alert(key+"="+map_data_single[key]);
			}
			*/
			//sectionInfos = result.overviewResponse.sectionInfos;
			/*
			map_pattype = result.overviewResponse.map_pattypesectionInfo;
			map_applicant = result.overviewResponse.map_applicantsectionInfo;
			map_inventor = result.overviewResponse.map_inventorsectionInfo;
			map_ipc = result.overviewResponse.map_ipcsectionInfo;
			map_flzt = result.overviewResponse.map_flztsectionInfo;
			map_pdyear = result.overviewResponse.map_pdyearsectionInfo;
			*/
					
			unfilterTotalCount = result.overviewResponse.unfilterTotalCount;
			RecordCount = result.RecordCount;
//			lastestFlztInfo = result.lastestFlztInfo;
			channelInfo = result.channelInfo;
			strWhere = result.strWhere;
			
			URLEncoderWhere = result.URLEncoderWhere;
			SecurityCode = result.SecurityCode;
			
			$('#unfilterTotalCount').val(unfilterTotalCount);
			$('#RecordCount').val(RecordCount);
			$('#SecurityCode').val(SecurityCode);
			$('#URLEncoderWhere').val(URLEncoderWhere);
			
//			alert(unfilterTotalCount);
//			alert(sectionInfos);
//			alert(strWhere);
			
	/*	
			$.each(patentInfoList, function (n1, patentInfo)
			{
				alert(patentInfo.ab);
				alert(patentInfo.abPicPath);
			})
	*/
		})

		$('#chkall').attr("checked", false);

						if(RecordCount>0){

//alert("overview_tree="+overview_tree);
							if(overview_tree===1){
								showSection(sectionInfos,channelInfo,unfilterTotalCount,RecordCount);
							}else if(overview_tree===0||overview_tree===2){
								/*
								if((typeof sectionInfos)!="undefined"&&(sectionInfos!='')){
									showOverviewSection(sectionInfos,channelInfo,unfilterTotalCount,RecordCount);
								}
								*/
								if(params.xAxis==='PATTYPE'&&map_data_single!=null){
									showOverviewPattypeSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_1').html("");
										if($('#collapse1').hasClass('in')){
											$('#collapse1').collapse('hide');
										}
									}
								}
								
								//alert("map_flzt="+map_flzt);
								if(params.xAxis==='最新法律状态'&&map_data_single!=null){
									//alert("最新法律状态="+map_data_single);
								
									showOverviewFlztSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_2').html("");
										if($('#collapse2').hasClass('in')){
											$('#collapse2').collapse('hide');
										}
									}														
								}
								
								if(params.xAxis==='公开年'&&map_data_single!=null){
									showOverviewPDyearSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_3').html("");
										if($('#collapse3').hasClass('in')){
											$('#collapse3').collapse('hide');
										}									
									}
								}
								
								if(params.xAxis==='申请人'&&map_data_single!=null){
									showOverviewApplicantSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_4').html("");
										if($('#collapse4').hasClass('in')){
											$('#collapse4').collapse('hide');
										}
									}
								}
								
								if(params.xAxis==='发明人'&&map_data_single!=null){
									showOverviewInventorSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_5').html("");
										if($('#collapse5').hasClass('in')){
											//$('#collapse5').removeClass('in');
											$('#collapse5').collapse('hide');
										}
									}
								}
								
								if(params.xAxis==='IPC小类'&&map_data_single!=null){
									showOverviewIPCSection(map_data_single);
								}else{
									if(overview_tree===2){
										$('#collapse_6').html("");
										if($('#collapse6').hasClass('in')){
											//$('#collapse6').removeClass('in');
											$('#collapse6').collapse('hide');
										}
									}
								}
							}
							
							$('#overViewDiv').show();
							
//							alert("params.currentPage="+params.currentPage);
//							alert("RecordCount="+RecordCount);
							
//							alert(patentInfoList!='');
							if(patentInfoList!=''){
								fenye(params.currentPage,RecordCount);
								showPatentInfo(patentInfoList, channelInfo);
							}

						}else{
							$('#top-navbar').hide();
							$('#overViewDiv').hide();
							showexp("此次检索无结果");
						}
}

function showOverviewPattypeSection(map){
//	alert($("#collapseTwo").css('display'));
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
			content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}
//	alert(content);
	$('#collapse_1').html(content);
//	$("#collapseTwo").css('display','block');
}

function showOverviewFlztSection(map){
//	alert($("#collapseTwo").css('display'));
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
			content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}
//	alert(content);
	$('#collapse_2').html(content);
//	$("#collapseTwo").css('display','block');
}
function showOverviewPDyearSection(map){
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
				content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}
	/*
	content += 
	'<div style="font-size:12px; padding-left: 18px; color: #666; padding-top: 4px; padding-bottom: 4px; background-color: #fff;margin-bottom: 1px;text-align: left;">'+
	'<button class="btn btn-small" type="button">筛 选</button>  <button class="btn btn-small" type="button">排 除</button>'+
	'</div>';
	*/
	$('#collapse_3').html(content);	
}
function showOverviewApplicantSection(map){
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
				content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}	
	$('#collapse_4').html(content);	
}
function showOverviewInventorSection(map){
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
				content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}
	
	$('#collapse_5').html(content);	
}

function showOverviewIPCSection(map){
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
		content += 
			'<div style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
//				'<label class="checkbox" style="width:200px;overflow: hidden;">'+
//				'<input type="checkbox" value="'+key+'"></label>'+
				key+'('+map[key]+')'+
			'</div>';
	}
	
	$('#collapse_6').html(content);	
}

function downloadPDF() {
	//alert(ctx);	
		var tifInfos = "";
		$("input[name='patent']:checked").each(function(){
//			if ($(this).attr("checked")) 
				{
//alert($(this).attr("tifvalue"));			
				tifInfos += $(this).attr("tifvalue") + ";";
			}
		});
		
		if (tifInfos == "") {
			showexp("请勾选您需要下载的专利后点击下载。");
			return;
		}
//alert(tifInfos);
$("body").mask("正在生成下载文件，请稍候...");
		
		$.ajax({
//			url : ctx + '/downloadTIFFZip.do',
//			url : '<%=basePath%>createTIFFZip.do',
			url : '<%=basePath%><%=_action%>',
			type : 'POST',
			data : {
				'tifInfos' : tifInfos,
				'pictype' : <%=showPIC%>
			},
			success : function(jsonresult) {
$("body").unmask();
//			alert(jsonresult);

				showexp("资源获取成功，<a href="
						+ "<%=basePath%>downloadZipfile.do?fileName=" + jsonresult + ">[这里]</a>进行下载 !");

	//<a href="/Struts2Example/download.do?fileName=client.jar">fileABC.txt</a>
				/*
				if (json.rCode == '100000') {
					var html = "<div style='line-height:22px;'>资源获取成功，<a href="
							+ ctx + "/download/downloadFile?" + json.data
							+ " target='_blank'>[这里]</a>进行下载 !</div>";
//					$.dialog({
//						title : '下载',
//						max : false,
//						min : false,
//						content : html
//					});
					return true;
				} else {
					alert(json.rmsg);
				}
				*/
			},
			error : function() {
				$("body").unmask();
				//alert(json.rmsg);
			}
		});
}
//function showPatentInfo(patentInfoList,lastestFlztInfojson,channelinfojson) {
function showPatentInfo(patentInfoList,channelinfojson) {
	var text = "";
//ctx = '${pageContext.request.contextPath}';
//alert(channelinfojson);
	$.each(patentInfoList,function(index,patentInfo) {		
		var _sic = "";
		var arrSic = patentInfo.sic.split(" ");
		for (var i = 0; i <= arrSic.length-1; i++) {
			_sic += "<a href=\"javascript:treefindIpc(\'"+arrSic[i]+"\');\">"+arrSic[i]+"</a>";
		};		
		
		var _pa = "";
		var arrPa = this.pa.split(";");
		for (var i = 0; i <= arrPa.length-1; i++) {
			_pa += "<a href=\"javascript:treefindAppName(\'"+arrPa[i]+"\');\">"+arrPa[i]+"</a>";
		};
		
		

text = text + '<div class="row-fluid">';
text = text + '<span class="help-inline">';
text = text + '<label style="width: 100%;" class="checkbox">';
text = text + '<span style="font-weight: bold;" id="pindex0"></span>';
text = text + '<input id="ti_'+index+'" title="'+patentInfo.ti+'" name="patent" ';



text = text + ' value="{an:'+patentInfo.an+',sectionName:'+patentInfo.sectionName+',ti:'+patentInfo.ti+',pic:'+patentInfo.pic+',agt:"",countryCode:'+patentInfo.an.substring(0,2)+',tifDistributePath:'+patentInfo.tifDistributePath+',pages:'+patentInfo.pages+',pd:'+patentInfo.pd+',pnm:'+patentInfo.pnm + '}" ';

text = text + ' tifvalue="'+patentInfo.tifDistributePath+','+patentInfo.pages+','+patentInfo.an+ '" ';
//alert("text="+text);
text = text + ' type="checkbox" pnm="'+patentInfo.pnm+'" an="'+patentInfo.an;

text = text + '">';
//text = text + 'type="checkbox" pnm='+this.pnm+' sysid="#'+this.sectionName+'@'+this.pn+'" pid="'+this.sectionName+'@'+this.pn+'" anpn="'+this.an+'|'+this.pn+'" an='+this.an+'>';
//alert(text);
text = text + '<strong style="font-size: 13px;" class="text-info">';
text = text + '['+showchannel(channelinfojson, patentInfo.sectionName)+']';
text = text + '<a style="cursor: pointer;" onclick="javascript:getDetail(\''+patentInfo.id+'\')">'+patentInfo.ti+' ('+patentInfo.an+') </a>';

text = text + "<span id=\"ti_en_"+index+"\"></span>";

text = text + '</strong>';
//$("#detailSearchForm #index").val(pageIndex-1);
if($("#translate").val()==="1"&&patentInfo.sectionName.indexOf("patent")>-1) {
	text = text + "<span onclick=\"translate1('" + index + "')\" class=\"btn btn-warning btn-mini\">翻译</span>&nbsp;";
}
//alert("text="+text);
var pi_an = patentInfo.an;
//alert("pi_an="+pi_an);
//alert(lastestFlztInfojson);

/*
if(lastestFlztInfojson!=''){
$.each(lastestFlztInfojson, function (key, value) {	  
//alert( key + "--" + this.an + "--" + value);
//alert( key + "--" + value);

	if(key==pi_an){
		if(value=="在审"){
			text = text + '&nbsp;<span class=\"label label-info\">'+value+'</span>';
		}else if(value=="无效"){
			text = text + '&nbsp;<span class=\"label label-default\">'+value+'</span>';
		}else if(value=="有效"){
			text = text + '&nbsp;<span class=\"label label-success\">'+value+'</span>';
		}else{
			text = text + '&nbsp;<span class=\"label label-default\">'+value+'</span>';
		}
	}
});
}
*/

var value = patentInfo.flzt
//alert(value);
if(value=="在审"){
	text = text + '&nbsp;<span class=\"label label-info\">'+value+'</span>';
}else if(value=="无效"){
	text = text + '&nbsp;<span class=\"label label-default\">'+value+'</span>';
}else if(value=="有效"){
	text = text + '&nbsp;<span class=\"label label-success\">'+value+'</span>';
}else if(value!=""){
	text = text + '&nbsp;<span class=\"label label-default\">'+value+'</span>';
}

text = text + '</label></span>';

text = text + '</div>';

text = text + '<div class="row-fluid">';

if(patentInfo.estype!="wgzl_ab"){
	text = text + '<div class="span9" style="padding-left:20px; font-size: 12px;">';
}else{
	text = text + '<div class="span12" style="padding-left:20px; font-size: 12px;">';
}
/*
text = text + '<div class="row-fluid">';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <a href="javascript:treefindPubNum(\''+patentInfo.pnm+'\');\">'+patentInfo.pnm+'</a></span>';
text = text + '<span class="p-inline">申请日：<a href="javascript:treefindAppDate(\''+patentInfo.ad+'\');\">'+patentInfo.ad+'</a></span></div>';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）日：<a href="javascript:treefindPubDate(\''+patentInfo.pd+'\');\">'+patentInfo.pd+'</a></span>';
text = text + '<span class="p-inline">分类号：'+_sic+'</span></div>';

text = text + '<div class="row-fluid"><span class="p-inline"> 申请（专利权）人：'+_pa+'</span></div>';
text = text + '<div style="padding-right: 15px; padding-left: 5px;padding-bottom:8px;" class="row-fluid muted">'+patentInfo.ab+'</div>';

text = text + "<span id=\"ab_en_"+index+"\"></span>";
text = text + "</div>";
*/
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <a href="javascript:treefindPubNum(\''+patentInfo.pnm+'\');\">'+patentInfo.pnm+'</a></span>';
text = text + '<span class="p-inline">申请日：<a href="javascript:treefindAppDate(\''+patentInfo.ad+'\');\">'+patentInfo.ad+'</a></span></div>';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）日：<a href="javascript:treefindPubDate(\''+patentInfo.pd+'\');\">'+patentInfo.pd+'</a></span>';
text = text + '<span class="p-inline">分类号：'+_sic+'</span></div>';

text = text + '<div class="row-fluid"><span class="p-inline"> 申请（专利权）人：'+_pa+'</span></div>';
text = text + '<div style="padding-right: 15px; padding-left:5px;padding-bottom:8px;" class="row-fluid muted">'+patentInfo.ab+'</div>';

text = text + "<div id=\"ab_en_"+index+"\"></div>";
text = text + "</div>";

//alert(patentInfo.an+"-----"+patentInfo.estype);

if(patentInfo.estype!="wgzl_ab"){
	text = text + "<div class=\"span3\">";
	text = text + "<a class=\"fancybox\" rel=\"group\" href=\""+this.abPicPath+"\">";
	text = text + "<img class=\"img-polaroid img-responsive\" style=\"max-height:160px;\" src=\""+this.abPicPath+"\" complete=\"complete\" onerror=\"javascript:this.src='http://search.cnipr.com/images/ganlan_pic1.gif';\"/>";
	text = text + "</a>";
	text = text + "</div>";
}else{
	var intPages = patentInfo.pages;//16
	var TifDistributePath = patentInfo.tifDistributePath;//BOOKS/WG/2017/332301/2016305906313
	
//alert(patentInfo.an+"-----"+patentInfo.estype);
//alert("外观...");
//alert(patentInfo.pages);
//alert(TifDistributePath);
	//text = text + "---" +intPages + "---" +TifDistributePath + "---" +patentInfo.abPicPath;
	//text = text + "---" +intPages;
	
	text = text + "<ul class=\"thumbnails\" style=\"margin-left:0px\">";
	for (var i=1;i<=intPages;i++)
	{
		var imgpath = "http://pic.cnipr.com:8080/"+TifDistributePath+"/"+addPreZero(i)+".jpg";
		text = text + "<li style=\"margin-left: 0px\">";
		text = text + "<div class=\"thumbnail\" style=\"width:110px;height:110px;margin-left:10px\">";
		text = text + "<a class=\"fancybox\" rel=\"group\" href=\""+imgpath+"\">";						
		text = text + "<img src=\""+imgpath+"\" onerror=\"javascript:this.src='${ctx}/common/tu/ganlan_pic1.gif';\" class=\"zoomin\" alt=\"\" style=\"width:120px;height:120px;\">";
		text = text + "</a>";
		text = text + "</div>";
		text = text + "</li>";
	}
	text = text + "</ul>";
}


text = text + '</div>';
//alert(text);
	});
	

	$('#overViewDiv').html(text);
}


function showSection(sectionInfos,channelinfojson,unfilterTotalCount,RecordCount){
//	alert($('#recordCount').val());
//	var recordCount = $('#recordCount').val();
	/*
	$.each((sectionInfos),function(index) {
		alert(this.recordNum+"---"+this.sectionName);
	})

	$.each((channelinfojson),function(index) {
		alert(this.chrChannelName+"---"+this.chrTRSTable);
	})
	*/
	var map = new Object();
	
	$.each((channelinfojson),function(index) {
//		alert(this.chrChannelName+"---"+this.chrTRSTable);
//		map.put(this.chrTRSTable, this.chrChannelName);
		map[this.chrTRSTable] = this.chrChannelName;
	})
	
	var strSelected = "selected=\"selected\"";
	
	$("#sectionInfos option").remove();
	$("#sectionInfos").empty();
	
	if(RecordCount==unfilterTotalCount){
		$("#sectionInfos").append("<option "+strSelected+" value=''>全部("+unfilterTotalCount+")</option>");
	}else{
		$("#sectionInfos").append("<option value=''>全部("+unfilterTotalCount+")</option>");
	}
	
	for(key in map){
//alert(key+"="+map[key]);
		$.each((sectionInfos),function(index) {
//alert("####----"+this.recordNum+"---"+this.sectionName);
			if(key==this.sectionName){
				if(RecordCount==this.recordNum){
					$("#sectionInfos").append("<option "+strSelected+" value="+this.sectionName+" alt="+this.recordNum+">"+map[key]+"("+this.recordNum+")</option>");
				}else{
					$("#sectionInfos").append("<option value="+this.sectionName+" alt="+this.recordNum+">"+map[key]+"("+this.recordNum+")</option>");
				}
			}
		})
	}
	
//map.get("fmzl_ft");
//alert(sectionInfos);
/*
<option selected="selected" value="">全部(692)</option>
<option value="FMZL">发明专利(334)</option>
<option value="SYXX">实用新型(336)</option>
<option value="WGZL">外观设计(22)</option>
*/
}

function nextPage(pageindex){
	$('#searchType').val("2");
	params.xAxis="";
	params.currentPage=pageindex;
	requestExpData(params);
	
//alert("nextPage...="+pageindex);
//alert(params.language);
//alert(params.nodeId);
	/*
	var language = params.language;
	var nodeId = params.nodeId;	
//alert("language="+language);
	if ("CN" == language) {
		initRequestData(nodeId, "CN",pageindex);
	}else if ("EN" == language){
		initRequestData(nodeId, "EN",pageindex);
	}else if ("SX" == language){
		initRequestData(nodeId, "SX",pageindex);
	}
	*/
}

function addPreZero(num){
	return ('000000000'+num).slice(-6);
}

function fenye(currentPage,recordCount){
	var text = "";	
	//alert("currentPage="+currentPage);
	//alert("recordCount="+recordCount);
	
	var totalpageCount=0;

	if(recordCount%10>0){
		totalpageCount=Math.floor(recordCount/10)+1;
	}else{
		totalpageCount=Math.floor(recordCount/10);
	}
	
	//alert("totalpageCount="+totalpageCount);

		if (currentPage == 1) {
//			text = text + '<li><a href="#"> <span class="icon-step-backward"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-left" ></span> </a></li>';
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" href="#"> 上一页 </a></li>';
		} else {
//			text = text + '<li><a href="javascript:nextPage(1)" target="_self"> <span class="icon-step-backward"></span> </a></li>';
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) - 1) +  ')" target="_self"> 上一页 </a></li>';
		}

		text = text + '<li style="color: #666;margin-top:8px;"><input type="text" onKeyDown="if(event.keyCode==13) return false;" style="width: 50px; height: 19px; margin: 0px; line-height: 15px; padding: 0px" value="'+currentPage+'" id="pageEnterBtn"><span><input type="button" onClick="javascript:gotoPage('+totalpageCount+');" name="sub" value="GO">'+totalpageCount+'</span></li>';
		
		if (currentPage == totalpageCount) {
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" href="#"> 下一页 </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-step-forward"></span> </a></li>';
		} else {
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> 下一页 </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ totalpageCount +  ')" target="_self"> <span class="icon-step-forward"></span> </a></li>';
		}
		
		//alert("text="+text);
		$('#pageinfo').html(text);
}

function gotoPage(totalpageCount) {
	var page = document.getElementById("pageEnterBtn").value;
	var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数    

    if (!re.test(page)) {
    	showexp("请输入1至"+totalpageCount+"的正确页码！");
		return;
    }
    if(totalpageCount>=page){
    	nextPage(page);
	}else{
		showexp("请输入1至"+totalpageCount+"的正确页码！");
	}
    //nextPage($('#pageEnterBtn').val());
}

function getPatentList(){
	//$("input[name='patent']")
	var str = "";
	$("input[name='patent']:checked").each(function(){
		$(this).attr("an");//删除集合元素
		//alert($(this).attr("an"));//$(".myradio:checked").hide(); 
		str+=$(this).attr("an")+",";
	});
	if(str!=""){
		str=str.substr(0,str.length-1);
	}
	return str;
}

function showchannel(channelinfojson, tablename){
	var ChannelName = "";
	
	$.each($(channelinfojson),function(index) {
//		alert(this.chrTRSTable + "---"+ this.chrChannelName);
		if(this.chrTRSTable.indexOf(tablename)>-1){
			ChannelName = this.chrChannelName;
		}
	})
	return ChannelName;
}

function dbSearchModal() {
	$("#db-search-modal").modal('show');
}

function dbSearchNodeData() {
	var inText = $('#db-mult-text').val();

	var searchType_operator = $('input:radio[name="searchType"]:checked').val();
//	alert("searchType_operator = "+searchType_operator);	
	
//	alert(params.secondsearchexp);
	if(typeof(params.secondsearchexp)=="undefined"){
		params.secondsearchexp="";
	}
//	alert(params.secondsearchexp);

	if(inText!=null && inText!=""){
//		params.selectexp = params.selectexp + " " + searchType_operator + " " + inText;
		params.secondsearchexp = params.secondsearchexp + ";" + searchType_operator + " " + inText;
	}
	
	/*
	if(params.quadraticText!=null && params.quadraticText!=""){
		params.quadraticText += inText;
	}else{
		params.quadraticText = inText;
	}
	*/
//二次检索字段备份表达式
//params.cacheQuadraticText +=inText;
	
//	$('#selectexp').val(params.selectexp);
	$("#db-search-modal").modal('hide');
	$('body').mask('加载中...');
	$('#overViewDiv').html('');
	requestExpData(params);
}

function Download() {
//alert($('#area').val());
	var patentList = getPatentList();
//alert("patentList="+patentList);
	if(patentList == null||patentList=="")
	{
		showexp("请先选择要下载文摘的记录。");
    	return;
  	}
  	else
	{
  		if($('#area').val()==='cn'){
  			$('#downloadModal').modal('show');
  		}else{
  			$('#frdownloadModal').modal('show');
  		}
	}
}
function beginDownload() {
	var patentList = getPatentList();
//	alert(patentList);
	var checkedItems = "";

			
//alert(checkedItems);
	if($('#area').val()==='cn'){
		$("#downloadTableInfo input[name='downloadColumn']").each(
				function() {
//					alert($(this).attr("checked"));
					if ($(this).attr("checked")=='checked') {
						checkedItems += $(this).val() + ",";
					}
				})
	}else{
		$("#frdownloadTableInfo input[name='downloadColumn']").each(
				function() {
//					alert($(this).attr("checked"));
					if ($(this).attr("checked")=='checked') {
						checkedItems += $(this).val() + ",";
					}
				})
	}
			
	if (checkedItems != "") {
		checkedItems = checkedItems.substring(0, checkedItems.length - 1);
//alert(checkedItems);

		var where = "";
		var arrAn = patentList.split(',');
		for (var i=0;i<arrAn.length;i++)
		{
//			document.write(cars[i] + "<br>");
			where += "申请号="+arrAn[i] + " or ";
		}
		if(where!=""&&where.lastIndexOf(" or ")>0){
			where=where.substring(0,where.lastIndexOf(" or "));
//			where = "(" + where + ")";
		}
//alert(where);
		
//		var source = document.searchForm.strSources.value;
//		var strSortMethod=document.searchForm.strSortMethod.value;
//		var option=document.searchForm.option.value;

//		var iHitPointType=document.searchForm.iHitPointType.value;
//		var filterChannel=document.searchForm.filterChannel.value;
//		var strSynonymous=document.searchForm.strSynonymous.value;

$("body").mask("正在生成下载文件，请稍候...");

	$.ajax({
//		url : ctx + '/downloadTIFFZip.do',
		url : '<%=basePath%>createAbstractZip.do',
		type : 'POST',
		data : {
//			'strWhere' : where,
//			'strSources' : source,
			'downtype' : 0,
			'downloadcol' :  checkedItems,
//			'strSortMethod' : strSortMethod,
//			'iHitPointType' : iHitPointType,
			'filterChannel' : params.filterChannel,
//			'filterChannel' : $('#currentfilterChannel').val(),
//			'strSynonymous' : strSynonymous,
			'isbatchdownload' : 0,
			'patentList' : patentList
//			'downloadStart' : downloadStart,
//			'downloadAmount' : downloadAmount
		},
		success : function(jsonresult) {
			$("body").unmask();
//			alert(jsonresult);
			showexp("资源获取成功，<a href="
					+ "<%=basePath%>downloadZipfile.do?fileName=" + jsonresult + ">[这里]</a>进行下载 !");
		},
		error : function() {
			$("body").unmask();
			//alert(json.rmsg);
		}
	});

	}else{
		showexp("请选择下载的字段");
	}
}

$("#bt_analyse").click(function () {
	var _totalRecord = $("#unfilterTotalCount").val();
//alert(_totalRecord);
	
	if(_totalRecord>5000000){
		showexp("分析数据超过上限500万条专利，请缩小分析范围，重新进行分析。");
	}else{
		var language = params.language;
		newWinUrl("analyse.do?language="+language);
	}
});

//伪装一下表单提交在新窗口
function newWinUrl(url){
//alert(url);
//alert(params.filterChannel);
//alert(document.searchForm.strWhere.value);
//alert(document.searchForm.strSources.value);
//$('#selectexp').val(treeNode.cnTrsExp);
//$('#selectdbs').val(treeNode.cnTrsTable);
//alert($('#selectdbs').val());
    var f=document.createElement("form");
    
    var exp =document.createElement("input");
    exp.id = "strWhere";
    exp.name = "strWhere";
    exp.type = "hidden";
//exp.value = document.searchForm.strWhere.value;
	exp.value = $('#selectexp').val();
    
    var dbs =document.createElement("input");
    dbs.id = "strSources";
    dbs.name = "strSources";
    dbs.type = "hidden";
//    dbs.value = document.searchForm.strSources.value;
    dbs.value = $('#selectdbs').val();
    
    var filterChannel = params.filterChannel;
    if(filterChannel!=''){
    	dbs.value = filterChannel;
    }
    
    f.appendChild(exp);
    f.appendChild(dbs);
        
    f.setAttribute("action" , url );
    f.setAttribute("method" , 'post' );
    f.setAttribute("target" , '_black' );
    document.body.appendChild(f)
    
    f.submit();
}
</script>
<%@ include file="include-downloadmodal.jsp"%>