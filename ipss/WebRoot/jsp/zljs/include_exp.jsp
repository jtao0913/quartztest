<%@ page language="java" pageEncoding="UTF-8"%>

<form id="expForm" name="expForm" action="" method="post" target="_self">
	<input type="hidden" id="logicexpid" name="logicexpid">
	<input type="hidden" name="state">
	<input type="hidden" name="expName">
	<input type="hidden" name="treeType" value="-2">
	<input type="hidden" name="area" value="cn">
</form>

<script type="text/javascript">
function generate_pageinfo(area,pageno,totalpages){
//alert(pageno + "---" +totalpages)
//var pageno = 1;
	var text = "";
	var exppageinfo = "";
	var selinfo = "";
	
	$.ajax({
		type : "GET",
		url : "getExp.do?area="+area+"&pageno="+pageno+"&totalpages="+totalpages+"&"+ new Date(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);
			var _totalpages = jsonresult.split("#")[0];
			var result = jsonresult.split("#")[1];

//			alert(totalpages);
//			alert(result);
			
			var data= $.parseJSON(result);
//			var no = 1;
			for (var key in data) {
				var exp = data[key];
//				alert(exp.channel.length);
				var channel_less = exp.channel;
				if(exp.channel.length>20){
					channel_less = exp.channel.substr(0,20)+"...";
				}
				
				text+="<tr>";
				text+="<td style='width:6%;text-align:center;'><input name='strexp' type='checkbox' value='"+exp.id+"'></td>";
//				text+="<td style='width:6%;text-align:center;'>@"+exp.id+"</td>"; 
				if(area==='cnfr'){
					text+="<td style='width:33%;text-align:left;word-break: break-all;word-wrap:break-word;'><input type='hidden' id='channel_"+exp.id+"' value=\""+exp.channel+"\"/><input type='hidden' id='exp_"+exp.id+"' value=\""+exp.expression+"\"/> "+exp.expression+"</td>";
				}else{
//					text+="<td style='width:45%;text-align:center;'><input type='hidden' id='exp_"+exp.id+"' value=\""+exp.expression+"\"/><a id=\"name_"+exp.id+"\" onClick=\"insertAtCaret2('"+exp.id+"', '"+exp.chrSynonymous+"')\" style=\"cursor:pointer;\"> "+exp.name+"</a></td>"; 
					text+="<td style='width:33%;text-align:left;word-break: break-all;word-wrap:break-word;'><input type='hidden' id='channel_"+exp.id+"' value=\""+exp.channel+"\"/><input type='hidden' id='exp_"+exp.id+"' value=\""+exp.expression+"\"/><a id=\"name_"+exp.id+"\" onClick=\"showexp($('#exp_"+exp.id+"').val())\" style=\"cursor:pointer;\"> "+exp.name+"</a></td>";
				}
				
				text+="<td style='width:10%;text-align:center;'>"+exp.hitCount+"</td>";				
				
				text+="<td style='width:30%;text-align:center;' onClick=\"showexp($('#channel_"+exp.id+"').val())\" style=\"cursor:pointer;\"><a href=\"#\" style=\"cursor:pointer;\">"+channel_less+"</a></td>";
				text+="<td style='width:12%;text-align:center;'>"+exp.dtSearchTime+"</td>";
				text+="<td style='width:10%;text-align:center;'>"; 
				text+="<span onClick=\"showExpContent('"+exp.id+"','"+exp.channeltable+"')\" style=\"cursor:pointer;\" class=\"btn btn-success btn-mini\">查看</span>"; 
//				text+=" <span onClick=\"delExp(this,'"+exp.id+"','"+exp.name+"')\" style=\"cursor:pointer;\" class=\"btn btn-danger btn-mini\">删除</span>"; 
				text+="</td>";
				text+="</tr>";
			}
			$('#exptable').html(text);
			
			if(_totalpages!="0")
			{
				selinfo = "<input name='selall' id='selall' type='checkbox' UNCHECKED onClick='selectAllCheck(this.checked)'> 全 选 ";
				selinfo += " <input type='button' name='del' id='del' class=\"btn btn-danger btn-mini\" onClick=\"delbulkexp('"+area+"')\" value='删除'> ";
				if(area!='cnfr'){
					selinfo += "&nbsp;&nbsp;&nbsp;&nbsp;";
					selinfo += " <input type='button' name='comb_and' id='comb_and' class=\"btn btn-info btn-mini\" onClick=\"combine('and')\" value='合并（AND）'>";
					selinfo += " <input type='button' name='comb_or' id='comb_or' class=\"btn btn-info btn-mini\" onClick=\"combine('or')\" value='合并（OR）'>";
				}
				$('#seloption').html(selinfo);
			}
			if(_totalpages!="0"&&_totalpages!="1")
			{
				exppageinfo+="<span>共"+_totalpages+"页</span>";
				exppageinfo+="<span> 第"+pageno+"页</span>";
				exppageinfo+="  <span onClick=\"turnpage('"+area+"',1,"+_totalpages+")\" style=\"cursor:pointer;color:#0088cc;\">首页</span>";
				exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(pageno-1)+","+_totalpages+")\" style=\"cursor:pointer;color:#0088cc;\">上一页</span>";
	//			exppageinfo+="	<input id='currentpage' type='text' style='width:30px;height:18px;' value='"+pageno+"'>";
	//			exppageinfo+="	<input type='button' style='width:30px;height:18px;' onClick='skippage('"+area+"',"+_totalpages+")' value='翻页'>";
				exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(pageno+1)+","+_totalpages+")\" style=\"cursor:pointer;color:#0088cc;\">下一页</span>";
				exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(_totalpages)+","+_totalpages+")\" style=\"cursor:pointer;color:#0088cc;\">尾页</span>";			
				$('#exppage').html(exppageinfo);
			}
		}
	});
}

