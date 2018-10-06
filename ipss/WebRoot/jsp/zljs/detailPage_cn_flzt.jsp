<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>


<%@ include file="../../jsp/zljs/include-head-base.jsp"%>

<html>
	<head>
		<STYLE type=text/css>
		<!--
			body {
				margin-left: 0px;
				margin-top: 0px;
				margin-right: 0px;
				margin-bottom: 0px;
				scrollbar-face-color: ffffff;
				scrollbar-shadow-color: C1C1BB;
				scrollbar-highlight-color: C1C1BB;
				scrollbar-3dlight-color: EBEBE4;
				scrollbar-darkshadow-color: EBEBE4;
				scrollbar-track-color: F4F4F0;
				scrollbar-arrow-color: CACAB7;
			}
		-->
		</STYLE>
		<script src="<%=basePath%>js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript">
			function MoveTo(pageIndex){
				document.lawStatusSearchForm.pageIndex.value = pageIndex;
				document.lawStatusSearchForm.submit();
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
		
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</head>


	<body bgcolor="#F0F7FF" topmargin=0 text="#000066" link="#000066"
		vlink="#000066" alink="#000066" onLoad="">
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
			action="<%=basePath%>search.do?method=legalStatusSearch" method="post"
			target="_self">
			<input type="hidden" name="strWhere"
				value="${requestScope.strWhere }">
			<input type="hidden" name="pageIndex">
		</form>
		<div align="center">


   	<table class="table table-condensed" style="font-size:13px;">
		<tr>
			<td class="table_35" colspan="4" style="color:#f9a126;font-weight: bold;"><span class="glyphicon glyphicon-check" style="color:#f9a126;"> </span> 法律状态</td>
		</tr>
	</table>

<c:forEach var="legalStatusInfo" items="${requestScope.legalStatusInfoList}" varStatus="status">
      <table class="table table-condensed" style="font-size:13px;">
				<tr>
					<td class="table_15">申请号:</td>
					<td class="table_35">${legalStatusInfo.strAn}</td>
					<td class="table_15">法律状态公告日:</td>
					<td class="table_35">${legalStatusInfo.strLegalStatusDay}</td>
				</tr>
				<tr>
					<td class="table_15">法律状态信息:</td>
					<td class="table_35" colspan="3">${legalStatusInfo.strStatusInfo}</td>
				</tr>
				<tr>
					<td class="table_15">法律状态:</td>
					<td class="table_35" colspan="3">${legalStatusInfo.strLegalStatus}</td>
				</tr>
			</table>
</c:forEach>



<!-- 

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
			<input type='button' onClick="downloadLawStatus();return false;" value="下载" />
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
	</body>
</html>