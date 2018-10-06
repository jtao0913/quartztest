<%@ page language="java" pageEncoding="UTF-8"%>

<script type="text/javascript" src="<%=basePath%>js/kkpager.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/kkpager_blue.css" />
	
<input type="hidden" id="RecordCount" value="" />
<input type="hidden" id="selpagerecord" value="10" />
<input type="hidden" id="secondwhere" />


<div style="width: 800px; height: 600px; overflow: scroll;"
	class="modal hide fade" id="analysejieguoModal1" tabindex="1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header mycolor"
				style="padding: 0px 15px; margin-top: 20px; background-color: #fff; color: #666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%>
				</h4>
			</div>

			<div id="kkpager1"></div>
			<div id="overViewDiv1"></div>			
			
		</div>
	</div>
</div>


<!-- 模态框（Modal） -->
<div class="modal fade" id="analysejieguoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">		
		
			<div id="kkpager"></div>
			<div id="overViewDiv"></div>			
			
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
	

<script>
$(function(){
	//alert("555555");
});

function second_search(xAxis,yAxis) {
//alert(xAxis);
//alert(yAxis);	
$("#kkpager").html("");
//return;
		var where = "<%=exp%>";
	//alert(where);
		var xAxisName = $("#searchForm #xAxisName").val();
	//alert(xAxisName);
		var yAxisName = $("#searchForm #yAxisName").val();
	//alert(yAxisName);

		if(xAxisName==='省市')
		{
			xAxisName="国省";
		}
		if(yAxisName==='省市')
		{
			yAxisName="国省";
		}		
		
		if(xAxisName==='专利类型')
		{
			xAxis = zllx(xAxis);
		}
		if(yAxisName==='专利类型')
		{
			yAxis = zllx(yAxis);
		}
		if(xAxisName==='国民经济大类')
		{
			xAxis = getGmjj(xAxis);
		}
		if(yAxisName==='国民经济大类')
		{
			yAxis = getGmjj(yAxis);
		}
		var x = xAxisName + "=('" +xAxis+"')";
		var y = yAxisName + "=('" + yAxis+"')";
		
		//alert(x);
		//alert(y);
		
		var reg = new RegExp(" +","g");//g,表示全部替换
		var reg1 = new RegExp("[#]+","g");
		
		if(xAxisName==='第一申请人'||xAxisName==='申请人'||xAxisName==='第一发明人'||xAxisName==='发明人'){
//			a.replace(reg,"-");
			x = xAxisName + "=('" +xAxis.replace(reg,"#")+"')";
			x = x.replace(reg1,"#");
		}
		if(yAxisName==='第一申请人'||yAxisName==='申请人'||yAxisName==='第一发明人'||yAxisName==='发明人'){
			y = yAxisName + "=('" +yAxis.replace(reg,"#")+"')";
			y = y.replace(reg1,"#");
		}
	/*
		if(xAxisName==='第一申请人'||xAxisName==='申请人'||xAxisName==='第一发明人'||xAxisName==='发明人'){
			x = xAxisName + "=('" +xAxis.replace(" ","&nbsp;")+"')";
		}
		if(yAxisName==='第一申请人'||yAxisName==='申请人'||yAxisName==='第一发明人'||yAxisName==='发明人'){
			y = yAxisName + "=('" +yAxis.replace(" ","&nbsp;")+"')";
		}
	*/
	//alert("xAxisName="+xAxisName);
	//alert("yAxisName="+yAxisName);

	//alert("x="+x);
	//alert("y="+y);

//		if(y==='公开年=公开年'){
		if(yAxisName===yAxis&&yAxisName==='公开年'){
			x='公开年='+xAxis;
			where = "("+where + ") and " + x ;
		}else if(yAxis===''){
			where = "("+where + ") and " + x ;
		}else{
			where = "("+where + ") and " + x + " and " + y;
			where = where.replace("and 公开年=申请年","");
			where = where.replace("and 公开年=('申请年')","");
		}

		$("#secondwhere").val(where);
		requestExpData(1);
}

