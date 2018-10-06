<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.dao.ChannelDAO,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*,com.cnipr.corebiz.search.entity.PatentInfo,java.util.List,com.cnipr.cniprgz.entity.WASSectionInfo,com.cnipr.cniprgz.commons.fenye.Page"%>
<%@ page import="com.cnipr.cniprgz.entity.ChannelInfo"%>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <%@ include file="include-head.jsp"%>
	<title>检索概览-<%=website_title%></title>
	
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
	<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>	
</head>

<%  
    response.setHeader("X-XSS-Protection","0");
    response.setCharacterEncoding("UTF-8");
%>
<%
	String area = request.getParameter("area")==null?(String)request.getAttribute("area"):request.getParameter("area");
	area = area==null?"cn":area;
	
	String filterChannel = (String)request.getAttribute("filterChannel");
//System.out.println("filterChannel="+filterChannel);
	filterChannel = request.getAttribute("filterChannel")==null?"全部":filterChannel;
//System.out.println("filterChannel="+filterChannel);
	
//	String pageCount = (String)request.getAttribute("pageCount");
/*
	String indexPage = request.getParameter("indexPage");
	if (indexPage == null || indexPage.equals("")) {
		indexPage = "1";
	}
*/
String strWhere = request.getParameter("strWhere");
String strSources = request.getParameter("strSources");

System.out.println("strWhere="+strWhere);
System.out.println("strSources="+strSources);

/*
	String strSources =  "";
	if( request.getAttribute("strSources")!=null)
		strSources=(String)request.getAttribute("strSources");
*/	
/*
	String searchKind = (String)request.getAttribute("searchKind");
	String tifServerURL = DataAccess.getProperty("PicServerURL");
	
	String semanSearch=(String)request.getAttribute("strWhere");
	
	String strWhere = semanSearch;
	String sf=(String)request.getAttribute("simFlag");
	if(semanSearch==null)
		semanSearch ="";
	if(sf!=null&&sf.equals("Y")){
		semanSearch="Y";
	}else if(semanSearch!=null){
		semanSearch=semanSearch.toLowerCase().indexOf("ss")>-1||semanSearch.indexOf("智能检索")>-1||semanSearch.toLowerCase().indexOf("trskeyword/")>-1?"Y":"N";
	}	 
	
	String inChannel = (String)request.getAttribute("filterChannel");
	String strSources =  "";
	if( request.getAttribute("strSources")!=null)
		strSources  = (String) request.getAttribute("strSources");
		
//System.out.println("strSources="+strSources);
	
	String strChannel = inChannel;
	if(strChannel==null)
		strChannel = strSources;
	
	if (inChannel == null || inChannel.equals("")) {
		inChannel = (String)request.getAttribute("strChannels");
	} else {
		inChannel = (new ChannelDAO()).getChannelsIDByName(inChannel);
	}
//System.out.println("inChannel="+inChannel);
	
	String strItemGrant = "";
	if(request.getSession().getAttribute("strItemGrant")!=null)
		strItemGrant = (String)request.getSession().getAttribute("strItemGrant");
//System.out.println("inChannel="+inChannel);
	
	int ABSTBatchCount = (Integer) request.getSession().getAttribute("ABSTBatchCount");
	
//	String totalRecord = (String)request.getAttribute("totalRecord");
 
String _userId = "";
if(request.getSession().getAttribute("userid")!=null)
{
	_userId = ((String)request.getSession().getAttribute(Constant.APP_USER_ID));	
}
*/

//OverviewSearchResponse overviewResponse = null;
List<PatentInfo> patentInfoList = null;
//request.setAttribute("totalRecord", totalRecord);
long totalRecord = 0L;
long currentRecord = 0L;

System.out.println(request.getSession().getAttribute("list"));
System.out.println(session.getAttribute("list"));

