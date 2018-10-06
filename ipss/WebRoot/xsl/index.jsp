<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>

<%
String wap = DataAccess.get("wap")==null?"0":DataAccess.get("wap");
if(wap.equals("1")){
%>
<script src="<%=basePath%>wap/js/uaredirect.js"></script>
<script type="text/javascript">uaredirect("wap/");</script>
<%}%>

<%@ include file="jsp/zljs/include-head.jsp"%>
<%@ include file="jsp/zljs/include-head-nav.jsp"%>

<head>
<%
String hangyeID = (String)session.getAttribute("hangye");
hangyeID = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
//out.println("hangyeID="+hangyeID);
%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=website_title%>-专利检索查询,专利搜索下载</title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
    <meta name="description" content="<%=SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="common/com_2/css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="common/com_2/css/ie.css">
    <![endif]-->
	
<!-- 
<STYLE type=text/css>
body{
	background:url(images/area/<%= Log74Access.get("log74.areacode")%>/common/com_2/img/index/x003.jpg) no-repeat 0 0;
	background-position: center;
	background-repeat: no-repeat;
}
</STYLE>
-->
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
</head>
	<body>&nbsp; 
	 
<!--LOGO-->
 <div style="height: 100px"></div>
 <div class="container">
 	<div class="row text-center" >
 	<!-- 
 	<img src="common/com_2/img/index/logo.png" width="460"  height="75" />
	-->
 	<img src="images/area/<%= Log74Access.get("log74.areacode")%>/common/com_2/img/index/logo.png"  />
 	
 	<!-- 
 	<%if(hangyeID.equals("")){%>
 	<img src="images/area/<%= Log74Access.get("log74.areacode")%>/common/com_2/img/index/logo.png"  />
 	<%}else{%>
 	<img src="images/liaoning/<%=hangyeID%>.png"  />
 	<%}%>
 	 -->
 	</div>
</div>
<!--搜索-->
<div style="height: 20px"></div>
<div class="container">
<div class="row text-center">
 		
<form id="searchForm" class="form-inline" name="searchForm" method="post" target="_self">
			<input type="hidden" value="电子" name="content1" />
			<input type="hidden" id="colname" value="申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" name="colname" />
			<!-- 
			<input type="hidden" value="cn" name="area" />
			 -->
			<input type="hidden" id="strWhere" name="strWhere"/>
			<input type="hidden" id="simpleSearch" name="simpleSearch" value="1"/>
			<input type="hidden" id="presearchword" name="presearchword" />
			
			<input type="hidden" id="savesearchword" name="savesearchword" value="ON">
			<input type="hidden" id="strChannels" name="strChannels"/>
			
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE"/>
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要"/>
			<input type="hidden" name="strStat" value=""/>
			<input type="hidden" name="iHitPointType" value="115"/>
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch"/>
			<input type="hidden" id="bContinue" name="bContinue" value=""/>
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" />
			<input type="hidden" value="" name="channelid"/> 		    

            <span class="help-inline muted">快速检索&nbsp;</span>
			<div class="input-append">
			<input type="text" id="content" name="content" class="input-xxlarge" id="sousou" value="请输入关键词，例如：电脑" onfocus="if(value=='请输入关键词，例如：电脑') {value=''}" onblur="if (value=='') {value='请输入关键词，例如：电脑'}" placeholder="请输入关键词进行检索"/>
			<button type="button" class="btn btn-warning"  onClick="doQsearch()"><i class="icon-search icon-white"></i>&nbsp;检 索</button>	
			</div>
			<div style="height:10px;"></div>
			<div class="row">
            <ul class="inline">
				<li><label class="radio" style="width: 80px"><input type="radio" id="areacn" name="area" value="cn" checked> 中国专利</label></li>
				<li><label class="radio" style="width: 110px"><input type="radio" id="areafr" name="area"  value="fr"> 国外及港澳台</label></li>
			</ul>
		</div>
	</form>
 	</div>	
 </div>
 <!--块状展示-->
 <div style="height:10px"></div>
 <div class="container">
 <center>
 	<div class="row">
 	<ul class="row-fluid" style="max-width:650px;max-height:300px;color: #FFFFFF;">
 		<li class="span4 cursor height80" style="background-color:#6666FF; " onClick="gotolink(1);">
 		   <span class="span5"><img class="in_im" src="common/com_2/img/index/invalid60.png"></span>
           <span class="span7 font_15_in_80">表格检索</span>	
        </li>
 		<li class="span4 cursor height80" style="background-color: #6D3353;" onClick="gotolink(2);">
 		   <span class="span5"><img class="in_im" src="common/com_2/img/index/expert60.png"></span>
           <span class="span7 font_15_in_80">专家检索</span>
        </li>
        <li class="span4 cursor height80" style="background-color: #009999;" onClick="gotolink(0);">
 		   <span class="span5"><img class="in_im" src="common/com_2/img/index/legal60.png"></span>
           <span class="span7 font_15_in_80">法律状态检索</span>		
 		</li>
 	</ul>
 	
 	<div style="height:5px;"></div>

 	<ul class="row-fluid" style="max-width:650px;max-height:300px;color: #FFFFFF;">
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(3);" style="background-color: #64c119;">CNIPR视角</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(4);" style="background-color: #ddae1c;">CNIPR服务</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(5);" style="background-color: #ec5777;">CNIPR学院</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(6);" style="background-color: #26beff;">中国专利年会</li>
 	</ul>
