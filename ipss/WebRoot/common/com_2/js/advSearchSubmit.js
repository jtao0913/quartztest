var fieldShortName = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
		"L", "M", "N", "O", "P", "Q", "R", "S", "T" ,"Z","X","Y","U","W"];
var fieldName = [ "申请号", "申请日", "公开（公告）号", "公开（公告）日", "名称", "摘要", "主分类号",
		"分类号", "申请（专利权）人", "发明（设计）人", "优先权", "地址", "专利代理机构", "代理人", "国省代码",
		"同族专利项", "权利要求书", "说明书", "ss", "法律状态" ,"参考文献","名称,摘要,权利要求书","法律状态码","优先权","专利号"]
//$(function() {
//	$("#cli4").toggle(function() {
//		$(this).html("<font color='red'><< </font>");
//		$("#sh4").show();
//
//	}, function() {
//		$("#sh4").hide();
//		$(this).html("<font color='red'>>> </font>");
//	});
//	$("#fieldcode2name").bind("click", function() {
//		openFieldnameHtml();
//	});
//	$('a.custom-width').cluetip({
//		width : '450',
//		showTitle : false
//	});
//});
function checkSearchForm() {
	if (validLogicInput()) {
		var crossLanguage = $("#crossLanguagecheck").attr("checked");
		var saveExp = $("#saveExpcheck").attr("checked");
		var synonymous = $("#strSynonymouscheck").attr("checked");
		if (crossLanguage) {
			$("#crossLanguage").val("1");
		}
		if (synonymous) {
			$("#strSynonymous").val("SEGMENT_GB");
		}

		if (saveExp) {
			var resp = ajaxCallBySync("/exp!saveExp.action");
			if (resp) {
				var success = eval('[' + resp + ']')[0].success;
				if (success) {
					$("body").mask('请稍候');
					$("#saveExp").val("1");
					$("#searchForm").submit();
				} else {
					var dialog = $
							.dialog({
								title : '提示',
								id : 'downloadDialog',
								content : "<div style='height:60px;width:400px;overflow-y:auto;padding-left:15px;padding-top:10px'>您保存的表达式已经达到上限，点击确定将自动删除最早保存的表达式！<br><br><input type='checkbox' id='showhintBox'  onclick='setShowHit();'>不再提示，自动删除最早保存表达式<\div>",
								padding : 10,
								width : 400,
								resizable : true,
								max : false,
								min : false,
								button : [ {
									id : 'downloadBtn',
									name : '确定',
									callback : submitSearch
								} ],
								cancel : true,
								cancelVal : '关闭'
							});
				}
			}
		}
	} else {
		return false;
	}
}
function checkSearchFormivalid(){
	if(validLogicInput()){
		$("body").mask('请稍候...');
		$("#searchForm").submit(); 
	}else{
		return false;
	}
}
function validLogicInput() {
	
	var textbox = $('#txtComb').val();
	if(textbox!=null && textbox!=""){
		$("#strWhere").val(textbox);
		return true;
	}
	
	var i = 0;
	var searchCond = "";
	var channelCnt = $('input:checked[name="channelId"]').length;
	if (channelCnt == 0) {
		alert('检索频道不能为空');
		return false;
	}

	var endAd = jQuery.trim($("#txt_B_2").val());
	if (endAd != '' && jQuery.trim($("#txt_B").val()) == '') {
		alert('请输入开始日期！');
		return false;
	}

	var endPd = jQuery.trim($("#txt_D_2").val());
	if (endPd != '' && jQuery.trim($("#txt_D").val()) == '') {
		alert('请输入开始日期！');
		return false;
	}
//	searchCond = jQuery.trim($("#txtComb").val());
	$("#txtComb").val("");
//	if (searchCond == null || searchCond == "") {
		$(fieldShortName).each(function() {
			var idFlag = "#txt_" + this;
			var param = jQuery.trim($(idFlag).val());
			if (param != '') {
				if (this == "A" || this == "C") {
					param = isAppendCN(param);
				}

				if (this == "B" && endAd != '') {
					param = param + ' to ' + endAd;
				}

				if (this == "D" && endPd != '') {
					param = param + ' to ' + endPd;
				}

				if (searchCond == "") {
					if (this == "T") {
						var legalName = $("#txt_T").val();
						var legalV = $('#legalV').val();
//						alert(legalName+":"+legalV);
//						var LegalStatus = getLegal(param);
						searchCond = fieldName[i] + "=(" + legalV + ")";
					} else {
						if(this == "X"){
							var threeV = $("#txt_X").val();
							searchCond = fieldName[i] + "+=(" + param + "%)";
						}else{
							searchCond = fieldName[i] + "=(" + param + ")";
						}
					}
				} else {
					var tempExp = "";
					if (this == "T") {
						var legalName = $("#txt_T").val();
						var legalV = $('#legalV').val();
						tempExp = fieldName[i] + "=(" + legalV + ")";
					} else {
						if(this == "X"){
							var threeV = $("#txt_X").val();
							tempExp = fieldName[i] + "+=(" + param + "%)";
						}else{
							tempExp = fieldName[i] + "=(" + param + ")";
						}
						
					}
					
					if (searchCond.indexOf(tempExp) == -1) {
						searchCond += " and " + tempExp;
					}
				}
			}
			i++;
		});
//	}
	if (searchCond == '') {
		alert("请输入检索条件");
		return false;
	} else {
		searchCond = $.trim(searchCond);
		var leftF = 0;
		var rightF = 0;
		for ( var i = 0; i < searchCond.length; i++) {
			var k = searchCond.charAt(i);
			if (k == "(") {
				leftF = leftF + 1;
			} else if (k == ")") {
				rightF = rightF + 1;
			}
		}
		if (leftF != rightF) {
			alert("表达式括号不匹配，请仔细检查表达式！");
			return false;
		}
		$("#strWhere").val(searchCond);
		return true;
	}

}
function insertAtCursor(myField, myValue) {
	// IE support
	if (document.selection) {
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
		sel.select();
	}

	// MOZILLA/NETSCAPE support
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
		
	
		//之前写法上错误了,导致火狐，chrome等显示不正常
//		myField.value += myValue;
		
		$(myField).val($(myField).val() + myValue);
		myField.focus();
	}
}
function addItems(item) {
	insertAtCursor($("#txtComb"), item);
}
/**
 * 将表格内容出入到逻辑输入框内
 */
