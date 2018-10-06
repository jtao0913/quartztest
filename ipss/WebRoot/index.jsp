<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>
<%if(areacode!=null&&areacode.equals("000")){ %>
<!-- 
<div class="clearfix"  style="text-align:center;background: #D8D8D8;border: 1px solid #000;padding:4px;">
	本网站是内部演示测试版本，随时可能关闭，敬请知晓！如有疑问请点击联系工作人员。<a href="http://www.cnipr.com/fw/fwtd/" target="_blank">点击联系</a>
</div>
 -->
<%}%>
<%
String showtype = request.getParameter("showtype")==null?"":request.getParameter("showtype");//computer
/*
String wap = DataAccess.get("wap")==null?"0":DataAccess.get("wap");
if(wap.equals("1")&&!showtype.equals("computer")){
%>
<script src="<%=basePath%>wap/js/uaredirect.js"></script>
<script type="text/javascript">uaredirect("wap/");</script>
<%}
*/
%>

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
	<link href="common/com_2/css/panel.css" rel="stylesheet">
	
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
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
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
			<input type="hidden" id="strSources" name="strSources"/>			
			
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
			<input type="text" id="content" name="content" class="input-xxlarge" id="sousou"  placeholder="请输入关键词进行检索"/>
			<button type="button" class="btn btn-warning"  onClick="doQsearch()"><i class="icon-search icon-white"></i>&nbsp;检 索</button>	
			</div>
			<div style="height:10px;"></div>
			<div class="row">
            <ul class="inline">
				<li><label class="radio" style="width: 150px"><input type="radio" name="area" value="cn" checked> CNIPA专利（中文）</label></li>
				<li><label class="radio" style="width: 160px"><input type="radio" name="area" value="fr"> 港澳台及海外（英文）</label></li>
			</ul>
		</div>
	</form>
 	</div>	
 </div>
 <!--块状展示-->
 <div style="height:10px"></div>
 
 
<%
boolean b_showchart = true;
//String guosheng = "安徽";
String guosheng = "CNIPA";
boolean b_showotherchart = true;
%> 

<%if(b_showchart||b_showotherchart){%>
 	<div class="container" style="width: 900px;">
		<div id="myCarousel" class="carousel slide">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
			</ol>
			<!-- Carousel items -->
			<div class="carousel-inner">
<%}%>
			
				<div class="active item">
						<center>
							<div class="row">
								<ul class="row-fluid" style="width: 650px; height: 85px; color: #FFFFFF;">

								    <li class="span4 cursor height80" style="background-color: #6666FF;" onClick="gotolink(0);">
										<span class="span5"><img class="in_im" src="common/com_2/img/index/legal60.png"></span> 
										<span class="span7 font_15_in_80">语义检索 <span class="badge badge-warning">NEW</span></span>
									</li>
									
									<li class="span4 cursor height80" style="background-color: #6D3353;" onClick="gotolink(1);">
										<span class="span5"><img class="in_im" src="common/com_2/img/index/invalid60.png"></span>
										<span class="span7 font_15_in_80">表格检索</span>
									</li>
									<li class="span4 cursor height80" style="background-color: #009999;" onClick="gotolink(2);">
										<span class="span5"><img class="in_im" src="common/com_2/img/index/expert60.png"></span>
										<span class="span7 font_15_in_80">专家检索</span>
									</li>
									<!-- 
                                    <li class="span4 cursor height80" style="background-color: #6666FF;" onClick="gotolink(21);">
										<span class="span5"><img class="in_im" src="common/com_2/img/index/legal60.png"></span> 
										<span class="span7 font_15_in_80">法律状态 </span>
									</li>
			                         -->

								</ul>

								<ul class="row-fluid"
									style="width: 650px; height: 85px; color: #FFFFFF;">
									<li class="span3 font_15_in_80 cursor" onclick="gotolink(3);"
										style="background-color: #64c119;">CNIPR视角</li>
									<li class="span3 font_15_in_80 cursor" onclick="gotolink(4);"
										style="background-color: #ddae1c;">CNIPR服务</li>
									<li class="span3 font_15_in_80 cursor" onclick="gotolink(5);"
										style="background-color: #ec5777;">CNIPR学院</li>
									<li class="span3 font_15_in_80 cursor" onclick="gotolink(6);"
										style="background-color: #26beff;">中国专利年会</li>
								</ul>
								<!-- 
	 武汉
 	<ul class="row-fluid" style="max-width:650px;max-height:300px;color: #FFFFFF;">
 		<li class="span3 font_15_in_80 cursor" style="background-color: #64c119;"><a style="color:#fff" href="/navjump.jsp?jumpNavID=944&username=guest">生命健康</a></li>
 		<li class="span3 font_15_in_80 cursor" style="background-color: #ddae1c;"><a style="color:#fff" href="/navjump.jsp?jumpNavID=847&username=guest">智能装备</a></li>
 		<li class="span3 font_15_in_80 cursor" style="background-color: #ec5777;"><a style="color:#fff" href="/navjump.jsp?jumpNavID=750&username=guest">信息技术</a></li>
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

