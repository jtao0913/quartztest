<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>表格检索【中国】-<%=com.cnipr.cniprgz.commons.SetupAccess.getProperty("title")%></title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
	<meta name="description" content="<%=com.cnipr.cniprgz.commons.SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->



<!-- 智能检索类库导入 -->


<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
	
//System.out.println("strItemGrant:"+strItemGrant);
%>

</head>

<body>
<%@ include file="include-head-base.jsp"%>
<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>


<% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>                   
                      <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
<script type='text/javascript' src="<%=basePath %>semanjs/maxlength.js"></script>
<%}}
 %>
<script type="text/javascript">
function channelChecked_sx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){   
         if(o[i] == obj){   
              obj.checked = true;   
         }else{   
              o[i].checked = false;   
         }   
    }
    
    <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH )!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
    <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
    document.getElementById("txtR").disabled = true;
    document.getElementById("txtR").style.background='#CCCCCC';
      document.getElementById("txtT").disabled = true;
    document.getElementById("txtT").style.background='#CCCCCC';
    <%}}%>
      <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
   		 <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
    document.getElementById("txtS").disabled = true;
    document.getElementById("txtS").style.background='#CCCCCC';
    document.getElementById("sss").disabled = true;
    <%}}%>
}



function channelChecked_yx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){   
         if(o[i] == obj){   
              obj.checked = true;   
         }else{   
              o[i].checked = false;   
         }   
    }
    
    <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH )!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
    <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
    document.getElementById("txtR").disabled = true;
    document.getElementById("txtR").style.background='#CCCCCC';
    document.getElementById("txtT").disabled = true;
    document.getElementById("txtT").style.background='#CCCCCC';
    <%}}%>
      <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
   		 <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
    document.getElementById("txtS").disabled = true;
    document.getElementById("txtS").style.background='#CCCCCC';
    document.getElementById("sss").disabled = true;
    <%}}%>
}



function channelChecked(){

<% if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.SHIXIAOSEARCH)){%>
	document.getElementById("sxChannel").checked = false;
<%} }%>

<% if(SetupAccess.getProperty(SetupConstant.EFFECTLIB)!=null && SetupAccess.getProperty(SetupConstant.EFFECTLIB).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.EFFECTLIB)){%>
	document.getElementById("yxChannel").checked = false;
<%} }%>

   <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH)!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
	 <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
	document.getElementById("txtR").disabled = false;
	document.getElementById("txtR").style.background='#ffffff';
	document.getElementById("txtT").disabled = false;
    document.getElementById("txtT").style.background='#ffffff';
	 <%}}%>
	  <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
		<% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
	document.getElementById("txtS").disabled = false; 
	document.getElementById("txtS").style.background='#ffffff';
	document.getElementById("sss").disabled = false; 
	<%}} %>
}

function getCopeCode() {
	//document.domain;
	<% String corpcordAppURL = DataAccess.getProperty("corpcordAppURL"); %>
	window.open('<%=corpcordAppURL%>','b','');
}

function picQuery() {
			var picwin = window.open("<%=basePath %>search/ipc.do","pic","width=836,height=800,scrollbars=yes,resizable=yes,location=no,menubar=no,titlebar=no,toolbar=no,status=no,z-look=yes");
			picwin.focus();
	}

function sicQuery() {
			var sicwin = window.open("<%=basePath %>search/ipc.do","sic","width=836,height=800,scrollbars=yes,resizable=yes,location=no,menubar=no,titlebar=no,toolbar=no,status=no,z-look=yes");
			sicwin.focus();
	}
	

</script>
<!--
<link href="<%=basePath %>semancss/jquery.autocomplete.css" rel="stylesheet" type="text/css">
<link type="text/css" href="<%=basePath %>semanjs/themes/ui-lightness/ui.all.css" rel="stylesheet" />
 智能检索结束 -->


<%@ include file="include-head-secondsearch.jsp"%>

