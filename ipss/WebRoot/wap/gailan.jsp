<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="include-head.jsp"%>

	<title>检索概览-<%=website_title%></title>
	
	<script type="text/javascript" src="<%=basePath%>common/com_2/js/jquery.js"></script>	 
	<script type="text/javascript" src="<%=basePath%>common/com_2/js/common.js"></script>
	<script type="text/javascript" src="<%=basePath%>common/mask/mask.js"></script>
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
	<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
	
<script type="text/javascript">
function showexp(exp){
	var html1 =
		"<div style='max-width:800px;line-height:22px;word-break:break-all;word-wrap:break-word;'>"
		+ exp
		+ "</div>"
	$.dialog({
		title:'提示',
		max:false,
		min:false,
		lock: true,
		content: html1
	});
}
</script>
	
</head>
<body>

<input type="hidden" id="strWhere"/>
<input type="hidden" id="strSources"/>
<input type="hidden" id="searchType"/>
<input type="hidden" id="RecordCount"/>

<%  
response.setHeader("X-XSS-Protection","0");
response.setCharacterEncoding("UTF-8");

String area = request.getParameter("area")==null?(String)request.getAttribute("area"):request.getParameter("area");
area = area==null?"cn":area;

String strWhere = request.getParameter("strWhere");
String strSources = request.getParameter("strSources");

//System.out.println("strWhere="+strWhere);
//System.out.println("strSources="+strSources);

//request.setAttribute("totalRecord", totalRecord);
long totalRecord = 0L;
long currentRecord = 0L;
%>
<script language="javascript">
var params = {};
var isLoading = false;

$(function() {
	$('#strWhere').val("<%=strWhere%>");
	$('#strSources').val("<%=strSources%>");
	
//alert($('#strWhere').val());
//alert($('#selectdbs').val());
//alert($('#treeType').val());

//alert($('#selectexp').val()===null);
//alert($('#selectexp').val()==="null");
	
	params.language="cn";
	params.sortMethod='-公开（公告）日';
	params.currentPage=1;
	params.totalPages=0;
	params.xAxis="";
	params.strWhere=$('#strWhere').val();
	params.strSources=$('#strSources').val();
	
	$('#searchType').val("1");	
//alert($('#treeType').val());
	requestExpData(params);
});