<%if(b_showchart){%>
				<div class="item">
					<center>
						<div style="width: 650px; height: 190px; margin-left: -20px;">
							<div class="row">
								<ul class="row-fluid">
									<li class="span4">
										<div class="panel panel-success">
											<div class="panel-heading" sytyle="height:30px;">2018年<%=guosheng%>申请人排名</div>
											<div class="panel-body">
												<a   
													onclick1='newWinUrl("<%=guosheng%>","申请人",20,"",0,"2","doughnut","line,bar,pie,doughnut,polar,rose")'
													onclick='newWinUrl("<%=guosheng%>","301")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/01_sqr.png"></a>
											</div>
										</div>
									</li>

									<li class="span4">
										<div class="panel panel-info">
											<div class="panel-heading" sytyle="height:30px;">2018年<%=guosheng%>对应国民经济分类构成</div>
											<div class="panel-body">
												<a
													onclick1='newWinUrl("<%=guosheng%>","国民经济大类",20,"",0,"2","bar","line,bar,pie,polar,rose")'
													onclick='newWinUrl("<%=guosheng%>","608")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/02_gmjj.png"></a>
											</div>
										</div>
									</li>
									<li class="span4">

										<div class="panel panel-danger">
											<div class="panel-heading" sytyle="height:30px;">2018年<%=guosheng%>专利类型构成</div>
											<div class="panel-body">
												<a
													onclick1='newWinUrl("<%=guosheng%>","专利类型",20,"",0,"2","line","line,bar,pie,doughnut,polar,rose")'
													onclick='newWinUrl("<%=guosheng%>","701")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/03_lxgc.png"></a>
											</div>
										</div>

									</li>
								</ul>
							</div>

						</div>
					</center>
				</div>
				<%} %>

<%if(b_showotherchart==true) {%>
              <div class="item">
					<center>
						<div style="width: 650px; height: 190px; margin-left: -20px;">
							<div class="row">
								<ul class="row-fluid">
									<li class="span4">
										<div class="panel panel-default">
											<div class="panel-heading" sytyle="height:30px;">2018年CNIPA省市类型构成</div>
											<div class="panel-body">
												<a  
													onclick1='newWinUrl("","省级行政",34,"专利类型",4,"0","stack","line,bar,bar_horizontal,stack,bubble,polar")'
													onclick='newWinUrl("<%=guosheng%>","702")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/04_gs.png"></a>
											</div>
										</div>
									</li>

									<li class="span4">
										<div class="panel panel-default">
											<div class="panel-heading" sytyle="height:30px;">2018年来CNIPA申请公开构成</div>
											<div class="panel-body">
												<a 
													onclick1='newWinUrl("","申请区域",30,"",0,"2","pie","line,bar,pie,doughnut,polar,rose")'
													onclick='newWinUrl("<%=guosheng%>","802")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/05_sj.png"></a>
											</div>
										</div>
									</li>
									<li class="span4">

										<div class="panel panel-default">
											<div class="panel-heading" sytyle="height:30px;">2018年CNIPA受理代理机构排名</div>
											<div class="panel-body">
												<a
													onclick1='newWinUrl("","专利代理机构分析",20,"",0,"2","pie","line,bar,pie,doughnut,polar,rose")'
													onclick='newWinUrl("<%=guosheng%>","807")'
													href="#"><img class="img-responsive"
													src="<%=basePath%>images/index_analyse/06_dljg.png"></a>
											</div>
										</div>

									</li>
								</ul>
							</div>

						</div>
					</center>
				</div>
<%} %>

