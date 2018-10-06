<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="n" uri="/WEB-INF/taglib/n.tld"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>

<%@ include file="../../../jsp/zljs/include-head-base.jsp"%>

<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>法律状态</title>
<script type="text/javascript" src="<%=basePath%>semanjs/jquery-1.3.2.min.js"></script>
<script  type="text/javascript" > 
	function viewSWGB(an,lawpd) {  
				$("#an").val(an);
				$("#lawpd").val(lawpd); 
			    $("#ViewSWGBForm").submit();  
			}
	 
</script>

<style>
<!--
body,table {font-size:10.8pt;}
//-->
</style>
</head>

<body  bgcolor="#FFF3E8">
<form name="lawStatusSearchForm"
			action="<%=basePath%>search.do?method=legalStatusSearch" method="post"
			target="_self">
			<input type="hidden" name="strWhere"
				value="${requestScope.strWhere }">
			<input type="hidden" name="pageIndex">
</form>

<!-- 事物公报 -->
<form name="ViewSWGBForm" id="ViewSWGBForm" action="<%=basePath%>view.do?method=viewSWGB" method="post"	target="_blank">
			<input type="hidden" name="an" id="an">
			<input type="hidden" name="lawpd"  id="lawpd">
</form>


<div align="center"><a href="javascript:window.close();">返回</a></div>

<center>  

 <c:forEach var="legalStatusInfo"	items="${requestScope.legalStatusInfoList}">
                <table border="1" width="80%"  bgcolor="#F0F7FF" bordercolorlight="#ffffff" cellspacing="0" bordercolor="#999999"> 
					<tr>
					<td width="20%" bgcolor="#D9F0FD" nowrap>申请号</td>
                 	<td bgcolor="#FFF3E8">&nbsp;${legalStatusInfo.strAn}</td>
					</tr>
					<tr><td bgcolor="#D9F0FD">法律状态</td>
                 <td bgcolor="#FFF3E8"><pre>&nbsp;${legalStatusInfo.strLegalStatus}</pre></td></tr>
                  
                 <tr><td bgcolor="#D9F0FD">法律状态信息</td> 
                 <td bgcolor="#FFF3E8"><pre>&nbsp;${legalStatusInfo.strStatusInfo}</pre></td></tr>
                 
                 <tr><td bgcolor="#D9F0FD" nowrap>法律状态公告日</td>
                                    <td>&nbsp;<strong>${legalStatusInfo.strLegalStatusDay}</strong> 
                                   
                                    <% if(SetupAccess.getProperty(SetupConstant.VIEWSWGB)!=null 
										   && SetupAccess.getProperty(SetupConstant.VIEWSWGB).equals("1")){%>
									 
                                    &nbsp;
                                    <a href="#" onclick="viewSWGB('${legalStatusInfo.strAn}','${legalStatusInfo.strLegalStatusDay}');">
                                    	[浏览公报]
                                    </a>
                                    <%} %>
                                    </td></tr> 
				
               </table>
               <br>
</c:forEach>
              
   
      <p>&nbsp;        

    <!--table WIDTH="500" bordercolorlight="#ffffff" border="1" cellspacing="0"  bordercolor="#FFFFFF" align="center">
      <tr>
        <td align="center"> <font color="#CC6666"><b>关于专利检索系统法律状态的说明</b></font> 
          <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;本检索系统的专利申请（专利）的状态信息主要来源于国家知识产权局出版的发明、实用新型和外观设计专利公报。由于专利申请（专利）的法律状态发生变化时，专利公报的公布及检索系统登录信息存在滞后性的原因，该检索系统的法律状态信息仅供参考。需要准确的法律状态信息时，请向国家知识产权局专利局请求出具专利登记簿副本，查询其法律状态。 
          <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;法律状态信息项目主要有实质审查请求生效、申请的撤回、申请的视为撤回、申请的驳回、授权、专利权的视为放弃、主动放弃专利权、专利权的恢复、专利权无效、专利权在期限届满前终止、专利权届满终止等。
<p align="left">&nbsp;&nbsp;&nbsp;&nbsp;当专利申请（专利）没有登录法律状态信息时，是指发明专利申请已公开但还没有提出实质审查请求或实质审查请求尚未生效；对于实用新型和外观设计专利申请则表示该专利申请已经授权。
</td></tr></table-->
</center>
</body>
</html>
