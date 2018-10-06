<!DOCTYPE html>
<html lang="en">
<%@ page import="com.cnipr.cniprgz.commons.DataAccess" contentType="text/html; charset=UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ include file="../../zljs/include-head-base.jsp"%>
<%@ include file="../../zljs/include-head.jsp"%>

<head>
<script type="text/javascript" src="<%=basePath%>jsp/viewPlugin/png/jquery.media.js"></script>
	
	<script language="javascript">
	$(function(){
		$('a.media').media({width:800,height:1200});
	});
	</script>
	<title></title>
		
<%
String _show_action = "";
String _download_action = "createPDFZip.do";
//0:tif;1:png
%>
</head>

<Script language="JavaScript">
self.moveTo(0,0)
self.resizeTo(screen.availWidth,screen.availHeight)

//无提示关闭窗口
function CloseWin()
{
	window.close()
}

function nextpage(){
	document.PatentInfo.strUrl.value='${requestScope.strUrl}';
	document.PatentInfo.totalPages.value='${requestScope.pages}';

//alert(document.PatentInfo.strCurPage.value);
	
	if(parseInt(document.PatentInfo.strCurPage.value)<parseInt(document.PatentInfo.totalPages.value)){
		document.PatentInfo.strCurPage.value = parseInt(document.PatentInfo.strCurPage.value) + 1;
		document.PatentInfo.submit();
	}else{
		showexp("请输入1至"+parseInt(document.PatentInfo.totalPages.value)+"的正确页码！");
	}
}

function prevpage(){
	document.PatentInfo.strUrl.value='${requestScope.strUrl}';
	document.PatentInfo.totalPages.value='${requestScope.pages}';

	if(parseInt(document.PatentInfo.strCurPage.value)>1){
		document.PatentInfo.strCurPage.value = parseInt(document.PatentInfo.strCurPage.value) - 1;
		document.PatentInfo.submit();
	}else{
		showexp("请输入1至"+parseInt(document.PatentInfo.totalPages.value)+"的正确页码！");
	}
}
//document.all.txtCurrentPage.value
function MoveTo()
{
	document.PatentInfo.strUrl.value='${requestScope.strUrl}';
	document.PatentInfo.totalPages.value='${requestScope.pages}';

	var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数    
    if (!re.test(document.all.txtCurrentPage.value)) {
//		alert("请输入数字！");
		showexp("请输入1至"+parseInt(document.PatentInfo.totalPages.value)+"的正确页码！");
		return;
    }

	if(parseInt(document.all.txtCurrentPage.value)>=1&&parseInt(document.all.txtCurrentPage.value)<=parseInt(document.PatentInfo.totalPages.value)){
		document.PatentInfo.strCurPage.value = parseInt(document.all.txtCurrentPage.value);
		document.PatentInfo.submit();
	}
}
</Script>

<body bgcolor="#3498db" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>






<form name="PatentInfo" action="<%=basePath%>showPIC.do?method=viewDocument">
	<input type="hidden" name="strChannel" value="${requestScope.strChannel}">
	<input type="hidden" name="strUrl" value="${requestScope.strUrl}">
	<input type="hidden" name="pngDistributePath" value="${requestScope.pngDistributePath}">
	<input type="hidden" name="strAPO" value="${requestScope.an }">
	<input type="hidden" name="strTI" value="${requestScope.ti}">
	<input type="hidden" name="strIPC" value="${requestScope.strIPC}">
	<input type="hidden" name="strANN" value="${requestScope.strANN}">
	<input type="hidden" name="totalPages" value="${requestScope.pages }">
	<input type="hidden" name="strCurPage" value="${requestScope.strCurPage }">
	<input type="hidden" name="strCryp" value="">
	<input type="hidden" name="strThirdParty" value="">
</form>

	
    <div class="navbar navbar-inverse navbar-fixed-top mycolor_bor" style="line-height:35px;">
    <div class="container">
            <div class="row">
     
     <span class="pull-left">
    		说明书共 ${requestScope.pages} 页，当前为第 ${requestScope.strCurPage} 页
  		    <button class="btn btn-default" style="margin-top:-2px;"  onclick="downloadPIC()" id="btnDownload">下载</button>
  		
  	  &nbsp;<button class="btn btn-default" style="margin-top:-2px;"  onclick="Refresh()" id="btnRefresh">刷新</button>
  	  </span> 
  		   <span class="pull-right"><button class="btn btn-default" onClick="javascript:parent.CloseWin();">关闭窗口</button></span> 
  
    </div>
    </div>
  </div>


<a class="media" href="<%=basePath%>jsp/viewPlugin/png/2014800622559.pdf"></a>


</body>
</html>



<Script language="JavaScript">
function Refresh() {
	location.reload();
}
function downloadPIC() {
//		var tifInfos = "BOOKS/FM/2000/20000105/97180597.0,92,CN97180597.0";
		var tifInfos = "${requestScope.strUrl}"+","+"${requestScope.pages}"+","+"${requestScope.an}";
//		alert(tifInfos);

$("body").mask("正在生成下载文件，请稍候...");
		
		$.ajax({
			url : '<%=basePath%><%=_download_action%>',
			type : 'POST',
			data : {
				'tifInfos' : tifInfos
			},
			success : function(jsonresult) {
$("body").unmask();

				$.dialog({
					id : "winlogin",
					bgcolor : "#FFF",
					width : "200px",
					title : '下载',
					max : false,
					min : false,
					content : "<div style='line-height:22px;'>资源获取成功，<a href="
						+ "<%=basePath%>downloadZipfile.do?fileName=" + jsonresult
						+ ">[这里]</a>进行下载 !</div>"
				});

			},
			error : function() {
				//$("body").unmask();
			}
		});		
	}
</Script>

