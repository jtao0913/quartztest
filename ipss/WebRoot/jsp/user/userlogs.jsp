<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="com.cnipr.cniprgz.commons.page.*"%>
<%@page import="com.cnipr.cniprgz.entity.LogInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	PageBaseInfo pageInfo = (PageBaseInfo) request
			.getAttribute("logInfo");
%>
<html>
<head>
<title>检索服务平台日志统计</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<style type="text/css">
	body{font-size:11pt;}
	td{font-size:10pt;}
	.exheading {font-weight: bold; cursor: hand}
	.Arraw {color:#FFFFFF; cursor:hand; font-family:Webdings; font-size:14pt}
</style>

<script language=javascript>
	function thisUrl(page){	
	    document.searchLogForm.currentpage.value = page;
	    document.searchLogForm.submit();
	}
</script>
</head>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0"  bgcolor="#FAFFFF">
<form name="searchLogForm" action="<%=basePath%>user.do?method=getUserLogs" method="post" target="_self">
	<input type="hidden" name="startyear" id="startyear" value="${requestScope.startyear}">
	<input type="hidden" name="startmonth" id="startmonth" value="${requestScope.startmonth}">
	<input type="hidden" name="startday" value="${requestScope.startday}">
	<input type="hidden" name="endyear" value="${requestScope.endyear }">
	<input type="hidden" name="endmonth" id="endmonth" value="${requestScope.endmonth }">
	<input type="hidden" name="endday" value="${requestScope.endday }">
	<input type="hidden" name="currentpage">
</form>

<center>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
   <tr> 
     <td ><div align="center"><img src="<%=basePath%>images/user/index_38.gif" width="620"></div></td>
   </tr>
     <tr> 
       <td ><div align="center"><img src="<%=basePath%>images/user/index_35.gif" width=286 height=19 alt=""></div></td>
     </tr>
</table><br>
<table width="100%" border="1" cellspacing="1" cellpadding="0" bordercolorlight="#4787b8">
	<tr height="32">
		<td>统计从${requestScope.startyear}年${requestScope.startmonth}月${requestScope.startday}号 &nbsp;到${requestScope.endyear}年${requestScope.endmonth}月${requestScope.endday}号</td>
		
      <td>&nbsp; <a href="<%=basePath%>jsp/user/statresultshowerconditionuser.jsp"><u>返回</u></a> <a target="_self" onclick="window.print()" style="cursor:hand"><u>打印</u></a> 
        <a target="_self" onclick="document.execCommand('SAVEAS')" style="cursor:hand"><u>保存</u></a> 
      </td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="1" cellpadding="0" bordercolorlight="#4787b8">
	<tr bgcolor="#4787b8" align="center">
	  <td width="7%"><font color="#FFFFFF"><b>序号</b></font></td>
	  <td><font color="#FFFFFF"><b>用户名</b></font></td>
      <td><font color="#FFFFFF"><b>执行操作</b></font></td>
	  <td><font color="#FFFFFF"><b>申请号</b></font></td>
	  <td><font color="#FFFFFF"><b>具体时间</b></font></td>
	  <td><font color="#FFFFFF"><b>来访IP</b></font></td>
	  <td><font color="#FFFFFF"><b>具体页码</b></font></td>
	</tr>
<% 
	if (pageInfo != null && pageInfo.getList() != null) {
		ArrayList logs = pageInfo.getList();
		for (int i = 0; i < logs.size(); i++) {
		LogInfo logInfo = (LogInfo)logs.get(i);
%>
	<tr align="center"  height="20">
	  <td><%=i+1%></td>
	  <td><%=(String) request.getSession().getAttribute("username")%></td>
	  <td><%=logInfo.getStrGrantName() %>&nbsp;</td>
	  <td><%=logInfo.getStrAPO() %>&nbsp;</td>
	  <td><%=logInfo.getVisitTime() %>&nbsp;</td>
	  <td><%=logInfo.getVisitIP() %>&nbsp;</td>
	  <td><%=logInfo.getApoPage() %>&nbsp;</td>
	</tr>
<%	
		}
    }
 %>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								共
								<%=pageInfo.getCountRownum()%>
								笔 共
								<%=pageInfo.getCountPagenum()%>
								页 第
								<%=pageInfo.getCurPageNo()%>
								页
							</td>
							<td align="right" valign="baseline">
								<label>
									<!--<input type="text" name="curPageNo" size="3" value='<%=pageInfo.getCurPageNo()%>' />
	  <input type="submit" value="Go" class="inp_A1" onMouseOver="this.className='inp_A2'" 

onMouseOut="this.className='inp_A1'" />-->
<input type="hidden" value="<%=pageInfo.getCurPageNo()%>" name="curPageNo"/>
									<input type="button" value="首 页"
										<%=pageInfo.disabledInfo(pageInfo.THEFIRSTPAGE)%>
										onClick="thisUrl(1);" />
										
										<input type="button" value="前 页"
										<%=pageInfo.disabledInfo(pageInfo.THEFIRSTPAGE)%>
										onClick="thisUrl(<%=pageInfo.getPrevPageNo()%>);" />
									<input type="button" value="后 页" class="inp_A1"
										<%=pageInfo.disabledInfo(pageInfo.THELASTPAGE)%>
										onClick="thisUrl(<%=pageInfo.getLastPageNo()%>);" />
									<input type="button" value="末 页" class="inp_A1"
										<%=pageInfo.disabledInfo(pageInfo.THELASTPAGE)%>
										onClick="thisUrl(<%=pageInfo.getCountPagenum()%>);" />
								</label>
							</td>
						</tr>
					</table>
</center>
</body>
</html>