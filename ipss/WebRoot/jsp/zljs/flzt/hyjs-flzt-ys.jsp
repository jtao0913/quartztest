<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>法律状态检索【中国】-<%=website_title%></title>
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

<body>
<!--导航-->
<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="../include-head-nav.jsp"%>

<script src="<%=basePath %>semanjs/wordtips.js"></Script>
<Script src="<%=basePath %>semanjs/jquery.autocomplete.min.js"></Script>
<script type="text/javascript" src="<%=basePath %>semanjs/ui/ui.core.js"></script>
<script type="text/javascript" src="<%=basePath %>semanjs/ui/ui.dialog.js"></script>
<script type="text/javascript" src="<%=basePath %>semanjs/external/bgiframe/jquery.bgiframe.js"></script>

<%
String pageCount = (String)request.getAttribute("pageCount");
%>

		<script type="text/javascript">
			function MoveTo(pageIndex){
				if(pageIndex<=30){
					document.lawStatusSearchForm.pageIndex.value = pageIndex;
					document.lawStatusSearchForm.submit();
				}else{		
					showexp("游客模式仅能浏览30页，如有需要请拨打4001880860");		
				}				
			}
			
			function JumpTo(){
				var jumpPage = document.getElementById("txtJumpPageNumber").value;
				
				if (jumpPage <= 0) {
					MoveTo(0);
				} else if (jumpPage <= ${requestScope.lawpage.pageCount} ) {
					MoveTo(jumpPage - 1);
				} else {
					MoveTo(${requestScope.lawpage.pageCount} - 1);
				}
			}

	   function showDetail(index){
				//alert(index);
				document.getElementById("detail_an").innerHTML = 
				
				"<a href='#' onclick='viewDetail(\""+document.getElementById("detail_"+index+"_an").innerHTML+"\")'>"+document.getElementById("detail_"+index+"_an").innerHTML+"</a>";
				document.getElementById("detail_status").innerHTML = document.getElementById("detail_"+index+"_status").innerHTML;
				document.getElementById("detail_day").innerHTML = document.getElementById("detail_"+index+"_day").innerHTML;
				document.getElementById("detail_statusinfo").innerHTML = document.getElementById("detail_"+index+"_statusinfo").innerHTML;
		}
			
		function viewDetail(an) {
			if(an!="" && an.indexOf("CN")<0)
				an="CN"+an;
			document.detailSearchForm.strWhere.value = "申请号=" + an;
			document.detailSearchForm.submit();
		}
			
		function downloadLawStatus()
		{
			if(typeof($("#downloadstart").val())=="undefined" || $("#downloadstart").val()=="")
				{
					alert("请填写下载起始记录号");return false; 
				}
			else
			{
				 if(isNaN($("#downloadstart").val())) 
			  	 { 
			  	    alert("下载起始记录号不是数字"); return false; 
			     }else
			     {
			     	 if( parseInt($("#downloadstart").val()) <1 )
			  	       {  alert("下载起始记录号不能小于1"); return false; }
			     }
			}
			
			if(typeof($("#downloadend").val())=="undefined" || $("#downloadend").val()=="")
			{
				alert("请填写下载结束记录号");return false;
			}
			else
			{
				 if(isNaN($("#downloadend").val()) ) 
			  	 { 
			  	    alert("下载结束记录号不是数字"); return false; 
			     }else
			     {
			     	 if( parseInt($("#downloadend").val()) <1 )
			  	       {  alert("下载起始记录号不能小于1"); return false; }
			  	     if( parseInt($("#downloadend").val()) < parseInt($("#downloadstart").val())  )
			  	       {  alert("下载起始记录号不能小于起始记录号"); return false; }
			  	     if( ( parseInt($("#downloadend").val()) - parseInt($("#downloadstart").val()) ) > <%=SetupAccess.getProperty(SetupConstant.BATCHDOWNLOADSTATUSMAX)%>   )
			  	       {  alert("下载记录数不能大于<%=SetupAccess.getProperty(SetupConstant.BATCHDOWNLOADSTATUSMAX)%>"); return false; }
			     }
			}
			
			$("#downloadLawStatusForm").submit();
		}

		function gotoPage() {
			var pageCount = <%=pageCount%>;
//			alert(document.getElementById("pageIndex").value);
			var pageIndex = document.getElementById("pageIndex").value;
//			alert("3333"+pageIndex);
			var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数

		    if (!re.test(pageIndex)) {
//				alert("请输入数字！");
				alert("请输入1至"+pageCount+"的正确页码！");
				return;
		    }
//		    alert("2222");
//		    document.searchForm.action = "<%=basePath%>overviewSearch.do";
//			document.searchForm.pageIndex.value = page;
//			document.searchForm.submit();

			if(pageCount>=pageIndex){
				document.lawStatusSearchForm.pageIndex.value = pageIndex;
				document.lawStatusSearchForm.submit();
			}else{
				alert("请输入1至"+pageCount+"的正确页码！");
			}
		}
		
		function gotoPage11() {
//			alert(<%=pageCount%>);
			var pageCount = <%=pageCount%>;
			
			var page = document.getElementById("pageEnterBtn").value;

//			alert((pageCount>page));
			
			var re = /^[1-9]+[0-9]*]*$/;   //判断字符串是否为数字     //判断正整数    
		    if (!re.test(page)) {
//				alert("请输入数字！");
				alert("请输入1至"+pageCount+"的正确页码！");
				return;
		    }
			if(pageCount>page){
			    document.searchForm.action = "<%=basePath%>overviewSearch.do";
				document.searchForm.pageIndex.value = page;
				document.searchForm.submit();
			}else{
				alert("请输入1至"+pageCount+"的正确页码！");
			}
		}
		</script>
	</head>

