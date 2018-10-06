<%@ page language="java" pageEncoding="UTF-8"%>

<script type="text/javascript">
var expList = [];
var expList2 = [];
var secondsearchexp = [];
var params = {};
var area = '<%=area%>';
var currentPage = 1;

$(function() {
	$('#strWhere').val("<%=strWhere%>");
	$('#strSources').val("<%=strSources%>");
	$('#treeType').val("<%=treeType%>");
	$('#logicexpid').val("<%=logicexpid%>");
	
//alert($('#selectexp').val());
//alert($('#selectdbs').val());
//alert($('#treeType').val());

//alert($('#selectexp').val()===null);
//alert($('#selectexp').val()==="null");
	
	params.language=area;
	params.sortMethod='-公开（公告）日';
	params.currentPage=currentPage;
	params.totalPages=0;
	params.xAxis="PATTYPE";
	params.strWhere=$('#strWhere').val();
	params.logicexpid=$('#logicexpid').val();
//	params.semanticexp=$('#semanticexp').val();
	params.nodeId="";
	params.strSources=$('#strSources').val();
	
	$('#searchType').val("1");
	
//alert($('#treeType').val());
	
	//treeType==-1，表格检索
	//treeType==-2，逻辑检索。逻辑检索不记录到历史表达式中
	if($('#treeType').val()==="-1"||$('#treeType').val()==="-2"){
		requestExpData(params);
	}
});

function pre_2_renderfilter(exp){	
//	alert(exp);
	for (var key in expList) {
		var val = expList[key];
//alert(key + "---" + val);
		if(val==(exp)){
			return;
		}
	}
	expList.push(exp);
	renderfilter();
}

//pre_renderfilter(item,content," and ");
function pre_renderfilter(item,content,conj){	
	if(item==='公开年'||item==='申请年'){
		var reg = new RegExp("年","g");//g,表示全部替换。
		content=content.replace(reg,"");
//		content=content.replace('年','');
	}
	var exp = item+"=("+content+")";
	
//	alert(exp);	
//	pre_renderfilter(" and "+exp);
	exp = conj + exp;

//	alert(exp);
	for (var key in expList) {
		var val = expList[key];
//alert(key + "---" + val);
		if(val==(exp)){
			return;
		}
	}
	expList.push(exp);
	renderfilter();
}

//function renderfilter(expList,exp){
	function renderfilter(){
//$('#expchange').val(1);
		var filterexp = "";
		$('#filter').html("");
		
		var id = 0;
		for (var key in expList) {
			var exp = expList[key];
//alert(key + "---" + exp);
			var conj = "";
			if(exp.indexOf(" and ")==0||exp.indexOf(" AND ")==0){
				conj = "and";
			}
			if(exp.indexOf(" not ")==0||exp.indexOf(" NOT ")==0){
				conj = "not";
			}
//exp = exp.substring(5);
			var content = '<div class="well" style="padding:8px;font-size:12px;margin-top:-12px;">';
			if(conj==='and'){
				content += '<span>筛选:</span>';
			}else if(conj==='not'){
				content += '<span style="color:red;margin-top:8px;">排除:</span>';
			}
			content += '<input type="hidden" id="exp_'+id+'" value="'+exp+'"/>';		
			content += '<span style="color:black;">'+exp.substring(5)+'</span>';
			content += '<span> <button class="btn btn-mini btn-warning" onClick="delexp($(\'#exp_'+id+'\').val())" >删除</button></span>';
			content += '</div>';
				
			$('#filter').html($('#filter').html()+content);
			
			filterexp+=exp;		
//			alert(exp+"----"+exp.substring(5));		
			id++;
		}		
		
		if(filterexp.indexOf("专利类型=")>-1){
			$('#filterexp').val(filterexp.replace("PCT发明公开","8").replace("PCT实用新型","9").replace("发明公开","1").replace("实用新型","2").replace("外观专利","3"));
		}else{
			$('#filterexp').val(filterexp);
		}		
//		alert($('#filterexp').val());
	}

function delexp(exp){
	var _expList = [];
//alert(exp);
	for (var key in expList) {
		var val = expList[key];
//alert(key + "---" + val);
		if(val!=exp){
			_expList.push(val);
		}
	}
	
	expList = _expList;
	renderfilter();
	
//	params.xAxis=$(this).parent().parent().attr("alt");
	params.xAxis="PATTYPE";
	
//alert($('#filterexp').val());
	$('#searchType').val("1");
	params.filterexp=$('#filterexp').val();
	//requestExpDataOverview(params,1);//0代表filter表达式没变，如果是1，出结果后，左侧展开的菜单要缩回	
	requestExpData(params);
}

