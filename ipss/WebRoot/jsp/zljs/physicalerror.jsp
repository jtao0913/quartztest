<!DOCTYPE html>
<html lang="en">
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.dao.ChannelDAO,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="st" uri="/WEB-INF/taglib/section.tld"%>
<%@ taglib prefix="tb" uri="/WEB-INF/taglib/tb.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>专利检索查询,专利搜索下载-知识产权综合服务平台</title>

	</head>

<body>
<!--导航-->

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>
<%@ include file="include-head-secondsearch.jsp"%>

<%
String type = "";
%>
<%@ include file="include-head-jiansuo.jsp"%>
<%
     String search_error  = (String)request.getAttribute("search_error");
     String area  = (String)request.getAttribute("area");
//out.print(search_error);
%>
<div style="width:1014px;margin: auto;padding-top:40px;">
 <div class="row-fluid">
    <div class="span3">
             <img src="<%=basePath%>common/com_2/img/error.png"/> 
    </div> 
     <div class="span9" style="margin-top:60px;">
非常抱歉，检索失败：<strong style="color:#6699cc"><%=search_error%></strong>
<!-- 
没有找到与您检索 “<strong style="color:#6699cc"><%=request.getAttribute("strWhere")%></strong>” 的相关结果。
 -->
<br>
<br>
<br>

建议您：<br>
1. 请仔细查看您输入的字词是否有误，比如大小写<br>
2. 请尝试其他的检索词，去掉那些不必要的字词或者尝试前后加%<br>
3. 调整检索词，改用比较常见的字词<br>
4. 阅读《帮助中心》也许会对您有帮助:您也可以通过   <a href="<%=basePath%>wap/biaoge.jsp">表格检索</a>、<a href="<%=basePath%>wap/mingling.jsp">命令行检索</a> 进行比较全面查询。
     </div> 
  </div>   
</div>
     
<div style="height:120px;"></div>
<%@ include file="include-buttom.jsp"%>
  </body>
</html>