<body>

<%@ include file="../include-head-secondsearch.jsp"%>

<%String type = "flzt";%>
<%@ include file="../include-head-jiansuo.jsp"%>


<!--
记录总数:${requestScope.totalRecord} &nbsp;&nbsp;共${requestScope.lawpage.pageCount}页  &nbsp;&nbsp;
-->



<!--内导航条-->

		<div id="nav_keleyi_com" style="width:1120px;clear:both;margin:auto;">
			<div class="row-fluid">
				<div name="top-navbar" class="navbar navbar-inverse">
					<form action="doOverviewSearch?cid=" method="post"
				name="searchForm" id="searchForm">
				<input type="hidden" name="filterItems" id="filterItems"
					value=""> <input type="hidden"
					name="strWhere" value="名称,摘要,申请号,公开（公告）号,分类号,主分类号,发明（设计）人, 申请（专利权）人,专利代理机构,代理人,地址+=(咖啡%)" id="strWhere" /> <input
					type="hidden" name="start" value="1" id="start" /> <input
					type="hidden" name="limit" value="20" id="pageLimit" /> <input
					type="hidden" name="option" value="2"
					id="ioption" /> <input type="hidden" name="strSortMethod"
					value="+TABLE_SN,RELEVANCE" id="strSortMethod" /> <input
					type="hidden" name="channelId" value="FMZL,SYXX,WGZL"
					id="channelId" /> <input type="hidden" name="strSources"
					value="" id="strSources" /> <input
					name="crossLanguage" id="crossLanguage" type="hidden"
					value="" /> <input type="hidden"
					name="strSynonymous" value=""
					id="strSynonymous" /> <input type="hidden" name="filterChannel"
					value="" id="filterChannel" /> <input
					type="hidden" name="key2Save" value=""
					id="key2Save" /> <input type="hidden" name="keyword2Save"
					value="" id="keyword2Save" /> <input
					type="hidden" name="checkSimilar" value="false" />
					<strong>
					<div class="navbar-inner" style=" background-image: none;background-repeat:no-repeat;filter: none;background-color: #999966; border: 0px;border-bottom:0px solid #5cc0cd;">
						<div class="container">
							<div class="nav-collapse collapse">
								<ul class="nav" >
									<li style="color:#ffffff;line-height:40px ;">
										中国专利法律状态&nbsp;&nbsp;&nbsp;&nbsp;总数:${requestScope.totalRecord}
									</li>		
								</ul>
								<!-- 
								<ul class="nav pull-right">
									<li>
										<a href="#"><span class="icon-white  icon-step-backward"></span></a>
									</li>
									<li>
										<a href="#"><i class="icon-white  icon-chevron-left" ></i> </a>
									</li>
									<li style="color: #fff;margin-top:8px;"><input type="text" style="width: 30px; height: 19px; margin: 0px; line-height: 15px; padding: 0px" value='1' id="pageEnterBtn"><span>/${requestScope.lawpage.pageCount}</span>
									</li>
									<li><a href="#" ><i class="icon-white  icon-chevron-right"></i> </a>
									</li>
									<li><a href="#" ><i class="icon-white  icon-step-forward"></i> </a>
									</li>
								</ul>
								 -->
								 <n:lawpage pageCount="${requestScope.lawpage.pageCount}"
				pageIndex="${requestScope.lawpage.pageIndex}"></n:lawpage>
							</div>
						</div>
					</div>
					</strong>
					</form>
				</div>
			</div>

		</div>
<!--内容页面-->	
<div style="width:1020px;clear:both;margin:auto;">
   <div class="span12">
   <c:forEach var="legalStatusInfo" items="${requestScope.legalStatusInfoList}" varStatus="status">
   	<div class="row-fluid">
						<div>
							<div class="span12">
								<strong class="text-info">申请号：${legalStatusInfo.strAn}</strong>
							</div>
						</div>
						<div class="row-fluid">
							<span class="p-inline muted"><b>法律状态： </b>${legalStatusInfo.strLegalStatus}</span>
							<span class="p-inline muted"><b>法律状态公告日： </b>${legalStatusInfo.strLegalStatusDay}</span>
						</div>
						<div class="row-fluid">
							<span class="p-inline muted"><b>法律状态信息： </b>${legalStatusInfo.strStatusInfo}</span>
						</div>
						<hr />
	</div>
	</c:forEach>

	
   </div>