function combine(_prep){
//	alert(area);
	var exps = "";
	$("input[name='strexp']:checkbox").each(function(i) {
		if(this.checked){
//			alert(this.id);			
			if(exps!=""){
				exps+=" " + _prep + " ";
			}
			exps+=$("#exp_"+this.value).val();			
//			alert($("#exp_"+this.value).val());			
		}			
	});
	
//	insertAtCursor(field, item);
//	document.getElementById("txtComb")
	
	$("#txtComb").val(exps);
}

function delbulkexp(area){
//alert("delexp....");
	var expids = "";
	$("input[name='strexp']:checkbox").each(function(i) {
		if(this.checked){
//			alert(this.id);
			if(expids!=""){
				expids+="#";
			}
			expids+=this.value;
		}			
	});
		
	if(expids!="")
	{
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg)==true){
			$.ajax({
				type : "GET",
	//			url : "/" + contextPath + "/expdeleteExp.do?timeStamp=" + new Date(),
				url : "deleteExp.do?timeStamp=" + new Date(),
				
				data : {
					'expid' : expids,
					'totalPages' : 0
				},
				contentType : "application/json;charset=UTF-8",
				success : function(jsonresult) {	
	//				alert(jsonresult);
	//				alert(obj);
	
					if(jsonresult=="OK"){
						showexp("删除成功");
	
	//						var tr=obj.parentNode.parentNode;
	//						var tbody=tr.parentNode;
	//						tbody.removeChild(tr);
	
						generate_pageinfo(area,1,0);
					}else{
						showexp("删除失败");
					}
				}
			})
		}
		
	}else{
		showexp("请选择要删除的表达式");
	}
}

function showExpContent(obj_expid,strSources){
//alert($("#"+obj_expid).val());
//alert(obj_expid);
	var _strdb = "";

	$("input[name='strdb']").each(function(){
//		$(this).attr("checked",false);
		this.checked=false;
	});

	$("input[name='strdb']").each(function(){
//		if($(this).attr("checked")){
//			_strdb += $(this).val()+",";
//			$(this).attr("checked",false);
//		}
//		alert($(this).val());

		if((","+strSources+",").indexOf(","+$(this).val()+",")>-1){
//		if((","+strSources+",").indexOf(","+$(this).attr("value")+",")>-1){
			this.checked=true;
		}
	});
	
	var area = "cn";
	if(strSources.indexOf("patent")>-1){
		area = "fr";
	}
	
//document.expForm.action="<%=basePath %>pretoJsonOverView.do?logicexpid="+obj_expid+"&area=cn";
	
	$("#expForm #logicexpid").val(obj_expid);
	$("#expForm #area").val(area);
//	$("#expForm").attr("action", "<%=basePath %>pretoJsonOverView.do?logicexpid="+obj_expid+"&area="+area);
//	$("#expForm").attr("action", "<%=basePath %>toJsonOverView.do");
	$("#expForm").attr("action", "<%=basePath %>pretoJsonOverView.do");
	$("#expForm").submit();
//$("#searchForm").attr("action", "pretoJsonOverView.do");
//$("#searchForm #expsearch").val("1");
//$("#searchForm #logicexpid").val(obj_expid);
//$("#searchForm").submit();
	/*
	$('body').mask('正在检索');		
		$.ajax({
			type : "GET",
			url : "pretoJsonOverView.do?timeStamp=" + new Date(),
			//url : "/toJsonOverView.do",
			data : {			
				'logicexpid' : obj_expid
//				'area' : area
			},
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
				alert(jsonresult);
				
				if (jsonresult != null&&jsonresult != "") {
					processJsonresult(jsonresult,searchType);
				}else{
					$('#top-navbar').hide();
					$('#overViewDiv').hide();
					showexp("此次检索无结果，请检查检索表达式");
				}

				isLoading = false;
				$('body').unmask();
			}
		});
	*/
}