<%if(b_showchart||b_showotherchart){%>
			</div>
			<!-- Carousel nav -->
			<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel"
				data-slide="next">&rsaquo;</a>
		</div>
	</div>
<%}%>
 
 
 
 
 
 
 
 
 

<script type="text/javascript">
$("#bt_analyse").click(function (){
	 newWinUrl("<%=basePath%>analyse.do?language=cn");
})

function _newWinUrl(guosheng,_xAxis,_xAxisSize,_yAxis,_yAxisSize,_cnfr,_charttype,_allcharttype){
		var url = "<%=basePath%>analyse.do?language=cn";
	    var f=document.createElement("form");
	    
	    var exp =document.createElement("input");
	    exp.id = "index_exp";
	    exp.name = "index_exp";
	    exp.type = "hidden";
	    //exp.value = "国省代码=江苏 and 公开年=2017";
	    //exp.value = "申请区域=中国 and 公开年=2018";
	    if(guosheng!=""&&guosheng!="CNIPA"){
	    	exp.value = "国省代码="+guosheng+" and 公开年=2018";
	    }else{
	    	exp.value = "公开年=2018";
	    }
	    
	    var dbs =document.createElement("input");
	    dbs.id = "strSources";
	    dbs.name = "strSources";
	    dbs.type = "hidden";
	    dbs.value = "14,15,16";
	    
	    var xAxis =document.createElement("input");
	    xAxis.id = "xAxis";
	    xAxis.name = "xAxis";
	    xAxis.type = "hidden";
	    xAxis.value = _xAxis;
	    
	    var xAxisSize =document.createElement("input");
	    xAxisSize.id = "xAxisSize";
	    xAxisSize.name = "xAxisSize";
	    xAxisSize.type = "hidden";
	    xAxisSize.value = _xAxisSize;
	    
	    var yAxis =document.createElement("input");
	    yAxis.id = "yAxis";
	    yAxis.name = "yAxis";
	    yAxis.type = "hidden";
	    yAxis.value = _yAxis;
	    
	    var yAxisSize =document.createElement("input");
	    yAxisSize.id = "yAxisSize";
	    yAxisSize.name = "yAxisSize";
	    yAxisSize.type = "hidden";
	    yAxisSize.value = _yAxisSize;
	    
	    var cnfr =document.createElement("input");
	    cnfr.id = "cnfr";
	    cnfr.name = "cnfr";
	    cnfr.type = "hidden";
	    cnfr.value = _cnfr;
	    
	    var charttype =document.createElement("input");
	    charttype.id = "charttype";
	    charttype.name = "charttype";
	    charttype.type = "hidden";
	    charttype.value = _charttype;
	    
	    
	    var allcharttype =document.createElement("input");
	    allcharttype.id = "allcharttype";
	    allcharttype.name = "allcharttype";
	    allcharttype.type = "hidden";
	    allcharttype.value = _allcharttype;
	    
	    f.appendChild(exp);
	    f.appendChild(dbs);
	    f.appendChild(cnfr);
	    f.appendChild(xAxis);
	    f.appendChild(xAxisSize);
	    f.appendChild(yAxis);
	    f.appendChild(yAxisSize);
	    f.appendChild(charttype);
	    f.appendChild(allcharttype);

	    f.setAttribute("action" , url);
	    f.setAttribute("method" , 'post' );
	    f.setAttribute("target" , '_black' );
	    document.body.appendChild(f);
	    
	    f.submit();
}

