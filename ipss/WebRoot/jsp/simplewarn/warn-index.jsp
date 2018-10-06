<!DOCTYPE html>
<html>
<%@ page import="com.cnipr.cniprgz.commons.DataAccess,
com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html; charset=utf-8"%>

<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.dao.*"%>
<%@ page import="com.cnipr.cniprgz.entity.*"%>
<%@ page import="java.util.* "%>
<%@ page import="net.jbase.common.page.* "%>
<%@ page import="net.jbase.common.util.* "%>
<%@ page import="com.cnipr.cniprgz.func.* "%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>定期预警-首页</title> 
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Language" content="UTF-8"/>
<meta http-equiv="P3P" content="CP=CAO PSA OUR"/>  



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
	  					$(this).cluetip({local:true, cluetipClass: 'jtip', 
	 				    //cluetipClass: 'rounded',
	 				  //  dropShadow: false,  
	 					sticky: true,tracking: true,	
	 				//	activation: 'click',
	 					closePosition: 'title',closeText: '关闭',   
	 					arrows: true,width:450});
	 					}
	 					);
});
-->
</script>
</head>

<body>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>

<!-- 
<script type="text/javascript" src="<%=basePath%>scripts/app/global.js"></script>
 -->   
<script type="text/javascript" src="<%=basePath%>scripts/app/system.js"></script>
<script src="<%=basePath%>scripts/jquery/cluetip/jquery.cluetip.js" type="text/javascript"></script>
<%

  TSimpleWarnDAO simpleWarnDAO  =  new TSimpleWarnDAO(); 
  int userId = -1; 
  String order =  request.getParameter("order") ;
  String sort =  request.getParameter("sort") ;
  int start = 1;
  List simpleWarns = null;
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
		pagination = simpleWarnDAO.findSimpleWarns(userId, false, order, sort, start, Constant.WARNPAGESIZE);
		simpleWarns = pagination.getList(); 
		
	} catch (Exception e) { 
		e.printStackTrace();
	}
}
%>
 <div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%String menuname = "simplewarn";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>
        <div class="span10">
         <!--span10 -->
         <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>定期预警</strong></span></td>
				</tr>
           </table>

<form name="searchForm" id="searchForm" action="<%=basePath%>getMyWarm.do">
<table width="95%" class="table table-striped table-bordered table-hover ">
<tr class="simpleWarnFirstTR">
<td class="simpleWarnTD" width="15%">定期预警名称</td>
<td class="simpleWarnTD" width="20%">表达式</td>
<td class="simpleWarnTD" width="20%">数据库</td>
<td class="simpleWarnTD" width="50">周期</td>
<td class="simpleWarnTD" width="50">状态</td>
<td class="simpleWarnTD" width="160">创建时间</td>
<td class="simpleWarnTD" width="160">操作
<a href="#" class="tooltip"  rel=".memo1"><img src="<%=basePath%>images/tooltip.gif" border='0'/></a> 
</td>
</tr>
 <div class="memo1">
 	<strong>查看预警：</strong>查看具体预警历史及数据量。<br>
	<strong>删除：</strong>删除该预警任务。<br>
	<strong>续订：</strong>对每个预警任务，系统根据所设预警周期执行系统指定次数预警，指定次数之后如果用户还需继续预警，请点击续订。<br>
	<strong>修改：</strong>用户可对预警周期进行修改。
 </div>

<% if(userId!= -1  && simpleWarns!=null)
{
	for(int i=0;i<simpleWarns.size();i++)
	{
		TSimpleWarn simplewarn = (TSimpleWarn) simpleWarns.get(i);
	%>
	<tr class="simpleWarnTR<%=(i%2) %>">
	<td class="redl" width="160" style="word-wrap:break-word">
	<%=simplewarn.getName() %></td>
	<td>
	<%if(simplewarn.getExpression().length()>20){
		out.print(simplewarn.getExpression().substring(0,20));
	%>
	<a class="exptip" onClick='javascript:showexp("<%=simplewarn.getExpression().replace("\"","'").replace("'","‘")%>")'>查看</a>
	<div class="expmemo<%=i %>" style="display:none;"><%=simplewarn.getExpression() %></div>
	<%}else{
		out.print(simplewarn.getExpression());
     } %>
	</td>
	<td><%
	String channelArray[]  = StringUtil.splitStringToArray(simplewarn.getChannels(),",");
	
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
	<td><%= Constant.periodMap.get(simplewarn.getPeriod()) %></td>
	<td><% if(simplewarn.getStatus()>0)out.print("可用");else out.print("不可用"); %></td> 
	<td><%=DateUtil.format(simplewarn.getCreatetime(),"yyyy-MM-dd") %></td> 
	<td class="redl"> 
	<a href="warnExecuteList.do?warnid=<%=simplewarn.getId() %>" target="_self">查看预警</a> 
	<!-- 
	<a href="javascript:Util.del('确定删除吗？','warn-edit-do.jsp?method=delete&id=<%=simplewarn.getId() %>&start=<%=start %>');">删除</a>
	 -->
	<a onClick="javascript:showexp('<a href=warnEditDo.do?method=delete&id=<%=simplewarn.getId() %>&start=<%=start%>>确定删除吗？</a>')">删除</a>
	
	<% if(simplewarn.getStatus()==0 ) {%>
	<a href="warnEditDo.do?method=renew&id=<%=simplewarn.getId()%>&start=<%=start %>">续订</a>
	<%}else{ %>
	<a href="warnEdit.do?id=<%=simplewarn.getId() %>&start=<%=start %>">修改</a>
	<%} %>
	</td>
	</tr>
    <%}//end for %>
<tr>
<td colspan='7' height="43" align="right" background="../images/pic002.jpg" class="bluel">
<input type="hidden" name="start" value="1" id="start"/>
<%@ include file="/lib/pagination.jsp" %>
</td>
</tr>
  <%}//end if %>
</table> 
</form>
         <!--span10 -->
        </div>
      </div>
</div>
</div>

<div> 
</div>


<script type="text/javascript">
function showexp(exp){
	var html =
		"<div style='line-height:22px;'>"
		+ exp
		+ "</div>";

	$.dialog({
		title:'提示',
		max:false,
		min:false,
		lock: true,
		content: html
	});
}
</script>

<!--main结束-->	
<%@ include file="/jsp/zljs/include-buttom.jsp"%>

<script type="text/javascript">
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