function insertAtCaret2 (expid, synonymous)
{
//	var b1=document.searchForm.txtComb.value;
//	$("#expressSearchForm #area").val($("#searchForm #area").val());	
	
	var b1=$("#searchForm #txtComb").val();
//	alert(b1)
	
//	alert("expid = " + expid);
//	var b2=document.getElementById("exp_" + expid).value;
	var b2=$("#exp_" + expid).val();
	
//	alert(b2);
	
	//var b3 = eval(text.id + '_Synonymous').value;
	/*
	if (document.expForm.area.value == 'cn') {
		if(synonymous == "1")
			window.parent.document.searchForm.synonymous.checked = true;
		else
			window.parent.document.searchForm.synonymous.checked = false;
	}
	*/
	
	while (b2.indexOf("\\/")!= -1) {
		b2=b2.replace("\\/","/");
	}
	while (b2.indexOf("￡?")!= -1) {
		b2=b2.replace("￡?","?");
	}

	while (b2.indexOf("￡￥")!= -1) {
		b2=b2.replace("￡￥","%");
	}
	b2 = b2.replace(/\(/g,"\(");
	b2 = b2.replace(/\)/g,"\)");
	
	if (b1.length>0) 
	{
		//window.parent.document.forms[0].txtSearchWord.value = window.parent.document.forms[0].txtSearchWord.value + b2;
		document.searchForm.txtComb.value = document.searchForm.txtComb.value + b2; 
	}
	else
	{
		//window.parent.document.forms[0].txtSearchWord.value = b2;
		document.searchForm.txtComb.value = b2;
	}
	//window.parent.document.forms[0].txtSearchWord.focus();
	document.searchForm.txtComb.focus();	
}  

function clearPageData(){
	$('#txtComb').val('');
}



function changeState(expId, state){
	document.expForm.action = "expchangeState.do?method=changeState";
	document.expForm.expid.value = expId;
	document.expForm.state.value = state;
	document.expForm.submit();
}

function showExp11(expId) {
	var b2=document.getElementById("exp_" + expId).value;
	b2 = b2.replace(/\(/g,"\(");
	b2 = b2.replace(/\)/g,"\)");
	showexp(b2);
}

function renameExp(expid, index){
	var newName = window.showModalDialog('jsp/zljs/HistoryRename.jsp?expId=' + expid ,'', 'dialogHeight:280px;dialogWidth:250px;center:yes;resizable:no;help:no;status:no;scroll:no');
	if (newName != null && newName != '' && newName != 'undefind') {
		showexp("重命名历史表达式成功");
		var element = document.getElementById('name_' + expid);
		element.innerHTML = '@' + index + ': ' + newName;
	} else if(newName == ''){ 
		showexp("重命名历史表达式失败");
	}
}