if(request.getSession().getAttribute("list")!=null){
	patentInfoList=(List<PatentInfo>)request.getSession().getAttribute("list");
//	System.out.println("patentInfoList="+patentInfoList.size());	
//	request.setAttribute("sections", getSectionInfo(channelList,overviewResponse.getSectionInfos()));
//	overviewResponse.getSectionInfos()
	totalRecord=(Long)request.getAttribute("unfilterTotalCount");
	currentRecord=(Long)request.getAttribute("totalRecord");	
//	List<WASSectionInfo>
	List<WASSectionInfo> ls_SectionInfo = (List<WASSectionInfo>)request.getAttribute("sections");
//	List<WASSectionInfo> infoList = new ArrayList<WASSectionInfo>();
	for (WASSectionInfo info : ls_SectionInfo) {
//		System.out.println("SectionName="+info.getSectionName());
	}
%>
<script language="javascript">
var params = {};

function nextPage(pageIndex){
	var strChannels = $('#searchForm #strChannels').val();
	var strWhere = $("#searchForm #strWhere").val();
//	strWhere = escape(strWhere);
			
	strWhere=encodeURI(strWhere);
	strWhere=encodeURI(strWhere);
			
//	alert(strChannels);
//	alert(strWhere);
			
//  $("#searchForm #strWhere").attr("value",strWhere);
//  $("#searchForm #strChannels").attr("value",strChannels);
    $("#searchForm").attr("action","<%=basePath%>wapoverviewSearch.do?wap=1&strWhere="+strWhere+"&strChannels="+strChannels+"&pageIndex="+pageIndex);
    $("#searchForm").attr("target", "_self");		
	$("#searchForm").submit();
}

function getPatentByChannel(channelname,qty){
	//alert(document.searchForm.strSources.value);
	if(qty>0){
		var strChannels = $('#searchForm #strSources').val();
		var strWhere = $("#searchForm #strWhere").val();
//		strWhere = escape(strWhere);
				
		strWhere=encodeURI(strWhere);
		strWhere=encodeURI(strWhere);

		document.searchForm.action = "<%=basePath%>wapoverviewSearch.do?wap=1&strWhere="+strWhere+"&filterChannel="+channelname+"&strChannels="+strChannels+"&pageIndex=1";
//alert(document.searchForm.action);
		
//		document.searchForm.filterChannel.value = channelname;
//		document.searchForm.strChannels.value = document.searchForm.strSources.value;
//		document.searchForm.pageIndex.value = "1";

		$("#searchForm").attr("target", "_self");
			document.searchForm.submit();
		}else{
			showexp("无此类数据，请重新选择类别");
		}
}

function getDetail(index){
//alert(document.searchForm.strWhere.value);
	/*
	document.showDetail.strWhere.value = document.searchForm.strWhere.value;
	
	document.showDetail.strSources.value = document.searchForm.strSources.value;
	document.showDetail.strChannels.value = document.searchForm.strChannels.value;
	document.showDetail.strSortMethod.value = document.searchForm.strSortMethod.value;

	document.showDetail.index.value = index;
	document.showDetail.filterChannel.value = document.searchForm.filterChannel.value;
	*/
    //document.showDetail.area.value = params.language;
    document.showDetail.strWhere.value = "id="+index;
	
	
	var strChannels = $('#searchForm #strChannels').val();
	var strSources = $('#searchForm #strSources').val();
	var strWhere = "id="+index;//$("#searchForm #strWhere").val();
	var strSortMethod = $("#searchForm #strSortMethod").val();
	var filterChannel = $("#searchForm #filterChannel").val();
//	strWhere = escape(strWhere);
			
//	strWhere=encodeURI(strWhere);
//	strWhere=encodeURI(strWhere);
	
	document.showDetail.action = "<%=basePath%>wapdetailSearch.do?wap=1&index="+index+"&strChannels="+strChannels+"&strSources="+strSources+"&strWhere="+strWhere+"&strSortMethod="+strSortMethod+"&filterChannel="+filterChannel;
//	alert("getDetail.....");	
	document.showDetail.submit();
}

function findPubDate(pubDate) {
	if (pubDate != null && pubDate != "") {
		var strWhere = "";
		strWhere = "公开（公告）日=(" + pubDate + ")";
		
//		alert(strWhere);
		strWhere = encodeURI(strWhere);	
//		alert(strWhere);
		requestExpData(strWhere);
	}
}

function findAppName(appName) {
	if (appName != null && appName != "") {
		var strWhere = "";
		if (appName.indexOf(']') > 0 || appName.indexOf('[')>=0) {
			strWhere = "申请（专利权）人=("
					+ appName.replace("[", "").replace("]", "") + ")"
		} else {
			strWhere = "申请（专利权）人=(" + appName + ")";
		}

		strWhere = encodeURI(strWhere);
		strWhere = encodeURI(strWhere);
		requestExpData(strWhere);
	}
}

function requestExpData_(strWhere) {
	$("#searchForm").attr("action", "wapoverviewSearch.do");
	$("#searchForm #strWhere").val(strWhere);		
//	$("#searchForm").attr("target", "_blank");
	$('#searchForm').submit();
}

function requestExpData(strWhere) {
	var strChannels = $('#searchForm #strChannels').val();
	$("#searchForm").attr("action", "wapoverviewSearch.do?wap=1&strWhere="+strWhere+"&strChannels="+strChannels);
//	$("#searchForm").attr("target", "_blank");
	$('#searchForm').submit();
}
</script>


<body>

<form id="searchForm" name="searchForm" method="post" target="_self">
	<input type="hidden" id="wap" name="wap" value="1"/>
	<input type="hidden" name="area" id="area" value="<%=area%>">
	<input type="hidden" name="strChannels" id="strChannels" value="${requestScope.strSources}">
	<input type="hidden" name="pageIndex" id="pageIndex">
	<input type="hidden" name="strWhere" id="strWhere" value="${requestScope.strWhere}"/>
	<input type="hidden" name="strSources" id="strSources" value="${requestScope.strSources}">
	
	<input type="hidden" name="strSortMethod" id="strSortMethod" value="${requestScope.strSortMethod}">
	<input type="hidden" name="filterChannel" id="filterChannel" value="${requestScope.filterChannel}">
</form>

<form id="showDetail" name="showDetail"
			action="<%=basePath%>wapdetailSearch.do?method=detailSearch" method="post"
			target="_self">
	<input type="hidden" id="strWhere" name="strWhere">
	<input type="hidden" id="strSources" name="strSources">
	<input type="hidden" id="strChannels" name="strChannels">
	<input type="hidden" id="strSortMethod" name="strSortMethod">
	<input type="hidden" id="strDefautCols" name="strDefautCols">
	<input type="hidden" id="strStat" name="strStat">
	<input type="hidden" id="iOption" name="iOption">
	<input type="hidden" id="iHitPointType" name="iHitPointType">
	<input type="hidden" id="bContinue" name="bContinue">
	<input type="hidden" id="index" name="index">
	<input type="hidden" id="filterChannel" name="filterChannel">
	<input type="hidden" id="area" name="area" value="<%=area%>">			
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
            	 	  <img  src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>
<!--顶部显示-->
<!--筛选结果-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="dropdown col-xs-4">
	   <button type="button" class="btn btn-sm btn-warning dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">
		筛选结果
		<span class="caret"></span>
	  </button>
	<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
		<li role="presentation">
		<%
		if(currentRecord==totalRecord){
		%>
			<a role="menuitem" tabindex="-1" href="#">全部(<%=totalRecord%>)条</a>
		<%}else{%>
			<a role="menuitem" tabindex="-1" href="javascript:getPatentByChannel('<%=strSources%>','<%=totalRecord%>');">全部(<%=totalRecord%>)条</a>
		<%}%>
		</li>
<%
String filterChannelName = "";

	for (WASSectionInfo info : ls_SectionInfo) {
//		System.out.println("SectionName="+info.getSectionName());

//		if(info.getRecordNum()==currentRecord){
		if (info.getChannelName().equals(filterChannel)) {
			filterChannelName = info.getSectionName();
%>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#"><%=info.getSectionName()%>(<%=info.getRecordNum()%>)条</a></li>
<%
		}else{
%>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:getPatentByChannel('<%=info.getChannelName()%>','<%=info.getRecordNum()%>');"><%=info.getSectionName()%>(<%=info.getRecordNum()%>)条</a></li>
<%
		}			
%>
		
<%
	}
	
	filterChannelName = filterChannelName.equals("")?"全部":filterChannelName;
%>
	</ul>
         </div>
		<div class="col-xs-8" style="line-height: 30px;">
			<%=filterChannelName%>(<%=currentRecord%>)条
		</div>
	</div>
</div>
<!--筛选结果-->

<!--单条记录-->
<%
	com.opensymphony.xwork2.ActionContext cxt = com.opensymphony.xwork2.ActionContext.getContext();
   	java.util.Map<String, Object> _application = cxt.getApplication();
    
	List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)_application.get("channelInfoList_fr");
	List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)_application.get("channelInfoList_cn");
		
	java.util.HashMap<String,String> hm_channel = new java.util.HashMap<String,String>();
	for(ChannelInfo ci:channelInfoList_fr)
	{  
//		System.out.println(ci.getIntChannelID());
		hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
	}
