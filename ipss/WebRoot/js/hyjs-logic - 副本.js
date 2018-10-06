var localObj = window.location;
var contextPath = localObj.pathname.split("/")[1];
//	var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
//	var server_context=basePath;
//	alert(contextPath);


function selectAllCheckSort(objValue) {
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







function turnpage(area,pageno,totalpages){
//	alert(pageno);
	if(pageno>0&&pageno<=totalpages){		
		generate_pageinfo(area,pageno,totalpages);
	}
}

function generate_pageinfo(area,pageno,totalpages){
//alert(pageno + "---" +totalpages)
//	var pageno = 1;
	var text = "";
	var exppageinfo = "";
	var selinfo = "";
	
	$.ajax({
		type : "GET",
		url : "getExp.do?area="+area+"&pageno="+pageno+"&totalpages="+totalpages+"&"+ new Date(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//			alert(jsonresult);

			var _totalpages = jsonresult.split("#")[0];
			var result = jsonresult.split("#")[1];

//			alert(totalpages);
//			alert(result);
			
			var data= $.parseJSON(result);
//			var no = 1;
			for (var key in data) {
				var exp = data[key];
				
				text+="<tr>";
				text+="<td style='width:8%;text-align:center;'><input name='strexp' id='exp"+exp.id+"' type='checkbox'></td>";
				text+="<td style='width:8%;text-align:center;'>@"+exp.id+"</td>"; 
				text+="<td style='width:35%;text-align:center;'><a id=\"name_"+exp.id+"\" onClick=\"insertAtCaret2('"+exp.id+"', '"+exp.chrSynonymous+"')\" style=\"cursor:pointer;\"> "+exp.expression+"<input type=\"hidden\" id=\"exp_"+exp.id+"\" value=\""+exp.expression+"\"/></a></td>"; 
				text+="<td style='width:12%;text-align:center;'>"+exp.hitCount+"</td>"; 
				text+="<td style='width:25%;text-align:center;'>"+exp.channel+"</td>"; 
				text+="<td style='width:20%;text-align:center;'>"; 
				text+="<span onClick=\"showExpContent('exp_"+exp.id+"','"+exp.channeltable+"')\" style=\"cursor:pointer;\" class=\"btn btn-success btn-mini\">查看</span>"; 
				text+=" <span onClick=\"delExp(this,'"+exp.id+"','"+exp.name+"')\" style=\"cursor:pointer;\" class=\"btn btn-danger btn-mini\">删除</span>"; 
				text+="</td>";
				text+="</tr>";
			}
			$('#exptable').html(text);
			
			selinfo = "<input name='selall' id='selall' type='checkbox' UNCHECKED onClick='selectAllCheckSort(this.checked)'>全 选 ";
			selinfo += " <button name='del' id='del' type='button' onClick='delbulkexp('"+area+"')'>删除</button>";
			$('#seloption').html(selinfo);
			
			exppageinfo+="<span>共"+_totalpages+"页</span>";
			exppageinfo+="  <span onClick=\"turnpage('"+area+"',1,"+_totalpages+")\">首页</span>";
			exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(pageno-1)+","+_totalpages+")\">上一页</span>";
			exppageinfo+="	<input id='currentpage' type='text' style='width:30px;height:18px;' value='"+pageno+"'>";
//			exppageinfo+="	<input type='button' style='width:30px;height:18px;' onClick='skippage('"+area+"',"+_totalpages+")' value='翻页'>";
			exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(pageno+1)+","+_totalpages+")\">下一页</span>";
			exppageinfo+="	<span onClick=\"turnpage('"+area+"',"+(_totalpages)+","+_totalpages+")\">尾页</span>";			
			$('#exppage').html(exppageinfo);
		}
	});
}




function skippage(area,totalpages){
	var pageno = $("#currentpage").val();
//	alert(pageno);
	
	if(pageno>0&&pageno<=totalpages){
		generate_pageinfo(area,pageno,totalpages);
	}
}








	
function delbulkexp(area){
alert("delexp...."+area);
	var expids = "";
	$("input[name='strexp']:checkbox").each(function(i) {
		if(this.checked){
//			alert(this.id);
			if(expids!=""){
				expids+="#";
			}
			expids+=this.id;
		}			
	});
		
	if(expids!=""){
		$.ajax({	
			type : "GET",
//			url : "/" + contextPath + "/expdeleteExp.do?timeStamp=" + new Date(),
			url : "expdeleteExp.do?timeStamp=" + new Date(),
		
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
	}else{
		showexp("请选择要删除的表达式");
	}
}
	
function delExp(obj,expId, expName){	
	expName = expName.replace(/\(/g,"\(");
	expName = expName.replace(/\)/g,"\)");
	if(confirm('确定删除表达式：\"' + expName + '\"吗?')) {
//		document.expForm.action = "<%=basePath%>expdeleteExp.do?method=deleteExp";
//		document.expForm.expid.value = expId;
//		document.expForm.submit();
		
//		alert(<%=basePath%>);
		
		$.ajax({	
			type : "GET",
//			url : "/" + contextPath + "/expdeleteExp.do?timeStamp=" + new Date(),
			url : "expdeleteExp.do?timeStamp=" + new Date(),
		
			data : {
				'expid' : expId,
				'totalPages' : 0
			},
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {

//				alert(jsonresult);
//				alert(obj);

				if(jsonresult=="OK"){
					showexp("删除成功");
					var tr=obj.parentNode.parentNode;
					var tbody=tr.parentNode;
					tbody.removeChild(tr);
				}else{
					showexp("删除失败");
				}
			}
		})		
	}
}



function showExpContent(obj_expid,strSources){
//	alert(strSources);
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
//		alert((","+strSources+",") + "-------------" + (","+$(this).attr("alt")+","));

//		alert((","+strSources+",").indexOf(","+$(this).attr("alt")+","));
		
		if((","+strSources+",").indexOf(","+$(this).attr("alt")+",")>-1){
//			alert((","+strSources+",") + "-------------" + (","+$(this).attr("alt")+","));
//			$(this).attr("checked",true);
			this.checked=true;
		}
	});	
	
	$("#searchForm #strChannels").val(strSources);
	$("#searchForm #strWhere").val($("#"+obj_expid).val());
	$("#searchForm").submit();
}

function clearPageData(){
	$('#txtComb').val('');
}

//页面编辑公用函数
function insertAtCursor(myField, myValue) {
	//IE support
	if (document.selection) {
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
		sel.select();
	}
	//MOZILLA/NETSCAPE support
	else if (myField.selectionStart || myField.selectionStart == '0') {
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
function addItems(item) {
	var field = document.getElementById("txtComb");
	insertAtCursor(field, item);
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
function changeState(expId, state){
	document.expForm.action = "<%=basePath%>expchangeState.do?method=changeState";
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
	var newName = window.showModalDialog('<%=basePath%>jsp/zljs/HistoryRename.jsp?expId=' + expid ,'', 'dialogHeight:280px;dialogWidth:250px;center:yes;resizable:no;help:no;status:no;scroll:no');
	if (newName != null && newName != '' && newName != 'undefind') {
		showexp("重命名历史表达式成功");
		var element = document.getElementById('name_' + expid);
		element.innerHTML = '@' + index + ': ' + newName;
	} else if(newName == ''){ 
		showexp("重命名历史表达式失败");
	}
}

function searchsaveexp(_url, area) {
//	var _url = "<%=basePath%>";

	var _strdb = "";

//	this.checked=true;
	$("input[name='strdb']").each(function(){
//		if($(this).attr("checked")){
		if(this.checked==true){
			_strdb += $(this).val()+",";
		}
	});
	
	var othersdb = $('#searchForm #strChannels').val();
	if(othersdb!=""){
		_strdb = othersdb + "," + _strdb;
	}
	
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
	
	if($.trim(_txtComb) == ''){
		showexp("请输入检索表达式");
		return;
	}

$("body").mask("正在处理中，请稍候...");
		var text = "";
		$.ajax({
			type : "GET",
//			url : "/" + contextPath + "/logicSaveExpression.do?timeStamp=" + new Date(),
			
//			url : _url + "logicSaveExpression.do?timeStamp=" + new Date(),
			url : "logicSaveExpression.do?timeStamp=" + new Date(),
			
			data : {
				'strChannels' : _strdb,
				'strWhere' : _txtComb,
				'area' : area,
				'totalPages' : 0
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
$("body").unmask();
				generate_pageinfo(area,1,0);
//				alert(jsonresult);

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