function searchsaveexp(_url, area) {
	var _strdb = "";
//	this.checked=true;
	$("input[name='strdb']").each(function(){
//		if($(this).attr("checked")){
		if(this.checked==true){
			if((","+_strdb+",").indexOf($(this).val())==-1){
				_strdb += $(this).val()+",";
			}
		}
	});
//	alert(_strdb);
	
	var othersdb = $('#searchForm #strChannels').val();
	if(othersdb!=""){
		var _arrdb = othersdb.split(",");
		$.each(_arrdb, function(i, el){
			if((","+_strdb).indexOf("," + _arrdb[i] + ",")==-1){
				_strdb += "," + _arrdb[i];
			}
		});
//		alert("555==="+_strdb.substring(_strdb.length-1));
		if(_strdb.substring(_strdb.length-1)!=',')
		{
			_strdb+=",";
		}
	}
//	alert(_strdb);
	
	if(_strdb.length>0){
		_strdb = _strdb.substring(0,_strdb.length-1);
	}else{
		showexp("请选择频道");
		return;
	}
	
//	var res = str.split(" ");
	var _arr = _strdb.split(",");
	var uniqueArr = [];
	$.each(_arr, function(i, el){
	    if($.inArray(el, uniqueArr) === -1) uniqueArr.push(el);
	});
	
	_strdb = uniqueArr.toString();	
	
//	alert("_strdb="+_strdb);

	var _txtComb=$("#searchForm #txtComb").val();
	
	alert(_txtComb);
	
	if($.trim(_txtComb) == ''){
		showexp("请输入检索表达式");
		return;
	}
	
	var left_bracket=0;
	var right_bracket=0;
	
	for(i=0;i<_txtComb.length;i++){
//		 alert(str.charAt(i));
		var _char = _txtComb.charAt(i);
		if(_char==='('||_char==='（')
		{
			left_bracket++;
		}
		if(_char===')'||_char==='）')
		{
			right_bracket++;
		}    			 
	}
	
//	alert("left_bracket="+left_bracket);
//	alert("right_bracket="+right_bracket);
//	alert(left_bracket!=right_bracket);
	
	if(left_bracket!=right_bracket){
		alert("您输入的表达式左右括号不匹配，请重新输入");
		return;
	}
	

$("body").mask("正在处理中，请稍候...");
		var text = "";
		$.ajax({
			type : "GET",
//			url : "/" + contextPath + "/logicSaveExpression.do?timeStamp=" + new Date(),
//			url : _url + "logicSaveExpression.do?timeStamp=" + new Date(),
			url : "logicSaveExpression.do?searchType=1&timeStamp=" + new Date(),
			
			data : {
				'searchType' : 1,
				'currentPage' : 1,
				'strSources' : _strdb,
				'strWhere' : _txtComb,
				'area' : area,
				'language' : area,
				'totalPages' : 0
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
$("body").unmask();

//				alert(jsonresult);

				generate_pageinfo(area,1,0);

//				overviewResponse.getRecordCount()+"#"+expid+"#"+synonymous+"#"+strWhere+"#"+strTRSTableName
				
//				$("#username").attr("value","guest");//清空内容 
//				$("#password").attr("value","123456");
/*
				var arr = jsonresult.split("#");
			    for (i = 0; i < arr.length; i++)
			    {
					//alert(arr[i]);
			    }
//jsonresult = overviewResponse.getRecordCount()+"#"+expid+"#"+synonymous+"#"+strWhere+"#"+strSources+"#"+strTRSTableName+"#"
			    var recordcount = arr[0];
			    var expid = arr[1];
			    var synonymous = arr[2];
			    var strSources = arr[4];
			    var strTRSTableName = arr[5];
			    
			    var strWhere = arr[3];
			    var expName = strWhere;
			    if (expName.length>23) {
					expName = expName.substring(0,23) + "......";
				}
				
var innerTD = "<tr><td style='text-align: center;'>@"+expid+"</td><td style='text-align: center;'><a id='name_"+expid+
				"' onClick='insertAtCaret2(\""+expid+"\", \""+synonymous+"\")' style='cursor:hand'>"+
				expName+"<input type='hidden' id='exp_"+expid+"' value='"+strWhere+"'/></a></td><td style='text-align: center;'>"+
				recordcount+"</td><td style='text-align: center;'>"+strTRSTableName+"</td><td style='text-align: center;'>"+
				"<span onClick='showExpContent(\"exp_"+expid+"\",\""+strSources+"\")' style='cursor:pointer;' class='btn btn-success btn-mini'>查看</span> "+
				"<span onClick=\"delExp(this,'"+expid+"','"+expName+"')\" style='cursor:pointer;' class='btn btn-danger btn-mini'>删除</span></td></tr>";
			    
			    $(innerTD).prependTo("#exptable");
*/
			    
			}
		})
	}
	

function turnpage(area,pageno,totalpages){
//	alert(pageno);
	if(pageno>0&&pageno<=totalpages){		
		generate_pageinfo(area,pageno,totalpages);
	}
}


function skippage(area,totalpages){
	var pageno = $("#currentpage").val();
//	alert(pageno);
	
	if(pageno>0&&pageno<=totalpages){
		generate_pageinfo(area,pageno,totalpages);
	}
}

function selectAllCheck(objValue) {
	if (objValue == true) {
		$("input[name='strexp']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",true);
//			$(this).checked = true;
			this.checked=true;
		});		
	} else {
		$("input[name='strexp']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",false);
//			$(this).checked = false;
			this.checked=false;
		});	
	}
}
</script>