</div>



		<form name="detailSearchForm" 
			action="<%=basePath%>search.do?method=detailSearch" method="post"
			target="_blank">
			<input type="hidden" name="strWhere">
			<input type="hidden" name="strSources" id="strSources"
				value="fmzl_ab,fmzl_ft,syxx_ab,syxx_ft,wgzl_ab">
			<input type="hidden" name="strSortMethod"
				value="RELEVANCE">
			<input type="hidden" name="strDefautCols"
				value="">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iOption" value="2">
			<input type="hidden" name="iHitPointType"
				value="115">
			<input type="hidden" name="bContinue"
				value="">
			<input type="hidden" name="index">
			<input type="hidden" name="area" value="cn">
			<input type="hidden" name="dateLimit" id="dateLimit" value="">
			<input type="hidden" name="appNum" id="appNum"  value="">
			<input type="hidden" name="simFlag" id="simFlag"  value="">
			<input type="hidden" name="apdRange" id="apdRange"  value="">
			<input type="hidden" name="sqFlag" id="sqFlag"  value="">
			<input type="hidden" name="singledb" id="singledb"  value="">
		</form>
		
		<form name="lawStatusSearchForm"
			action="<%=basePath%>legalStatusSearch.do" method="post"
			target="_self">
			<input type="hidden" name="strWhere"
				value="${requestScope.strWhere }">
			<input type="hidden" name="pageIndex">
		</form>








<!-- 

		<div align="center">


			<table border="1" cellspacing="2" cellpadding=0 width="98%" >
				<tr bgcolor="#4B7935" height="120%" align="center">
					<td bgcolor="#D9F0FD" nowrap>
						<font ><b>记录号</b>
						</font>
					</td>
					<td bgcolor="#D9F0FD" nowrap>
						<font ><b>申请号</b>
						</font>
					</td>
					<td bgcolor="#D9F0FD" nowrap>
						<font ><b>法律状态</b>
						</font>
					</td>
					
					<td bgcolor="#D9F0FD" nowrap>
						<font ><b>法律状态公告日</b>
						</font>
					</td>
				</tr>
				<c:forEach var="legalStatusInfo" items="${requestScope.legalStatusInfoList}" varStatus="status">
					<tr>
						<td class="gray" height="26">
							${legalStatusInfo.index}
						</td>
						<td id="detail_${status.index}_an" class="blue1" onClick="showDetail(${status.index})" style="cursor:hand">
							${legalStatusInfo.strAn}
						</td>
						<td id="detail_${status.index}_status" class="gray">
							${legalStatusInfo.strLegalStatus}
						</td>
						<td id="detail_${status.index}_day" class="gray">
							${legalStatusInfo.strLegalStatusDay}
						</td>
						<span style="display:none" id="detail_${status.index}_statusinfo">${legalStatusInfo.strStatusInfo}</span>
					</tr>
				</c:forEach>


			</table>
<hr>
		<div>
			记录总数:${requestScope.totalRecord} &nbsp;&nbsp;共${requestScope.lawpage.pageCount}页  &nbsp;&nbsp;
			<n:lawpage pageCount="${requestScope.lawpage.pageCount}"
				pageIndex="${requestScope.lawpage.pageIndex}"></n:lawpage>
		</div>	
		<div>
		 <% if(SetupAccess.getProperty(SetupConstant.BATCHDOWNLOADLAWSTATUS)!=null && SetupAccess.getProperty(SetupConstant.BATCHDOWNLOADLAWSTATUS).equals("1")){%>
							     
		<form action="<%=basePath%>download.do?method=downloadLawStatus" method="post" 
		                 target="blank" name="downloadLawStatusForm" id="downloadLawStatusForm">
			<input type="hidden" name="strWhere" value="${requestScope.strWhere }">
			下载:从第<input type="text" value='1' name="downloadstart" id="downloadstart"/>
			到<input type="text" value='100' name="downloadend" id="downloadend" />
			<input type='button' onclick="downloadLawStatus();return false;" value="下载" />
		</form>
		<%} %>
		</div>	
		<div>
		<table width="650" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" class="collapse">
		<tr><td nowrap bgcolor=#D9F0FD class="gray">申请号</td><td class="gray" id="detail_an">&nbsp;</td></tr>
		<tr><td nowrap bgcolor=#D9F0FD class="gray">法律状态公告日</td><td class="gray" id="detail_day">&nbsp;</td></tr>
		<tr><td nowrap bgcolor=#D9F0FD class="gray">法律状态</td><td class="gray" id="detail_status">&nbsp;</td></tr>
		<tr><td nowrap bgcolor=#D9F0FD class="gray">法律状态信息</td><td class="gray" id="detail_statusinfo">&nbsp;</td></tr>
		</table>
		</div>
		</div>
 -->		
		<%@ include file="../include-buttom.jsp"%>
	</body>
</html>