function newWinUrl(guosheng,_analyseMenuID){
	var url = "<%=basePath%>analyse.do?language=cn";
    var f=document.createElement("form");
    
    var exp =document.createElement("input");
    exp.id = "index_exp";
    exp.name = "index_exp";
    exp.type = "hidden";
    //exp.value = "国省代码=江苏 and 公开年=2017";
    //exp.value = "申请区域=中国 and 公开年=2018";
    if(guosheng!=""&&guosheng!="CNIPA"){
    	exp.value = "国省代码="+guosheng+" and 公开年=2018";
    }else{
    	exp.value = "公开年=2018";
    }
    
    var dbs =document.createElement("input");
    dbs.id = "strSources";
    dbs.name = "strSources";
    dbs.type = "hidden";
    dbs.value = "14,15,16";
    
    var analyseMenuID =document.createElement("input");
    analyseMenuID.id = "analyseMenuID";
    analyseMenuID.name = "analyseMenuID";
    analyseMenuID.type = "hidden";
    analyseMenuID.value = _analyseMenuID;
    
    
    f.appendChild(exp);
    f.appendChild(dbs);
    f.appendChild(analyseMenuID);

    f.setAttribute("action" , url);
    f.setAttribute("method" , 'post' );
    f.setAttribute("target" , '_black' );
    document.body.appendChild(f);
    
    f.submit();
}
</script>
 
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
    		//window.location.href="<%=basePath%>showFlztSearchForm.do";
    		window.location.href="<%=basePath%>showSemanticSearchForm.do";
    	}else if(url==1){
    		window.location.href='<%=basePath%>showSearchForm.do?area='+area;
    	}else if(url==2){
    		window.location.href='<%=basePath%>showLogicForm.do?area='+area;
    	}else if(url==21){
    		window.location.href='<%=basePath%>showFlztSearchForm.do';
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
    		window.location.href='http://www.cnipa.gov.cn/';
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
			var area = $('input[name="area"]:checked').val();
//			alert("area="+area);
			
			//aa and bb or cc
			if ((content.indexOf(" and ")>-1||content.indexOf(" AND ")>-1)&&
					 (content.indexOf(" or ")==-1&&content.indexOf(" OR ")==-1)&&
					 (content.indexOf(" not ")==-1&&content.indexOf(" NOT ")==-1))
			{
				var reg = new RegExp(" and ","g");//g,表示全部替换。
				content = content.replace(reg," ");
				
				var reg1 = new RegExp(" AND ","g");//g,表示全部替换。
				content = content.replace(reg1," ");

//				content = content.replace(" and "," ");
//				content = content.replace(" AND "," ");
				
				$("#strWhere").attr("value",colname+"("+$.trim(content).replace(/\s+/g, " and ")+")");
			}else if( (content.indexOf(" and ")==-1&&content.indexOf(" AND ")==-1)&&
					 (content.indexOf(" or ")>-1||content.indexOf(" OR ")>-1)||
					 (content.indexOf(" not ")>-1||content.indexOf(" NOT ")>-1)){
			
				$("#strWhere").attr("value",colname+"("+$.trim(content)+")");
			}else if( (content.indexOf(" and ")>-1||content.indexOf(" AND ")>-1)&&
					 (content.indexOf(" or ")>-1||content.indexOf(" OR ")>-1||
					 content.indexOf(" not ")>-1||content.indexOf(" NOT ")>-1)){
			
				$("#strWhere").attr("value",colname+"("+$.trim(content)+")");
			}
			else{
				$("#strWhere").attr("value",colname+"("+$.trim(content).replace(/\s+/g, " and ")+")");
			}

//alert($("#strWhere").val());
			
			if(area=='cn'){
				$("#strChannels").val("14,15,16,17");
				$("#strSources").val("14,15,16,17");
			}else{
				$("#strChannels").val("18,19,20,21,22,23,24,25");
				$("#strSources").val("18,19,20,21,22,23,24,25");
			}
//			$("#searchForm").attr("action","expressSearch.do?simpleSearch=1&pageType=all&quickSearchEncode=UTF8");			
			$("#searchForm").attr("action","pretoJsonOverView.do?simpleSearch=1&pageType=all&quickSearchEncode=UTF8");
			$("#searchForm").submit();
		}else{
			return false;
		}
	}
</script>
<script type="text/javascript">
function hangyelogin(username){
//alert("window.onload......");
//var username = $('#username').attr('title');
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
