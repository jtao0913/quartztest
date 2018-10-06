<%@ page language="java" pageEncoding="UTF-8"%>

<input type="hidden" id="strSources" value="" />
<input type="hidden" id="strWhere" value="" />
<!-- <input type="hidden" id="semanticexp" value="" /> -->
<input type="hidden" id="currentexp" value="" />
<input type="hidden" id="treeType" value="" />
<input type="hidden" id="RecordCount" value="" />
<input type="hidden" id="logicexpid" value="" />
<input type="hidden" id="ABSTBatchCount" value="<%=ABSTBatchCount%>" />

<%
String ShowBase64 = (String)application.getAttribute("ShowBase64");
if(ShowBase64==null) {
	ShowBase64="";
}
%>
<input type="hidden" id="ShowBase64" value="<%=ShowBase64%>"/>

<!--span9右-->

						
				<div class="span9" >
				
					<div id="mapDiv">
					<%
					//out.println("treeType="+treeType);
					if(treeType==-5)
					{
					%>
					<%@ include file="../../map/guangdong.jsp"%>
					<%}%>
					</div>
				<!--  
				<div id="expcontent" class="well" style="display:none;height:18px;overflow:auto;margin-top:0px;border-color:#ccc;color:#888;padding:6px;font-size:12px;text-align: left;">检索表达式：<span id="expression"></span></div>
				-->
				<div style="height:8px;"></div>
				<div class="input-append">
					<input id="expcontent" class="input-xxlarge" type="text" style="width:828px;display:none;">
					<button id="retrievesearch" class="btn" type="button" style="display:none;">重新检索</button>
				</div>
				<div style="height:6px;"></div>
				<%@ include file="include_overview_nav.jsp"%>
				<div id="overViewDiv" style="display:none;"> </div>
                <div style="height:10px;"></div>
                <div id="kkpager" style="display:none;"></div>

				</div>

<script type="text/javascript">
function translate1(index) {
	var checkedItems = "ti_"+index + ":" + $("#ti_"+index).attr("an");	
//	alert(checkedItems);
	
	if(checkedItems==""){
		showexp("请您选择要翻译的专利");
	}else{
		$("body").mask("正在翻译，请稍候...");
			$.ajax({
				type : "GET",
				url : "mutitranslate.do?timeStamp=" + new Date(),				
				data : {
					'ans' : checkedItems
				},
				contentType : "application/json;charset=UTF-8",
				success : function(jsonresult) {
//alert(jsonresult);
					var arr = jsonresult.split("===");
//					alert(arr.length);
					for(var i = 0;i < arr.length; i++){
//						alert(arr[i]);
						var _arr = arr[i].split("\\n");
//						alert(_arr.length);
//alert("#ti_en_"+_arr[0]);
						$("#ti_en_"+_arr[0]).html("译文:"+_arr[1]);
						if(_arr.length==3){
							$("#ab_en_"+_arr[0]).html("译文:\r\n"+_arr[2]);
						}
					}
					
//					if(itemnum==0)
					{
						$("body").unmask();
					}
				}
			})
	}
}