//	HashMap<String,String> hm_channel_cn = new HashMap<String,String>();
	for(ChannelInfo ci:channelInfoList_cn)
	{  
//		System.out.println(ci.getIntChannelID());
		hm_channel.put( ci.getChrTRSTable(),ci.getChrChannelName());
	}
	
	patentInfoList=(List<PatentInfo>)request.getSession().getAttribute("list");
/* 	
	String LatestFlzt = DataAccess.getProperty("LatestFlzt")==null?"0":DataAccess.getProperty("LatestFlzt");
	java.util.Map<String, String> lastestFlztInfo = null;
	if(LatestFlzt.equals("1")){
		lastestFlztInfo = (java.util.Map<String, String>)request.getSession().getAttribute("lastestFlztInfo");
	}
 */	
//	System.out.println("patentInfoList="+patentInfoList.size());	
//	totalRecord  = (Long)request.getAttribute("totalRecord");	
//	List<WASSectionInfo> ls_SectionInfo = (List<WASSectionInfo>)request.getAttribute("sections");
	
	for (PatentInfo pi_info : patentInfoList) {
System.out.println("SectionName="+pi_info.getAb());
		String NationTypeName = hm_channel.get(pi_info.getSectionName());
				
		if(NationTypeName==null){
			java.util.Iterator iter = hm_channel.entrySet().iterator();
			while (iter.hasNext()) {
				java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();
				String key = (String)entry.getKey();
				String val = (String)entry.getValue();
						
				if(key.indexOf(pi_info.getSectionName())>-1){
					NationTypeName = val;
					break;
				}
			}
		}
				
		
/* 		String Pi_LatestFlztInfo = "";
		if(pi_info.getCountryCode().toUpperCase().equals("CN")
				&&LatestFlzt.equals("1")
				){
				Pi_LatestFlztInfo = lastestFlztInfo.get(pi_info.getAn());
			} */
		
		
%>
<div class="container dantiao">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<div class="row">
		<div class="col-xs-12"><a onClick="javascript:getDetail('<%=pi_info.getId()%>')"><%=pi_info.getTi()%> (<%=pi_info.getAn()%>) </a><span class="label label-info"><%=NationTypeName%></span>
		<%
//		if(LatestFlzt.equals("1"))
		String Pi_LatestFlztInfo = pi_info.getFlzt();
		{
					if(Pi_LatestFlztInfo!=null&&Pi_LatestFlztInfo.equals("在审")){
						out.print("&nbsp;<span class=\"label label-info\">在审</span>");
					}else if(Pi_LatestFlztInfo!=null&&Pi_LatestFlztInfo.equals("无效")){
						out.print("&nbsp;<span class=\"label label-default\">无效</span>");
					}else if(Pi_LatestFlztInfo!=null&&Pi_LatestFlztInfo.equals("有效")){
						out.print("&nbsp;<span class=\"label label-success\">有效</span>");
					}else{
						out.print("&nbsp;<span class=\"label label-default\">"+Pi_LatestFlztInfo+"</span>");
					}
		}
		%>
		
		
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12">申请（专利权）人：
		
<%
				String[] arrAppName = pi_info.getPa().split(";");
				for(int i=0;i<arrAppName.length;i++){
					out.println("<a href=\"javascript:findAppName(\'"+arrAppName[i]+"\');\">"+arrAppName[i]+"</a>");
				}
%>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12">公开（公告）日：<a href="javascript:findPubDate('<%=pi_info.getPd()%>');"><%=pi_info.getPd()%></a></div>
	</div>
	<div class="row">
		<div class="col-xs-12">摘要：<%=pi_info.getAb()%></div>
	</div>
</div>
<%
	}
