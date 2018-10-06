var localObj = window.location;
var contextPath = localObj.pathname.split("/")[1];
//	var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;
//	var server_context=basePath;
//	alert(contextPath);


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