<%
String type = "cnbiaodan";
%>
<%@ include file="include-head-jiansuo.jsp"%>
<!-- 
<script type="text/javascript" src="<%=basePath%>js/SimpleTable.js"></script>
 -->
<div style="width:1014px;margin: auto;">
   
<form class="form-horizontal" id="searchForm" name="searchForm"  method="post" target="_self">
			<input type="hidden" id="area" name="area" value="cn">
			<input type="hidden" name="channelid">
			<input type="hidden" id="presearchword" name="presearchword" value="<%=request.getAttribute("presearchword") %>">
			<input type="hidden" id="strWhere" name="strWhere">
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE">
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iHitPointType" value="115">
			
			<input type="hidden" id="strChannels" name="strChannels">
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" value="<%=request.getAttribute("trsLastWhere") %>">
   
   <!--国别选择-->
   <!-- 
        <div style="height:15px;"></div>
		                 <ol class="inline long">
										<li><label class="checkbox"> <input
												name="channelId" id="invention" type="checkbox" value="FMZL"
												checked="checked">中国发明公开
										</label></li>
										<li><label class="checkbox"> <input
												name="channelId" id="newDemo" type="checkbox" value="SYXX"
												checked="checked">中国实用新型
										</label></li>
										<li><label class="checkbox"> <input
												id="outDesign" name="channelId" type="checkbox" value="WGZL"
												checked="checked">中国外观设计 
										</label></li>
										<li><label class="checkbox"> <input
												type="checkbox" id="authorization" name="channelId"
												value="FMSQ">中国发明授权 </label></li>
							</ol>
							<ol class="inline text-warning">
								<li><label class="checkbox"> <input type="checkbox"
										value="" id="selectAll">全选库 </label></li>
							</ol>
							 -->
						    <!--国别选择结束-->
						    
	<div style="height:15px;"></div>
		<ol class="inline long">
		<c:forEach var="channel" items="${requestScope.channelTag}">			
			<li><label style="width:105px;cursor:hand" class="checkbox">
			<!--
			<img style="width:30px;margin-bottom:5px" class="img-responsive " src="images/cn/${channel.intChannelID}.png">
			-->
			<input type="checkbox" type="checkbox" onclick="channelChecked();" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck}
			 style="cursor:hand">${channel.chrChannelName}</label></li>			
		</c:forEach>
		</ol>
		<!-- 
		<input type="checkbox" name="savesearchword" value="ON" id="c4" style="cursor:hand"><label for="c4" style="cursor:hand">保存检索表达式</label>
		 -->
						    


<base target="_self"/>



<!-- 
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td height="43"  background="<%=basePath%>img/table_topbg.jpg" class="gray">
		<input type="hidden" name="channelid" value="">
		<input type="hidden" name="searchChannel" value="">&nbsp;&nbsp;&nbsp;&nbsp;
		<c:forEach var="channel" items="${requestScope.channelTag}">
			<input type="checkbox" onclick="channelChecked();" value="${channel.intChannelID}" name="strdb" ${channel.chrCheck}
			 style="cursor:hand">
			<label style="cursor:hand">
				${channel.chrChannelName}
			</label>
			&nbsp;&nbsp;&nbsp;&nbsp;
		</c:forEach>
		<% if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){%>
		 <% if(strItemGrant.contains(SetupConstant.SHIXIAOSEARCH)){%>
		<input type="checkbox" value="34,35,36" name="strdb" id="sxChannel"  
		<%if( request.getAttribute("channelId")!=null && request.getAttribute("channelId").equals("34,35,36") ) out.print("checked"); %>
			 style="cursor:hand" onclick="channelChecked_sx(this);">
		<label style="cursor:hand">
				失效专利
		</label>
         <%} } %>
         &nbsp;&nbsp;&nbsp;&nbsp;
         <% if(SetupAccess.getProperty(SetupConstant.EFFECTLIB)!=null && SetupAccess.getProperty(SetupConstant.EFFECTLIB).equals("1")){%>
		 <% if(strItemGrant.contains(SetupConstant.EFFECTLIB)){%>
		<input type="checkbox" value="304,305,306" name="strdb" id="yxChannel"  
		<%if( request.getAttribute("channelId")!=null && request.getAttribute("channelId").equals("304,305,306") ) out.print("checked"); %>
			 style="cursor:hand" onclick="channelChecked_yx(this);">
		<label style="cursor:hand">
				有效专利
		</label>
         <%} } %>
