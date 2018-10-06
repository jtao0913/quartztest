<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.fenye.Page,com.cnipr.corebiz.search.entity.PatentInfo"%>

<head>
  <%@ include file="include-head.jsp"%>
  
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>外观设计细缆-<%=website_title%></title>
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
	<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>

<script type="text/javascript">
String.prototype.replaceAll  = function(s1,s2){
	return this.replace(new RegExp(s1,"gm"),s2);
}
var sRoot = "<%=basePath%>";

function MoveTo(pageIndex){
	var strChannels = $('#detailSearchForm #strChannels').val();
	var strSources = $('#detailSearchForm #strSources').val();
	var strWhere = $("#detailSearchForm #strWhere").val();
//	strWhere = escape(strWhere);
			
	strWhere=encodeURI(strWhere);
	strWhere=encodeURI(strWhere);
//alert("pageIndex="+pageIndex);
//	$("#detailSearchForm #strSources").val("${requestScope.strSources}");
//	$("#detailSearchForm #index").val(pageIndex-1);
	
	$("#detailSearchForm").attr("target","_self");
	$("#detailSearchForm").attr("action","<%=basePath%>wapdetailSearch.do?wap=1&strWhere="+strWhere+"&strChannels="+strChannels+"&strSources="+strSources+"&index="+(pageIndex-1));
	$("#detailSearchForm").submit();
}
</script>
<script language="javascript">
  var loadimg='<%=basePath%>images/loading.gif'; //加载时的loading图片
  loadimg='<img src="'+loadimg+'">'; //加载时的loading图片
  
  var sRoot = "<%=basePath%>";
  
  function showPage(tabId, url){
//alert(tabId+"........."+url);	  
//    $('#maintab a[href="#'+tabId+'"]').tab('show'); //显示点击的tab页面
//alert($('#'+tabId).html());
	if($('#'+tabId).html().length<20)
	{ // 当tab页面内容小于20个字节时ajax加载新页面
		$('#'+tabId).html('<br>'+loadimg+' 页面加载中，请稍后...'); //设置页面加载时的loading图片
//		$('#'+tabId).load(url); //ajax加载页面
//alert("<%=basePath%>" + "/" + url);	
		
		var text = "";
		$.ajax({
			type : "GET",
			url : "<%=basePath%>" + "/" + url + "&" + new Date(),
			
//			data : {
//				'favoritepatents' : params.favoritepatents,
//				'totalPages' : params.totalPages
//			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
//				showexp(jsonresult);
//				$('#myModal').modal('hide');
				$('#'+tabId).html(jsonresult);
			}
		});
	}
  }
</script>

<%
PatentInfo patentInfo = (PatentInfo)request.getAttribute("patentInfo");
%>

</head>
<body>

<form name="detailSearchForm" id="detailSearchForm" action="<%=basePath%>wapdetailSearch.do" method="post" target="_self">
<input type="hidden" id="wap" name="wap" value="1"/>
<input type="hidden" name="strWhere" id="strWhere" value="${requestScope.strWhere }">
<input type="hidden" name="strChannels" id="strChannels" value="${requestScope.strChannels}">
<input type="hidden" name="strSources" id="strSources" value="${requestScope.strSources}">
<input type="hidden" id="strSortMethod" name="strSortMethod" value="${requestScope.strSortMethod }">
<input type="hidden" name="strDefautCols" value="${requestScope.strDefautCols }">
<input type="hidden" name="strStat" value="${requestScope.strStat }">
<input type="hidden" name="iOption" value="${requestScope.iOption }">
<input type="hidden" name="iHitPointType" value="${requestScope.iHitPointType }">
<input type="hidden" name="bContinue" value="${requestScope.bContinue }">
<input type="hidden" name="index" id="index">
<input type="hidden" name="area" id="area" value="cn">
<input type="hidden" name="dateLimit" id="dateLimit" value="">
<input type="hidden" name="appNum" id="appNum"  value="">
<input type="hidden" name="simFlag" id="simFlag"  value="">
<input type="hidden" name="apdRange" id="apdRange"  value="">
<input type="hidden" name="sqFlag" id="sqFlag"  value="">
<input type="hidden" name="singledb" id="singledb"  value="${requestScope.patentInfo.sectionName}">
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

<!--顶部下一条-->
<!--细览注录项-->
<div class="container" style="background-color: #ffffff;margin: auto;padding:12px;">
	<center>
	<div style="height:60px;"></div>
	 <div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group" id="maintab">
		  <a class="btn btn-default mycolor_bor" href="#jiben" data-toggle="tab">著录项信息	
		  </a>
		  <a class="btn btn-default mycolor_bor" href="#falv" data-toggle="tab" onclick='showPage("falv","wapviewLegalStatus.do?strAn=${requestScope.patentInfo.an}")'>法律状态
		  </a>
		   <a class="btn btn-default mycolor_bor"  href="#tif" data-toggle="tab">查看图像	
		  </a> 
	    </div>
	 </div>
  </center> 
  
  <!--tabstart-->
 <div class="tab-content">
	<!--基础信息 tabstart-->
   <div class="tab-pane fade in active" id="jiben">
      	<!--单条记录-->
