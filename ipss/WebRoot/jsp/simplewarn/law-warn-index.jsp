<%@ page import="com.cnipr.cniprgz.commons.DataAccess,
com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib prefix="s" uri="/WEB-INF/taglib/section.tld"%>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>
<%@ page import="com.cnipr.cniprgz.func.* "%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>法律状态预警-首页</title> 
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Language" content="UTF-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="P3P" content="CP=CAO PSA OUR"/>  

<script type="text/javascript" src="<%=basePath%>scripts/app/global.js"></script>   
<script type="text/javascript" src="<%=basePath%>scripts/app/system.js"></script>
<script type="text/javascript" src="<%=basePath%>scripts/jquery/jquery-1.3.2.min.js"></script>   
<link rel="stylesheet" href="<%=basePath%>css/default.css" type="text/css" media="all"/>

<link href="<%=basePath%>css/navi.css" rel="stylesheet" type="text/css"/>

<script src="<%=basePath%>scripts/jquery/cluetip/jquery.cluetip.js" type="text/javascript"></script>
<style media="all" type="text/css">@import "<%=basePath%>scripts/jquery/cluetip/jquery.cluetip.css";</style>



<script type="text/javascript">
<!--  
jQuery(function($){  
	 $('a.tooltip').each( function(){
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
});
-->
</script>
</head>

<body>

<%

  TLawWarnDAO lawWarnDAO  =  new TLawWarnDAO(); 
  int userId = -1; 
  String order =  request.getParameter("order") ;
  String sort =  request.getParameter("sort") ;
  int start = 1;
  List lawWarns = null;
  Pagination pagination = null ;

	// 通过ID，获取数据库的具体信息
   ChannelFunc channelFunc = new ChannelFunc();
   channelFunc.setChannelDAO(new ChannelDAO());
   
if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
{
	userId = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));
	
	if(request.getParameter("start")!=null)
		start = Integer.parseInt(request.getParameter("start"));
	else
		start = 1; 
	try {
		pagination = lawWarnDAO.findLawWarns(userId, false, order, sort, start, Constant.WARNPAGESIZE);
		lawWarns = pagination.getList(); 
		
	} catch (Exception e) { 
		e.printStackTrace();
	}
}
%>
 

<form name="searchForm" id="searchForm" action="<%=basePath%>jsp/simplewarn/law-warn-index.jsp">
<table width="95%" align="center" borderColor="#ffffff" bgColor="#d0e5fa" border="0" cellSpacing="1" cellPadding="0">
<tr class="simpleWarnFirstTR">
<td class="simpleWarnTD" width="20%">专利名称</td>
<td class="simpleWarnTD" width="15%">申请号</td>
<td class="simpleWarnTD" width="20%" style='display:none;'>数据库</td>
<td class="simpleWarnTD" width="50">周期</td>
<td class="simpleWarnTD" width="50">状态</td>
<td class="simpleWarnTD" width="50">预警</td>
<td class="simpleWarnTD" width="160">创建时间</td>
<td class="simpleWarnTD" width="160">操作
 <a href="#" class="tooltip"  rel=".memo1"><img src="<%=basePath%>images/tooltip.gif" border='0'/></a> 
</td>
</tr>
 <div class="memo1"> 
	<strong>删除：</strong>删除该预警任务。<br>
	<strong>续订：</strong>对每个预警任务，系统根据所设预警周期执行系统指定次数预警，指定次数之后如果用户还需继续预警，请点击续订。<br> 
 </div>

<% if(userId!= -1  && lawWarns!=null)
{
	for(int i=0;i<lawWarns.size();i++)
	{
		TLawWarn lawWarn = (TLawWarn) lawWarns.get(i);
	%>
	<tr class="simpleWarnTR<%=(i%2) %>">
	<td>
	<%if(lawWarn.getName().length()>20){
	out.print(lawWarn.getName().substring(0,20) ); %>
	<div class="expmemo<%=i %>" style="display:none;"><%=lawWarn.getName() %></div>
	<%}else{  
		out.print(lawWarn.getName());
     } %>
	</td>
	
	<td class="redl" width="160" style="word-wrap:break-word">
	<a href="#" onclick="showDetail('<%=lawWarn.getAn() %>')"  target=""><%=lawWarn.getAn() %></a></td>	
	<td style='display:none;'><%
	String channelArray[]  = StringUtil.splitStringToArray(lawWarn.getChannels(),",");
	
	List<ChannelInfo> channelList = channelFunc.getInfoMapByChannel(channelArray);
 
	// TRS表名 （egg：发明专利，实用新型，外观设计）  
	String strTRSTableName = "";
	if(channelList!=null)
	for (ChannelInfo info : channelList) { 
		strTRSTableName += info.getChrChannelName() + ",";
	}	 
	%>
	<%=strTRSTableName %>
	</td>
	<td><%= Constant.periodMap.get(lawWarn.getPeriod()) %></td>
	<td><% if(lawWarn.getStatus()>0)out.print("可用");else out.print("不可用"); %></td> 
	<td><% if(lawWarn.getLastupdatetime()!=null && lawWarn.getUpdatetime()!=null && lawWarn.getLastupdatetime().getTime()!= lawWarn.getUpdatetime().getTime())out.println("<span style='color:red'>新</span>");else out.println("无更新"); %></td> 
	<td><%=DateUtil.format(lawWarn.getCreatetime(),"yyyy-MM-dd") %></td> 
	<td class="redl"> 
	<a href="<%=basePath%>search.do?method=viewLegalStatus&strAn=<%=lawWarn.getAn() %>" target="_blank">查看法律状态</a> 
	<a href="javascript:Util.del('确定删除吗？','law-warn-edit-do.jsp?method=delete&id=<%=lawWarn.getId() %>&start=<%=start %>');">删除</a>
	<% if(lawWarn.getStatus()==0 ) {%>
	<a href="law-warn-edit-do.jsp?method=renew&id=<%=lawWarn.getId() %>&start=<%=start %>">续订</a>
	<%} %>
	</td>
	</tr>
    <%}//end for %>
<tr>
<td colspan='6' height="43" align="right" background="../images/pic002.jpg" class="bluel">
<input type="hidden" name="start" value="1" id="start"/>
<%@ include file="/lib/pagination.jsp" %>
</td>
</tr>
  <%}//end if %>
</table> 
</form>





<form name="showDetailForm" id="showDetailForm"
			action="<%=basePath%>search.do?method=detailSearch" method="post"
			target="_blank">
			<input type="hidden" name="strWhere" id="strWhere">
			<input type="hidden" name="strSources">
			<input type="hidden" name="strChannels">  
			<input type="hidden" name="area" value="cn">  
</form>













<div> 


</div>

<script type="text/javascript">
function showDetail(an)
{
	$("#strWhere").val("申请号="+an);
	$("#showDetailForm").submit();	
}

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