function requestExpData(pageindex){

	var where = $("#secondwhere").val();
	
		$.ajax({
			type : "GET",
			url : "toJsonOverView.do?timeStamp=" + new Date(),
			//url : "/toJsonOverView.do",
			data : {			
				'searchType' : '2',
				'treeType' : '-1',
				'xAxis' : '',
				'nodeId' : '',
				'selectexp' : where,
				'selectdbs' : '<%=dbs%>',
				'pagerecord' : 10,
				'currentPage' : pageindex,
				'language' : 'cn'
			},
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
				if (jsonresult != null&&jsonresult != "") {					
//					alert(jsonresult);
					processJsonresult(jsonresult);
				}else{
					showexp("此次检索无结果，请检查检索表达式");
				}

//				$('body').unmask();
			}
		});
	}
	
function processJsonresult(jsonresult){
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
			unfilterTotalCount = result.overviewResponse.unfilterTotalCount;
			RecordCount = result.RecordCount;
//			lastestFlztInfo = result.lastestFlztInfo;
			channelInfo = result.channelInfo;
			strWhere = result.strWhere;			
			URLEncoderWhere = result.URLEncoderWhere;
			SecurityCode = result.SecurityCode;			
		})

		$('#chkall').attr("checked", false);

		if(RecordCount>0){
/*			
			$('#unfilterTotalCount').val(unfilterTotalCount);
			
			$('#resultfilter').html("结果筛选（共"+RecordCount+"件）");
			$('#SecurityCode').val(SecurityCode);
			$('#URLEncoderWhere').val(URLEncoderWhere);
*/
//			alert("RecordCount="+RecordCount);
//			alert(URLEncoderWhere);
			
			$('#RecordCount').val(RecordCount);
			initPager();			
//							$('#overViewDiv').show();
							
//							alert("params.currentPage="+params.currentPage);
//							alert("RecordCount="+RecordCount);
							
//							alert(patentInfoList!='');
							if(patentInfoList!=''){
//								fenye(params.currentPage);
								showPatentInfo(patentInfoList, channelInfo);
							}

						}else{
							showexp("此次检索无结果");
						}
}

