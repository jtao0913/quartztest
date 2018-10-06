<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<% 
	String area = (String)request.getAttribute("area");
%>

<%@ include file="../../jsp/zljs/include-head-base.jsp"%>

<html>
<head>
<link href="<%=basePath%>common/com_2/css/bootstrap.min.css" rel="stylesheet"/>
<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet"/>
<Script src="js/DisplayTip.js"></Script>
<script language=javascript>
<!--

function insertAtCaret2 (expid, synonymous) 
{ 
//	alert("synonymous="+synonymous);
//	var b1=window.parent.document.forms[0].txtSearchWord.value;
	var b1=window.parent.document.searchForm.txtComb.value;
	
	
//	alert("expid = " + expid);
	var b2=document.getElementById("exp_" + expid).value;
	//alert(b2);
	
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
		window.parent.document.searchForm.txtComb.value = window.parent.document.searchForm.txtComb.value + b2; 
	}
	else
	{
		//window.parent.document.forms[0].txtSearchWord.value = b2;
		window.parent.document.searchForm.txtComb.value = b2;
	}
	//window.parent.document.forms[0].txtSearchWord.focus();
	window.parent.document.searchForm.txtComb.focus();
}  

function changeState(expId, state){
	document.expForm.action = "<%=basePath%>expchangeState.do?method=changeState";
	document.expForm.expid.value = expId;
	document.expForm.state.value = state;
	document.expForm.submit();
}

function showExp(expId) {
	var b2=document.getElementById("exp_" + expId).value;
	b2 = b2.replace(/\(/g,"\(");
	b2 = b2.replace(/\)/g,"\)");
	alert(b2);
}

function renameExp(expid, index){
	var newName = window.showModalDialog('<%=basePath%>jsp/zljs/HistoryRename.jsp?expId=' + expid ,'', 'dialogHeight:280px;dialogWidth:250px;center:yes;resizable:no;help:no;status:no;scroll:no');
	if (newName != null && newName != '' && newName != 'undefind') {
		alert("重命名历史表达式成功");
		var element = document.getElementById('name_' + expid);
		element.innerHTML = '@' + index + ': ' + newName;
	} else if(newName == ''){ 
		alert("重命名历史表达式失败");
	}
}

function delExp(expId, expName){
	expName = expName.replace(/\(/g,"\(");
	expName = expName.replace(/\)/g,"\)");
	if(confirm('确定删除表达式：\"' + expName + '\"吗?')) {
		document.expForm.action = "<%=basePath%>expdeleteExp.do?method=deleteExp";
		document.expForm.expid.value = expId;
		document.expForm.submit();
	}
}
//-->
</script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body style="margin:0px;padding:0px;">
<form name="expForm" action="" method="post" target="_self">
	<input type="hidden" name="expid">
	<input type="hidden" name="state">
	<input type="hidden" name="expName">
	<input type="hidden" name="area" value="<%=area %>">
</form>
<table width="100%" class="table table-striped table-bordered table-hover " style="margin:0px;padding:0px;font-size:13px;">
<c:forEach var="exp" items="${requestScope.expList}" varStatus="status">
 <!--   <tr>
    <td height="24" colspan="5">没有存历史表达式</td>
  </tr>-->
  	<tr>
			 <td style="width:8%;text-align: center;">@${status.index + 1}</td>
			 <td style="width:35%;text-align: center;"><a  id="name_${exp.id}" onClick="insertAtCaret2('${status.index}', '${exp.chrSynonymous}')" style="cursor:hand"> ${exp.name}<input type="hidden" id="exp_${status.index}" value="${exp.expression}"/></a></td>
			 <td style="width:12%;text-align: center;">${exp.hitCount}</td>
			 <td style="width:35%;text-align: center;">${exp.channel}</td>
			 <td style="width:10%;text-align: center;"><span onClick="delExp('${exp.id}','${exp.name}')" style="cursor:hand">删除</span></td>
			  </tr>
</c:forEach>
</table>
</body>
</html>