$(document).ready(function(){
//alert("ready......");
//var area = '<%=area%>';
	var currentPage = 1;
	$('.panel-heading a').click(function(){
//alert($(this).attr("alt"));
		var xAxis = $(this).attr("alt");
		var collapseid = $(this).attr("href").replace("#collapse","collapse_");
//alert(collapseid);
		var content = $('#'+collapseid).html();
		content = $.trim(content);
//alert(content);
		if(content==='加载中...'||content===''){
//			params.language=area;
			params.sortMethod='-公开（公告）日';
			params.currentPage=currentPage;
			params.totalPages=0;
			params.xAxis=xAxis;
			params.xAxisSize=20;
//			params.filter='';
			params.filterexp=$('#filterexp').val();
			$('#searchType').val("0");
//alert("requestExpData.........");
			//requestExpDataOverview(params,0);//0代表filter表达式没变，如果是1，出结果后，左侧展开的菜单要缩回
			requestExpData(params);
		}
	});
	
$("a[name='include']").click(function(){
	var divID = $(this).parent().prev().attr("id");
//alert(divID);	
	var content = "";
	$("div#"+divID+" input").each(function(){
		if($(this).is(':checked')) {
//			alert($(this).val()+"--"+$(this).attr('checked'));
			if(content!=""){
				content+=" or ";
			}
//			content+=$(this).val();
			var str = $(this).val();
			if(str.indexOf(" ")==-1){
				content+=$(this).val();
			}else{
				content+="'" + $(this).val() + "'";
			}
			
		}
	});

	if(content!=""){
		var item = $(this).parent().parent().attr("alt");
		/*
		if(item==='公开年'||item==='申请年'){
			content=content.replace('年','');
		}

		if(item==='专利类型'){
			if(content==='发明公开'){
				content=1;
			}
			if(content==='实用新型'){
				content=2;
			}
			if(content==='外观专利'){
				content=3;
			}
			if(content==='PCT发明公开'){
				content=8;
			}
			if(content==='PCT实用新型'){
				content=9;
			}
		}
		
		var exp = $(this).parent().parent().attr("alt")+"=("+content+")";
		
//		alert(exp);
		
//		pre_renderfilter(" and "+exp);
		*/
		pre_renderfilter(item,content," and ");
//		pre_renderfilter_2(item,content," and ");
		
		params.xAxis=item;
		params.filterexp=$('#filterexp').val();
		params.currentPage=1;
		$('#searchType').val("1");
		//params.filter=" and " + exp;
		//requestExpDataOverview(params,1);//0代表filter表达式没变，如果是1，出结果后，左侧展开的菜单要缩回
		requestExpData(params);
	}
});

$("a[name='exclude']").click(function(){
			var divID = $(this).parent().prev().attr("id");
		//alert(divID);	
			var content = "";
			$("div#"+divID+" input").each(function(){
				if($(this).is(':checked')) {
//					alert($(this).val()+"--"+$(this).attr('checked'));
					if(content!=""){
						content+=" or ";
					}
					
					var str = $(this).val();
					if(str.indexOf(" ")==-1){
						content+=$(this).val();
					}else{
						content+="'" + $(this).val() + "'";
					}
					
					//content+=$(this).val();
				}
			});

//alert($('collapse_2').find('input').value());
//alert($(this).parent().parent().attr("alt"));
			if(content!=""){
//				var exp = $(this).parent().parent().attr("alt")+"=("+content+")";

				//renderfilter(expList," not "+exp);
//				pre_renderfilter(" not "+exp);
				var item = $(this).parent().parent().attr("alt");
				pre_renderfilter(item,content," not ");
//				pre_renderfilter_2(item,content," not ");
				
				params.xAxis=item;
				params.xAxisSize=20;
				
				//params.filter=" not " + exp;
				params.filterexp=$('#filterexp').val();
				params.currentPage=1;
				//requestExpDataOverview(params,1);//0代表filter表达式没变，如果是1，出结果后，左侧展开的菜单要缩回
				//overview_requestExpData(params,1);
				$('#searchType').val("1");
				requestExpData(params);
			}
		});
});
</script>
