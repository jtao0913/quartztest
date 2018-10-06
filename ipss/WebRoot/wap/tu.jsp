<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.cnipr.cniprgz.entity.ChannelInfo"%>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess"%>

<head>
<%@ include file="include-head.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>说明书全文-<%=website_title%></title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--
	<link href="../common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="../common/tu/css/fancybox.css" rel="stylesheet">
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>	
	<link href="css/wap.css" rel="stylesheet">
-->
	
<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>	

<Script language="JavaScript">
function _MoveTo()
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
function MoveTo(pagenum){
//	alert("pagenum="+pagenum);

//	document.PatentInfo.strUrl.value='${requestScope.strUrl}';
//	document.PatentInfo.totalPages.value='${requestScope.pages}';
//	document.PatentInfo.strCurPage.value = parseInt(pagenum);
//	document.PatentInfo.submit();
	
	var strUrl = '${requestScope.strUrl}';
	var totalPages = '${requestScope.pages}';
	var strCurPage = parseInt(pagenum);
	
//	alert("strUrl = " + strUrl);
//	alert("totalPages = " + totalPages);
//	alert("strCurPage = " + strCurPage);
	
	document.PatentInfo.action="<%=basePath%>wapshowPIC.do?wap=1&curpage="+strCurPage+"&strCurPage="+strCurPage+"&method=viewDocument&strUrl="+strUrl+"&totalPages="+totalPages;
	
//	alert("document.PatentInfo.action = " + document.PatentInfo.action);
	
//	$("#PatentInfo").submit();
	document.PatentInfo.submit();
}

</Script>

<%
//PatentInfo patentInfo = (PatentInfo)request.getAttribute("patentInfo");
String showPIC = DataAccess.get("showPIC")==null?"1":DataAccess.get("showPIC");

String pictype = "";

if(showPIC.equals("0")){
	pictype = "tif";
}else if(showPIC.equals("1")){
	pictype = "png";
}else if(showPIC.equals("2")){
	pictype = "pdf";
}

String dbName = (String)request.getAttribute("dbName");
if (dbName!=null&&dbName.contains("wgzl")) {
	pictype = "jpg";
}
%>
</head>

	<body>

<form id="PatentInfo" name="PatentInfo" action="<%=basePath%>wapshowPIC.do" method="post" target="_self">
	<input type="hidden" id="wap" name="wap" value="1"/>
	<input type="hidden" name="strChannel" value="${requestScope.strChannel}">
	<input type="hidden" id="strUrl" name="strUrl" value="${requestScope.strUrl}">
	<input type="hidden" name="pngDistributePath" value="${requestScope.pngDistributePath}">
	<input type="hidden" name="strAPO" value="${requestScope.an}">
	<input type="hidden" name="strTI" value="${requestScope.ti}">
	<input type="hidden" name="strIPC" value="${requestScope.strIPC}">
	<input type="hidden" name="strANN" value="${requestScope.strANN}">
	<input type="hidden" id="totalPages" name="totalPages" value="${requestScope.pages }">
	<input type="hidden" id="strCurPage" name="strCurPage" value="${requestScope.strCurPage }">
	<input type="hidden" name="strCryp" value="">
	<input type="hidden" name="strThirdParty" value="">
</form>

<form name="viewInstructionForm" action="<%=basePath%>wapshowPIC.do?method=viewDocument" method="post" target="_self">
<input type="hidden" id="wap" name="wap" value="1"/>
<input type="hidden" name="strUrl" value="${requestScope.patentInfo.tifDistributePath}">
<input type="hidden" name="strChannels"	value="${requestScope.strChannels}">
<input type="hidden" name="strAn" value="${requestScope.patentInfo.an }">
<input type="hidden" name="ti"	value="${requestScope.patentInfo.ti }">
<input type="hidden" name="totalPages" value="${requestScope.patentInfo.pages}">
<input type="hidden" name="strIPC"	value="${requestScope.patentInfo.pic }">
<input type="hidden" name="strANN"	value="${requestScope.patentInfo.pa }">
<input type="hidden" name="dbName"	value="${requestScope.dbName }">
<input type="hidden" name="pictype"	value="<%=pictype%>">
<input type="hidden" name="FTS" value="">
</form>

<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>


<!--顶部显示-->
<!--页数选择-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="dropdown col-xs-4">
	   <button type="button" class="btn btn-sm btn-warning dropdown-toggle" id="dropdownMenu1" 
			data-toggle="dropdown">
		页数选择
		<span class="caret"></span>
	  </button>
	  <!--
      <button class="btn btn-default" style="margin-top:-2px;" onClick="prevpage()" id="btnPrev">上一页</button>
    		<button class="btn btn-default" style="margin-top:-2px;" onClick="nextpage()" id="btnNext">下一页</button>
    		<input type="text" class="form-control input-lg" style="width:150px;height:26;line-height:20px;margin-top:8px;" name="txtCurrentPage" onKeyDown="OnPageMemberkeyDown()" value="${requestScope.strCurPage}">
    		<button class="btn btn-default" style="margin-top:-2px;"  onClick="MoveTo()">转到</button>&nbsp;
    		说明书共 ${requestScope.pages} 页，当前为第 ${requestScope.strCurPage} 页
	   -->
	  
	<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
	
<%
/*
String totalPages = (String)request.getAttribute("pages");
String curPage = (String)request.getAttribute("strCurPage");

int pageCount = 0;
int pageIndex = 0;

pageCount = (nav.getPageCount()==null||nav.getPageCount().equals(""))?0:Integer.parseInt(nav.getPageCount());
pageIndex = (nav.getPageIndex()==null||nav.getPageIndex().equals(""))?0:Integer.parseInt(nav.getPageIndex());
pageIndex += 1;
*/

int totalPages = 0;
int curPage = 0;

totalPages = (request.getAttribute("pages")==null||request.getAttribute("pages").equals(""))?0:Integer.parseInt((String)request.getAttribute("pages"));
curPage = (request.getAttribute("strCurPage")==null||request.getAttribute("strCurPage").equals(""))?0:Integer.parseInt((String)request.getAttribute("strCurPage"));

//pageIndex = (nav.getPageIndex()==null||nav.getPageIndex().equals(""))?0:Integer.parseInt(nav.getPageIndex());
//pageIndex += 1;
for(int n=0;n<totalPages;n++){%>
		<li role="presentation">
			<a role="menuitem" tabindex="-1" href="#" onClick="MoveTo('<%=n+1%>')">第 <%=n+1%> 页</a>
		</li>
<%}%>
</ul>
         </div>
		<div class="col-xs-8" style="line-height: 30px;">
			共 <%=totalPages%> 页，当前为第 <%=curPage%> 页
		</div>
	</div>
</div>
<!--页数选择-->
<div class="container dantiao">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;border-left:0;"></div>
	</div>
	<div class="row">
			
<%if(showPIC.equals("1")){%>
<img class="img-responsive" src="<%=com.cnipr.cniprgz.commons.DataAccess.getProperty("PNGServerURL")%>/imgpub/showimg.do?path=${requestScope.pi}&pageno=${requestScope.strCurPage}"></img>
<%}else if(showPIC.equals("0")){%>
<div class="col-xs-12"><img class="img-responsive" src="${requestScope.pngDistributePath}"></div>
<%}%>
			
		
	</div>
</div>


<%@ include file="include-bottom.jsp"%>

	</body>
</html>