function showPatentInfo(patentInfoList,channelinfojson) {
//	alert(patentInfoList);
//	alert(channelinfojson);
	
	var text = "";
//ctx = '${pageContext.request.contextPath}';
//alert(channelinfojson);
	$.each(patentInfoList,function(index,patentInfo) {		
		var _sic = "";
		var arrSic = patentInfo.sic.split(" ");
		for (var i = 0; i <= arrSic.length-1; i++) {
			_sic += "<a href=\"javascript:findIpc(\'"+arrSic[i]+"\');\">"+arrSic[i]+"</a>";
		};		
		
		var _pa = "";
		var arrPa = this.pa.split(";");
		for (var i = 0; i <= arrPa.length-1; i++) {
			_pa += "<a href=\"javascript:findAppName(\'"+arrPa[i]+"\');\">"+arrPa[i]+"</a>";
		};


text = text + '<div class="row-fluid">';
text = text + '<span class="help-inline">';
text = text + '<label style="width: 100%;" class="checkbox">';
text = text + '<span style="font-weight: bold;" id="pindex0"></span>';
/*
text = text + '<input id="ti_'+index+'" title="'+patentInfo.ti+'" name="patent" ';
text = text + ' value="{an:'+patentInfo.an+',sectionName:'+patentInfo.sectionName+',ti:'+patentInfo.ti+',pic:'+patentInfo.pic+',agt:"",countryCode:'+patentInfo.an.substring(0,2)+',tifDistributePath:'+patentInfo.tifDistributePath+',pages:'+patentInfo.pages+',pd:'+patentInfo.pd+',pnm:'+patentInfo.pnm + '}" ';
text = text + ' tifvalue="'+patentInfo.tifDistributePath+','+patentInfo.pages+','+patentInfo.an+ '" ';
//alert("text="+text);
text = text + ' type="checkbox" pnm="'+patentInfo.pnm+'" an="'+patentInfo.an;
text = text + '">';
*/
//text = text + 'type="checkbox" pnm='+this.pnm+' sysid="#'+this.sectionName+'@'+this.pn+'" pid="'+this.sectionName+'@'+this.pn+'" anpn="'+this.an+'|'+this.pn+'" an='+this.an+'>';
//alert(text);
text = text + '<strong style="font-size: 13px;" class="text-info">';
text = text + '['+showchannel(channelinfojson, patentInfo.sectionName)+']';
text = text + '<a style="cursor: pointer;" onclick="javascript:getDetail(\''+patentInfo.id+"\',\'"+patentInfo.sectionName+'\')">'+patentInfo.ti+' ('+patentInfo.an+') </a>';

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
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）号： <a href="javascript:findPubNum(\''+patentInfo.pnm+'\');\">'+patentInfo.pnm+'</a></span>';
text = text + '<span class="p-inline">申请日：<a href="javascript:findAppDate(\''+patentInfo.ad+'\');\">'+patentInfo.ad+'</a></span></div>';
text = text + '<div class="row-fluid"><span class="p-inline">公开（公告）日：<a href="javascript:findPubDate(\''+patentInfo.pd+'\');\">'+patentInfo.pd+'</a></span>';
text = text + '<span class="p-inline">分类号：'+_sic+'</span></div>';

text = text + '<div class="row-fluid"><span class="p-inline"> 申请（专利权）人：'+_pa+'</span></div>';
text = text + '<div style="padding-right: 15px; padding-left:5px;padding-bottom:8px;" class="row-fluid muted">'+patentInfo.ab+'</div>';

text = text + "<div id=\"ab_en_"+index+"\"></div>";
text = text + "</div>";

//alert(patentInfo.an+"-----"+patentInfo.estype);
/*
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
*/

text = text + '</div>';
//alert(text);
	});

	$('#overViewDiv').html(text);
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
</script>
<script type="text/javascript">
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}
//init
function initPager(){
	var RecordCount = $('#RecordCount').val();
	var pagerecord = $('#selpagerecord').val();
	
//	alert(RecordCount+"---"+pagerecord);	
	var totalPage = parseInt(RecordCount/pagerecord);
	
	if(RecordCount%pagerecord>0){
		totalPage=Math.floor(RecordCount/pagerecord)+1;
	}else{
		totalPage=Math.floor(RecordCount/pagerecord);
	}
	
	var totalRecords = RecordCount;
	var pageNo = getParameter('pno');
	if(!pageNo){
		pageNo = 1;
	}
	//生成分页
	//有些参数是可选的，比如lang，若不传有默认值
	kkpager.generPageHtml({
//		pagerid : 'bottompageinfo',
		pno : pageNo,
		//总页码
		total : totalPage,
		//总数据条数
		totalRecords : totalRecords,
		//链接前部
		hrefFormer : 'pager_test',
		isGoPage : false,
		isShowFirstPageBtn : false,
		isShowLastPageBtn : false,
		isShowTotalPage : false,
		isShowCurrPage : false,
		//链接尾部
		hrefLatter : '.html',
		getLink : function(n){
//			alert(n);
			return this.hrefFormer + this.hrefLatter + "?pno="+n;
		},
		/*
		,lang				: {
			firstPageText			: '首页',
			firstPageTipText		: '首页',
			lastPageText			: '尾页',
			lastPageTipText			: '尾页',
			prePageText				: '上一页',
			prePageTipText			: '上一页',
			nextPageText			: '下一页',
			nextPageTipText			: '下一页',
			totalPageBeforeText		: '共',
			totalPageAfterText		: '页',
			currPageBeforeText		: '当前第',
			currPageAfterText		: '页',
			totalInfoSplitStr		: '/',
			totalRecordsBeforeText	: '共',
			totalRecordsAfterText	: '条数据',
			gopageBeforeText		: '&nbsp;转到',
			gopageButtonOkText		: '确定',
			gopageAfterText			: '页',
			buttonTipBeforeText		: '第',
			buttonTipAfterText		: '页'
		}*/		
		mode : 'click',//默认值是link，可选link或者click
		click : function(n){
//			alert(n);
			this.selectPage(n);
			nextPage(n);
//			return false;
		}
	});
}
function nextPage(pageindex){
	requestExpData(pageindex);	
//	kkpager.selectPage(pageindex);
}
</script>