function insertItem(num) {
	// if($("#cli3").attr("class")=="bgss_more"){
	// return;
	// }
	
	var text = jQuery.trim($("#txt_" + fieldShortName[num]).val());
	// 修改空也能入逻辑框
	if (1)
	/*
	(text == "")
	{
		alert("请输入检索内容");
		return;
	}else
    */
	{
		if (num == 0 || num == 2) {
			text = text + '%';
		}
        if (num == 24) {
			text = text + '%';
		}
		if (num == 2 || num == 3) {
			var end = '';

			if (num == 1) {
				var end = jQuery.trim($("#txt_B_2").val());
				if (end != '' && jQuery.trim($("#txt_B").val()) == '') {
					alert('请输入开始日期！');
					return false;
				}
			} else {
				var end = jQuery.trim($("#txt_D_2").val());
				if (end != '' && jQuery.trim($("#txt_D").val()) == '') {
					alert('请输入开始日期！');
					return false;
				}
			}

			if (end != '') {
				text = text + ' to ' + end;
			}

		}

		if (num == 19) {
			text = getLegal(text);
		}
		if(num == 21){
			text = fieldName[num] + "+=(" + text + "%)";
		}else{
			text = fieldName[num] + "=(" + text + ")";
		}
		insertAtCursor($("#txtComb"), text);
	}
}
function openFieldnameHtml() {
	$.dialog({
		id : 'openFieldnameHtml',
		max : false,
		min : false,
		width : 450,
		fixed : true,
		left : '50%',
		top : '50%',
		content : 'url:windows/fieldCode2Name.html'
	});
	$.dialog({
		id : 'openFieldnameHtml'
	}).title('字段名称');
}
function clearText(){
	$("input[type='text']").each(function(i){
		$(this).val('');
	});
	$('#txt_S').val('');
	$('#txtComb').val('');
}