</td>
</tr>
</table>
 -->

<!--               <tr> 
                <td height="35" height="28" bgcolor="C7E1F7" class="gray" width="74%">&nbsp;
<input type="checkbox" value="ON" name="secondsearch"
								<% if (request.getAttribute("secondOrFilter") == null || !request.getAttribute("secondOrFilter").equals("secondsearch")) {%> disabled <%} else if(request.getAttribute("secondOrFilter").equals("secondsearch")) {%> onClick="document.loginform.filtersearch.checked=false" checked <%} %>
									id="c1" style="cursor:hand">
								<label for="c1" style="cursor:hand">
									二次检索
								</label>
								<input type="checkbox" name="filtersearch" value="ON"
								<% if (request.getAttribute("secondOrFilter") == null || request.getAttribute("secondOrFilter").equals("secondsearch")) {%> disabled <%} else if(request.getAttribute("secondOrFilter").equals("filtersearch")) {%> onclick="document.loginform.secondsearch.checked=false" checked <%} %>
									id="c2" style="cursor:hand">
								<label for="c2" style="cursor:hand">
									过滤检索
								</label>			
								<input type="checkbox" name="synonymous" value="1" id="c3"
									style="cursor:hand">
								<label for="c3" style="cursor:hand">
									同义词检索
								</label>
								
								<input type="checkbox" name="savesearchword" value="ON" id="c4"
									style="cursor:hand">
								<label for="c4" style="cursor:hand">
									保存检索表达式
								</label>
								<% if(SetupAccess.getProperty(SetupConstant.ZICISEARCH)!=null && SetupAccess.getProperty(SetupConstant.ZICISEARCH).equals("1")){%>
								<select size="1" name="iOption" id="iOption" class="gray">>
									<option value="2" <% if (request.getAttribute("cizi") == null || request.getAttribute("cizi").equals("2")) {%> selected <%} %> >
										按字检索
									</option>
									<option value="0" <% if (request.getAttribute("cizi") != null && request.getAttribute("cizi").equals("0")) {%> selected <%} %>>
										按词检索
									</option>
								</select>
								<%} %>
								<span>
								
								<% if(SetupAccess.getProperty(SetupConstant.ORDEROPEN)!=null && SetupAccess.getProperty(SetupConstant.ORDEROPEN).equals("1")){%> 
								&nbsp;&nbsp;排序： 
								<select  name="sortcolumn" id="sortcolumn" style="width:100px" class="gray">>
									<option value="公开（公告）日">
										公开（公告）日
									</option>
									<option value="公开（公告）号">
										公开（公告）号
									</option>
									<option value="申请日">
										申请日
									</option>
									<option value="申请号">
										申请（专利）号
									</option>
									<option value="颁证日">颁证日</option>
									<option value="名称">
										名称
									</option>
									<option value="主分类号">
										主分类号
									</option>
									<option value="RELEVANCE" selected>
										相关性
									</option>
								</select><select name="R1" id="R1" class="gray">>
									<option value="">
										降序
									</option>
									<option value="+">
										升序
									</option>
								</select>
								
								<%} %>
  </span>
</td>
              </tr> -->

<script type="text/javascript">