<!-- 
	 武汉
 	<ul class="row-fluid" style="max-width:650px;max-height:300px;color: #FFFFFF;">
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('smjk');" style="background-color: #64c119;">生命健康</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('znzb');" style="background-color: #ddae1c;">智能装备</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('xxjs')" style="background-color: #ec5777;">信息技术</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(6);" style="background-color: #26beff;">武汉市知识产权局</li>
 	</ul>
 	
 	<ul class="row-fluid" style="max-width:650px;max-height:300px;color: #FFFFFF;">
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('smjk');" style="background-color: #64c119;">国家知识产权局</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('znzb');" style="background-color: #ddae1c;">辽宁知识产权局</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="hangyelogin('xxjs')" style="background-color: #ec5777;">辽宁省知识产权网</li>
 		<li class="span3 font_15_in_80 cursor"  onclick="gotolink(6);" style="background-color: #26beff;">辽宁知识产权服务平台</li>
 	</ul>
-->
 	</div>
 </center>
 </div>
 
 
<!--底部展示-->

<%@ include file="jsp/zljs/include-buttom.jsp"%>
		

</body>
</html>

	<!--[if lte IE 6]>
    <script type="text/javascript" src="common/com_2/js/bootstrap-ie.js"></script>
    <![endif]-->


<script type="text/javascript">
    function gotolink(url){
//var ctx = ${ctx};
//alert(ctx);
		var area = $("input[type='radio']:checked").val();
    
    	if(url==0){
    		window.location.href="<%=basePath%>showFlztSearchForm.do";
    	}else if(url==1){
    		//alert($("#areacn").checked);    		
    		window.location.href='<%=basePath%>showSearchForm.do?area='+area;
    	}else if(url==2){
    		window.location.href='<%=basePath%>showLogicForm.do?area='+area;
    	}
    	
   	
    	else if(url==3){
    		window.location.href='http://www.cnipr.com/sj/zx/';
    	}else if(url==4){
    		window.location.href='http://www.cnipr.com/fw/';
    	}else if(url==5){
    		window.location.href='http://www.cnipr.com/xy/swzs/';
    	}else if(url==6){
    		window.location.href='http://www.piac-china.com/';
    	}
    	
    	/*
    	武汉
    	else if(url==3){
    		window.location.href='http://www.cnipr.com/CNIPR/';
    	}else if(url==4){
    		window.location.href='http://www.cnipr.com/sfsj/';
    	}else if(url==5){
    		window.location.href='http://www.cnipr.com/PX/';
    	}else if(url==6){
    		window.location.href='http://www.whst.gov.cn/';
    	}
    	
    	辽宁
    	else if(url==3){
    		window.location.href='http://www.sipo.gov.cn/';
    	}else if(url==4){
    		window.location.href='http://www.lnipo.gov.cn/';
    	}else if(url==5){
    		window.location.href='http://www.lnipo.gov.cn/';
    	}else if(url==6){
    		window.location.href='http://www.lnipo.gov.cn/ztzl/zhfwpt/';
    	}
    	*/
    }
    
    jQuery(function(){
        $(document).keydown(function(event){
            if(event.keyCode==13){
				doQsearch();
            }
        });
    });

	function goquicksearch(searchType) {
		document.searchForm.strWhere.value = searchType;
		document.searchForm.submit();
	}
	
	function doQsearch(){
		var content = $('#content').val();
		var colname = $('#colname').val();

//alert(colname);
//alert(content);

		if(content!=null && content!=""){
//					var area = $('#area').val();
//					alert(area);
//					$("input[name='rd']:checked").val();
			var area = $('input[name="area"]:checked').val();
//					alert(area);
					//.attr("action","insert.do?method=regist")//更改属性
					//$("#text_id").attr("value",'test');//填充内容 
					
					//name.replace(/\s+/g,"");

			$("#strWhere").attr("value",colname+"("+$.trim(content).replace(/\s+/g, " and ")+")");
					//strChannels
			if(area=='cn'){
//				$("#strChannels").val("14,15,16");
			}else{
//				$("#strChannels").val("18,19,20,21,22,23,24,25");
			}
			$("#searchForm").attr("action","expressSearch.do?simpleSearch=1&pageType=all&quickSearchEncode=UTF8");
			$("#searchForm").submit();
		}else{
			return false;
		}
	}
</script>
<script type="text/javascript">
function hangyelogin(username){
//alert("window.onload......");
//	var username = $('#username').attr('title');
//alert('username='+username);	
	if(username!=''){
//alert('username为空');
//		$('#username').val()='guest';
//		$('#password').val()='123456';
		$("#username").attr("value",username);//清空内容 
		$("#password").attr("value","123456");
		initLoginRequestData();
		location.href = "<%=basePath%>mytreehangye.do";
	}
}
</script>