$("#retrievesearch").click(function() {
	var expcontent = $("#expcontent").val();
	expcontent = $.trim(expcontent);
	
	expcontent = expcontent.replace("快速检索=","申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
	expcontent = expcontent.replace("语义检索=","主权项语义,摘要语义+=");	
	
//alert(expcontent);
	params.strWhere=expcontent;	
	$('#strWhere').val(expcontent);
	clearexp();
	requestExpData(params);	
});

function insertDBtitle(textTem) {
	var field = document.getElementById("db-mult-text");
	insertAtCursor(field, textTem);
}

function selectAllCheckSort(objValue) {
	if (objValue == true) {
		$("input[name='patent']:checkbox").each(function(i) {
	//		alert($(this).val());
	//		$(this).attr("checked",true);
	//		$(this).checked = true;
			this.checked=true;
		});		
	} else {
		$("input[name='patent']:checkbox").each(function(i) {
		//		alert($(this).val());
		//		$(this).attr("checked",false);
		//		$(this).checked = false;
			this.checked=false;
		});
	}
}

function getDetail(index,sectionname){
//alert("index="+index);
//alert("sectionname="+sectionname);
    document.showDetail.area.value = params.language;
    document.showDetail.strWhere.value = "id="+index;//escape(params.strWhere);    
    document.showDetail.strSources.value = sectionname;   
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

function insertAtCursor1(myField, myValue) {	
//	alert(myField + "----" + myValue);
	if (document.selection) {
//		alert("111");
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
		sel.select();
		// MOZILLA/NETSCAPE support
	} else if (myField.selectionStart || myField.selectionStart == '0') {
//		alert(myField.value+"----"+myValue);
		var startPos = myField.selectionStart;
		var endPos = myField.selectionEnd;
//		alert("aaa");
		// save scrollTop before insert
		var restoreTop = myField.scrollTop;
		alert("bbb");

//		myField.value = myField.value.substring(0, startPos) + myValue + myField.value.substring(endPos, myField.value.length);
/*
		$("#db-mult-text").text("abcdefg");
		
		var _text = $("#db-mult-text").text();
		alert(_text);
		var _text1 = $("#db-mult-text").html();
		alert(_text1);
*/	
//		$("#db-mult-text").text(_text.substring(0, startPos) + myValue + _text.substring(endPos, myField.value.length));
var _text1 = $("#db-mult-text").val();
alert(_text1);

var _text2 = $("#db-mult-text").text();
alert(_text2);


		$("#db-mult-text").val(myValue);
		
		var _text = $("#db-mult-text").val();
		alert(_text);
		
		alert("ccc");
		if (restoreTop > 0) {
			// restore previous scrollTop
			myField.scrollTop = restoreTop;
		}
//		alert("ddd");
		myField.focus();
//		alert("eee");
		myField.selectionStart = startPos + myValue.length;
		myField.selectionEnd = startPos + myValue.length;
//		alert("fff");
	} else {
//		alert("333");
		myField.value += myValue;
		myField.focus();
	}
}

function insertAtCursor(myField, myValue) {
//IE support
	if (document.selection) {
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
		sel.select();
//MOZILLA/NETSCAPE support
	} else if (myField.selectionStart || myField.selectionStart == '0') {
		var startPos = myField.selectionStart;
		var endPos = myField.selectionEnd;
//save scrollTop before insert
		var restoreTop = myField.scrollTop;
		myField.value = myField.value.substring(0, startPos) + myValue
				+ myField.value.substring(endPos, myField.value.length);
		if (restoreTop > 0) {
//restore previous scrollTop
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
/*
function channelsChange(selectChannel) {
	var selectChannelCount = $("#sectionInfos").find("option:selected").attr("alt");
	
	if(selectChannelCount!="0"){
//	alert(params.nodeId);
		$('body').mask("请等待...");
		params.currentPage = "1";
		params.filterChannel = selectChannel;
//		$('#strSources').val(selectChannel);
//		$('#currentfilterChannel').val(selectChannel);		
		
		$('#overViewDiv').html('');
		requestExpData(params);
	//	alert("1111");
		$('#pageEnterBtn').val('1');
	//	alert("2222");
	}
}
*/
function clearexp(){
	var overviewtree = $('#overviewtree').val();
//	alert(overviewtree);
	
	params.nodeId="";	
	if(overviewtree=="0"){
		$('#searchType').val("1");
	}else if(overviewtree=="1"){
		$('#searchType').val("2");
	}	
	expList = [];
	secondsearchexp = [];
	params.currentPage = "1";
	params.xAxis="PATTYPE";
	params.logicexpid="";
//	params.filterexp=$('#filterexp').val();
	params.filterexp="";
	$('#filterexp').val("");
	$('#filter').html("");
	
	$('#logicexpid').val("");
	$("#expcontent").hide();
	$("#retrievesearch").hide();
	$("#nav_div").hide();	
	$("#kkpager").hide();
	$("#overViewDiv").html("");
	$('#RecordCount').val("0");
	
	$("#mapDiv").hide();
//	nextPage(1);
	kkpager.selectPage(1);
//	$('#pageEnterBtn').val("1");
}

function findAppName(appName) {
//alert(appName);	
	if (appName != null && appName != "") {
		var strWhere = "";

		if (appName.indexOf(']') > 0 || appName.indexOf('[')>=0) {
			strWhere = "申请（专利权）人=('" + appName.replace("[", "").replace("]", "") + "')"
		} else {
			strWhere = "申请（专利权）人=('" + appName + "')";
		}
/*	
		$('#searchForm #strWhere').val(strWhere);		
	    $('#searchForm #area').val(params.language);
	    $('#searchForm #strSources').val(params.strSources);
	    $('#searchForm #strChannels').val(params.strSources);
		$('#searchForm #simpleSearch').val("1");
	    $("#searchForm").attr("target", "_blank");	
		$('#searchForm').submit();
*/
		params.strWhere=strWhere;	
		$('#strWhere').val(strWhere);
		//$('#searchType').val("1");
		clearexp();
		requestExpData(params);
	}
}

function findAppDate(param) {
	var strWhere = "申请日=(" + param + ")";	
	params.strWhere=strWhere;	
	$('#strWhere').val(strWhere);
	clearexp();
	requestExpData(params);
}
function findPubNum(param){
	var strWhere = "公开（公告）号=(" + param + ")";
	params.strWhere=strWhere;	
	$('#strWhere').val(strWhere);
	clearexp();
	requestExpData(params);
}
function findPubDate(param){
	var strWhere = "公开（公告）日=(" + param + ")";
	params.strWhere=strWhere;	
	$('#strWhere').val(strWhere);
	clearexp();
	requestExpData(params);
}
function findIpc(param){
//	alert("params.xAxis="+params.xAxis);
	var strWhere = "分类号=(" + param + ")";
	params.strWhere=strWhere;
	$('#searchType').val("1");	
	$('#strWhere').val(strWhere);
	clearexp();
	requestExpData(params);
}

function changesortmethod() {
//alert($("#sortcolumn").val());	
	var language = params.language;
	params.language=language;
	params.sortMethod='-公开（公告）日';
	params.currentPage=1;
	params.totalPages=0;
	params.filter=$('#filterexp').val();
	params.strSortMethod=$("#sortcolumn").val();//strSortMethod
	params.xAxis="";
	$('#searchType').val("2");
	requestExpData(params);
}
function changepagerecord() {				
	//alert("changepagerecord()........");
	var selpagerecord = document.getElementById("selpagerecord").value;
//alert(selpagerecord);
	
	var language = params.language;
	params.language=language;
	params.sortMethod='-公开（公告）日';
	params.currentPage=1;
	params.totalPages=0;
//	params.filter=$('#filterexp').val();
//	params.strSortMethod=$("#sortcolumn").val();
	params.xAxis="";
	$('#searchType').val("2");
	params.pagerecord=selpagerecord;
	
	requestExpData(params);
}

function showexpression(){
	/*
	var filterexp = "";
	var overviewtree = $('#overviewtree').val();
	if(overviewtree==="0"){
		for (var key in expList) {
			var exp = expList[key];
	//alert(key + "---" + val);
			var conj = "";
			if(exp.indexOf(" and ")==0){
				conj = "and";
			}
			if(exp.indexOf(" not ")==0){
				conj = "not";
			}
			filterexp += exp;
		}
//alert(filterexp);
//alert($('#strWhere').val());
	}
	$('#expression').html($.trim($('#strWhere').val()+filterexp));
	*/
	$('#expression').html($.trim($('#strWhere').val()));
}
//查询概览信息
function requestExpData(params) {
//alert($('#area').val());
//alert($('#strWhere').val());
//alert($('#strSources').val());

//alert("params.xAxis="+params.xAxis);
//alert(params.secondsearchexp);

//alert("secondsearchexp="+params.secondsearchexp);
//clearexp();
	$("#mapDiv").hide();
	showexpression();
//$('#currentPage').val(params.currentPage);
	$('#data-process-img').show();
	isLoading = true;
	
	$('body').mask('正在检索');
//alert(params.strWhere);
//alert("strSources="+params.strSources);
//alert(params.filterChannel);
//alert(params.currentPage);
//alert(params.language);
//alert("params.filterexp="+params.filterexp);
	var searchType = $('#searchType').val();
//alert("searchType="+searchType);
	if(params.language==='cn'||params.language==='CN'){
		$('#leftflztdiv').show();
	}else{
		$("#leftflztdiv").hide();
	}
	$("#nodeId").val(params.nodeId);
	
//	alert(params.strWhere.indexOf("="));
	if (params.strWhere.indexOf("=") < 0) {
//		strWhere = "主权项语义,摘要语义+='" + URLDecoder.decode(strWhere, "UTF-8") + "'";
//		申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=
//		params.strWhere = "主权项语义,摘要语义+=(" + params.strWhere + ")";
		params.strWhere = "语义检索=(" + params.strWhere + ")";
	}	
	
	$.ajax({
		type : "GET",
		url : "toJsonOverView.do?timeStamp=" + new Date(),
		//url : "/toJsonOverView.do",
		data : {			
			'searchType' : searchType,
			'treeType' : '<%=treeType%>',
			'xAxis' : params.xAxis,
			'xAxisSize' : params.xAxisSize,
			'nodeId' : params.nodeId,
			'strWhere' : params.strWhere,
//			'semanticexp' : params.semanticexp,
//			'secondsearchexp' : encodeURIComponent(params.secondsearchexp),
//			'secondsearchexp' : params.secondsearchexp,
//params.secondsearchexp
			'strSortMethod' : params.strSortMethod,
			'filterexp' : params.filterexp,
			'strSources' : params.strSources,
			'logicexpid' : params.logicexpid,			
//			'filterChannel' : params.filterChannel,
			'pagerecord' : params.pagerecord,
			'currentPage' : params.currentPage,
			'language' : params.language
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			if (jsonresult != null&&jsonresult != "") {
				//processJsonresult(jsonresult,1);	
				/*
				if(searchType===1){
					processJsonresult(jsonresult,2);
				}else{
//					alert(0);
					processJsonresult(jsonresult,0);//第二次参数为0代表overview，为1代表tree
				}
				*/
//				$("#expcontent").show();//表示display:block

				/*
				var overviewtree = $('#overviewtree').val();
				if(overviewtree=="0"){
//					$('#searchType').val("1");
					$("#expcontent").show();
					$("#retrievesearch").show();					
				}else if(overviewtree=="1"){
//					$('#searchType').val("2");
					//$("#expcontent").hide();
				}
				*/
//				$("#nav_div").show();//表示display:block
//				$("#overViewDiv").show();//表示display:block
				//$("#expcontent").hide();//表示display:none;
				$("#tab2").show();
				processJsonresult(jsonresult,searchType,params.currentPage);
			}else{
				//$('#top-navbar').hide();
				//$('#overViewDiv').hide();				
				//$("#expcontent").hide();//表示display:block
				$("#nav_div").hide();//表示display:block
				$("#overViewDiv").hide();//表示display:block
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

function processJsonresult(jsonresult, searchType,pageindex){
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
		strWhere_ori = result.strWhere_ori;
			
		strSources = result.strSources;
//alert(strWhere);

		URLEncoderWhere = result.URLEncoderWhere;
		SecurityCode = result.SecurityCode;		

		
		var pieDataList = [];
		var legend = [];
		
		var str_wordcloud = "<ol>";
		var al_wordcloud = result.al_wordcloud;
		for (var key in al_wordcloud) {
			var val = al_wordcloud[key];
			var word = val.split(':');
//			alert(key+"---"+val);
			str_wordcloud+="<label class='pull-left' style='width:145px;'><input name='strWordcloud' type='checkbox' value='"+word[0]+"'> "+val+"</label>";
//			str_wordcloud+="<input name='strWordcloud' type='checkbox' value='"+word[0]+"'>"+val;
			
			pieDataList.push({
				'value' : al_wordcloud[key],
				'name' : key
			});
			legend.push(key);
		}
		
//		str_wordcloud+="<input type='button' value='语义筛选' onClick='selectWordCloud()'>";
		str_wordcloud+="</ol>";
//		alert(str_wordcloud);
		$("#wordcloudDiv").html(str_wordcloud);

//		alert(legend);
//		alert(pieDataList);
//		_generateCloudChart(legend,pieDataList,"shine");
	})

		$('#chkall').attr("checked", false);

		if(RecordCount>0){
			$("#nav_div").show();
			$("#kkpager").show();
			$('#currentexp').val(strWhere);
			
			var overviewtree = $('#overviewtree').val();
			if(overviewtree=="0"){
//				$('#searchType').val("1");
//				$("#expcontent").show();
				$("#expcontent").show();
				$("#retrievesearch").show();
//				$("#expcontent").val(strWhere);
				$("#expcontent").val(strWhere_ori.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=","快速检索=").replace("主权项语义,摘要语义+=","语义检索="));
//				$("#expcontent").val(params.strWhere.replace("主权项语义,摘要语义+=","语义检索="));
			}else if(overviewtree=="1"){
				$("#expcontent").hide();
				$("#retrievesearch").hide();
				$("#expcontent").val("");
				//$("#expcontent").hide();
			}
			
			$('#unfilterTotalCount').val(unfilterTotalCount);
			$('#RecordCount').val(RecordCount);
			$('#resultfilter').html("结果筛选（共"+RecordCount+"件）");
			$('#SecurityCode').val(SecurityCode);
			$('#URLEncoderWhere').val(URLEncoderWhere);
			$('#strSources').val(strSources);			
			
//			alert(SecurityCode);
//			alert(URLEncoderWhere);
			
//			initPager();
			initPager(pageindex);
			
//alert("overview_tree="+overview_tree);
							/*
							if(searchType===1){
//								showSection(sectionInfos,channelInfo,unfilterTotalCount,RecordCount);
								showOverviewPattypeSection(map_data_single);
							}else 
								*/
//								alert("searchType="+searchType);
								
						if(searchType===0||searchType===1||searchType==="0"||searchType==="1"){
							//alert("searchType="+searchType);
							/*
							if((typeof sectionInfos)!="undefined"&&(sectionInfos!='')){
								showOverviewSection(sectionInfos,channelInfo,unfilterTotalCount,RecordCount);
							}
							*/
//							var searchType = $('#searchType').val();
							if(map_data_single!=null){
								
								showleftmenu(params,map_data_single,searchType);
								
								if(searchType===1||searchType==="1")
								{
									/*
									$('#collapse_1').html("");if($('#collapse1').hasClass('in')){$('#collapse1').collapse('hide');}
									$('#collapse_2').html("");if($('#collapse2').hasClass('in')){$('#collapse2').collapse('hide');}									
									$('#collapse_3').html("");if($('#collapse3').hasClass('in')){$('#collapse3').collapse('hide');}
									$('#collapse_4').html("");if($('#collapse4').hasClass('in')){$('#collapse4').collapse('hide');}
									$('#collapse_5').html("");if($('#collapse5').hasClass('in')){$('#collapse5').collapse('hide');}
									$('#collapse_6').html("");if($('#collapse6').hasClass('in')){$('#collapse6').collapse('hide');}
									*/
									/*
									$('#collapse_1').html("");{$('#collapse1').collapse('hide');}
									$('#collapse_2').html("");{$('#collapse2').collapse('hide');}
									$('#collapse_3').html("");{$('#collapse3').collapse('hide');}
									$('#collapse_4').html("");{$('#collapse4').collapse('hide');}
									$('#collapse_5').html("");{$('#collapse5').collapse('hide');}
									$('#collapse_6').html("");{$('#collapse6').collapse('hide');}
									*/
									/*
									$('#collapse_1').html("");$('#collapse1').collapse('hide');//$('#collapse1').removeClass('in');
									$('#collapse_2').html("");$('#collapse2').collapse('hide');//$('#collapse2').removeClass('in');
									$('#collapse_3').html("");$('#collapse3').collapse('hide');//$('#collapse3').removeClass('in');
									$('#collapse_4').html("");$('#collapse4').collapse('hide');//$('#collapse4').removeClass('in');
									$('#collapse_5').html("");$('#collapse5').collapse('hide');//$('#collapse5').removeClass('in');
									$('#collapse_6').html("");$('#collapse6').collapse('hide');//$('#collapse6').removeClass('in');
									*/
									
								}
								
//								alert("searchType="+searchType);
//								alert("params.xAxis="+params.xAxis);
//								alert("map_data_single="+map_data_single);
								
//								setTimeout("fun()",1500);
								/*
								if(params.xAxis==='PATTYPE'){
//									$('#collapse_1').html("");
//									$('#collapse1').collapse('hide');
//									$('#collapse1').collapse('show');
									showOverviewPattypeSection(map_data_single);
									$('#collapse1').attr('class','panel-collapse collapse in');
									$('#collapse1').collapse('show');
								}else if(params.xAxis==='最新法律状态'){
									showOverviewFlztSection(map_data_single);
									$('#collapse2').attr('class','panel-collapse collapse in');
									$('#collapse2').collapse('show');
								}else if(params.xAxis==='公开年'){
									showOverviewPDyearSection(map_data_single);
									$('#collapse3').attr('class','panel-collapse collapse in');
									$('#collapse3').collapse('show');
								}else if(params.xAxis==='申请人'){
									showOverviewApplicantSection(map_data_single);
									$('#collapse4').attr('class','panel-collapse collapse in');
									$('#collapse4').collapse('show');
								}else if(params.xAxis==='发明人'){
									showOverviewInventorSection(map_data_single);
									$('#collapse5').attr('class','panel-collapse collapse in');
									$('#collapse5').collapse('show');
								}else if(params.xAxis==='IPC小类'){
									showOverviewIPCSection(map_data_single);
									$('#collapse6').attr('class','panel-collapse collapse in');
									$('#collapse6').collapse('show');
								}
								*/
							}								
						}
							
						$('#overViewDiv').show();
							
//						alert("params.currentPage="+params.currentPage);
//						alert("RecordCount="+RecordCount);
							
//						alert(patentInfoList!='');
						if(patentInfoList!=''){								
							$('#top-navbar').show();
							fenye(params.currentPage);
							showPatentInfo(patentInfoList, channelInfo);
						}

					}else{
						$('#top-navbar').hide();
						$('#overViewDiv').hide();
							
						$('#RecordCount').val("0");
						fenye(0);
						$("#kkpager").hide();
						
						showexp("此次检索无结果");
					}
}

function selectWordCloud(){
	var str = "";
	$("input[name='strWordcloud']:checked").each(function(){
//		alert($(this).attr("value"));
		str+=$(this).attr("value")+" ";
	});
	
//	alert("str = "+str);
	
	if(str!=""){
//		str=str.substr(0,str.length-5);
//		str="主权项语义,摘要语义+=("+str+")";
		str="语义检索=("+str+")";
		
//		alert(str);

		if(str!=null && str!=""){
			pre_2_renderfilter(" and " + str);
			params.filterexp=$('#filterexp').val();
		}

		params.currentPage = "1";
		$("#wordcloudModal").modal('hide');
		$('body').mask('加载中...');
		$('#overViewDiv').html('');
		$('#searchType').val("1");
		requestExpData(params);
	}

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

//生成词云
function _generateCloudChart(legend,pieDataList,theme) {
//alert("_generateCloudChart");
//alert(analysisName);
//alert(legend);
//alert(pieDataList);
//alert(theme);

//var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
//echarts.dispose(chart);

	var cloudChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
	//var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'));
	cloudChart.setOption({
//		backgroundColor: '#2c343c',
		title : {
//			text : analysisName
		},
		tooltip: {},

		series : [ {
//			name : analysisName,
			type : 'wordCloud',
//			center : [ '65%', '60%' ],
//			roseType : rose,																								
            gridSize: 2,
            sizeRange: [12, 50],
            rotationRange: [-90, 90],
            shape: 'pentagon',
            width: 600,
            height: 400,
            drawOutOfBound: true,
            textStyle: {
                normal: {
                    color: function () {
                        return 'rgb(' + [
                            Math.round(Math.random() * 160),
                            Math.round(Math.random() * 160),
                            Math.round(Math.random() * 160)
                        ].join(',') + ')';
                    }
                },
                emphasis: {
                    shadowBlur: 10,
                    shadowColor: '#333'
                }
            },
            data : pieDataList		
		} ]
	});
//	alert("_generateCloudChart.............");
}

function fun(){}
/*
$("[name='leftSectionItem']").live('click',function () {
	$('#searchType').val("1");
	var item_value=$(this).html();
	item_value = item_value.split("(")[0];
	var secondexp = $(this).parent().parent().attr("alt") + "=" + item_value;
	params.secondsearchexp=secondexp;
//alert(params.secondsearchexp);
	requestExpData(params);
});
*/
function showLeftSection(map){
	$('#searchType').val("0");
	
	var RecordCount = $('#RecordCount').val();
//	alert("RecordCount="+RecordCount);
//	num.toFixed(2)
	
	params.xAxis="PATTYPE";
	var content = "";	
	for(key in map){
//alert(key+"="+map[key]);
		content += 
		'<div name="leftSectionItem" style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
			'<label class="checkbox" style="width:250px;font-size:12px;overflow: hidden;"><input type="checkbox" value="'+key+'">'+key+'（'+map[key]+"/"+(100*(map[key]/RecordCount)).toFixed(2)+'%）</label>'+
		'</div>';
/*
		content += 
		'<div name="leftSectionItem" style="font-size:13px;padding-left:18px; color: #666; padding-top: 6px; background-color: #fff;margin-bottom: 1px;">'+
			key+'('+map[key]+')'+
		'</div>';
*/
	}	
	return content;
}

function showOverviewSection(no,map){
//	alert($("#collapseTwo").css('display'));
//	var content = showLeftSection(map);
//	alert(content);	
	$('#collapse_'+no).html(showLeftSection(map));
//	$("#collapseTwo").css('display','block');
}
/*
function showOverviewPattypeSection(map){
//	alert($("#collapseTwo").css('display'));
//	var content = showLeftSection(map);
//	alert(content);	
	$('#collapse_1').html(showLeftSection(map));
//	$("#collapseTwo").css('display','block');
}

function showOverviewFlztSection(map){
//	alert($("#collapseTwo").css('display'));
//	var content = showLeftSection(map);
//	alert(content);
	$('#collapse_2').html(showLeftSection(map));
//	$("#collapseTwo").css('display','block');
}
function showOverviewPDyearSection(map){
//	var content = showLeftSection(map);
	$('#collapse_3').html(showLeftSection(map));	
}
function showOverviewApplicantSection(map){
//	var content = showLeftSection(map);
	$('#collapse_4').html(showLeftSection(map));	
}
function showOverviewInventorSection(map){
//	var content = showLeftSection(map);	
	$('#collapse_5').html(showLeftSection(map));	
}

function showOverviewIPCxiaoleiSection(map){
//	var content = showLeftSection(map);	
	$('#collapse_6').html(showLeftSection(map));	
}
function showOverviewIPCbuSection(map){
//	var content = showLeftSection(map);	
	$('#collapse_7').html(showLeftSection(map));	
}
*/
function downloadPDF() {
//alert("downloadPDF....");	
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
//			_sic += "<a href=\"javascript:findIpc(\'"+arrSic[i]+"\');\">"+arrSic[i]+"</a>";
			_sic += arrSic[i]+";";
		};		
		var _pa = "";
		    _pa = this.pa;
		/*
		var arrPa = this.pa.split(";");
		for (var i = 0; i <= arrPa.length-1; i++) {
//			_pa += "<a href=\"javascript:findAppName(\'"+arrPa[i]+"\');\">"+arrPa[i]+"</a>";
			_pa += arrPa[i];
		};
		*/

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


if(patentInfo.sectionName.indexOf("patent")>-1) {
	text = text + '[' + patentInfo.acceptArea+']';
}else{
	text = text + '[' + showchannel(channelinfojson, patentInfo.sectionName)+']';
}

text = text + '<a style="cursor: pointer;" onclick="javascript:getDetail(\''+patentInfo.id+"\',\'"+patentInfo.sectionName+'\')">'+patentInfo.ti+' ('+patentInfo.an+') </a>';

text = text + "<span id=\"ti_en_"+index+"\"></span>";

text = text + '</strong>';

//text = text + "<span>"+$("#translate").val()+"---"+patentInfo.sectionName+"</span>";
//$("#detailSearchForm #index").val(pageIndex-1);
if(
//		$("#translate").val()==="1"&&
		patentInfo.sectionName.indexOf("patent")>-1) {
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

if(patentInfo.score!='0'){
	text = text + '&nbsp;<span class=\"label label-warning\">语义值：'+Math.round(patentInfo.score)+'</span>';	
}


text = text + '</label></span>';

text = text + '</div>';

text = text + '<div class="row-fluid">';

if(patentInfo.estype!="wgzl_ab"){
	text = text + '<div class="span9" style="padding-left:20px; font-size: 12px;">';
}else{
	text = text + '<div class="span12" style="padding-left:20px; font-size: 12px;">';
}

//text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <a href="javascript:findPubNum(\''+patentInfo.pnm+'\');\">'+patentInfo.pnm+'</a></span>';

var showBase64=$("#ShowBase64").val();
//alert(showBase64=="1");
//alert(showBase64==1);

//Math.random()
if((showBase64=="1"||showBase64==1)&&Math.random()>0.5){
	text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <img src="data:image/png;base64,'+patentInfo.pnmbase64+'"/></span>';
}else{
	text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <font class="my_color">'+patentInfo.pnm+'</font></span>';
}

//text = text + '<span class="p-inline">申请日：<a href="javascript:findAppDate(\''+patentInfo.ad+'\');\">'+patentInfo.ad+'</a></span></div>';


if((showBase64=="1"||showBase64==1)&&Math.random()>0.5){
	text = text + '<span class="p-inline">申请日： <img src="data:image/png;base64,'+patentInfo.adbase64+'"/></span></div>';
}else{
	text = text + '<span class="p-inline">申请日：<font class="my_color">'+patentInfo.ad+'</font></span></div>';
}


//text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）日：<a href="javascript:findPubDate(\''+patentInfo.pd+'\');\">'+patentInfo.pd+'</a></span>';


if((showBase64=="1"||showBase64==1)&&Math.random()>0.5){
	text = text + '<div class="row-fluid" style="width:680px;overflow:hidden;"><span class="p-inline">公开（公告）日：<img src="data:image/png;base64,'+patentInfo.pdbase64+'"/></span>';
}else{
	text = text + '<div class="row-fluid" style="width:680px;overflow:hidden;"><span class="p-inline">公开（公告）日：<font class="my_color">'+patentInfo.pd+'</font></span>';
}



if((showBase64=="1"||showBase64==1)&&(patentInfo.sic==patentInfo.pic)){
	text = text + '<span class="p-inline">分类号：<img src="data:image/png;base64,'+patentInfo.sicbase64+'"/></span></div>';
}else{
	text = text + '<span class="p-inline">分类号：<font class="my_color">'+_sic+'</font></span></div>';
}


text = text + '<div class="row-fluid"><span class="p-inline"> 申请（专利权）人：<font class="my_color">'+_pa+'</font></span></div>';
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
	
	if(pageindex<=30){
		params.currentPage=pageindex;
		requestExpData(params);		
		kkpager.selectPage(pageindex);
	}else{
		showexp("游客模式仅能浏览30页，如有需要请拨打4001880860");		
	}
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

function fenye(currentPage){
	var text = "";	
//alert("currentPage="+currentPage);
//alert("recordCount="+recordCount);

	var recordCount = $('#RecordCount').val();
	
	var totalpageCount=0;
	var pagerecord = $('#selpagerecord').val();

	if(recordCount%10>0){
		totalpageCount=Math.floor(recordCount/pagerecord)+1;
	}else{
		totalpageCount=Math.floor(recordCount/pagerecord);
	}
	
//alert("totalpageCount="+totalpageCount);

		if (currentPage == 1) {
//			text = text + '<li><a href="#"> <span class="icon-step-backward"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-left" ></span> </a></li>';
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="#"> 上一页 </a></li>';
		} else {
//			text = text + '<li><a href="javascript:nextPage(1)" target="_self"> <span class="icon-step-backward"></span> </a></li>';
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) - 1) +  ')" target="_self"> 上一页 </a></li>';
		}

//		text = text + '<li style="color: #fff;margin-top:8px;"><input type="text" onKeyDown="if(event.keyCode==13) return false;" style="width: 50px; height: 19px; margin-top:-1px;; line-height: 15px; padding: 0px" value="'+currentPage+'" id="pageEnterBtn"><span><input type="button" class="btn btn-mini" style="margin-top:-1px;" onClick="javascript:gotoPage('+totalpageCount+');" name="sub" value="GO">'+totalpageCount+'</span></li>';
		text = text + '<li style="color: #fff;margin-top:10px;">'+currentPage+'/'+totalpageCount+'</li>';
		
		if (currentPage == totalpageCount) {
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="#"> 下一页 </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-step-forward"></span> </a></li>';
		} else {
			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> 下一页 </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ totalpageCount +  ')" target="_self"> <span class="icon-step-forward"></span> </a></li>';
		}
		
		//alert("text="+text);
		$('#pageinfo').html(text);
}

function gotoPage(totalpageCount) {
	var page = document.getElementById("pageEnterBtn").value;
	var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字//判断正整数    

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
	$('#db-mult-text').val("");
//	$("#optionsRadios1").attr("checked");
	$("#optionsRadios1").attr("checked","checked");
	
	var dbs = $("#strSources").val();
	if(dbs.indexOf("patent")>-1){
		$("#cn_secondsearch_item").hide();
		$("#fr_secondsearch_item").show();
	}else{
		$("#cn_secondsearch_item").show();
		$("#fr_secondsearch_item").hide();
	}
	
	$("#db-search-modal").modal('show');
}

function dbSearchNodeData() {
//alert("5555");
	var inText = $('#db-mult-text').val();

	var searchType_operator = $('input:radio[name="searchType"]:checked').val();
//	alert("searchType_operator = "+searchType_operator);
//	alert(params.secondsearchexp);
	if(typeof(params.secondsearchexp)=="undefined"){
		params.secondsearchexp="";
	}
//alert(params.secondsearchexp);
//alert("inText="+inText);

	if(inText!=null && inText!=""){
//params.strWhere = params.strWhere + " " + searchType_operator + " " + inText;
//params.secondsearchexp = params.secondsearchexp + ";" + searchType_operator + " " + inText;
		/*
		if(params.secondsearchexp!=null&&params.secondsearchexp!=""){
			params.secondsearchexp += ";";
		}
		*/
		/*
		if(str.indexOf(" ")==-1){
			params.secondsearchexp += searchType_operator + " " + inText;
		}else{
			params.secondsearchexp += searchType_operator + " '" + inText + "'";
		}*/
//		params.secondsearchexp += searchType_operator + " " + inText;
		
//		alert(params.secondsearchexp);	
//		pre_renderfilter(item,content," and ");
		pre_2_renderfilter(" "+searchType_operator + " " + inText);
//		pre_renderfilter(item,inText," "+searchType_operator + " ");
		params.filterexp=$('#filterexp').val();
	}	
	/*
	if(params.quadraticText!=null && params.quadraticText!=""){
		params.quadraticText += inText;
	}else{
		params.quadraticText = inText;
	}
	*/
//alert("params.secondsearchexp="+params.secondsearchexp);
//二次检索字段备份表达式
//params.cacheQuadraticText +=inText;
	
//$('#strWhere').val(params.strWhere);
//$('#searchType').val("1");
	params.currentPage = "1";
	$("#db-search-modal").modal('hide');
	$('body').mask('加载中...');
	$('#overViewDiv').html('');
	$('#searchType').val("1");
	requestExpData(params);
}

function Download() {
//alert($('#area').val());
//alert(params.language);
	var patentList = getPatentList();
//alert("patentList="+patentList);
	if(patentList == null||patentList=="")
	{
		showexp("请先选择要下载文摘的记录。");
    	return;
  	}
  	else
	{
//if($('#area').val()==='cn'){
		if(params.language==='cn'){
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

//	alert($('#area').val());
	var area = "<%=area%>";
			
//alert(checkedItems);
	if(area==='cn'){
		
		$("#downloadTableInfo input[name='downloadColumn']").each(
				function() {
//					alert($(this).attr("checked"));
					if ($(this).attr("checked")=='checked'&&(","+checkedItems+",").indexOf("," + $(this).val() + ",")<0) {						
//						alert(checkedItems+"----"+$(this).val());
						checkedItems += $(this).val() + ",";
					}
				})
	}else{
		
		$("#frdownloadTableInfo input[name='downloadColumn']").each(
				function() {
//					alert($(this).attr("checked"));
					if ($(this).attr("checked")=='checked'&&(","+checkedItems+",").indexOf("," + $(this).val() + ",")<0) {
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
//			'filterChannel' : params.filterChannel,
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
	
//	alert($('#selectexp').val());
//	alert($('#selectdbs').val());

//alert($('#currentexp').val());
	
	var _totalRecord = $("#unfilterTotalCount").val();
	
	if(_totalRecord>5000000){
		showexp("分析数据超过上限500万条专利，请缩小分析范围，重新进行分析。");
	}else{
		var language = params.language;
//		alert("language="+language);
//		newWinUrl("analyse.do?language="+language);		
//		$("#analyse #strWhere").val($('#strWhere').val());
		$("#analyse #strWhere").val($('#currentexp').val());
		$("#analyse #strSources").val($('#strSources').val());
//		$("#analyse #filterexp").val(params.filterexp);
		
		$("#analyse").attr('action',"analyse.do?language="+language);
		$("#analyse").submit();
	}	
});

function reporter(){
	var exp=$('#currentexp').val();
	$("#repor #strWhere").val($('#currentexp').val());
	$("#repor").submit();
}

function _download2000(){
//$(".dropmenu").unbind("click");
//$(".dropmenu").hide();
//$(".dropmenu").show();
//alert("_download2000");

	var begin=$("#_begin").val();
	var end=$("#_end").val();
	var ABSTBatchCount=$("#ABSTBatchCount").val();
	
//	alert("ABSTBatchCount="+ABSTBatchCount);
	
	var reg = new RegExp("^[0-9]*$");
	
/*
	if(!reg.test(begin)||!reg.test(end)){
		showexp("输入件数错误，请重新输入！");
		return false;
	}else if(begin <= 0 || end <= 0){
		showexp("请输入大于0的数字！");
		return false;
	}else if((end-begin)<0){
		showexp("结束标记应大于开始标记！");
		return false;
	}else if((end-begin)>ABSTBatchCount){
		showexp("您所在的权限组，每次下载仅限 "+ABSTBatchCount+" 件专利著录项！");
		return false;
	}
*/
//	alert("batchdownload....."+ABSTBatchCount);

	if(!reg.test(begin)||!reg.test(end)){
		showexp("输入件数错误，请重新输入！");
		return false;
	}else if(begin <= 0 || end <= 0){
		showexp("请输入大于0的数字！");
		return false;
	}else if((end-begin)<0){
		showexp("结束标记应大于开始标记！");
		return false;
	}	
	else if((end-begin)>ABSTBatchCount){
		showexp("您所在的权限组，每次下载仅限 "+ABSTBatchCount+" 件专利著录项！");
		return false;
	}	
	else{
//		alert("batchdownload.....11111111");	
		var checkedItems = "";
		
		if(params.language==='cn'){
			$("#downloadBatchTableInfo input[name='downloadColumn']").each(
					function() {
						if ($(this).attr("checked")=='checked') {
							if((","+checkedItems).indexOf(","+$(this).val() + ",")===-1){
								checkedItems += $(this).val() + ",";
							}							
						}
					});
		}else{
			$("#frdownloadBatchTableInfo input[name='downloadColumn']").each(
					function() {
						if ($(this).attr("checked")=='checked') {
//							checkedItems += $(this).val() + ",";
							if((","+checkedItems).indexOf(","+$(this).val() + ",")===-1){
								checkedItems += $(this).val() + ",";
							}							
						}
			});
		}
		
//alert("checkedItems="+checkedItems);
		
		if (checkedItems != "") {
			checkedItems = checkedItems.substring(0, checkedItems.length - 1);
//alert(checkedItems);
//alert(params.strWhere);
//alert(params.strSources);

			//var where =document.searchForm.strWhere.value;
			//var source = document.searchForm.strSources.value;
//			var strSortMethod=document.searchForm.strSortMethod.value;
//			var option=document.searchForm.option.value;

//			var iHitPointType=document.searchForm.iHitPointType.value;
//			var filterChannel=document.searchForm.filterChannel.value;
//			var strSynonymous=document.searchForm.strSynonymous.value;
			
			var downloadStart = begin;
			var downloadAmount = (end-begin)+1;

$("body").mask("正在生成下载文件，请稍候...");

//$("#downloadBatchModal").modal("hide");
/*
alert(where);
alert(source);
alert(strSortMethod);
alert(iHitPointType);
alert(filterChannel);
alert(strSynonymous);
alert(downloadStart);
alert(downloadAmount);
*/
//alert("params.strSources="+params.strSources);

//strSources
//strWhere
//alert($('#currentexp').val());

//alert($("#strWhere").val());
//alert($("#strSources").val());

//$('#expression').html($.trim($('#strWhere').val()));

		$.ajax({
//			url : ctx + '/downloadTIFFZip.do',
			url : '<%=basePath%>createAbstractZip.do',
			type : 'POST',
			data : {
				'area' : '<%=area%>',
				'strWhere' : $('#currentexp').val(),
				'strSources' : $("#strSources").val(),
				'downtype' : 0,
				'downloadcol' :  checkedItems,
				'searchType' : 2,
//				'strSortMethod' : strSortMethod,
//				'iHitPointType' : iHitPointType,
//				'filterChannel' : filterChannel,
//				'strSynonymous' : strSynonymous,
//				'searchType':2,
				'xAxis' : '',
				'isbatchdownload' : 1,
				'downloadStart' : downloadStart,
				'downloadAmount' : downloadAmount
			},
			success : function(jsonresult) {
				$("body").unmask();
//				alert(jsonresult);

				$.dialog({
					id : 'winlogin',
					bgcolor : '#FFF',				
					title : '下载',
					max : false,
					min : false,
					content : '<div style="line-height:22px;">资源获取成功，<a href='
						+ '<%=basePath%>downloadZipfile.do?fileName=' + jsonresult
						+ '>[这里]</a>进行下载 !</div>'
				});

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
}
//伪装一下表单提交在新窗口
function newWinUrl(url){
//alert(url);
//alert(params.filterChannel);
//alert(document.searchForm.strWhere.value);
//alert(document.searchForm.strSources.value);
//$('#strWhere').val(treeNode.cnTrsExp);
//$('#strSources').val(treeNode.cnTrsTable);
//alert($('#strSources').val());
    var f=document.createElement("form");
    
    var exp =document.createElement("input");
    exp.id = "strWhere";
    exp.name = "strWhere";
    exp.type = "hidden";
//exp.value = document.searchForm.strWhere.value;
	exp.value = $('#strWhere').val();
    
    var dbs =document.createElement("input");
    dbs.id = "strSources";
    dbs.name = "strSources";
    dbs.type = "hidden";
//dbs.value = document.searchForm.strSources.value;
    dbs.value = $('#strSources').val();
//dbs.value = "5555";
//alert(dbs.value);
    /*
    var filterChannel = params.filterChannel;
    if(filterChannel!=''){
    	dbs.value = filterChannel;
    }
    */
    f.appendChild(exp);
    f.appendChild(dbs);    
    
    f.setAttribute("action" , url );
    f.setAttribute("method" , 'post' );
    f.setAttribute("target" , '_black' );
    document.body.appendChild(f)
    
    f.submit();
}
</script>

<form id="analyse" name="analyse" action="" method="post" target="_blank">
	<input type="hidden" name="strWhere" id="strWhere" value="">
	<input type="hidden" name="strSources" id="strSources" value="">
	<input type="hidden" name="filterexp" id="filterexp" value="">	
</form>

<form id="repor" name="repor" action="ReporterServlet" method="post" target="_blank">
	<input type="hidden" name="strWhere" id="strWhere" value="">
	<input type="hidden" name="nodeId" id="nodeId" value="">
</form>

<form id="showDetail" name="showDetail" action="<%=basePath%>detailSearch.do?method=detailSearch" method="post" target="_blank">
	<input type="hidden" name="strWhere" id="strWhere" value="">
	<input type="hidden" id="area" name="area">
	<input type="hidden" name="strSources" id="strSources" value="">
</form>

<%@ include file="include-downloadmodal.jsp"%>
<%@ include file="include-jieguo-leftmenu-js.jsp"%>