</script>
 	 <!--表格检索-->
		<div class="row-fluid">
					<div style="background-color: #ffffff;margin: auto;">

			<table class="table table-condensed" style="font-size:12px;border: 2px solid #ffffff;">
				<tr>
					<td class="table_10"><label class="control-label" for="txt_A" onClick="insertItem(obj, 'A');">申 请（专 利）号：</label></td>
					<td class="table_40"><input type="text" field="申请号" id="txt_A" name="txt_A" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:CN02144686.5</span></td>
					<td class="table_10"><label class="control-label" onClick="insertItem(obj, 'B');">申 请 日：</label></td>
					<td class="table_40"><input type="text" field="申请日" class="form_datetime" id="txt_B" name="txt_B" style="width: 165px;height:18px;" /><span class="muted"> 例如:20101010</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_C" onClick="insertItem(obj, 'C');">公 开（公 告）号：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）号" id="txt_C" name="txt_C" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:CN1387751</span></td>
					<td class="table_10"><label class="control-label" onClick="insertItem(obj, 'D');">公 开（公 告）日：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）日" class="form_datetime" id="txt_D" name="txt_D" style="width: 165px;height:18px;" /><span class="muted"> 例如:20110105</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_E" onClick="insertItem(obj, 'E');">名 称：</label></td>
					<td class="table_40"><input type="text" field="名称" id="txt_E" name="txt_E" class="input-m edium" style="width: 165px;height:18px;"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_F" onClick="insertItem(obj, 'F');">摘要：</label></td>
					<td class="table_40"><input type="text" field="摘要" id="txt_F" name="txt_F" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:计算机</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_K" onClick="insertItem(obj, 'K');">主 权 项：</label></td>
					<td class="table_40"><input type="text" field="主权项" id="txt_K" name="txt_K" class="input-m edium" style="width: 165px;height:18px;"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_P" onClick="insertItem(obj, 'P');">优 先 权：</label></td>
					<td class="table_40"><input type="text" field="优先权" id="txt_P" name="txt_P" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:02112242</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_G" onClick="insertItem(obj, 'G');">主 分 类 号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="主分类号" id="txt_G" name="txt_G"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_G&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent"
											title="主分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
											</span><span class="muted"> 例如:G06F15/16 </span></td>						
					
					<td class="table_10"><label class="control-label" for="txt_H"
									onClick="insertItem(obj, 'H');"> 分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="分类号" id="txt_H" name="txt_H"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_H&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent" title="分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
											</span><span class="muted"> 例如:G06F15/16 </span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_I" onClick="insertItem(obj, 'I');">申 请（专 利 权）人：</label></td>
					<td class="table_40"><input type="text" field="申请（专利权）人" id="txt_I" name="txt_I" style="width: 165px;height:18px;" /> <span class="muted"> 例如:顾学平</span></td>
					<td class="table_10"><label class="control-label" for="txt_J" onClick="insertItem(obj, 'J');">发 明（设 计）人：</label></td>
					<td class="table_40"><input type="text" field="发明（设计）人" id="txt_J" name="txt_J" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:顾学平</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_L" onClick="insertItem(obj, 'L');">地 址：</label></td>
					<td class="table_40"><input type="text" field="地址" id="txt_L" name="txt_L" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:鞍山市</span></td>
					<td class="table_10"><label class="control-label" for="txt_O" onClick="insertItem(obj, 'O');">国 省 代 码：</label></td>
					<td class="table_40"><input type="text" field="国省代码" id="txt_O" name="txt_O" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:江苏% 或 %32%</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_M" onClick="insertItem(obj, 'M');">专 利 代 理 机 构：</label></td>
					<td class="table_40"><input type="text" field="专利代理机构" id="txt_M" name="txt_M" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:柳沈</span></td>
					<td class="table_10"><label class="control-label" for="txt_N" onClick="insertItem(obj, 'N');">代 理 人：</label></td>
					<td class="table_40"><input type="text" field="代理人" id="txt_N" name="txt_N" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:李恩庆  </span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for=txt_Q onClick="insertItem(obj, 'Q');">权 利 要 求 书：</label></td>
					<td class="table_40"><input type="text" field="权利要求书" id="txt_Q" name="txt_Q" class="input-medium"  style="width: 165px;height:18px;"/><span class="muted"> 例如:计算机 </span></td>
					<td class="table_10"><label class="control-label" for="txt_R" onClick="insertItem(obj, 'R');">说 明 书：</label></td>
					<td class="table_40"><input type="text" field="说明书" id="txt_R" name="txt_R" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:计算机</span></td>
				</tr>
			</table>
                  
                  
                  
                  </div></div>
                  
            
       
			<!--表格检索结束-->
			<!--逻辑框-->
			<div class="row-fluid">

							<div class="span7 column ui-sortable">
								
								<div style="height:40px">
									<span class="muted">逻 辑 框</span>
								</div>
								<div class="row-fluid">
									<span class="span2"></span>
									<textarea class="span10" rows="8" id="txtComb" name="txtComb"></textarea>
								</div>
								
							</div>
							<div class="span5">
								<div class="text-center">      
                                     <button class="btn btn-warning" id="subBtn" name=submit1 onClick="javascript:submitDataToSearch();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
									</a> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
										<button class="btn btn-success" type=reset value='' name=cler1>
										<i class="icon-search icon-white"></i>&nbsp;清 除</button>
										
								</div>
							</div>
						</div>
						<!--逻辑框结束-->