<div class="container dantiao">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<div class="row">
	<div class="col-xs-12"><a>${requestScope.patentInfo.ti} (${requestScope.patentInfo.an}) </a><span class="label label-info">外观设计</span><!--&nbsp;<span class="label label-default">无效</span>&nbsp;--></div>
	</div>
	<div class="row">
		<div class="col-xs-12">公开（公告）号 :<a> ${requestScope.patentInfo.pnm}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">申 请 日:<a> ${requestScope.patentInfo.ad}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">公开（公告）日:<a> ${requestScope.patentInfo.pd}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">申请(专利权)人:<a> ${requestScope.patentInfo.pa}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">发明(设计)人 :<a> ${requestScope.patentInfo.pin}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">国省代码:<a> ${requestScope.patentInfo.co}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">主分类号:<a> ${requestScope.patentInfo.pic}</a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">地址:<a> ${requestScope.patentInfo.ar}</a></div>
	</div>
	<button type="button" class="btn btn-info btn-xs" onClick="return click_a('divOne_1')">查看隐藏著录项</button>
<div id="divOne_1" style="display:none;">
	<div class="row">
     <div class="col-xs-12">分类号:<a> ${requestScope.patentInfo.sic}</a></div>
	</div>
	<div class="row">
	 <div class="col-xs-12">专利代理机构 :<a> ${requestScope.patentInfo.agc}</a></div>
	</div>
	<div class="row">
     <div class="col-xs-12">代理人:<a> ${requestScope.patentInfo.agt}</a></div>
	</div>
	<div class="row">
	 <div class="col-xs-12">进入国家日期:<a> ${requestScope.patentInfo.den}</a></div>
	</div>
	<div class="row">
     <div class="col-xs-12">优先权:<a> ${requestScope.patentInfo.pr}</a></div>
	</div>
	<div class="row">
     <div class="col-xs-12">国际公布:<a> ${requestScope.patentInfo.ipn}</a></div>
	</div>
	<div class="row">
	 <div class="col-xs-12">国际申请:<a> ${requestScope.patentInfo.ian}</a></div>
	</div>
	<div class="row">
     <div class="col-xs-12">分案申请号:<a> ${requestScope.patentInfo.dan}</a></div>
	</div>
	<div class="row">
	 <div class="col-xs-12">范畴分类:<a> ${requestScope.patentInfo.fcic}</a></div>
	</div>
	<div class="row">
	 <div class="col-xs-12">颁证日:<a> ${requestScope.patentInfo.ipd}</a></div>
	</div>
</div>

	<div class="row">
		<div class="col-xs-12"><strong>简要说明：</strong>
 		${requestScope.patentInfo.ab}
 		</div>
	</div>
	
</div>
<!--单条记录-->
   </div>
    <!--基础信息 end-->
     <!--TIF图形全文 start-->
<div class="tab-pane fade" id="tif" >
	<div class="container dantiao">    
		<div class="row">
			<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;border-left:0;"></div>
		</div>
	</div>

<%
/*
ArrayList<String> imagePubPathList = new ArrayList<String>();
imagePubPathList = (ArrayList<String>)request.getAttribute("ThumbnailImagePubPathList");

Iterator<String> iter = imagePubPathList.iterator();
while(iter.hasNext())
{
	String imagePubPath = (String)iter.next();
	out.println(imagePubPath);
}
*/


	java.util.ArrayList<String> imagePubPathList = new java.util.ArrayList<String>();
	imagePubPathList = (java.util.ArrayList<String>)request.getAttribute("ThumbnailImagePubPathList");

	java.util.Iterator<String> iter = imagePubPathList.iterator();
	while(iter.hasNext())
	{
		String imagePubPath = (String)iter.next();
//		out.println(imagePubPath);
%>
		<div class="row">
			<div class="col-xs-12">
				<img class="img-responsive" src="<%=imagePubPath%>" complete="complete">
			</div>
		</div>
<%				
	}

%>

<!--
	<c:forEach items="${ThumbnailImagePubPathList}" var="path" varStatus="stat">
		<div class="row">
			<div class="col-xs-12">
				<img class="img-responsive" src="${requestScope.patentInfo.abPicPath}" complete="complete">
			</div>
		</div>
	</c:forEach>
-->
	
</div>



   <!--TIF图形全文 end-->
   <!--法律状态 start-->
   <div class="tab-pane fade" id="falv">
   	
   </div>
   <!--法律状态 end--> 
   <div style="height:30px;"></div>
</div>
<!--tabsend-->

  
  
</div>
<!--细览注录项-->





<%@ include file="include-bottom.jsp"%>






	</body>
</html>
<script language="javascript" type="text/javascript">
function click_a(divDisplay)
{
	if(document.getElementById(divDisplay).style.display != "block")
	{
		document.getElementById(divDisplay).style.display = "block";
	}
	else
	{
		document.getElementById(divDisplay).style.display = "none";
	}
}
</script>
