<%@ page language="java" pageEncoding="UTF-8"%>

<%@ include file="include-kkpager.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=basePath%>css/kkpager_blue.css" />

<input type="hidden" id="RecordCount" value="" />
<input type="hidden" id="selpagerecord" value="10" />
<input type="hidden" id="secondwhere" />

<form id="showDetail" name="showDetail" action="<%=basePath%>detailSearch.do?method=detailSearch" method="post" target="_blank">
	<input type="hidden" name="strWhere" id="strWhere" value="">
	<input type="hidden" id="area" name="area">
	<input type="hidden" name="strSources" id="strSources" value="">
</form>

<!-- 模态框（Modal） -->
<div class="modal fade" id="analysejieguoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width:900px;padding:26px;">			
			<div id="overViewDiv" ></div>
			<div id="kkpager"></div>			
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<script>
$(function(){
	//alert("555555");
});
function getGmjj(content){
	var words = content.split('-')
//alert(zl_type);
	var gmjj = words[0]
	if(gmjj.length>1){
		gmjj=gmjj.substring(1);
	}	
	return gmjj;
}
function second_search(xAxis,yAxis) {
//alert(xAxis);
//alert(yAxis);	
//$("#kkpager").html("");

//$("#kkpager").remove();
//new_obj = $("<div id='kkpager'></div>"); 
//$("#overViewDiv").before(new_obj);
//return;
		var where = "<%=exp%>";
//alert(where);
		var xAxisName = $("#searchForm #xAxisName").val();
//alert(xAxisName);
		var yAxisName = $("#searchForm #yAxisName").val();
//alert(yAxisName);

		if(xAxisName==='省市')
		{
			xAxisName="省级行政";
		}
		if(yAxisName==='省市')
		{
			yAxisName="省级行政";
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

//alert(where);
		
		$("#secondwhere").val(where);
		requestExpData(1);
}

function showWordcloudModal(){
	
	$('#wordcloudModal').mask("请等待...");
	$('#wordcloudModal').unmask();
}

function requestExpData(pageindex){
//alert(vm.cnfr);	
	var where = $("#secondwhere").val();
	$('#analysejieguoModal').mask("请等待...");
	
		$.ajax({
			type : "GET",
			url : "toJsonOverView.do?timeStamp=" + new Date(),
			//url : "/toJsonOverView.do",
			data : {			
				'searchType' : '2',
				'treeType' : '-1',
				'xAxis' : '',
				'nodeId' : '',
				'strWhere' : where,
				'strSources' : '<%=dbs%>',
				'pagerecord' : 10,
				'cnfr' :vm.cnfr,
				'currentPage' : pageindex,
				'language' : 'cn'
			},
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
				if (jsonresult != null&&jsonresult != "") {					
//					alert(jsonresult);
					processJsonresult(jsonresult,pageindex);
				}else{
					showexp("此次检索无结果，请检查检索表达式");
				}

//				
			}
		});
		
		$('#analysejieguoModal').unmask();
	}
	
function processJsonresult(jsonresult,pageindex){
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
initPager(pageindex);			
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
//alert(patentInfoList);
//alert(channelinfojson);
	
	var text = "<table class='position_table table table-striped table-bordered' cellpadding='0' cellspacing='0' border='1' style='font-size:11px;'>";
//ctx = '${pageContext.request.contextPath}';
//alert(channelinfojson);
	text += "<tr style='background-color:#e6f2f0;'><td>申请号</td><td>申请日</td><td>申请人</td><td>名称</td><td>专利类型</td><td>状态</td></tr>";
	$.each(patentInfoList,function(index,patentInfo) {
//申请号    申请日   申请人  名称  最新法律状态
//text = text + '['+showchannel(channelinfojson, patentInfo.sectionName)+']';
		text += "<tr>";
		text += "<td style=\"cursor:pointer;color:#3498db;width:15%;\" onclick=\"javascript:getDetail(\'"+patentInfo.id+"\',\'"+patentInfo.sectionName+"\')\">"+patentInfo.an+"</td>";
		text += "<td style=\"width:10%;\" >"+patentInfo.ad+"</td>";
		text += "<td style=\"width:25%;\" >"+patentInfo.pa+"</td>";
		text += "<td style=\"width:30%;\" >"+patentInfo.ti+"</td>";
		text += "<td style=\"width:9%;\" >"+showchannel(channelinfojson, patentInfo.sectionName)+"</td>";
		text += "<td style=\"width:9%;\" >"+patentInfo.flzt+"</td>";
		text += "</tr>";		
//alert(text);
	});
	text = text + '</table>';

	$('#overViewDiv').html(text);
}

function getDetail(index,sectionname){
//alert("index="+index);
//alert("sectionname="+sectionname);
    document.showDetail.area.value = "<%=area%>";
    document.showDetail.strWhere.value = "id="+index;//escape(params.selectexp);    
    document.showDetail.strSources.value = sectionname;   
    document.showDetail.submit();
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
/*
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}
function initPager(pageindex){
//	alert("initPager......")	
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
//	var pageNo = getParameter('pno');
	var pageNo = pageindex;
	
//	alert("pageNo="+pageNo)
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
		mode : 'click',//默认值是link，可选link或者click
		click : function(n){
//			alert(n);
//			this.config.pno=pageNo;
			//总页码
//			this.config.total=totalPage;
			//总数据条数
//			this.config.totalRecords=totalRecords;
			this.selectPage(n);
			nextPage(n);
			return false;
		}
	},true);
}
*/
function nextPage(pageindex){
	requestExpData(pageindex);	
//	kkpager.selectPage(pageindex);
}
</script>