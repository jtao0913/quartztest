<%@ page import="com.cnipr.cniprgz.commons.DataAccess,com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>定期预警-预警历史</title>

<link rel="stylesheet" href="<%=basePath%>css/default.css" type="text/css" media="all"/>

<link href="<%=basePath%>css/navi.css" rel="stylesheet" type="text/css"/>

</head>
<body>
 
<%
TSimpleWarnDAO simpleWarnDAO  =  new TSimpleWarnDAO(); 
TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO();
TSimpleWarn simpleWarn  = null;
int userId = -1; 
String order =  request.getParameter("order") ;
String sort =  request.getParameter("sort") ;
int start = 1;
List simpleExecutes = null;
Pagination pagination = null ;

String warnid =  request.getParameter("warnid");

if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
{
	userId = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));
	
	if(request.getParameter("start")!=null)
		start = Integer.parseInt(request.getParameter("start"));
	else
		start = 1; 

	if(warnid!=null)
	{
		simpleWarn = simpleWarnDAO.getSimpleWarn(Integer.parseInt(warnid));
		try {
			pagination = simpleExecuteDAO.findSimpleExecutes(warnid,start, Constant.WARNPAGESIZE);
			simpleExecutes = pagination.getList();			
		} catch (Exception e) { 
			e.printStackTrace();
		}		
	}
}


if(warnid!=null)
{
%>

<span style="margin-left:50px;font-size:14px"><a href="getMyWarm.do">返回</a></span>
<form name="searchForm" id="searchForm" action="<%=basePath%>warnExecuteList.do">
<table border="0" width="80%" align="center" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#FFFFFF"> 

<tr><td background="../images/title_bg.gif" colspan="3"  class="title" height="30">


[<%=simpleWarn.getName()%>]的预警历史<a href="#" class="exptip" rel=".expmemo">表达式</a>
<div class="expmemo" style="display:none;">
	<%=simpleWarn.getExpression() %>
</div>
<br> 

</td></tr>
<tr class="simpleWarnFirstTR">
<!--td>全选<input type="checkbox" name="" value="" /></td--> 
<td class="simpleWarnTD">周期</td> 
<td class="simpleWarnTD">日期区间</td>
<td class="simpleWarnTD">专利数量</td>
<td class="simpleWarnTD">操作</td>
</tr>
 
<%
	if(simpleExecutes!=null)
	for(int i=0;i<simpleExecutes.size();i++){
		TSimpleExecute simpleExecute = (TSimpleExecute)simpleExecutes.get(i);
%>
<tr class="simpleWarnTR${list_index%2}" align="center">
<!--td><input type="checkbox" name="" value="" /></td--> 
<td><%= Constant.periodMap.get(simpleExecute.getPeriod()) %></td> 
<td><%= DateUtil.format(simpleExecute.getPdStart(),"yyyy-MM-dd")%>至<%=DateUtil.format(simpleExecute.getPdEnd(),"yyyy-MM-dd")%></td> 
<td><%=simpleExecute.getAmount() %><%if(simpleExecute.getIsnew()==1)out.print("<span style='color:red'>未读</span>"); %></td> 
<td class="redl">
<a href="#" onClick="javascript:isnew('<%=simpleExecute.getId()%>');$('#dispForm<%=simpleExecute.getId()%>').submit();">查看</a>
<a href="javascript:Util.del('确定删除吗？','warnExecuteDo.do?method=delete&id=<%=simpleExecute.getId()%>&start=<%=start %>&warnid=<%=simpleWarn.getId() %>');">删除</a> 
</td>
</tr>

<%}%>

<tr>
<td colspan='6' height="43" align="right" background="../images/pic002.jpg" class="bluel">
	<input type="hidden" name="start" value="0" id="start"/>
	<input type="hidden" name="warnid" value="<%=simpleWarn.getId() %>" id="warnid"/>

<%@ include file="/lib/pagination.jsp"%>
</td>
</tr>
</table>
</form>
 


		<%
		for(int i=0;i<simpleExecutes.size();i++){
			TSimpleExecute simpleExecute = (TSimpleExecute)simpleExecutes.get(i);
			String expression =  simpleWarn.getExpression()+" and "+
			" 公开（公告）日=("+DateUtil.format(simpleExecute.getPdStart(),"yyyy.MM.dd")
					+" to "+DateUtil.format(simpleExecute.getPdEnd(),"yyyy.MM.dd")+")";
			String area = "cn";
			if(simpleWarn.getArea()==0)
				area = "fr";
		%>
		
		
			 <FORM id="dispForm<%=simpleExecute.getId() %>" method="post" target="_blank" action="<%=basePath%>overviewSearch.do?method=overviewSearch">
					<input type="hidden" name="securityCode" value="<%=SecurityTools.getSecurityCode(expression) %>">
					<input type="hidden" name="appType" value="2">
					<input type="hidden" name="method" value="detailSearch"> 
					<input type="hidden" name="strSortMethod" value="RELEVANCE">
					<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
					<input type="hidden" name="strStat" value="">
					<input type="hidden" name="iHitPointType" value="115">
					<input type="hidden" id="bContinue" name="bContinue" value=""> 
					<input type="hidden" name="iOption" value="2">
					<input type="hidden" name="index" value="0">
					<input type="hidden" name="area" value="<%=area%>">
					<input type="hidden" name="dateLimit" id="dateLimit" value="">
					<input type="hidden" name="appNum" id="appNum"  value="">
					<input type="hidden" name="simFlag" id="simFlag"  value="">
					<input type="hidden" name="apdRange" id="apdRange"  value="">
					<input type="hidden" name="navID" id="navID"  value="0"> 
					<input type="hidden" id="strChannels" name="strChannels" value="<%=simpleWarn.getChannels() %>"> 
					<input type="hidden" id="strWhere"  name="strWhere" value="<%=expression %>" /> 
		</FORM>
		<%}%>

 
<%} %>



<div id="alert" style="display:none; cursor: default;padding-top:10px"> 
	       <table align='center'>
		       <tr>
		       <td valign='middle' width="35"><img src="${base}/images/right.png" border="0" width="35" height="35" /></td>
		       <td height='35'>操作成功</td></tr>
		        <tr> 
		        <td colspan='2'>
		        <input type="button" id="alert_yes" class="button2" onclick="$.unblockUI({fadeOut:0});location.reload();" value="确定" /> 
		        </td>
		        </tr>
	        </table>
</div>



<script type="text/javascript">
function isnew(id)
{
	$.ajax({
			type : "GET",
				url : "<%=basePath%>warnExecuteDo.do?method=isnew&start=<%=start%>",
//				type : "post",
				dataType : "json", 
				data : {'id':id},
				cache :  "false" ,
				success : function(json){  
					if(json.jsonMessage=="true")
					{}						
		 		}//end success
		});//end .ajax
}



 $('a.exptip').each( function(){
	  					$(this).cluetip({
	 				   	local:true, 
	 				     cluetipClass: 'jtip', 
	 				    //cluetipClass: 'rounded',
	 				  //  dropShadow: false,  
	 					sticky: true,  
	 					tracking: true,	
	 				//	activation: 'click',
	 					closePosition: 'title',
	 					closeText: '关闭',   
	 					arrows: true,
	 					width:450 	
	 					});
	 					}
	 					);
	 					
	//<![CDATA[ 
		 <%
		 if(request.getAttribute("warnMessage")!=null)
		 {
			%>
			alert('<%=request.getAttribute("warnMessage")%>');
			<% 
		 }
		 %>
  			 
		 
	//]]> 
</script>
</body>
</html>