</form>
</div>

                  
<%@ include file="include-buttom.jsp"%>


</BODY>
</HTML>
<Script language="JavaScript"> 
var obj = document.searchForm.txtComb;
var vCountry = "1";
</Script>


<script language="javascript" type="text/javascript">
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

<script type="text/javascript">
    jQuery(function(){
        $(document).keydown(function(event){
            if(event.keyCode==13){
//                 $("a[name='searchBtn']").click();
					submitDataToSearch();
            }
        });
        $('#selectAll').change(function(){
        	if(this.checked){
        		$('input[name="channelId"]').attr({'checked':true});
        	}else{
        		$('input[name="channelId"]').attr({'checked':false});
        	}
        });
        $('#inverSelect').change(function(){
        	if(this.checked){
        		$('input[name="channelId"]').each(function(){
        			if(this.checked){
        				$(this).attr({'checked':false});
        			}else{
        				$(this).attr({'checked':true});
        			}
        		})
        	}else{
        		$('input[name="channelId"]').each(function(){
        			if(this.checked){
        				$(this).attr({'checked':false});
        			}else{
        				$(this).attr({'checked':true});
        			}
        		})
        	}
        });
    });
    /*
    $(function(){
    	 //获得用户的历史表达式
        getHistoryExp();
    });
    function getHistoryExp(){
    	$.ajax({
      		type: "POST",
      		url: ctx+"/search/json/getUserHistoryExp",
      		success: function(data){
      	  		if(data.rCode == "100000"){
      	  			var tempText= "";
      	  			$(data.data.result).each(function(i){
      	  				var tempValue = this.trsExp;
      	  				if(tempValue.length >10){
      	  					tempValue = tempValue.substring(0,7)+"...";
      	  				}
      	  				tempText += '<li><a href="javascript:showExtExp(\''+(i+"history")+'\');" title='+this.trsExp+' >'+tempValue+'</a></li>'
      	  				+'<input type="hidden" value=\"'+this.trsExp+'\" id=\"'+(i+"history")+'\">';
      	  			});
	  				$('#historyExp').html(tempText);
      	  		}
      		}
      	});
    }
   */ 
    function submitDataToSearch(){
		strdbValid();
		if(validLogicInput()){
			if($('#saveExpcheck').attr('checked')){
				$('#saveExpcheck').val("1");
			}else{
				$('#saveExpcheck').val("0");
			}

            //alert($('#strWhere').val());
            //alert("strWhere="+document.searchForm.strWhere.value);
            //document.searchForm.strWhere.value = $('#strWhere').val();
            document.searchForm.action="<%=basePath%>overviewSearch.do?area=cn";
            document.searchForm.submit();
        }
	}
	
    /*
    function showExtExp(historyId){
    	$('#currentExp').html($('#'+historyId).val());
    	$('#showExpModel').modal('show');
    }
    */
	function strdbValid(){
//		var checkedLength=0;
		var strChannels = "";
		 $("input[name='strdb']").each(function(){
			if($(this).attr("checked")){
//				checkedLength++;
				if(strChannels!=""){
					strChannels += ",";
				}
				strChannels += $(this).val();
			}
		});
		if(strChannels==""){
			alert("请选择检索库");
			return false;
		}else{
			$('#searchForm #strChannels').val(strChannels);
			return true;
		}
	}

    /**
    *
    *解析表达式
    *
    **/
    function validLogicInput(){
    	var searchCond="";
    	
    	var fieldShortName=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V"];
    	var txtComb=" " + document.searchForm.txtComb.value + " ";
    		
    	var combinedTxt="";
    	txtComb = $.trim(txtComb);

//    	alert(txtComb);
    	if(txtComb!=""){
    		searchCond=txtComb;
    	}else{
    		$(fieldShortName).each(function(){
    			var idFlag="#txt_"+this;    			
    			var param=jQuery.trim($(idFlag).val());
    			
    			if(param!=''){
    				if(searchCond==''){
    					if(this=='S'){
    						searchCond+=$(idFlag).attr("field")+"="+parseSemanticExp();
    					}else{
    						if($(idFlag).attr("field")=='申请号'||$(idFlag).attr("field")=='公开（公告）号'){
    							if($(idFlag).val().toLowerCase().indexOf('cn')==0){
    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=$(idFlag).attr("field")+"=(CN"+$(idFlag).val()+")";
    							}
    						}else{ 
    							if($(idFlag).attr("field")=='anFR'){
    								searchCond+="an=("+$(idFlag).val()+")";
    							}else if($(idFlag).attr("field")=='pnFR'){
    								searchCond+="pn=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}
    						}
    					}
    				}else{
    					if(this=='S'){
    						searchCond+=" and "+ $(idFlag).attr("field")+"=("+parseSemanticExp()+")";
    					}else{
    						if($(idFlag).attr("field")=='申请号'||$(idFlag).attr("field")=='公开（公告）号'){
    							if($(idFlag).val().toLowerCase().indexOf('cn')==0){
    								searchCond+=" and "+$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=" and "+$(idFlag).attr("field")+"=(CN"+$(idFlag).val()+")";
    							}
    						}else{
    							if($(idFlag).attr("field")=='anFR'){
    								searchCond+=" and an=("+$(idFlag).val()+")";
    							}else if($(idFlag).attr("field")=='pnFR'){
    								searchCond+=" and pn=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=" and "+$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}
    						}
    					}
    				}
    			}
    		});    		
//    		alert("searchCond="+searchCond);
//    		searchCond==''?alert("请输入检索条件"):"";
    	}
//    	alert("searchCond="+searchCond);
    	if(searchCond==''){//如果检索条件为空,返回错误
    		alert("请输入检索表达式");
    		return false;
    	}else{
    		//是否进行了二次检索
    		/*
    		if(secondSearch()){
    			$("#searchForm #strWhere").attr("value","("+searchCond+") and ("+$("#searchForm #presearchword").val()+")"); 
    			$("#searchForm #bContinue").attr("value", "1");
    			return true;
    		}if(filterSearch()){
    			$("#searchForm #strWhere").attr("value","("+searchCond+") not ("+$("#presearchword").val()+")");
    			$("#searchForm #strWhere").attr("value"," ("+$("#searchForm #presearchword").val()+") not ("+searchCond+")");
    			return true;
    		} else {
    			strWhere=searchCond;
    		}
    		*/
//    		$("#searchForm #strWhere").attr("value",searchCond);
    		$("#searchForm #strWhere").val(searchCond);
    		
//    		document.searchForm.strWhere.value = searchCond;
    		
    		//$("#strSortMethod").attr("value","-"+sortField);
//alert("return true");
    		return true;
    	}
    }

</script>