function requestExpData(params) {
//alert($('#area').val());
//alert($('#strWhere').val());
//alert($('#strSources').val());

//alert("params.xAxis="+params.xAxis);
//alert(params.secondsearchexp);

//alert("secondsearchexp="+params.secondsearchexp);
//clearexp();
//$('#currentPage').val(params.currentPage);
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
	
	$.ajax({
		type : "GET",
		url : "toJsonOverView.do?timeStamp=" + new Date(),
		//url : "/toJsonOverView.do",
		data : {			
			'searchType' : searchType,
			'strWhere' : params.strWhere,
//			'semanticexp' : params.semanticexp,
//			'secondsearchexp' : encodeURIComponent(params.secondsearchexp),
//			'secondsearchexp' : params.secondsearchexp,
//params.secondsearchexp
			'strSortMethod' : params.strSortMethod,
			'strSources' : params.strSources,			
//			'filterChannel' : params.filterChannel,
			'pagerecord' : params.pagerecord,
			'currentPage' : params.currentPage,
			'wap' : 1,
			'language' : 'cn'
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
			if (jsonresult!=null&&jsonresult!="") {
//				alert(jsonresult);
				processJsonresult(jsonresult,searchType,params.currentPage);
			}else{
				//$('#top-navbar').hide();
				//$('#overViewDiv').hide();				
				//$("#expcontent").hide();//表示display:block
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

function getDetail(index){
//	alert("index="+index);
//    document.showDetail.strWhere.value = "id="+index;		
	var strWhere = "id="+index;
	var strSources = $('#strSources').val();
//	strWhere = escape(strWhere);
				
//	strWhere=encodeURI(strWhere);
//	strWhere=encodeURI(strWhere);
		
	document.showDetail.action = "<%=basePath%>wapdetailSearch.do?wap=1&strSources="+strSources+"&strWhere="+strWhere+"&index="+index;
//	alert("getDetail.....");	
	document.showDetail.submit();
}

function processJsonresult(jsonresult,searchType,pageindex){
//alert(jsonresult);
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
//alert("strWhere="+strWhere);
//alert("RecordCount="+RecordCount);
			URLEncoderWhere = result.URLEncoderWhere;
			SecurityCode = result.SecurityCode;			
		})

//		$('#chkall').attr("checked", false);

		var _RecordCount = parseInt(RecordCount);
		if(_RecordCount>0){
//alert(SecurityCode);
//alert(URLEncoderWhere);
			
			$("#RecordCount").val(RecordCount);			
			$("#totalRecord").html("全部（"+RecordCount+"）条");
//			initPager();
			$('#overViewDiv').show();
							
//							alert("params.currentPage="+params.currentPage);
//							alert("RecordCount="+RecordCount);
							
//							alert(patentInfoList!='');
							if(patentInfoList!=''){
								fenye(params.currentPage);
								showPatentInfo(patentInfoList, channelInfo);
							}

						}else{
//							showexp("此次检索无结果");
//							$('#overViewDiv').hide();
							var text='<div class="container dantiao">此次检索无结果</div>';
							$('#overViewDiv').html(text);
							$('#RecordCount').val("0");
							fenye(0);							
						}
}

function fenye(currentPage){
	var text = "";	
//alert("currentPage="+currentPage);
//alert("recordCount="+recordCount);

	var recordCount = $('#RecordCount').val();
	
	var totalpageCount=0;
	var pagerecord = 10;

	if(recordCount%10>0){
		totalpageCount=Math.floor(recordCount/pagerecord)+1;
	}else{
		totalpageCount=Math.floor(recordCount/pagerecord);
	}
	
//alert("totalpageCount="+totalpageCount);

		if (currentPage == 1) {
//			text = text + '<li><a href="#"> <span class="icon-step-backward"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-left" ></span> </a></li>';
			text = text + '<input class="btn btn-default" name="FirstPage" type="button" value="上一页 ">';
		} else {
			text = text + '<input class="btn btn-default" name="FirstPage" type="button" value="上一页 " onclick="javascript:nextPage('+ (parseInt(currentPage) - 1) +  ')">';
//			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) - 1) +  ')" target="_self"> 上一页 </a></li>';
		}

//		text = text + '<li style="color: #fff;margin-top:8px;"><input type="text" onKeyDown="if(event.keyCode==13) return false;" style="width: 50px; height: 19px; margin-top:-1px;; line-height: 15px; padding: 0px" value="'+currentPage+'" id="pageEnterBtn"><span><input type="button" class="btn btn-mini" style="margin-top:-1px;" onClick="javascript:gotoPage('+totalpageCount+');" name="sub" value="GO">'+totalpageCount+'</span></li>';
		text = text + ''+currentPage+'/'+totalpageCount+'';
		
		if (currentPage == totalpageCount) {
//			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="#"> 下一页 </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="#"> <span class="icon-step-forward"></span> </a></li>';
			text = text + '<input class="btn btn-default" name="FirstPage" type="button" value="下一页 ">';
		} else {
//			text = text + '<li><a style="background-image: none;background:none;border: 0px;font-weight: normal;color:#fff;font-size:13px;" href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> 下一页 </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')" target="_self"> <span class="icon-chevron-right"></span> </a></li>';
//			text = text + '<li><a href="javascript:nextPage('+ totalpageCount +  ')" target="_self"> <span class="icon-step-forward"></span> </a></li>';
			text = text + '<input class="btn btn-default" name="FirstPage" type="button" value="下一页 " onclick="javascript:nextPage('+ (parseInt(currentPage) + 1) +  ')">';
		}
		
		//alert("text="+text);
		$('#pageinfo').html(text);
}

function nextPage(pageindex){
//	$('#searchType').val("2");
	params.xAxis="";
	params.currentPage=pageindex;
	requestExpData(params);
}

function getPatentByChannel(sectionName){
	if(sectionName==='fmzl_ft'){
		sectionName="发明公布";
	}else if(sectionName==='fmsq_ft'){
		sectionName="发明授权";
	}else if(sectionName==='syxx_ft'){
		sectionName="实用新型";
	}else if(sectionName==='wgzl_ab'){
		sectionName="外观专利";
	}
	return sectionName;
}

function showPatentInfo(patentInfoList,channelinfojson) {
	var text = "";
//ctx = '${pageContext.request.contextPath}';
//alert(channelinfojson);
	$.each(patentInfoList,function(index,patentInfo) {
		
		text += '<div class="container dantiao">';
		text += '<div class="row"><div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;border-left:0;"></div></div>';
		text += '<div class="row"><div class="col-xs-12"><a onClick="javascript:getDetail(\''+patentInfo.id+'\')">'+patentInfo.ti+'('+patentInfo.an+')</a><span class="label label-info">'+getPatentByChannel(patentInfo.sectionName)+'</span>';

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

		text += '</div></div>';
		
		text += '<div class="row">';
		text += '<div class="col-xs-12">申请（专利权）人：';
		text += '<a href="#">'+patentInfo.pa+'</a>';
		text += '</div></div>';
		
		text += '<div class="row">';
		text += '<div class="col-xs-12">公开（公告）日：'+patentInfo.pd+'</a></div>';
		text += '</div>';
		text += '<div class="row">';
		text += '<div class="col-xs-12">摘要：'+patentInfo.ab+'</div>';
		text += '</div>';
		text += '</div>';
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	});

	$('#overViewDiv').html(text);
}
</script>
<div style="height:40px;"></div>

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
<!--筛选结果-->
<div class="container" style="margin-top: 30px;">
	<div class="row">
		<!--<div class="dropdown col-xs-4">
	   <button type="button" class="btn btn-sm btn-warning dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">
		筛选结果
		<span class="caret"></span>
	  </button> 
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
			<li role="presentation">
				<a role="menuitem" tabindex="-1" href="#">全部(<%=totalRecord%>)条</a>
			</li>
		</ul>
         </div>
         -->
		<div class="col-xs-12" style="line-height: 30px;" id="totalRecord">
			
		</div>
	</div>
</div>
<div id="overViewDiv"></div>


<!--下一页-->
<div class="container" style="line-height:40px;margin-top:10px;">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<center id="pageinfo">

	</center>
	<div style="height:40px;"></div>
</div>



<form id="showDetail" name="showDetail"
			action="<%=basePath%>wapdetailSearch.do?method=detailSearch" method="post"
			target="_self">
	<input type="hidden" id="strWhere" name="strWhere">
	<input type="hidden" id="strSources" name="strSources">
	<input type="hidden" id="area" name="area" value="<%=area%>">			
</form>

<%@ include file="include-bottom.jsp"%>


	</body>
</html>
