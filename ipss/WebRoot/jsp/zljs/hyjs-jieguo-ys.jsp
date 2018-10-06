<!DOCTYPE html>
<html lang="en">
<%@ page import="com.cnipr.cniprgz.entity.WASSectionInfo,com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.dao.ChannelDAO,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="st" uri="/WEB-INF/taglib/section.tld"%>
<%@ taglib prefix="tb" uri="/WEB-INF/taglib/tb.tld"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<%@ include file="include-head-base.jsp"%>

<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
<meta name="description" content="<%=website_title%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
<link rel="stylesheet" type="text/css" href="css/ie.css">
<![endif]-->
<%
response.setHeader("X-XSS-Protection","0");
response.setCharacterEncoding("UTF-8");

int ABSTBatchCount = (Integer)request.getSession().getAttribute("ABSTBatchCount");

String userId = "";
if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
{
	userId = ((String)request.getSession().getAttribute(Constant.APP_USER_ID));	
}

int intAnalyseState = 0;
if(request.getSession().getAttribute("intAnalyseState")!=null)
{
	intAnalyseState = ((Integer)request.getSession().getAttribute("intAnalyseState"));	
}
int intAnalyseNumUpperlimit = 0;
if(request.getSession().getAttribute("intAnalyseNumUpperlimit")!=null)
{
	intAnalyseNumUpperlimit = ((Integer)request.getSession().getAttribute("intAnalyseNumUpperlimit"));	
}

//System.out.println("intAnalyseState="+intAnalyseState);
//System.out.println("intAnalyseNumUpperlimit="+intAnalyseNumUpperlimit);
//String area = (String)session.getAttribute("area");
//area="cn";
String area = request.getParameter("area");
if(area==null||area.equals("")){
	area="cn";
}
//String strWhere = (String)session.getAttribute("strWhere");
//String strSources = (String)session.getAttribute("strSources");
String strWhere = request.getParameter("strWhere");
//System.out.println(strWhere);

String strSources = request.getParameter("strSources");
//String semanticexp = request.getParameter("semanticexp");

//out.println("area="+area);
//System.out.println("strWhere="+strWhere);
//System.out.println("strSources="+strSources);
String logicexpid = request.getParameter("logicexpid")==null?"":request.getParameter("logicexpid").toUpperCase();
if(logicexpid!=null&&!logicexpid.equals("")) {
//ExpressionInfo ei = expFunc.getExpbyID(Integer.parseInt(logicexpid));
//System.out.println(ei.getExpression());
//System.out.println(ei.getSources());				
//strWhere = (String)session.getAttribute("strWhere");
//strSources = (String)session.getAttribute("strSources");
}

String _action = "createPDFZip.do";
//0:tif;1:png
String showPIC = "0";

//treeType==-1，表格检索
//treeType==-2，逻辑检索。逻辑检索不记录到历史表达式中
int treeType = request.getParameter("treeType")==null?-1:Integer.parseInt(request.getParameter("treeType"));
//out.println("treeType="+treeType);
String overviewtree = (treeType==-1||treeType==-2)?"0":"1";

/*
String type = "";
if(treeType==0){
	type="ipc";
}else if(treeType==4){
	type="gmjj";
}else if(treeType==5){
	type="address";
}
*/
//out.println("treeType="+treeType);

//int shixiao = 0;
String nav_parentId = request.getParameter("parentId");
if(nav_parentId==null){
	nav_parentId="0";
}

String jumpNavID = request.getParameter("jumpNavID");
String translate = (String)application.getAttribute("translate");
//////////////////////////////////////////////////////////////////////////////
String userID = (String)session.getAttribute("userid");
com.trs.usermanage.UserManage usermanage = new com.trs.usermanage.UserManage();

//int ABSTBatchCount = usermanage.getABSTBatchCount();
//out.println("ABSTBatchCount="+ABSTBatchCount);

