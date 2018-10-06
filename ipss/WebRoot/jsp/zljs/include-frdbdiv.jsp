<%@ page language="java" pageEncoding="UTF-8"%>

<script language="javascript" type="text/javascript">
function selectAllOthers(objValue,continent) {
	$("#"+continent+" input[name='strdb']:checkbox").each(function(i) {
//		this.checked=true;
//		alert(objValue);

    	if(objValue == true){
//        	aler("1111");
//    		this.attr({'checked':true});
    		this.checked=true;
    	}else{
//    		aler("2222");
//    		this.attr({'checked':false});
    		this.checked=false;
    	}		
	});	
}

function click_a(divDisplay)
{
	if(document.getElementById(divDisplay).style.display != "block")
	{
		document.getElementById(divDisplay).style.display = "block";
	}
	else
	{
		document.getElementById(divDisplay).style.display = "none";
	}
}
</script>



<div id="db-search-modal" style="display:none;">

<div style="height:30px;width:100px;">
	<label>
		<input class="chksearchdb" name="欧洲国家"
			type="checkbox" onclick="selectAllOthers(this.checked,'ouzhou')">
		<b>欧洲国家</b>
	</label>
</div>

<div id="ouzhou">

<ol class="inline" style="margin:0px 0px 0px 0px">
<c:forEach var="channel" items="${requestScope.channelTag}">
<% i = 0;i++; %> 
<c:if test="${channel.intContinent=='2'}">
	<li><label class="checkbox"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.chrChannelCode}.png">		
	<input type="checkbox" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>
</c:if>
	<% if(i%7==0) {%></ol><ol class="inline"><%} else {%> <%} %>	
</c:forEach>
</ol>

</div>




<div style="height:30px;width:100px;">
	<label>
		<input class="chksearchdb" name="亚洲国家"
			type="checkbox" onclick="selectAllOthers(this.checked,'yazhou')">
		<b>亚洲国家</b>
	</label>
</div>

<div id="yazhou">

<ol class="inline" style="margin:0px 0px 0px 0px">
<c:forEach var="channel" items="${requestScope.channelTag}">
<% i = 0;i++; %> 
<c:if test="${channel.intContinent=='1'}">
	<li><label class="checkbox"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.chrChannelCode}.png">		
	<input type="checkbox" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>
</c:if>
	<% if(i%7==0) {%></ol><ol class="inline"><%} else {%> <%} %>	
</c:forEach>
</ol>

</div>





<div style="height:30px;width:100px;">
	<label>
		<input class="chksearchdb" name="非洲国家"
			type="checkbox" onclick="selectAllOthers(this.checked,'feizhou')">
		<b>非洲国家</b>
	</label>
</div>

<div id="feizhou">

<ol class="inline" style="margin:0px 0px 0px 0px">
<c:forEach var="channel" items="${requestScope.channelTag}">
<% i = 0;i++; %> 
<c:if test="${channel.intContinent=='4'}">
	<li><label class="checkbox"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.chrChannelCode}.png">		
	<input type="checkbox" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>
</c:if>
	<% if(i%7==0) {%></ol><ol class="inline"><%} else {%> <%} %>	
</c:forEach>
</ol>

</div>






<div style="height:30px;width:100px;">
	<label>
		<input class="chksearchdb" name="美洲国家"
			type="checkbox" onclick="selectAllOthers(this.checked,'meizhou')">
		<b>美洲国家</b>
	</label>
</div>

<div id="meizhou">

<ol class="inline" style="margin:0px 0px 0px 0px">
<c:forEach var="channel" items="${requestScope.channelTag}">
<% i = 0;i++; %> 
<c:if test="${channel.intContinent=='3'}">
	<li><label class="checkbox"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.chrChannelCode}.png">		
	<input type="checkbox" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>
</c:if>
	<% if(i%7==0) {%></ol><ol class="inline"><%} else {%> <%} %>	
</c:forEach>
</ol>

</div>




<div style="height:30px;width:100px;">
	<label>
		<input class="chksearchdb" name="大洋洲国家"
			type="checkbox" onclick="selectAllOthers(this.checked,'dayangzhou')">
		<b>大洋洲国家</b>
	</label>
</div>

<div id="dayangzhou">

<ol class="inline" style="margin:0px 0px 0px 0px">
<c:forEach var="channel" items="${requestScope.channelTag}">
<% i = 0;i++; %> 
<c:if test="${channel.intContinent=='5'}">
	<li><label class="checkbox"><img style="width:25px;margin-bottom:8px" class="img-responsive" src="images/fr/${channel.chrChannelCode}.png">		
	<input type="checkbox" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck} style="cursor:hand">${channel.chrChannelName}</label></li>
</c:if>
	<% if(i%7==0) {%></ol><ol class="inline"><%} else {%> <%} %>	
</c:forEach>
</ol>

</div>




</div>