%>

<%
Page nav = new Page();
nav = (Page)request.getAttribute("nav");

int pageCount = 0;
int pageIndex = 0;

pageCount = (nav.getPageCount()==null||nav.getPageCount().equals(""))?0:Integer.parseInt(nav.getPageCount());
pageIndex = (nav.getPageIndex()==null||nav.getPageIndex().equals(""))?0:Integer.parseInt(nav.getPageIndex());

//out.println("pageCount="+pageCount);
//out.println("pageIndex="+pageIndex);

//out.println("pageIndex == pageCount:"+(pageIndex == pageCount));

%>

<!--下一页-->
<div class="container" style="line-height:40px;margin-top:10px;">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<center>
<%
//out.println("pagecount="+pagecount);
//out.println("pageindex="+pageindex);

		if (pageIndex == 1) {
%>
			<input class="btn btn-default" name="FirstPage" type="button" value="第一页">&nbsp;
			<input class="btn btn-default" name="PrevPage" type="button" value="上一页">&nbsp;
<%
		} else {
%>
			<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:nextPage('1');" value="第一页">&nbsp;
			<input class="btn btn-default" name="PrevPage" type="button" onClick="javascript:nextPage('<%=(pageIndex - 1)%>');" value="上一页">&nbsp;
<%
		}
