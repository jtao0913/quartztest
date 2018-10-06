<%@ page language="java" pageEncoding="UTF-8"%>

<!--国别选择-->
<% int i = 0; %>
        <div style="height:15px;"></div>

<ol class="inline" style="margin:0px 0px 0px 0px">

<c:forEach var="channel" items="${requestScope.channelTag}">

<% i++; %> 
   <%
   //if(i==1)out.print("");
   %>
<c:if test="${channel.chrCheck=='checked'}">

	<li><label class="checkbox" style="width:90px;cursor:hand"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.intChannelID}.png">		
	<input type="checkbox" value1="${channel.intChannelID}" value="${channel.chrTRSTable}" name="strdb" ${channel.chrIndexCheck} style="cursor:hand">${channel.chrChannelName}</label></li>

	<% if(i%8==0) {%></ol><ol class="inline" style="margin:0px 0px 0px 0px"><%} else {%> <%} %>
	
</c:if>	
</c:forEach>

<!--
<%
String OtherPatent = DataAccess.getProperty("OtherPatent");
//out.println("OtherPatent="+OtherPatent);
if(OtherPatent!=null&&OtherPatent.equals("1")){
%>
<li><a onClick="return click_a('db-search-modal')" style="cursor:hand">更多>></a></li>
<%}%>
</ol> 
<%if(OtherPatent!=null&&OtherPatent.equals("1")){ %>
<%@ include file="include-frdbdiv.jsp"%>
<%}%>
-->

<li><label class="checkbox" style="width:90px;cursor:hand"><input type="checkbox" value1="" value="otherpatent" name="strdb" style="cursor:hand">其他国家地区</label></li>

</ol>




<ol class="inline" style="margin:0px 0px 0px 0px">
<li><label class="checkbox"> <input type="checkbox" value="" id="selectAll" UNCHECKED onClick="selectAllCheckSort(this.checked)">全选库 </label></li>
</ol>




<script type="text/javascript">
function selectAllCheckSort(objValue) {
	if (objValue == true) {
		$("input[name='strdb']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",true);
//			$(this).checked = true;
			this.checked=true;
		});		
	} else {
		$("input[name='strdb']:checkbox").each(function(i) {
//			alert($(this).val());
//			$(this).attr("checked",false);
//			$(this).checked = false;
			this.checked=false;
		});	
	}
}
</script>