String strTradeInfoSel = usermanage.getUserTradeInfoByUserID(Integer.parseInt(userID),treeType);
//System.out.println("strTradeInfoSel="+strTradeInfoSel);
//3#guest#750$

String selTrade = "";
if(strTradeInfoSel!=null&&!strTradeInfoSel.equals("")){
//arrSelTrade = (strTradeInfoSel.split("#")[2]).split("[$]");
	selTrade = strTradeInfoSel.split("#")[2];
}

if(jumpNavID!=null&&!jumpNavID.equals("")){
	selTrade=jumpNavID;
}
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>检索结果-<%=website_title%></title>
<style type="text/css">
#winlogin{
    color: #fff800;
    background-color: #fff800;
    opacity: 0.2;
    cursor:pointer;
}
.ui_dialog_1{
	background-color:#E6E6E6;
}
</style>
</head>

<body>
<!--导航-->

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

<%@ include file="include-kkpager.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=basePath%>css/kkpager_blue.css" />
<!-- 
<script src="<%=basePath%>js/hyjs-jieguo.js"></script>
include-head-secondsearch-jieguo.jsp
-->

<input type="hidden" id="searchType" value=""/>
<input type="hidden" id="overviewtree" value="<%=overviewtree%>"/>
<input type="hidden" id="treeType" value="<%=treeType%>"/>










<!--内导航条-->

<%@ include file="include-jieguo-left-js.jsp"%>

		<!--内容页面-->
		<div style="width:1240px;clear:both;margin:auto;">
				
			<div class="row-fluid">							
				
<!--span3左-->
<div class="span3">
<%
//out.println("treeType="+treeType);
String sheetname = "分类导航";
if(treeType==1){
	sheetname = "行业分类导航";
}else if(treeType==3){
	sheetname = "专题数据库";
}else if(treeType==4){
	sheetname = "国民经济分类导航";
}else if(treeType==5){
	sheetname = "国内省市导航";
}else if(treeType==0){
	sheetname = "IPC分类导航";
}
%>
<div style="margin-bottom:8px;"><a href="index.jsp" style="text-decoration: none;"><img style="width:236px" src="images/area/<%=com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode")%>/common/com_2/img/index/s_logo.png"></a></div>
<%if(treeType!=-1&&treeType!=-2){ %>
				<div class="bs-docs-example">					 
					<ul id="myTab" class="nav nav-tabs">						
						<li class="active" id="tab1"><a href="#home" data-toggle="tab"><%=sheetname%></a></li>
						<li class="" id="tab2" style="display:none"><a href="#profile" data-toggle="tab">结果筛选</a></li>							
					</ul>
					
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade active in" id="home">
							<div
								style="overflow: hidden; background: none repeat scroll 0% 0% rgb(245, 245, 245); border-radius: 4px 4px 4px 4px; box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.05) inset;">
								<ul class="ztree" id="zTreee"
									style="min-height: 800px; font-size: 12px; background-color: #fefefe;"></ul>
								<%@ include file="include-jieguo-left-tree.jsp"%>
							</div>
						</div>
						<div class="tab-pane fade" id="profile" style="min-height: 800px; font-size: 12px; background-color: #fefefe;">
							<%@ include file="include-jieguo-left-statis.jsp"%>
						</div>
					</div>
				</div>
<%}else{%>
				<%@ include file="include-jieguo-left-statis.jsp"%>
<%}%>
</div>
				
				<%@ include file="include-jieguo.jsp"%>
				
			</div>
		</div>


<%@ include file="include-downloadmodal.jsp"%>


<%@ include file="include-buttom.jsp"%>
<script type="text/javascript">
$(".fancybox").fancybox();

function click_a(divDisplay) {
	if(document.getElementById(divDisplay).style.display != "block") {
		document.getElementById(divDisplay).style.display = "block";
	} else {
		document.getElementById(divDisplay).style.display = "none";
	}
}
</script>

</BODY>
	
</HTML>