%>
		
		
		
<%
		if (pageIndex==pageCount) {
%>
			<input class="btn btn-default" name="NextPage" type="button" value="下一页">&nbsp;
			<input class="btn btn-default" name="FirstPage" type="button" value="尾&nbsp;&nbsp;页">
<%
		} else {
%>
			<input class="btn btn-default" name="NextPage" type="button" onClick="javascript:nextPage('<%=(pageIndex + 1)%>');" value="下一页">&nbsp;
			<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:nextPage('<%=pageCount%>');" value="尾&nbsp;&nbsp;页">
<%
		}
%>


	</center>
</div>



<!--下一页
<div class="container" style="line-height:40px;margin-top:10px;">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<center>
		<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:MoveTo('1');" value="第一页">&nbsp;
		<input class="btn btn-default" name="PrevPage" type="button" onClick="javascript:MoveTo('1');" value="上一页">&nbsp;
		<input class="btn btn-default" name="NextPage" type="button" value="下一页" onClick="javascript:MoveTo('3');">&nbsp;
		<input class="btn btn-default" name="FirstPage" type="button" onClick="javascript:MoveTo('1');" value="尾&nbsp;&nbsp;页">
	</center>
</div>
下一页-->
<div style="height:40px;"></div>


<%@ include file="include-bottom.jsp"%>


<%
}else{
	return;
}
%>
	</body>
</html>
