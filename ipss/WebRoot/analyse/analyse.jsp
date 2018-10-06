﻿<%@ page import="com.cnipr.cniprgz.commons.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>统计分析</title>
<%@ include file="../jsp/zljs/include-head-base.jsp"%>

<link href="<%=basePath%>/common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>/common/com_2/css/main.css" rel="stylesheet">
<link href="<%=basePath%>/analyse/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>/analyse/bootstrap-switch.min.css" rel="stylesheet">
<%
String area = "cn";
area = request.getParameter("language").toLowerCase();

String index_exp = request.getParameter("index_exp");

String analyseMenuID = request.getParameter("analyseMenuID");
//String exp = (String)request.getAttribute("strWhere");
String exp = request.getParameter("strWhere");
String dbs = request.getParameter("strSources");

//out.println("index_exp="+index_exp);
//out.println("exp="+exp);
//out.println("dbs="+dbs);

if(exp==null&&index_exp!=null&&!index_exp.equals(""))
{
	exp = index_exp;
}

//System.out.println("area="+area);
//out.println("exp="+exp);
//out.println("dbs="+dbs);

int intAnalyseState = 0;
if(request.getSession().getAttribute("intAnalyseState")!=null)
{
	intAnalyseState = ((Integer)request.getSession().getAttribute("intAnalyseState"));	
}
//System.out.println("intAnalyseState="+intAnalyseState);
if(intAnalyseState==0){
%>
<script type="text/javascript">
alert("您没有分析权限");
window.close();
</script>
<%
return;
}

if(dbs==null||dbs.equals("")||exp==null||exp.equals("")){
%>
<script type="text/javascript">
window.close();
</script>
<%
return;
}

//int cnfr1 = 0;
if(dbs.indexOf("patent")>-1){
//	cnfr = 1;
	area = "fr";
}
 %>
</head>

<span id="L4EVER"></span>
<body style="background-color: #e6f2f0;font-family: Microsoft YaHei,'宋体' , Tahoma, Helvetica, Arial, "\5b8b\4f53", sans-serif;">
	<div class="row-fluid mycolor">
		<div style="width: 1258px; height: 40px; margin: auto;">
			<a href="<%=basePath%>"><img src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/x_logo.png"></a>
		</div>
	</div>

<div id="app" class="container"
		style="width: 1258px; margin: auto; padding: 16px;">

<div class="pull-left" style="width:220px;height:1000px;margin: auto;" id="accordion" role="tablist" aria-multiselectable="true">

<span class="list-group-item active" style="font-weight:bold;background-color: #3498db;border-color:#3498db;">分析主题</span>
<a href="#" onClick="javascript:$('#analyseindex').show();$('#analysecontent').hide();" class="list-group-item"  style="cursor:pointer;color:#f9a126;font-weight: bold;"> 分析首页<i class="glyphicon glyphicon-chevron-toggle"></i></a>

<div class="panel panel-default" id="analysemenu"></div>

</div>
<input id="analyseMenuID" type="hidden">

<%
if(area.equalsIgnoreCase("cn")){
%>
<DIV id="analyseindex" class="pull-right" style="display: block;margin: auto; padding: 18px; width: 990px; height: 600px; background-color: rgb(255, 255, 255);">
<DIV style="margin: auto; padding: 8px;font-size: 13px;"><FONT style="color: rgb(249, 161, 38); font-size: 14px; font-weight: bold;">分析首页-统计分析可视化 
</FONT>
<HR style="border: 1px solid #00ccff; border-image: none; margin-top: 6px; margin-bottom: 10px;">    
	根据检索结果从多个维度对检索数据进行分析：趋势分析、申请区域分析、申请人分析、发明人分析、代理人/代理机构分析、技术分类分析、中国专项分析、国外来华分析等。各个维度下又分几个维度的交叉统计分析。 
</DIV>
<DIV class="row" style="margin-top: 20px;">
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">来源国/区域构成分析</H5></DIV>
<DIV class="panel-body"><A href="#" onclick="directAnalyse('201')""><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse01.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">省市申请类型构成</H5></DIV>
<DIV class="panel-body"><A href="#" onclick="directAnalyse('702')""><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse02.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">综合趋势分析</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('101')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse03.png"></A>
</DIV></DIV></DIV></DIV>
<DIV class="row">
<DIV class="col-sm-3">
<DIV class="panel panel-danger">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">申请人排名</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('301')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse04.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-info">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">发明人排名</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('401')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse05.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-warning">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">国民经济分类构成</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('608')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse06.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-success">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">IPC分类趋势分析</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('601')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse07.png"></A>
</DIV></DIV></DIV></DIV></DIV>

<%}else{%>

<DIV id="analyseindex" class="pull-right" style="display: block;margin: auto; padding: 18px; width: 990px; height: 600px; background-color: rgb(255, 255, 255);">
<DIV style="margin: auto; padding: 8px;font-size: 13px;"><FONT style="color: rgb(249, 161, 38); font-size: 14px; font-weight: bold;">分析首页-统计分析可视化 
</FONT>
<HR style="border: 1px solid #00ccff; border-image: none; margin-top: 6px; margin-bottom: 10px;">    
	根据检索结果从多个维度对检索数据进行分析：趋势分析、申请区域分析、申请人分析、发明人分析、代理人/代理机构分析、技术分类分析、中国专项分析、国外来华分析等。各个维度下又分几个维度的交叉统计分析。 
    </DIV>
<DIV class="row" style="margin-top: 20px;">
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">受理国/区域构成分析</H5></DIV>
<DIV class="panel-body"><A href="#" onclick="directAnalyse('201')" ><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse01_fr.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">第一申请人申请趋势</H5></DIV>
<DIV class="panel-body"><A href="#" onclick="directAnalyse('307')" ><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse02_fr.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-4">
<DIV class="panel panel-default">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">综合趋势分析</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('101')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse03.png"></A>
</DIV></DIV></DIV></DIV>
<DIV class="row">
<DIV class="col-sm-3">
<DIV class="panel panel-danger">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">申请人排名</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('301')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse04.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-info">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">发明人排名</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('401')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse05.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-warning">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">发明人申请趋势</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('402')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse06_fr.png"></A>
</DIV></DIV></DIV>
<DIV class="col-sm-3">
<DIV class="panel panel-success">
<DIV class="panel-heading">
<H5 class="panel-title" style="font-size: 13px;">IPC分类趋势分析</H5></DIV>
<DIV class="panel-body"><A onclick="directAnalyse('601')" href="#"><IMG 
class="img-responsive" src="<%=basePath %>analyse/images/analyse07.png"></A>
</DIV></DIV></DIV></DIV></DIV>
<%}%>

<div  id="analysecontent" class="pull-right" style="display: none;width: 990px; height: auto; background-color: #ffffff; margin: auto; padding: 12px;">

<div id="introduce"></div>

        <div class="btn-toolbar" role="toolbar">
			<div class="btn-group" style="display: block;" id="charttype"></div>
			<div class="btn-group" style="display: block;" id="ipctype"></div>
			<div class="btn-group" style="display: block;" id="gmjjtype"></div>
			
			<div class="btn-group" style="display: block;">
			
			<select class="form-control input-sm" @change="change_theme()"  id="span_theme_contend">
      <option value="shine">默认色系</option>
      			<!-- 
				<option value="default">色系一</option>
				<option value="chalk">色系二</option>
				<option value="dark">色系三</option>
				
				<option value="halloween">色系五</option>
				 -->
				<option value="infographic">色系二</option>
				<!-- 
				<option value="macarons">色系七</option>
				<option value="purple-passion">色系八</option>
				<option value="roma">色系九</option>
				<option value="vintage">色系十</option>
				<option value="walden">色系十一</option>
				<option value="westeros">色系十二</option>
				 -->
				<option value="wonderland">色系三</option>
				<option value="essos">色系四</option>	
    </select>
    </div>
    <div class="btn-group" style="display: block;line-height:35px;margin-left:20px;font-size:12px;">
		 数字标签 <input type="checkbox" @click="change_label()" id="digital_label" name="digital_label" value="true"/>	 
	</div>
         </div>

			<div
				style="margin: auto; padding: 4px; padding-right: 38px; text-align: right;">
				<button type="button" class="btn btn-success btn-xs" onclick="vm.export_img()">导出图片</button>
			</div>

			<div id="panel" style="margin-bottom: 20px; padding: 10px;">
				<div class="chart" id="patentAnalysisEcharts"
					style="width: 940px; height: 480px;"></div>
			</div>

			<div
				style="margin: auto; padding: 4px; padding-right: 38px; text-align: right;">
				<button type="button" class="btn btn-info btn-xs" onclick="vm.export_table()">导出Excel</button>
			</div>
			
			
			
			
			
			

<table class="position_table table table-striped table-bordered" cellpadding="0" cellspacing="0" border="1" style="width:100%;display: none;font-size:11px;" id="tab_x">

				<tr style="background-color:#e6f2f0;">
					<td>{{xAxisName}}</td>
					<td>数量</td>
				</tr>
				<tr v-for="data in pieDataList0">
					<td>{{data.name}}</td>
					<td>
								<!-- 
								<a v-if="data.value>0" onClick="second_search('{{data.name}}','')" style="cursor:pointer;">
								      {{data.value}}
								</a>
								 
								 
								 <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">{{data.value}}</button>
                                 -->
								<a v-if="data.value>0" style="cursor:pointer;" data-toggle="modal" data-target="#analysejieguoModal"  onclick="javascript:second_search('{{data.name}}','')">{{data.value}}</a>
								<span v-else>
								      {{data.value}}
								</span>
								
					</td>
				</tr>
			</table>


<!-- 
			<table class="table table-condensed" style="display: none;" id="tab_xy">
				<tr>
					<td>
						<table style="width: 600px;" border='1'>
							<tr>
								<td>&nbsp;</td>
								<td v-for="data in xAxisData">{{data}}</td>
							</tr>
							<tr v-for="(index, data) in arrSeries">
								<td>
									<ul v-for="(_index, legend_data) in legend">
										<li v-if="index==_index">{{legend_data}}</li>
									</ul></td>
								<td v-for="_data in data">{{_data}}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
 -->



<style type="text/css">
#scrool{width:900px;margin:auto;overflow:auto;position:relative}
.position_th{background-color:gray;position:absolute;top:0}

list-style:none;
</style>

<script>
        $(document).ready(function(){
              $("div").scroll(function() {
                    $(".position_th").css({"top":$(this).scrollTop()})
              });
        });
</script>

<div id="scrool">
    <table class="position_table table table-striped table-bordered" cellpadding="0" cellspacing="0" border="1" style="display: none;font-size:11px;" id="tab_xy">
        <tr style="background-color:#e6f2f0;">
        	<td><div style="width:150px;">{{xAxisName}}/{{yAxisName}}</div></td><td v-for="data in xAxisData">{{data}}</td>
        </tr>
        <tr v-for="(index, data) in arrSeries">
								<td style="background-color:#e6f2f0;" width="150">
									<span  v-for="(legend_index, legend_data) in legend">
										<span v-if="index==legend_index" tag="">{{legend_data}}</span>
									</span>									
								</td>
								<td v-for="(_index,_data) in data">
								<!-- 
									<span v-for="(x_index,x_data) in xAxisData" style="display: none;">
										<span v-if="_index==x_index" id="">{{x_data}}</span>
									</span>
									<span v-for="(y_index,y_data) in legend" style="display: none;">
										<span v-if="index==y_index" id="">{{y_data}}</span>
									</span>									
									<span v-if="{{_data}}>0" id="">{{_data}}</span>
								 -->
								 
								     <a v-if="_data>0"  data-toggle="modal" data-target="#analysejieguoModal"  onclick="second_search('{{xAxisData[_index]}}','{{legend[index]}}')" style="cursor:pointer;">
								      {{_data}}
								    </a>
								    <span v-else>
								      {{_data}}
								    </span>
																	
								</td>
		 </tr>
    </table>
</div>


<form id="searchForm" name="searchForm" action="<%=basePath%>overviewSearch.do" method="post" target="_blank">
<input type="hidden" name="area" id="area" value="<%=area%>">
<input type="hidden" name="cnfr" id="cnfr">
<input type="hidden" name="strStat" id="strStat" value="1">
<input type="hidden" name="xAxisName" id="xAxisName" value="{{xAxisName}}">
<input type="hidden" name="yAxisName" id="yAxisName" value="{{yAxisName}}">
<input type="hidden" name="strWhere" id="strWhere" value="<%=exp%>">
<input type="hidden" name="strDefautCols" id="strDefautCols" value="{{xAxisName}},{{yAxisName}}">
<input type="hidden" name="strSources" id="strSources" value="<%=dbs%>">
<input type="hidden" name="strChannels" id="strChannels" value="<%=dbs%>">
</form>


<script type="text/javascript">
function zllx(leixing){
	if(leixing==='发明公开') {
		zl_type = '1';
	}else if(leixing==='实用新型') {
		zl_type = "2";
	}else if(leixing==='外观专利') {
		zl_type = "3";
	}else if(leixing==='PCT发明公开') {
		zl_type = "8";
	}else if(leixing==='PCT实用新型') {
		zl_type = "9";
	}
//alert(zl_type);
	return zl_type;
}
function getGmjj(content){
	var words = content.split('-')
//alert(zl_type);
	return words[0];
}

</script>

			<table class="table table-condensed" style="display: none;" id="tab_xx">
				<tr>
					<td>&nbsp;</td>
					<td v-for="data in xAxis">{{data}}</td>
				</tr>
				<tr v-for="(index, data) in arrSeries">
					<td><ul v-for="(_index, legend_data) in legend">
							<li v-if="index==_index">{{legend_data}}</li>
							</ul>
					</td>
					<td v-for="_data in data">
						     <a v-if="_data>0" onclick="second_search('{{xAxisData[_index]}}','{{legend[index]}}')">
						      {{_data}}
						    </a>
						    <span v-else>
						      {{_data}}
						    </span>					
					</td>
				</tr>
			</table>

<!-- 
<tr>
<td>
         <table style="width:600px;" border = '1'>
            <tr>
            	<td>&nbsp;</td>
                <td  v-for="data in legend">{{data}}</td>
            </tr>
             <tr  v-for="(index, data) in arrSeries">             
                <td><ul v-for="(_index, legend_data) in xAxis"><li v-if="index==_index">{{legend_data}}</li></ul></td>
                <td v-for="_data in data">{{_data}}</td>
             </tr>
          </table>	
</td>
</tr>
-->
			

		</div>

	</div>

	<%@ include file="../jsp/zljs/include-buttom.jsp"%>

</body>

</html>

<script type="text/javascript">
function loadjsfile(filename){
//	alert("begin loadjsfile...");
	var fileref=document.createElement('script');
	fileref.setAttribute("type","text/javascript");
	fileref.setAttribute("src",filename);
//	alert("end loadjsfile...");
}
function removejsfile(filename){
//	alert("begin removejsfile...");
	var allsuspects=document.getElementsByTagName("script");

	for (var i=allsuspects.length; i>=0;i--){
		if (allsuspects[i] &&allsuspects[i].getAttribute("src")!=null && allsuspects[i].getAttribute("src").indexOf(filename)!=-1){
		  allsuspects[i].parentNode.removeChild(allsuspects[i]);
		}
	}
//	alert("end removejsfile...");
}

</script>

<span id="AD_L4EVER">
<!-- 
<script src="<%=basePath%>/analyse/echarts.js"></script>
<script src="<%=basePath%>/analyse/echarts_3.7.0_echarts.simple.js"></script>
-->
<script src="<%=basePath%>/analyse/echarts.min.js"></script>
<!-- 
<script src="<%=basePath%>/analyse/china.js"></script>
<script src="<%=basePath%>/map/guangdong/guangdong.js"></script>
<script src="<%=basePath%>/analyse/world.js"></script>
-->
<script src="<%=basePath%>/analyse/vue.min.js"></script>
<script src="<%=basePath%>/analyse/json2.js"></script>
<script src="<%=basePath%>/analyse/jquery-extend.js"></script>

<script src="<%=basePath%>/analyse/echarts-wordcloud.min.js"></script>

<script src="<%=basePath%>/analyse/theme/shine.js"></script>
<script src="<%=basePath%>/analyse/theme/infographic.js"></script>
<script src="<%=basePath%>/analyse/theme/essos.js"></script>
<script src="<%=basePath%>/analyse/theme/wonderland.js"></script>	
</span> 
<script>L4EVER.innerHTML=AD_L4EVER.innerHTML;AD_L4EVER.innerHTML="";</script>

<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>

<script src="<%=basePath%>common/com_3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/mask/mask.js"></script>

<SCRIPT type=text/javascript src="<%=basePath%>common/mask/lhgdialog.min.js?skin=chrome"></SCRIPT>

<script language="javascript">
var loadimg = "./img/load2.gif"; // 加载时的loading图片

function showPage(tabId, url) {
	$('#maintab a[href="#' + tabId + '"]').tab('show'); // 显示点击的tab页面
	if($('#' + tabId).html().length < 20) { // 当tab页面内容小于20个字节时ajax加载新页面
		$('#' + tabId).html('<br>' + loadimg + ' 页面加载中，请稍后...'); // 设置页面加载时的loading图片
		$('#' + tabId).load(url); // ajax加载页面
	}
}
</script>

<script type="text/javascript">
//var location = (window.location+'').split('/');  
//var basePath = location[0]+'//'+location[2]+'/'+location[3];  
//var url = "${pageScope.basePath}";
//alert(url);
var menuList = [];

// 获取长度为len的随机字符串
function _getRandomString(len) {
    len = len || 32;
    var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678'; //默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1
    var maxPos = $chars.length;
    var pwd = '';
    for (i = 0; i < len; i++) {
        pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
    }
    return pwd;
}

var vm = new Vue({
		el : "#app",
		data : {
			dbs : '<%=dbs%>',
			exp : '<%=exp.replace("'", "\\\'")%>',
			chartTitle : '专利分析图',
			digital_label:false,
			dataTableList : '',
			pieDataList0:[],
			arrSeries:[],
			legend:[],
			menuId:'',
			xAxisData:[],
			xAxisName:'',
			yAxisName:'',
			xAxisSize:0,
			yAxisSize:0,			
			jsonresult:'',
			dimension:'',
			chartType:'',
			allChartType:'',
			theme:'shine',
			cnfr:''
		},
		computed : {
			style : function() {
				return "width:" + this.width + "px;height:" + this.height + "px"
			}
		},
		created: function () {
//alert("created.......");
//alert("created="+!menuList +"--"+ menuList!=0 +"--"+  menuList!='');



			$("body").mask("正在初始化，请稍候...");
			var text = "";
			var introduce = "";
			
		if(menuList){
			
			$.ajax({
				type : "GET",
				url : "getAllAnalyseMenuInfo.do?area=<%=area%>&" + new Date(),
				contentType : "application/json;charset=UTF-8",
				success : function(jsonresult) {
//					alert(jsonresult);
					var data= $.parseJSON(jsonresult);
					
					var no = 1;
					for (var key in data) {
						var val = data[key];
//alert(val.intID+"---"+val.chrName);
//						if(val.intEnable==1||val.intEnable=="1")
						if(val.intParentID==='0'||val.intParentID===0){							
							if(text!=''){
								text+="</div>";
							}
							if(no===1){
								text+="<a id='heading_"+no+"' role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse_"+no+"' aria-expanded='false' aria-controls='collapse_"+no+"'  class='list-group-item active'  style='background-color: #aaa;border-color:#aaa;border-bottom-color:#fff;-webkit-border-radius: 0;-moz-border-radius: 0;border-radius: 0;'>"+val.chrName+"<i class='glyphicon glyphicon-"+val.chrIcon+" pull-right'></i></a>";
							}else{
								text+="<a id='heading_"+no+"' role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse_"+no+"' aria-expanded='false' aria-controls='collapse_"+no+"'  class='list-group-item active'  style='background-color: #aaa;border-color:#aaa;border-bottom-color:#fff;margin-top:1px;'>"+val.chrName+"<i class='glyphicon glyphicon-"+val.chrIcon+" pull-right'></i></a>";
							}
							text+="<div id='collapse_"+no+"' class='panel-collapse collapse' role='tabpanel' aria-labelledby='heading_"+no+"'>";
							no++;
						}else{
//alert(val.intID+"---"+val.chrName);
							introduce+="<div style=\"margin:auto;padding:8px;display:none;font-size:13px;\" name=\"intr"+val.intID+"\" id=\"intr"+val.intID+"\"><font style=\"font-size:14px;font-weight: bold;color:#f9a126;\">"+val.chrName+"</font><hr style=\"border:1px solid #00ccff;margin-bottom:10px;margin-top:6px;\"/>"+val.chrIntroduce+"</div>"
							text+="<a href='#' name='menu' id='menu_"+val.intID+"' class='list-group-item' onClick=\"vm.analysePatent('"+val.intID+"','"+val.chrDefaultChart+"','"+val.chrXAxis+"',"+val.xAxisSize+",'"+val.chrYAxis+"',"+val.yAxisSize+",'"+val.intCNFR+"','"+val.chrChart+"')\">"+val.chrName+"</a>";
							
							menuList[val.intID] = val;
						}
					}
					
					$('#analysemenu').html(text);
					$('#introduce').html(introduce);	
				}
			});
			
		}else{
			
			for (var key in menuList) {
				var val = data[key];
//alert(val.intID+"---"+val.chrName);
//				if(val.intEnable==1||val.intEnable=="1")
				if(val.intParentID==='0'||val.intParentID===0){							
					if(text!=''){
						text+="</div>";
					}
					if(no===1){
						text+="<a id='heading_"+no+"' role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse_"+no+"' aria-expanded='false' aria-controls='collapse_"+no+"'  class='list-group-item active'  style='background-color: #aaa;border-color:#aaa;border-bottom-color:#fff;-webkit-border-radius: 0;-moz-border-radius: 0;border-radius: 0;'>"+val.chrName+"<i class='glyphicon glyphicon-"+val.chrIcon+" pull-right'></i></a>";
					}else{
						text+="<a id='heading_"+no+"' role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse_"+no+"' aria-expanded='false' aria-controls='collapse_"+no+"'  class='list-group-item active'  style='background-color: #aaa;border-color:#aaa;border-bottom-color:#fff;margin-top:1px;'>"+val.chrName+"<i class='glyphicon glyphicon-"+val.chrIcon+" pull-right'></i></a>";
					}
					text+="<div id='collapse_"+no+"' class='panel-collapse collapse' role='tabpanel' aria-labelledby='heading_"+no+"'>";
					no++;
				}else{
//alert(val.intID+"---"+val.chrName);
					introduce+="<div style=\"margin:auto;padding:8px;display:none;font-size:13px;\" name=\"intr"+val.intID+"\" id=\"intr"+val.intID+"\"><font style=\"font-size:14px;font-weight: bold;color:#f9a126;\">"+val.chrName+"</font><hr style=\"border:1px solid #00ccff;margin-bottom:10px;margin-top:6px;\"/>"+val.chrIntroduce+"</div>"
					text+="<a href='#' name='menu' id='menu_"+val.intID+"' class='list-group-item' onClick=\"vm.analysePatent('"+val.intID+"','"+val.chrDefaultChart+"','"+val.chrXAxis+"',"+val.xAxisSize+",'"+val.chrYAxis+"',"+val.yAxisSize+",'"+val.intCNFR+"','"+val.chrChart+"')\">"+val.chrName+"</a>";
					
//					menuList[val.intID] = val;
				}
			}
			
			$('#analysemenu').html(text);
			$('#introduce').html(introduce);			
			
		}
			
			$('body').unmask();
		},
		methods : {
			menu_selected : function(menuid){
//alert(menuid);
//$("[attribute^=value]")
//$(".list-group-item").on("click", function(){
				$("a[name=menu]").each(function() {
					$(this).removeClass("list-group-item-info");
				})
				$("#menu_"+menuid).addClass("list-group-item-info");
			},
			export_img : function(){
				var myChart = echarts.init(document.getElementById('patentAnalysisEcharts'));				
				var dataUrl = myChart.getDataURL();
//				alert(dataUrl);
							    
			    $("body").mask("正在生成下载文件，请稍候...");
			  	$.ajax({
//			  		url : ctx + '/downloadTIFFZip.do',
			  		url : '<%=basePath%>createAnalysePNG.do',
			  		type : 'POST',
			  		data : {
			  			'pngstr' : dataUrl
			  		},
			  		success : function(jsonresult) {
			  			$("body").unmask();
//			  			alert(jsonresult);

			  			$.dialog({
			  				id : 'winlogin',
			  				bgcolor : '#FFF',				
			  				title : '下载',
			  				max : false,
			  				min : false,
			  				content : '<div style="line-height:22px;">资源获取成功，<a href='
			  					+ '<%=basePath%>downloadZipfile.do?fileName=' + jsonresult
			  					+ '>[这里]</a>进行下载 !</div>'
			  			});

			  		},
			  		error : function() {
			  			$("body").unmask();
			  			//alert(json.rmsg);
			  		}
			  	});
			    
				
//				alert(dataUrl);					            
			},
			
			export_table : function(){				
				$("body").mask("正在生成下载文件，请稍候...");
					$.ajax({
						url : '<%=basePath%>createAnalyseTableZip.do',
						type : 'POST',
						data : {
//							'strWhere' : where,
//							'strSources' : source,
							'dimension' : this.dimension,
							'jsonresult' : this.jsonresult
						},
						success : function(jsonresult) {
							$("body").unmask();
//							alert(jsonresult);

							$.dialog({
								id : 'winlogin',
								bgcolor : '#FFF',				
								title : '下载',
								max : false,
								min : false,
								content : '<div style="line-height:22px;">资源获取成功，<a href='
									+ '<%=basePath%>downloadZipfile.do?fileName=' + jsonresult
									+ '>[这里]</a>进行下载 !</div>'
							});
						},
						error : function() {
							$("body").unmask();
							//alert(json.rmsg);
						}
					});
			},
			
			change_ipc_btn : function(xAxis,yAxis){				
//				alert("xAxis="+xAxis);
//				alert("yAxis="+yAxis);
			
				var ipcType='';
				if(xAxis.indexOf("IPC")>-1){
					ipcType=xAxis;
				}
				
				if(yAxis.indexOf("IPC")>-1){
					ipcType=yAxis;
				}				
				
				if(ipcType!=''){
					
					var _ipctype='';

	 			    var aBtn=$("#ipctype button");

		 		        for(var i=0;i<aBtn.length;i++)
		 		        {
//		 		        	alert(aBtn[i].innerText);
							aBtn[i].setAttribute('class','btn btn-default btn-sm');
		 		        }
						
						if(ipcType==='IPC部'){
							_ipctype='IPC_bu';
						}else if(ipcType==='IPC大类'){
							_ipctype='IPC_dl';
						}else if(ipcType==='IPC小类'){
							_ipctype='IPC_xl';
						}else if(ipcType==='IPC大组'){
							_ipctype='IPC_dz';
						}else if(ipcType==='IPC分类号'){
							_ipctype='IPC';
						}
		 		        
		 				var _this = document.getElementById("btn_"+_ipctype);
						_this.setAttribute("class","btn btn-warning btn-sm");
				}			
			},

			change_gmjj_btn : function(xAxis,yAxis){				
//				alert("xAxis="+xAxis);
//				alert("yAxis="+yAxis);
			
				var gmjjType='';
				if(xAxis.indexOf("国民经济")>-1){
					gmjjType=xAxis;
				}
				
				if(yAxis.indexOf("国民经济")>-1){
					gmjjType=yAxis;
				}				
				
				if(gmjjType!=''){
					
					var _gmjjtype='';

	 			    var aBtn=$("#gmjjtype button");

		 		        for(var i=0;i<aBtn.length;i++)
		 		        {
//		 		        	alert(aBtn[i].innerText);
							aBtn[i].setAttribute('class','btn btn-default btn-sm');
		 		        }
		 		      
						if(gmjjType==='国民经济部'){
							_gmjjtype='GMJJ_bu';
						}else if(gmjjType==='国民经济大类'){
							_gmjjtype='GMJJ_dl';
						}else if(gmjjType==='国民经济中类'){
							_gmjjtype='GMJJ_zl';
						}else if(gmjjType==='国民经济小类'){
							_gmjjtype='GMJJ_xl';
						}
		 		        
		 				var _this = document.getElementById("btn_"+_gmjjtype);
						_this.setAttribute("class","btn btn-warning btn-sm");
				}			
			},
			
 			change_ipctype : function(ipcType){
// 				alert("ipcType="+ipcType);
// 				alert("change_charttype");
// 				alert("dimension--"+dimension);
// 				alert("chartType---"+chartType);

 								var self = this;
// 				 			    var aBtn=document.getElementsByTagName("button");
 				 			    
// 								alert("btn_"+_ipctype); 								
// 								alert(_this.id);
//alert(_this.getAttribute("class"));
 								
// 								self.prepareData(chartType,'');

									var xAxis = self.xAxisName;
									var yAxis = self.yAxisName;
									
									var xAxisSize = self.xAxisSize;
									var yAxisSize = self.yAxisSize;

//alert("xAxis="+xAxis);
//alert("yAxis="+yAxis);
									
									if(xAxis.indexOf('IPC')>-1){
										xAxis = ipcType;
									}
									if(yAxis.indexOf('IPC')>-1){
										yAxis = ipcType;
									}

									self.analysePatent(self.menuId,'',xAxis,xAxisSize,yAxis,yAxisSize);
 				 			},

 				 			change_gmjjtype : function(gmjjType){
 				 	 			
// 				 				alert("ipcType="+ipcType); 			
// 				 				alert("change_charttype");
// 				 				alert("dimension--"+dimension);
// 				 				alert("chartType---"+chartType);

 				 								var self = this;
// 				 				 			    var aBtn=document.getElementsByTagName("button");
 				 				 			    	
// 				 								alert("btn_"+_ipctype); 								
// 				 								alert(_this.id);
 				//alert(_this.getAttribute("class"));
 				 								
// 				 								self.prepareData(chartType,'');

 													var xAxis = self.xAxisName;
 													var yAxis = self.yAxisName;
 													
 													var xAxisSize = self.xAxisSize;
 													var yAxisSize = self.yAxisSize;
 													
 													if(xAxis==='省市')
 													{
 														xAxis="国省";
 													}
 													if(yAxis==='省市')
 													{
 														yAxis="国省";
 													}

 				//alert("xAxis="+xAxis);
 				//alert("yAxis="+yAxis);
 													
 													if(xAxis.indexOf('国民经济')>-1){
 														xAxis = gmjjType;
 													}
 													if(yAxis.indexOf('国民经济')>-1){
 														yAxis = gmjjType;
 													}

 													self.analysePatent(self.menuId,'',xAxis,xAxisSize,yAxis,yAxisSize);
 				 				 			},
 				 			
 			change_charttype : function(dimension,chartType){
//alert("change_charttype");
//alert("dimension--"+dimension);
//alert("chartType---"+chartType);

				var self = this;
// 			    var aBtn=document.getElementsByTagName("button");
 			    var aBtn=$("#charttype button");
 		        for(var i=0;i<aBtn.length;i++)
 		        {
// 		        	alert(aBtn[i].innerText);
					aBtn[i].setAttribute('class','btn btn-default btn-sm');
 		        }
 				var _this = document.getElementById("btn_"+dimension+"_"+chartType); 				
				_this.setAttribute('class','btn btn-primary btn-sm');
								
//				alert(_this.id);
/*
				document.getElementById("btn_xy_map").setAttribute("hidden",true);
				document.getElementById("btn_xy_map").removeAttribute("hidden");
*/
//				list-group-item list-group-item-info
/*
				if(typeof(chartType)==="undefined"||chartType===""){
					chartType = self.chartType;
				}else{
					self.chartType = chartType;
				}
*/
				self.prepareData(chartType);
 			},
 			change_label: function(){
// 				alert("show_theme");			
//				var _select = document.getElementById("digital_label");
//				var _digital_label = _select.options[_select.options.selectedIndex].value;
				
				var _checkbox_digital = document.getElementById("digital_label");
				
//				alert(_checkbox_digital.checked)
				/*
				var self = this;
//alert("主题="+theme);

				if(_digital_label==="true"){
					self.digital_label = true;
				}else{
					self.digital_label = false;
				}
				*/
				var self = this;
				self.digital_label = _checkbox_digital.checked;
//				alert(self.digital_label==true);
				self.prepareData(self.chartType);				
			},
 			change_theme: function(){
//alert("show_theme");			
					var _select = document.getElementById("span_theme_contend");
					var theme = _select.options[_select.options.selectedIndex].value;
					var self = this;
//alert("主题="+theme);
					if(typeof(theme)==="undefined"||theme===""){
						
						if(typeof(self.theme)==="undefined"||self.theme===""){
							theme = "shine";
						}else{
							theme = self.theme;
						}
						
					}else{
						self.theme = theme;
					}
					
					var chartType = self.chartType;					
					self.prepareData(chartType);
			},
//			prepareData : function(dimension,chartType,reverse,theme){
			prepareData : function(chartType){
//alert("prepareData");
				var self = this;
//				var jsonresult = self.jsonresult;				
				
//alert("chartType=" + chartType);
//alert("theme=" + theme);

//alert(self.dimension);
//alert(self.chartType);
//alert(self.reverse);
				
//alert(chartType + "---" + _type);
//alert(jsonresult);
//				var cnfr = self.cnfr;
/*
				if(typeof(dimension)==="undefined"||dimension===""){
					dimension = self.dimension;
				}
*/
//				alert("dimension="+dimension);
				
				if(typeof(chartType)==="undefined"||chartType===""){
					chartType = self.chartType;
				}else{
					self.chartType = chartType;
				}
				
				var theme = self.theme;
//alert("theme="+theme);
				
//$("#span_theme").show();
				$("#span_theme_contend").show();
				
//				var dimension = self.dimension;
//				var reverse = self.reverse;
				
				var data= $.parseJSON(self.jsonresult);
				
//				alert(data.status);
				
				if (data.status == 1
//						 && data.results != null
						 ){
						//showexp("外观专利无IPC分类，无法进行IPC专项分析！");
							$('body').unmask();
							var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
							echarts.dispose(chart);
							alert("外观专利无IPC分类，无法进行IPC专项分析！");
//							alert("分析无结果");
					}else if (data.status == 2
//							 && data.results != null
					 ){
					//showexp("外观专利无IPC分类，无法进行IPC专项分析！");
					$('body').unmask();
//						alert("外观专利无IPC分类，无法进行IPC专项分析！");
						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						alert("分析无结果");
				}else  if (data.status == 0
//								 && data.results != null
								 ) {
//alert("self.jsonresult="+self.jsonresult);
$('body').unmask();

//alert(self.dimension);
//alert(chartType);

							if (self.dimension === 'x'&&(chartType==='pie'||chartType==='doughnut'||chartType==='rose'||chartType==='cloud')) {
								var pieDataList = [];
								var analysisName = data.analysisName;
								var legend = [];
								var map=data.results;
//								var map =data.arr_data_single;
								
								for (var key in map) {
									var val = map[key];
//									alert(key + "---" + val);									
									pieDataList.push({
										'value' : map[key],
										'name' : key
									});
									legend.push(key);
								}
								
								self.pieDataList0 = pieDataList;
								$("#tab_xy").hide();
//								$("#tab_xx").hide();
								$("#tab_x").show();
								
								//$("#charttype_1").show();
								//$("#charttype_2").hide();
//								$("#span_theme").show();
//alert(analysisName);
//alert(legend);
//alert(pieDataList);
								var rose = '';
								var radius = [];
								if(chartType==='rose'){
									rose='area';
									radius.push('5%');
									radius.push('60%');
//									radius : [ '40%', '70%' ],
//									radius : [ '10%', '50%' ],
									self._generatePieChart(analysisName,legend,pieDataList,rose,radius,theme);
								}else if(chartType==='pie'){
//									radius.push('40%');
//									radius.push('70%');
									self._generatePieChart(analysisName,legend,pieDataList,rose,radius,theme);
								}else if(chartType==='doughnut'){
									radius.push('40%');
									radius.push('70%');
									self._generateDoughnutChart(analysisName,legend,pieDataList,rose,radius,theme);
								}else if(chartType==='cloud'){
									
//removejsfile("<%=basePath%>/analyse/echarts.min.js");
//loadjsfile("<%=basePath%>/analyse/echarts_3.2.2_echarts.simple.js");
									
									self._generateCloudChart(analysisName,legend,pieDataList,rose,radius,theme);
									
//removejsfile("<%=basePath%>/analyse/echarts_3.2.2_echarts.simple.js");
//loadjsfile("<%=basePath%>/analyse/echarts.min.js");
									
								}
								
//								alert(self.digital_label);
							}
//							if (chartType == 'line') {
//							if (chartType == 'xchart'&&(_type=='line'||_type=='bar')) {
//_generateXYChart_horizontal
							if (self.dimension === 'x'&&
									(chartType==='line'||chartType==='bar'||chartType==='bar_horizontal')) {
								var valueList = [];
								var dataList = [];
								var pieDataList = [];
								var legend = [];
								var analysisName = data.analysisName;

								var map =data.results;
								
								for (var key in map) {
									var val = map[key];
//									alert(key + "---" + val);
									
									pieDataList.push({											
										'name' : key,
										'value' : map[key]
									});
									
									legend.push(key);
									valueList.push(key);									
									dataList.push(map[key]);
								}
								
//								self.legend = data.legend;
								self.pieDataList0 = pieDataList;
								$("#tab_xy").hide();
//								$("#tab_xx").hide();
								$("#tab_x").show();
								
								//$("#charttype_1").show();
								//$("#charttype_2").hide();
//								$("#span_theme").show();								
								
								if (chartType==='bar_horizontal') {									
//									array1.reverse();									
									self._generateXChart_horizontal(analysisName, 'bar',legend.reverse(),valueList.reverse(),dataList.reverse(),theme);
//									self._generateXChart_horizontal(analysisName, 'bar',legend,valueList,dataList,theme);
								}else{
									self._generateXChart(analysisName, chartType,legend,valueList,dataList,theme);
								}
							}
							
							if (self.dimension === 'x'&&chartType==='polar') {
								var _data = [];
								var legend = [];
								var pieDataList = [];
								
								var map =data.results;
								
								for (var key in map) {
//									alert(key+"--"+val);	
								
									var val = map[key];
									legend.push(key);
									_data.push(val);
									
									pieDataList.push({											
										'name' : key,
										'value' : map[key]
									});
								}								
								
//								self.legend = data.legend;
								self.pieDataList0 = pieDataList;
								
								$("#tab_xy").hide();
//								$("#tab_xx").hide();
								$("#tab_x").show();
								
								//$("#charttype_1").show();
								//$("#charttype_2").hide();
//								$("#span_theme").show();								
								
								self._generatePolarChart(analysisName, legend,_data,theme);
							}							

//alert("self.dimension...."+self.dimension);
//alert("chartType...."+chartType);
//alert("cnfr...."+self.cnfr);
							
							if (self.dimension === 'x'&&chartType==='map'&&self.cnfr==='2') {
//alert("map....");
								var pieDataList = [];
								var analysisName = data.analysisName;
								var legend = [];
								var map =data.results;
								var sum = 0;
								
//alert(data.results.length);
/*
series: [
        {
            name: 'World Population (2010)',
            type: 'map',
            mapType: 'world',
            roam: true,
            itemStyle:{
                emphasis:{label:{show:true}}
            },
            data:[
            	{name: 'Afghanistan', value: 28397.812},
*/
								var series = [];
								var dataObj = {};
								
								dataObj.name = '';
								dataObj.data = [];
								dataObj.type = 'map';
								dataObj.mapType = 'world';
								dataObj.roam = true;
								dataObj.itemStyle={};								
								
								var itemStyle={};
								var label = {};
								var emphasis = {};
								/*
								itemStyle: {
				                    emphasis: {
				                        barBorderRadius: 7
				                    },
				                    normal: {
				                        barBorderRadius: 7
					                 }
					            }
								*/

								var show=false;
								label.show=show;
								emphasis.label=label;
								itemStyle.emphasis=emphasis;
								dataObj.itemStyle=itemStyle;								
								
								for (var key in map) {
									var val = map[key];
//									alert(key + "---" + map[key]);
									/*
									if(key==='美国'){
										key='United States';
									}
									*/
									pieDataList.push({
										'name' : key,
										'value' : val
									});	
									
									var _data = {};
									_data.name = key;
									_data.value = val;
//									dataObj.data[key] = _data;

									if(self.digital_label==true&&_data.value>0){
										var _itemStyle = {};
		 								var _normal = {};
										var _label = {};
							            
							            _label.show=true;
							            _normal.label=_label;
							            _itemStyle.normal=_normal;
							            _data.itemStyle=_itemStyle;
									}
									
									dataObj.data.push(_data);
									
									sum=sum+val;
//									legend.push(key);
								}
								
//								alert(dataObj.data.length);								
//								dataObj.data[0]=pieDataList;
								
								series[0]=dataObj;
								
								var average = sum/dataObj.data.length;
								
								self.pieDataList0 = pieDataList;
								$("#tab_xy").hide();
//								$("#tab_xx").hide();
								$("#tab_x").show();
								
								//$("#charttype_1").show();
								/*
								$("#charttype_1 #btn_x_map").show();
								$("#charttype_1 #btn_x_map").hide();
								*/
								//$("#charttype_2").hide();
//								$("#span_theme").show();
								
								self._generateWorldChart(analysisName, legend,series,theme,average);
							}
        


						if (self.dimension === 'xy'&&
								(chartType==='barline'||chartType==='line'||chartType==='bar'||chartType==='bar_horizontal'||chartType==='bubble'||chartType==='stack')) {
							
//							alert(self.xAxisName);
//							alert(self.yAxisName);
							
							var dataList = [];
							var map =data.arrSeries;

							var no = 0;
							
							var max=0;
							
							for (var key in map) {
//								alert(no);
								var dataObj = {};

								dataObj.name = data.legend[key];
								dataObj.data = []; 
								
								if(chartType==='bar'||chartType==='bar_horizontal'){
									dataObj.stack = "总量";
								}
								
								if(this.digital_label==true){
	 								var _itemStyle = {};
//	 								var _normal = {};
									var _label = {};
									
//									var barBorderRadius=7;
									var _emphasis={};
									_emphasis.barBorderRadius=7;
									var _normal={};
									_normal.barBorderRadius=7;
						            
						            _label.show=true;
						            _normal.label=_label;
						            _itemStyle.normal=_normal;
						            
						            _itemStyle.emphasis = _emphasis;
						            
						            dataObj.itemStyle=_itemStyle;
								}
								
								/*
								var barBorderRadius=7;
								var emphasis={};
								emphasis.barBorderRadius=barBorderRadius;
								var normal={};
								normal.barBorderRadius=barBorderRadius;
								var itemStyle={};
								itemStyle.emphasis = emphasis;
								itemStyle.normal = normal;
								*/

//								areaStyle: {normal: {}},
								if(chartType==='stack'){
									dataObj.stack = "总量";								
									dataObj.type = 'line';
									
									var _normal = {};
									var _areaStyle = {};
									_areaStyle.normal=_normal;
									dataObj.areaStyle=_areaStyle;									
								}
								
								if(chartType==='bar_horizontal'){
									dataObj.type = 'bar';
								}else if(chartType==='bubble'){
									dataObj.type = 'scatter';
								}else if(chartType==='stack'){
									dataObj.type = 'line';
								}else{
									dataObj.type = chartType;
								}
								
								if(chartType==='barline'&&self.xAxisName==='申请年'&&self.yAxisName==='公开年'){
									if(no===0){
										dataObj.type = 'bar';
									}
									if(no===1){
										dataObj.type = 'line';
									}
								}
//								alert(self.yAxisName);
								/*
								var label = {};
								var normal = {};
								normal.show=true;
								normal.position="inside";
								label.normal = normal;
								
								dataObj.label = label;
								*/
								
								var val = map[key];
//								dataObj.data = '[320, 302, 301, 334, 390, 330, 320]';
								
//								alert(data.legend);								
//								var arrlegend = (data.legend).split(",");
//								alert("arrlegend[0]="+arrlegend[0]);
								
//								alert((data.xAxisData)[0]+","+(data.xAxisData)[1]+","+(data.xAxisData)[2]);
//								alert(val);
								
								for (var _key in val) {

									if(val[_key]>max){
										max=val[_key];
									}
									
//									alert(_key + "-" +  val[_key]);
									if(chartType==='bubble'){
										var scatter_data = [];
//										scatter_data[0]="'"+(data.xAxisData)[_key]+"'";
										scatter_data[0]=(data.xAxisData)[_key];
										scatter_data[1]=val[_key];
										
										dataObj.data[_key] = scatter_data;
//alert(dataObj.data[_key]);
									}else{
										dataObj.data[_key] = val[_key];
									}
									
								}
								
								/*
								var itemStyle={};
								var normal={};
								normal.opacity=0.8;
								normal.shadowBlur=10;
								normal.shadowOffsetX=0;
								normal.shadowOffsetY=0;
								normal.shadowColor='rgba(0, 0, 0, 0.5)';
								itemStyle.normal=normal;
								
								dataObj.itemStyle = itemStyle;
								*/
//alert("dataObj.data="+dataObj.data);								
								
								dataList[key] = dataObj;
								no++;
							}
//							alert(dataList);
								
								self.arrSeries = data.arrSeries;
								self.legend = data.legend;
								self.xAxisData = data.xAxisData;

								$("#tab_xy").show();
								$("#tab_x").hide();
								
								//$("#charttype_1").hide();
								//$("#charttype_2").show();
//								$("#span_theme").show();
//								$("#tab_xx").hide();

								/*
								if(reverse=='1'){
									self._generateXYChart(data.analysisName,data.xAxis,data.legend,dataList);
								}else{									
									self._generateXYChart(data.analysisName,data.legend,data.xAxis,dataList);
								}*/
								
								if(chartType==='bar_horizontal'){
									self._generateXYChart_horizontal(data.analysisName,data.xAxisData,data.legend,dataList,theme);
								}else if(chartType==='bubble'){
									self._generateBubbleChart(data.analysisName,data.xAxisData,data.legend,dataList,max,theme);
								}else{
									self._generateXYChart(data.analysisName,data.xAxisData,data.legend,dataList,theme);
								}								
							}
						
						if (self.dimension === 'xy'&&(chartType==='polar')) {
							var dataList = [];
							var map =data.arrSeries;
							/*
							var jsonstr = JSON.stringify(data.arrSeries);
							alert(jsonstr);
							
							var jsonstr1 = JSON.stringify(data.legend);
							alert(jsonstr1);
							
							var jsonstr2 = JSON.stringify(data.xAxisData);
							alert(jsonstr2);
							*/
//							alert(data.xAxisData);
//							for (var key in data.xAxisData) {
//								alert(key + "-" +  data.xAxisData[key]);
//							}
														
							for (var key in map) {
								var dataObj = {};
								dataObj.type = 'bar';
								
								dataObj.name = data.legend[key];
								dataObj.data = [];
								dataObj.coordinateSystem = 'polar';
								dataObj.center = [],
								dataObj.center[0] = '50%';
								dataObj.center[1] = '55%';
								
								dataObj.stack = 'a';
								
								if(this.digital_label==true){
									var _itemStyle = {};
	 								var _normal = {};
									var _label = {};
						            
						            _label.show=true;
						            _normal.label=_label;
						            _itemStyle.normal=_normal;
						            dataObj.itemStyle=_itemStyle;
								}
								
								var val = map[key];

								for (var _key in val) {
									dataObj.data[_key] = val[_key];
								}
								
								dataList[key] = dataObj;
							}
								
							self.arrSeries = data.arrSeries;
							self.legend = data.legend;
							self.xAxisData = data.xAxisData;

							$("#tab_xy").show();
							$("#tab_x").hide();
								
							//$("#charttype_1").hide();
							//$("#charttype_2").show();
//							$("#span_theme").show();
//							$("#tab_xx").hide();

							self._generateXYPolarChart(data.analysisName,data.xAxisData,data.legend,dataList,theme);
						}
						
//						alert("self.dimension="+self.dimension);
//						alert("chartType="+chartType);
//						alert("self.cnfr="+self.cnfr);

						if (self.dimension === 'xy'&&chartType==='map'&&self.cnfr==='0') {
						
							var dataList = [];
							var map =data.arrSeries;

//							alert(data.legend.length);
//							alert(data.xAxis.length);
							var sum = 0;
							
//							var jsonstr = JSON.stringify(data.legend);
//							alert(jsonstr);
														
							for (var key in map) {
								var dataObj = {};
								
//alert("data.legend["+key+"]="+data.legend[key]);
								
								dataObj.name = data.legend[key];
								dataObj.data = [];
								dataObj.type = 'map';
								dataObj.mapType = 'china';
								dataObj.roam = false;
								
								var label = {};
								var normal = {};
								normal.show=false;
								var emphasis = {};
								emphasis.show=false;
								label.normal = normal;
								label.emphasis = emphasis;
								dataObj.label = label;
								
								var val = map[key];
//dataObj.data = '[320, 302, 301, 334, 390, 330, 320]';
//alert("map["+key+"]="+val);
//var jsonstr = JSON.stringify(data.xAxisData);
//alert(jsonstr);
								
								for (var _key in val) {
									
//alert("data.xAxis["+_key+"]="+data.xAxisData[_key]);

									var _data = {};
									_data.name = data.xAxisData[_key];
									_data.value = val[_key];
									
//									alert(_data.value+"----"+(_data.value==='0')+"----"+(_data.value===0));
									
									if(_data.name.indexOf("未指定")>-1)
									{
//										alert(_data.name);
//										continue;
									}
									
									if(_data.name=='中国香港'){
										_data.name='香港';
									}
									if(_data.name=='中国台湾'){
										_data.name='台湾';
									}
									if(_data.name=='中国澳门'){
										_data.name='澳门';
									}
									
									_data.name=_data.name.replace("新疆维吾尔自治区","新疆");
									_data.name=_data.name.replace("广西壮族自治区","广西");
									_data.name=_data.name.replace("宁夏回族自治区","宁夏");									
									_data.name=_data.name.replace("西藏自治区","西藏");
									_data.name=_data.name.replace("自治区","");
									_data.name=_data.name.replace("省","");
									_data.name=_data.name.replace("市","");
									//新疆维吾尔自治区
									
									sum=sum+_data.value;
//alert(_data.name + "-" +  _data.value);

									if(this.digital_label==true&&_data.value>0){
		 								var _itemStyle = {};
		 								var _normal = {};
										var _label = {};
							            
							            _label.show=true;
							            _normal.label=_label;
							            _itemStyle.normal=_normal;
							            _data.itemStyle=_itemStyle;
									}
									
									dataObj.data[_key] = _data;									
//									alert(_key + "-" +  val[_key]);
								}
//alert(dataObj.data);
								
								dataList[key] = dataObj;
							}

							
							var average = sum/data.xAxisData.length;
//								sss.innerText=series;
								
//								self.pieDataList0 = pieDataList;
								self.arrSeries = data.arrSeries;
								self.legend = data.legend;
								self.xAxisData = data.xAxisData;

								$("#tab_xy").show();
								$("#tab_x").hide();
								
//								//$("#charttype_1").hide();
								//$("#charttype_2").show();
//								$("#span_theme").show();
								
								self._generateChinaChart(data.analysisName,data.xAxisData,data.legend,dataList,theme,average);
							}
						
						if (self.dimension === 'xy'&&chartType==='shandong'&&self.cnfr==='0') {
							var dataList = [];
							var map =data.arrSeries;

//							alert(data.legend.length);
//							alert(data.xAxis.length);
							var sum = 0;
							
//							var jsonstr = JSON.stringify(data.legend);
//							alert(jsonstr);
														
							for (var key in map) {
								var dataObj = {};
								
//alert("data.legend["+key+"]="+data.legend[key]);
								
								dataObj.name = data.legend[key];
								dataObj.data = [];
								dataObj.type = 'map';
								dataObj.mapType = '山东';
								dataObj.roam = false;
								
								var label = {};
								var normal = {};
								normal.show=false;
								var emphasis = {};
								emphasis.show=false;
								label.normal = normal;
								label.emphasis = emphasis;
								dataObj.label = label;
								
								var val = map[key];
//								dataObj.data = '[320, 302, 301, 334, 390, 330, 320]';
//alert("map["+key+"]="+val);
//var jsonstr = JSON.stringify(data.xAxisData);
//alert(jsonstr);
								
								for (var _key in val) {
									
//alert("data.xAxis["+_key+"]="+data.xAxisData[_key]);

									var _data = {};
									_data.name = data.xAxisData[_key];
									_data.value = val[_key];
									
//									alert(_data.value+"----"+(_data.value==='0')+"----"+(_data.value===0));

									if(_data.name=='中国香港'){
										_data.name='香港';
									}
									if(_data.name=='中国台湾'){
										_data.name='台湾';
									}
									if(_data.name=='中国澳门'){
										_data.name='澳门';
									}
									
									sum=sum+_data.value;
//alert(_data.name + "-" +  _data.value);

									if(this.digital_label==true&&_data.value>0){
		 								var _itemStyle = {};
		 								var _normal = {};
										var _label = {};
							            
							            _label.show=true;
							            _normal.label=_label;
							            _itemStyle.normal=_normal;
							            _data.itemStyle=_itemStyle;
									}
									
									dataObj.data[_key] = _data;									
//									alert(_key + "-" +  val[_key]);
								}
//alert(dataObj.data);
								
								dataList[key] = dataObj;
							}

							var average = sum/data.xAxisData.length;
//								sss.innerText=series;
								
//								self.pieDataList0 = pieDataList;
								self.arrSeries = data.arrSeries;
								self.legend = data.legend;
								self.xAxisData = data.xAxisData;

								$("#tab_xy").show();
								$("#tab_x").hide();
								
//								//$("#charttype_1").hide();
								//$("#charttype_2").show();
//								$("#span_theme").show();
								
								self._generateShandongChart(data.analysisName,data.xAxisData,data.legend,dataList,theme,average);
							}

						if (self.dimension === 'xy'&&chartType==='guangdong'&&self.cnfr==='0') {
							var dataList = [];
							var map =data.arrSeries;

//							alert(data.legend.length);
//							alert(data.xAxis.length);
							var sum = 0;
							
//							var jsonstr = JSON.stringify(data.legend);
//							alert(jsonstr);
														
							for (var key in map) {
								var dataObj = {};
								
//alert("data.legend["+key+"]="+data.legend[key]);
								
								dataObj.name = data.legend[key];
								dataObj.data = [];
								dataObj.type = 'map';
								dataObj.mapType = '广东';
								dataObj.roam = false;
								
								var label = {};
								var normal = {};
								normal.show=false;
								var emphasis = {};
								emphasis.show=false;
								label.normal = normal;
								label.emphasis = emphasis;
								dataObj.label = label;
								
								var val = map[key];
//								dataObj.data = '[320, 302, 301, 334, 390, 330, 320]';
//alert("map["+key+"]="+val);
//var jsonstr = JSON.stringify(data.xAxisData);
//alert(jsonstr);
								
								for (var _key in val) {
									
//alert("data.xAxis["+_key+"]="+data.xAxisData[_key]);

									var _data = {};
									_data.name = data.xAxisData[_key];
									_data.value = val[_key];
									
//									alert(_data.value+"----"+(_data.value==='0')+"----"+(_data.value===0));

									if(_data.name=='中国香港'){
										_data.name='香港';
									}
									if(_data.name=='中国台湾'){
										_data.name='台湾';
									}
									if(_data.name=='中国澳门'){
										_data.name='澳门';
									}
									
									sum=sum+_data.value;
//alert(_data.name + "-" +  _data.value);

									if(this.digital_label==true&&_data.value>0){
		 								var _itemStyle = {};
		 								var _normal = {};
										var _label = {};
							            
							            _label.show=true;
							            _normal.label=_label;
							            _itemStyle.normal=_normal;
							            _data.itemStyle=_itemStyle;
									}
									
									dataObj.data[_key] = _data;									
//									alert(_key + "-" +  val[_key]);
								}
//alert(dataObj.data);
								
								dataList[key] = dataObj;
							}

							var average = sum/data.xAxisData.length;
//								sss.innerText=series;
								
//								self.pieDataList0 = pieDataList;
								self.arrSeries = data.arrSeries;
								self.legend = data.legend;
								self.xAxisData = data.xAxisData;

								$("#tab_xy").show();
								$("#tab_x").hide();
								
//								//$("#charttype_1").hide();
								//$("#charttype_2").show();
//								$("#span_theme").show();
								
								self._generateShandongChart(data.analysisName,data.xAxisData,data.legend,dataList,theme,average);
							}
//						alert("self.dimension="+self.dimension);
//						alert("chartType="+chartType);
						
							if (self.dimension === 'xx'&&(chartType==='line'||chartType==='bar')) {
//								alert("xx");
							
								var dataList = [];
								var map =data.arrSeries;
								for (var key in map) {
									var dataObj = {};
									dataObj.name = data.legend[key];
									
									alert(dataObj.name);
									
									dataObj.data = []; 
//									dataObj.stack = "总量";
//									dataObj.stack = data.legend[key];
									dataObj.type = chartType;
									
									if(this.digital_label==true){
		 								var _label = {};
							            var _label_normal = {};
							            _label_normal.show=true;
							            _label.normal=_label_normal;					            
							            dataObj.label=_label;	
									}
									/*
									var label = {};
									var normal = {};
									normal.show=true;
									normal.position="inside";
									label.normal = normal;
									
									dataObj.label = label;
									*/
									var val = map[key];
//									dataObj.data = '[320, 302, 301, 334, 390, 330, 320]';
									
									for (var _key in val) {
										dataObj.data[_key] = val[_key];									
//										alert(_key + "-" +  val[_key]);
									}
									
									dataList[key] = dataObj;
								}
//									alert(dataList);
//									sss.innerText=series;
									
//									self.pieDataList0 = pieDataList;
									self.arrSeries = data.arrSeries;
									self.legend = data.legend;
									self.xAxis = data.xAxis;
									
//									$("#tab_xx").show();
									$("#tab_xy").show();
									$("#tab_x").hide();
									
									//$("#charttype_1").hide();
									//$("#charttype_2").show();
//									$("#span_theme").show();
									
									self._generateXYChart(data.analysisName,data.xAxis,data.legend,dataList,theme);
								}
							
//							$('body').unmask();
						} else {
							$.bootstrapGrowl('无分析结果', {
								ele : 'body',
								type : 'danger',
								offset : {
									from : 'top',
									amount : 100
								}
							});
						}						
//						self.unblockPage();
					},

//构成专利分析
			analysePatent : function(menuId,chartType,xAxis,xAxisSize,yAxis,yAxisSize,cnfr,allChartType) {
//			alert(chartType);
//			alert(xAxis);
//			alert(yAxis);
//			alert(reverse);
//			alert(cnfr);
//			alert("menuId="+menuId);
			this.menu_selected(menuId);
			
			$("body").mask("正在初始化，请稍候...");
			
			$("#analyseindex").hide();
			$("#analysecontent").show();

				var self = this;				
				
				if(typeof(cnfr)==="undefined"){
					cnfr = "";
				}
				
				if(typeof(menuId)==="undefined"||menuId===""){
					menuId = self.menuId;
				}else{
					self.menuId = menuId;
				}
				
				$("div[name^='intr']").each(function(i){
					$("#"+this.id).hide();
				});
				$("#intr"+menuId).show();
/*
				if(typeof(allChartType)==="undefined"||allChartType===""){
					allChartType = self.allChartType;
				}else{
					self.allChartType = allChartType;
				}
*/
				if(typeof(chartType)==="undefined"||chartType===""){
					chartType = self.chartType;
				}else{
					self.chartType = chartType;
				}
				
				if(typeof(cnfr)==="undefined"||cnfr===""){
					cnfr = self.cnfr;
				}else{
					self.cnfr = cnfr;
				}
				
//				self.menuId = menuId;
				self.xAxisName = xAxis;
				if(xAxis==='国省'){
					self.xAxisName = "省市";
				}
				
				self.yAxisName = yAxis;
				if(yAxis==='国省'){
					self.yAxisName = "省市";
				}
//				self.allChartType = allChartType;
				
				var dimension = "xy";
				if (yAxis === '') {
					dimension = "x";
				}
				self.dimension = dimension;
//				self.chartType = chartType;
//				self.cnfr = cnfr;				
				
//				if(typeof(allChartType)==="undefined"){
/*
				if(typeof(allChartType)==="undefined"||allChartType===""){
					if(dimension==='x'){
						allChartType = 'line,bar,pie';
					}else{
						allChartType = 'line,bar,bar_horizontal,bubble';
					}
				}
				self.allChartType = allChartType;
*/
				if(typeof(allChartType)==="undefined"||allChartType===""){
					allChartType = self.allChartType;
					if(typeof(allChartType)==="undefined"||allChartType===""){
						if(dimension==='x'){
							allChartType = 'line,bar,pie,polar,rose';
						}else{
							allChartType = 'line,bar,bar_horizontal,stack,bubble,polar';
						}
					}					
				}else{
					self.allChartType = allChartType;
				}
				//////////////////////////////////////////////////////////////////////////////////////////
				self.showChartType(dimension,chartType,allChartType);
				
				if(xAxis.indexOf('IPC')>-1||yAxis.indexOf('IPC')>-1)
				{
//					alert('ipc');
					$('#gmjjtype').html('');
					self.showIPCType();
				}else if(xAxis.indexOf('国民经济')>-1||yAxis.indexOf('国民经济')>-1)
				{
//					alert('ipc');
					$('#ipctype').html('');
					self.showGMJJType();
				}else{
					$('#ipctype').html('');
					$('#gmjjtype').html('');
				}
/*
				$('#charttype').html('');
				var text = '';
				var arrChart = allChartType.split(',');
				for (key in arrChart) {
					var chart = arrChart[key];
					var bt_theme = 'default';
					if(chart===chartType){
						bt_theme = 'warning';
					}
//					alert(dimension);
					text+="<button id=\"btn_"+dimension+"_"+chart+"\" type=\"button\" class=\"btn btn-"+bt_theme+"\" onClick=\"vm.change_charttype('"+dimension+"','"+chart+"')\">"+chart+"</button>";
				}
//				alert(text);
				$('#charttype').html(text);
*/
		//////////////////////////////////////////////////////////////////////////////////////////
		//alert("menuId="+menuId);

		var ori_exp = self.exp;
		if(menuId==='2001'||menuId==='2002'||menuId==='2003'||menuId==='2004'
				||menuId==='2005'||menuId==='2006'||menuId==='2007'||menuId==='2008'||menuId==='2009'||menuId==='2010'||menuId==='2011')
		{
			ori_exp = "("+ori_exp+") and 省级行政=山东省";
		}else if(menuId==='2101'||menuId==='2102'||menuId==='2103'||menuId==='2104'
				||menuId==='2105'||menuId==='2106'||menuId==='2107'||menuId==='2108'||menuId==='2109'||menuId==='2110'||menuId==='2111')
		{
			ori_exp = "("+ori_exp+") and 省级行政=广东省";
		}
		
		
				var _url = "";
				_url = "patentAnalysisXY.do";
				
				$.ajax({
					type : "GET",
//					url : getBasePath() + "patentAnalysisPie.do",
//					url : basePath + "/patentAnalysisPie.do" + "?" + _getRandomString(20),
//					url :   "http://127.0.0.1:8080/analyse/patentAnalysisPie.do" + "?" + _getRandomString(20),
					url :   '<%=basePath %>/' + _url + '?'+ _getRandomString(20),

							data : {
								'dbs' : self.dbs,
								'exp' : ori_exp,
								'xAxis' : xAxis,
								'yAxis' : yAxis,
								'xAxisSize' : xAxisSize,
								'yAxisSize' : yAxisSize,
								
								'cnfr' : cnfr
							},
							success : function(jsonresult) {
								//alert(jsonresult);
								/*
								 data = eval("("+data+")");
								 alert(data);
								 alert(data.status);
								 alert(data.analysisName);
								 */
								//alert("xAxis="+xAxis);
								//alert("yAxis="+yAxis);

								/*	
								if(xAxis=='申请年'&&yAxis=='公开年'||yAxis=='申请年'&&xAxis=='公开年'){
									dimension = "xx";
								}
								*/
								self.jsonresult = jsonresult;

								//self.prepareData(dimension,chartType,reverse);

								/*
								 if(chartType!="map"){
								 	self.change_charttype(dimension,chartType);	
								 }else{
								 	self.prepareData();
								 }
								 */
								 self.change_ipc_btn(xAxis,yAxis);
								 self.change_gmjj_btn(xAxis,yAxis);
								 self.change_charttype(dimension, chartType);
							}
						});
//						$('body').unmask();
					},
					showIPCType : function() {
//alert('showIPCType');					
						$('#ipctype').html('');
						var text = '';
						var chartname = '';
						var allIPCName = "IPC部,IPC大类,IPC小类,IPC大组,IPC分类号";
						var allIPC = "IPC_bu,IPC_dl,IPC_xl,IPC_dz,IPC";
						var arrChartName = allIPCName.split(',');
						var arrChart = allIPC.split(',');
						
						for (key in arrChart) {
							var chartname = arrChartName[key];						
							var chart = arrChart[key];
							
							var bt_theme = 'default';
							/*
							if(chart===chartType){
								bt_theme = 'warning';
							}
							*/
//							alert(dimension);
														
							text+="<button id=\"btn_"+chart+"\" type=\"button\" class=\"btn btn-"+bt_theme+" btn-sm\" onClick=\"vm.change_ipctype('"+chartname+"')\">"+chartname+"</button>";
						}
//						alert(text);
						$('#ipctype').html(text);
					},
					showGMJJType : function() {
						//alert('showIPCType');					
						$('#gmjjtype').html('');
						var text = '';
						var chartname = '';
						
						var allIPCName = "国民经济部,国民经济大类,国民经济中类,国民经济小类";
						var allIPC = "GMJJ_bu,GMJJ_dl,GMJJ_zl,GMJJ_xl";
						var arrChartName = allIPCName.split(',');
						var arrChart = allIPC.split(',');
										
						for (key in arrChart) {
							var chartname = arrChartName[key];
							var chart = arrChart[key];
													
							var bt_theme = 'default';
							/*
							if(chart===chartType){
								bt_theme = 'warning';
							}
							*/
//							alert(dimension);
							text+="<button id=\"btn_"+chart+"\" type=\"button\" class=\"btn btn-"+bt_theme+" btn-sm\" onClick=\"vm.change_gmjjtype('"+chartname+"')\">"+chartname+"</button>";
						}
//						alert(text);
						$('#gmjjtype').html(text);
					},
					showChartType : function(dimension,chartType,allChartType) {
						$('#charttype').html('');
						var text = '';
						var chartname = '';
						var arrChart = allChartType.split(',');
						for (key in arrChart) {
							var chart = arrChart[key];
							var bt_theme = 'default';
							/*
							if(chart===chartType){
								bt_theme = 'warning';
							}
							*/
//							alert(dimension);
							
							if(chart==='line'){
								chartname='折线图';
							}
							if(chart==='pie'){
								chartname='饼形图';
							}							
							if(chart==='doughnut'){
								chartname='环形图';
							}
							if(chart==='bar'){
								chartname='柱状图';
							}
							if(chart==='bar_horizontal'){
								chartname='条形图';
							}
							if(chart==='barline'){
								chartname='柱线图';
							}
							if(chart==='bubble'){
								chartname='气泡图';
							}
							if(chart==='stack'){
								chartname='面积图';
							}
							if(chart==='map'||chart==='shandong'||chart==='guangdong'){
								chartname='地图';
							}							
							if(chart==='polar'){
								chartname='极坐标';
							}
							if(chart==='rose'){
								chartname='玫瑰图';
							}
							if(chart==='cloud'){
								chartname='词云图';
							}
							
							text+="<button id=\"btn_"+dimension+"_"+chart+"\" type=\"button\" class=\"btn btn-"+bt_theme+" btn-sm\" onClick=\"vm.change_charttype('"+dimension+"','"+chart+"')\">"+chartname+"</button>";
						}
//						alert(text);
						$('#charttype').html(text);						
					},
					//生成饼图
					_generatePieChart : function(analysisName, legend,pieDataList,rose, radius, theme) {
						//alert("_generatePieChart");
						//alert(analysisName);
						//alert(legend);
						//alert(pieDataList);
						//alert(theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						//var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'));
						pieChart.setOption({
//							backgroundColor: '#2c343c',
							title : {
//								text : analysisName
							},
							legend : {
								orient : 'vertical',
								x : 'left',
								top : '10%',
								selected : {
									'空' : false,
									'其它' : false
								},
								data : legend
							},

							grid : {
								left : '40%',
								right : '4%',
								top: '10%',
								bottom : '3%',
								containLabel : true
							},

							tooltip : {
								trigger : 'item',
								formatter : "{a} <br/>{b} : {c} ({d}%)"
							},
							series : [ {
								name : analysisName,
								type : 'pie',
//								radius : radius,
//								radius : [ '40%', '70%' ],
//								radius : [ '10%', '50%' ],
								center : [ '65%', '60%' ],
								roseType : rose,
								
								
								data : pieDataList,
								itemStyle : {
									emphasis : {
										shadowBlur : 10,
										shadowOffsetX : 0,
										shadowColor : 'rgba(0, 0, 0, 0.5)'
									},
									normal : {
										label : {
											show : this.digital_label,
											position : 'outer',
											formatter : "{b} {c} ({d}%)",//在饼状图上显示百分比
											textStyle : {
												color : 'rgba(30,144,255,0.8)',
												align : 'center',
												baseline : 'middle',
												fontFamily : '微软雅黑',
												fontSize : 14,
												fontWeight : 'thin'
											}
										//自定义饼图上字体样式
										},
										labelLine : {
											show : true,
										}
									}
								}
							} ]
						});
					},

					//生成词云
					_generateCloudChart : function(analysisName, legend,pieDataList,rose, radius, theme) {
//alert("_generateCloudChart");
//alert(analysisName);
//alert(legend);
//alert(pieDataList);
//alert(theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var cloudChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						//var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'));
						cloudChart.setOption({
//							backgroundColor: '#2c343c',
							title : {
//								text : analysisName
							},
							tooltip: {},
							/*
							legend : {
								orient : 'vertical',
								x : 'left',
								top : '10%',
								selected : {
									'空' : false,
									'其它' : false
								},
								data : legend
							},
							
							grid : {
								left : '40%',
								right : '4%',
								top: '10%',
								bottom : '3%',
								containLabel : true
							},

							tooltip : {
								trigger : 'item',
								formatter : "{a} <br/>{b} : {c} ({d}%)"
							},
							*/
							series : [ {
//								name : analysisName,
								type : 'wordCloud',
//								center : [ '65%', '60%' ],
//								roseType : rose,																								
			                    gridSize: 2,
			                    sizeRange: [12, 50],
			                    rotationRange: [-90, 90],
			                    shape: 'pentagon',
			                    width: 600,
			                    height: 400,
			                    drawOutOfBound: true,
			                    textStyle: {
			                        normal: {
			                            color: function () {
			                                return 'rgb(' + [
			                                    Math.round(Math.random() * 160),
			                                    Math.round(Math.random() * 160),
			                                    Math.round(Math.random() * 160)
			                                ].join(',') + ')';
			                            }
			                        },
			                        emphasis: {
			                            shadowBlur: 10,
			                            shadowColor: '#333'
			                        }
			                    },
			                    data : pieDataList
								
								/*
								itemStyle : {
									emphasis : {
										shadowBlur : 10,
										shadowOffsetX : 0,
										shadowColor : 'rgba(0, 0, 0, 0.5)'
									},
									normal : {
										label : {
											show : this.digital_label,
											position : 'outer',
											formatter : "{b} {c} ({d}%)",//在饼状图上显示百分比
											textStyle : {
												color : 'rgba(30,144,255,0.8)',
												align : 'center',
												baseline : 'middle',
												fontFamily : '微软雅黑',
												fontSize : 14,
												fontWeight : 'thin'
											}
										//自定义饼图上字体样式
										},
										labelLine : {
											show : true,
										}
									}
								}
								*/
							
							
							} ]
						});
					},
					
					//生成环形图
					_generateDoughnutChart : function(analysisName, legend,pieDataList,rose, radius, theme) {
						//alert("_generatePieChart");
						//alert(analysisName);
						//alert(legend);
						//alert(pieDataList);
						//alert(theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						//var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'));
						pieChart.setOption({
//							backgroundColor: '#2c343c',
							title : {
//								text : analysisName
							},
							legend : {
								orient : 'vertical',
								x : 'left',
								top : '10%',
								selected : {
									'空' : false,
									'其它' : false
								},
								data : legend
							},

							grid : {
								left : '40%',
								right : '4%',
								top: '10%',
								bottom : '3%',
								containLabel : true
							},

							tooltip : {
								trigger : 'item',
								formatter : "{a} <br/>{b} : {c} ({d}%)"
							},
							series : [ {
								name : analysisName,
								type : 'pie',
								radius : radius,
//								radius : [ '40%', '70%' ],
//								radius : [ '10%', '50%' ],
								center : [ '65%', '60%' ],
								roseType : rose,								
								
								data : pieDataList,
								itemStyle : {
									emphasis : {
										shadowBlur : 10,
										shadowOffsetX : 0,
										shadowColor : 'rgba(0, 0, 0, 0.5)'
									},
									normal : {
										label : {
											show : this.digital_label,
											position : 'outer',
											formatter : "{b} {c} ({d}%)",//在饼状图上显示百分比
											textStyle : {
												color : 'rgba(30,144,255,0.8)',
												align : 'center',
												baseline : 'middle',
												fontFamily : '微软雅黑',
												fontSize : 14,
												fontWeight : 'thin'
											}
										//自定义饼图上字体样式
										},
										labelLine : {
											show : true,
										}
									}
								}
							} ]
						});
					},
					_generatePolarChart : function(analysisName, legend,data, theme) {
						//alert("_generatePieChart");
						//alert(analysisName);
						//alert(legend);
						//alert(data);
						//alert(theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var data = data;
						var cities = legend;
						var barHeight = 1;
						
						var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						//var pieChart = echarts.init(document.getElementById('patentAnalysisEcharts'));
						pieChart.setOption({
						title: {
					        text: analysisName
					    },
					    angleAxis: {
					        type: 'category',
					        data: legend
					    },
					    tooltip: {
					        show: true,
					        formatter: function (params) {
					            var id = params.dataIndex;
					            return legend[id] + '<br>专利数：' + data[id];
					        }
					    },
					    radiusAxis: {},
					    polar: {
					    	center : [ '50%', '55%' ]
					    },
					    series: [
					    {
					        type: 'bar',
					        data: data.map(function (d) {
					            return d;
					        }),
					        center : [ '50%', '55%' ],
					        coordinateSystem: 'polar',
					        name: '价格范围',
					        stack: '最大最小值'
					    }
					    /*
					    ,{
					        type: 'bar',
					        data: data.map(function (d) {
					            return barHeight * 2
					        }),
					        coordinateSystem: 'polar',
					        name: '均值',
					        stack: '均值',
					        barGap: '-100%',
					        z: 10
					    }
					    */
					    ]
						});
					},

					_generateXChart : function(analysisName, _type, legend, valueList, dataList, theme) {
//alert("_generateLineChart------");

//alert("analysisName------"+analysisName);
//alert("_type------"+_type);
//alert("legend------"+legend);
//alert("valueList------"+valueList);
//alert("dataList------"+dataList);
//alert("theme------"+theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);

						var lineChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						lineChart.setOption({							
							
						    color: ['#3398DB'],
						    tooltip : {
						        trigger: 'axis',
						        formatter : "{a} <br/>{b} : {c}",
						        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
						            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
						        }
						    },
							grid : {
								left : '5%',
								right : '4%',
								bottom : '20%',
								containLabel : true
							},
						    xAxis : [
						        {
                                    axisLabel: {
                                        interval:0,
                                        rotate:40
                                     },
						        
						            type : 'category',
						            data : valueList,
						            axisTick: {
						                alignWithLabel: true
						            }
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value'
						        }
						    ],
						    series : [
						        {
						            name:analysisName,
						            type:_type,
						            barWidth: '60%',
						            label: {
						                normal: {
						                    show: this.digital_label,
						                    position: 'outside'
						                }
						            },
						            data:dataList
						        }
						    ]							
							
						});
						
						//var img = lineChart.getDataURL();
						//$("#imgbenben").attr('src', img);
					},
					
					_generateXChart_horizontal : function(analysisName, _type, legend, valueList, dataList, theme) {
						//alert("_generateLineChart------");

						//alert("analysisName------"+analysisName);
						//alert("_type------"+_type);
						//alert("legend------"+legend);
						//alert("valueList------"+valueList);
						//alert("dataList------"+dataList);
						//alert("theme------"+theme);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);

						var lineChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						lineChart.setOption({							
							    color: ['#3398DB'],
							    tooltip : {
							        trigger: 'axis',
							        formatter : "{a} <br/>{b} : {c}",
							        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
							            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
							        }
							    },
								grid : {
									left : '5%',
									right : '4%',
									bottom : '20%',
									containLabel : true
								},
							    yAxis : [
							        {
	                                    axisLabel: {
	                                        interval:0,
	                                        rotate:0
	                                     },
											        	
							            type : 'category',
							            data : valueList,
							            axisTick: {
							                alignWithLabel: true
							            }
							        }
							    ],
							    xAxis : [
							        {
							            type : 'value'
							        }
							    ],
							    series : [
						        {
						            name:analysisName,
						            type:_type,
						            barWidth: '60%',
									
						            label: {
						                normal: {
						                    show: this.digital_label,
//						                    position: 'outside'
//						                    position: 'outer'
						                }
						            },
						            data:dataList
						        }
						    ]													

						});
					},

					_generateXYChart : function(analysisName, xAxisData, legend, series, theme) {
//alert("_generateXYChart");
//alert(analysisName);

//alert(xAxisData.length);
//alert(legend.length);

//alert(xAxisData);
//alert(legend);

//var jsonstr = JSON.stringify(series);
//alert(jsonstr);
/*
var jsonstr = JSON.stringify(series);
var _arr=jsonstr.split("},{");
alert(_arr.length);

for (var i = 0; i < _arr.length; i++) {
	alert(_arr[i]);
}
*/

//alert(parseInt(Math.random()*100+""));
						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var XYChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						XYChart.setOption({
							
						    tooltip : {
						        trigger: 'axis',
						        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
						            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
						        }
						    },
						    legend: {
								orient : 'horizontal',
								top : '2%',
								data : legend
						    },						    
							grid : {
								left : '5%',
								right : '4%',
								top : '18%',
								bottom : '30%',
								containLabel : true
							},
							calculable : true,
						    xAxis : [
						        {
                                    axisLabel: {
                                        interval:0,
                                        rotate:40
                                     },
						        
						            type : 'category',
						            data : xAxisData
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value'
						        }
						    ],
						    series : series
							
						});
						
					},
					
					_generateXYPolarChart : function(analysisName, xAxisData, legend, series, theme) {
						//alert("_generateXYChart");
//						alert(analysisName);

						//alert(xAxisData.length);
						//alert(legend);

						//alert(xAxisData);
						//alert(legend);

						var jsonstr = JSON.stringify(series);
						//alert(jsonstr);
						/*
						var jsonstr = JSON.stringify(series);
						var _arr=jsonstr.split("},{");
						//alert(_arr.length);
						for (var i = 0; i < _arr.length; i++) {
							alert(_arr[i]);
						}
						*/

						//alert(parseInt(Math.random()*100+""));
						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var XYChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						XYChart.setOption({
							
						    angleAxis: {
						    	axisLabel: {
                                    interval:0,
                                    rotate:40
                                 },
						   
						        type: 'category',
						        data: xAxisData,
						        z: 10
						    },
						    radiusAxis: {
						    },
						    tooltip : {
						        trigger: 'item',
						        formatter: "{a} <br/>{b} : {c}"
						    },
						    polar: {
						    	center : [ '50%', '55%' ],
						    	axisLabel: {
                                    interval:10,
                                    rotate:40
                                 }
						    },						    
						    series : series,
						    legend: {
						        show: true,
						        data: legend
						    }
						    
						    /*
						    angleAxis: {
						        type: 'category',
						        data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
						        z: 10
						    },
						    radiusAxis: {
						    },
						    polar: {
						    },
						    series: [{
						        type: 'bar',
						        data: [1, 2, 3, 4, 3, 5, 1],
						        coordinateSystem: 'polar',
						        name: 'A',
						        stack: 'a'
						    }, {
						        type: 'bar',
						        data: [2, 4, 6, 1, 3, 2, 1],
						        coordinateSystem: 'polar',
						        name: 'B',
						        stack: 'a'
						    }, {
						        type: 'bar',
						        data: [1, 2, 3, 4, 1, 2, 5],
						        coordinateSystem: 'polar',
						        name: 'C',
						        stack: 'a'
						    }],
						    legend: {
						        show: true,
						        data: ['A', 'B', 'C']
						    }
							*/
						});
												
					},					

					_generateBubbleChart : function(analysisName, xAxisData, legend, series, max, theme) {
						//alert("_generateBubbleChart");
						//alert(analysisName);

						//alert(xAxisData.length);
						//alert(legend.length);

//alert(xAxisData);
//alert(legend);

/*
alert(series);
for (var i = 0; i < series.length; i++) {
	alert(JSON.stringify(series[i]));
}
*/
						//var jsonstr = JSON.stringify(series);
						//alert(jsonstr);
						/*
						var jsonstr = JSON.stringify(series);
						var _arr=jsonstr.split("},{");
						alert(_arr.length);

						for (var i = 0; i < _arr.length; i++) {
							alert(_arr[i]);
						}
						*/

						//alert(parseInt(Math.random()*100+""));
												var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
												echarts.dispose(chart);
																		
												var XYChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
												XYChart.setOption({
													/*
												    grid: {
												        x: '10%',
												        x2: '20%',
												        y: '18%',
												        y2: '10%'
												    },
												    */
													grid : {
														left : '5%',
														right : '20%',
														bottom : '30%',
														containLabel : true
													},
												    
												    tooltip : {
												        trigger: 'axis',
												        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
												            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
												        }
												    },
												    legend: {
														orient : 'horizontal',
														top : '1%',
														data : legend
												    },						    

													calculable : true,
												    xAxis : [
												        {
						                                    axisLabel: {
						                                        interval:0,
						                                        rotate:40
						                                     },
												        
												            type : 'category',
												            data : xAxisData
												        }
												    ],
												    
												    visualMap: [
												        {
												                left: 'right',
												                top: '10%',
												                dimension: 1,
												                min: 0,
												                max: max,
												                itemWidth: 30,
												                itemHeight: 120,
												                calculable: true,
												                precision: 1,
												                text: ['圆形大小：专利数量'],
												                textGap: 30,
												                textStyle: {
												                    color: '#000'
												                },
												                inRange: {
												                    symbolSize: [10, 70]
												                },
												                outOfRange: {
												                    symbolSize: [10, 70],
												                    color: ['rgba(255,255,255,.2)']
												                },
												                controller: {
												                    inRange: {
												                        color: ['#c23531']
												                    },
												                    outOfRange: {
												                        color: ['#444']
												                    }
												                }
												            }
												        ],
												        
												    yAxis : [
												        {
												            type : 'value'
												        }
												    ],
												    series : series												    													
												});												
											},
					
					_generateXYChart_horizontal : function(analysisName, xAxisData, legend, series, theme) {
						
//alert("_generateXYChart_horizontal");	

//alert(xAxisData);
//alert(legend);
//var jsonstr = JSON.stringify(series);
//alert(jsonstr);

/*
var _arr=jsonstr.split("},{");
alert(_arr.length);
for (var i = 0; i < _arr.length; i++) {
	alert(_arr[i]);
}
*/
										
								var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
								echarts.dispose(chart);

								var _XYChart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
								
								_XYChart.setOption({
								    tooltip : {
								        trigger: 'axis',
								        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
								            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
								        }
								    },
								    legend: {
										orient : 'horizontal',
										top : '70%',
										data : legend
								    },						    
									grid : {
										left : '5%',
										right : '4%',
										bottom : '30%',
										containLabel : true
									},
									calculable : true,
								    yAxis : [
								        {
								        	type : 'category',
								            data : xAxisData
								        }
								    ],
								    xAxis : [
								        {
								            type : 'value'
								        }
								    ],
								    series : series										
							});
				},
					
					_generateChinaChart : function(analysisName, xAxis, legend,
							series, theme, average) {
						//alert("_generateXYChart");
						//alert(analysisName);
						//alert(xAxis);
						//alert(legend);
						//alert(series);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var ChinaChart = echarts
								.init(
										document
												.getElementById('patentAnalysisEcharts'),
										theme);
						ChinaChart.setOption({

							title : {
//								text: analysisName
							},
							tooltip : {
								trigger : 'item'
							},
							legend : {
								orient : 'vertical',
								left : 'left',
								data : legend
							},
							visualMap : {
								min : 0,
								max : average,
								left : 'left',
								top : 'bottom',
								text : [ '高', '低' ], // 文本，默认为数值文本
								calculable : true
							},
							/*
							toolbox : {
								show : true,
								orient : 'vertical',
								left : 'right',
								top : 'center',
								feature : {
									dataView : {
										readOnly : false
									},
									restore : {},
									saveAsImage : {}
								}
							},
							*/
							series : series
						});
					},
					
					_generateShandongChart : function(analysisName, xAxis, legend,
							series, theme, average) {
						//alert("_generateXYChart");
						//alert(analysisName);
						//alert(xAxis);
						//alert(legend);
						//alert(series);

						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);
						
						var ChinaChart = echarts
								.init(
										document
												.getElementById('patentAnalysisEcharts'),
										theme);
						ChinaChart.setOption({

							title : {
//								text: analysisName
							},
							tooltip : {
								trigger : 'item'
							},
							legend : {
								orient : 'vertical',
								left : 'left',
								data : legend
							},
							visualMap : {
								min : 0,
								max : average,
								left : 'left',
								top : 'bottom',
								text : [ '高', '低' ], // 文本，默认为数值文本
								calculable : true
							},
							/*
							toolbox : {
								show : true,
								orient : 'vertical',
								left : 'right',
								top : 'center',
								feature : {
									dataView : {
										readOnly : false
									},
									restore : {},
									saveAsImage : {}
								}
							},
							*/
							series : series
						});
					},

					_generateWorldChart : function(analysisName, legend,
							series, theme, average) {
						//alert("_generateWorldChart");
						//alert(analysisName);
						//alert(xAxis);
						//alert(legend);
						//alert(series);
						
						var chart = echarts.init(document.getElementById('patentAnalysisEcharts'),theme);
						echarts.dispose(chart);

						var WorldChart = echarts
								.init(
										document
												.getElementById('patentAnalysisEcharts'),
										theme);
						WorldChart
								.setOption({

									title : {
//								    	text: analysisName
//								        text: '专利申请区域构成分析',
//								        left: 'center',
//								        top: 'top'
									},
									tooltip: {
										//													    	trigger: 'item'													    	
										trigger : 'item',
										formatter : function(params) {
											/*
											var value = (params.value + '').split('.');
											value = value[0].replace(/(\d{1,3})(?=(?:\d{3})+(?!\d))/g, '$1,')
											        + '.' + value[1];
											 */
											var value = (params.value + '');
											if (value === 'NaN') {
												value = "0";
											}
											return params.name
													+ ' : '
													+ value
															.replace(
																	/(\d{1,3})(?=(?:\d{3})+(?!\d))/g,
																	'$1,');
										}
									},
									visualMap : {
										min : 0,
										max : average,
										text : [ '高', '低' ], // 文本，默认为数值文本
										realtime : false,
										calculable : true,
										inRange : {
											color : [ 'lightskyblue', 'yellow','orangered' ]
										}
									},
									/*
									toolbox : {
										show : true,
										orient : 'vertical',
										left : 'right',
										top : 'center',
										feature : {
											dataView : {
												readOnly : false
											},
											restore : {},
											saveAsImage : {}
										}
									},
									*/
									series : series
								});
					},

					//生成分析结果表格		
					generateDateTable : function(dataTableTitles, valueArr, dataList, isSingle) {
						var self = this;
						dataTableTitles.forEach(function(element, index) {
							self.dataTableTitles.push(element);
						});
						for (var i = 0; i < valueArr.length; i++) {
							var row = [];
							row[0] = valueArr[i];
							if (isSingle) {
								for (var j = 0; j < dataList.length; j++) {
									row[j + 1] = dataList[j].data[i];
								}
							} else {
								for (var j = 0; j < dataTableTitles.length - 1; j++) {
									row[j + 1] = dataList[i].data[j];
								}
							}

							self.dataTableList.push(row);
						}
					}

				}
			})
</script>


<%
//if(index_exp!=null&&!index_exp.equals(""))
//{
//	String analyseMenuID = request.getParameter("analyseMenuID");
/*
String xAxis = request.getParameter("xAxis");
String xAxisSize = request.getParameter("xAxisSize");
String yAxis = request.getParameter("yAxis");
String yAxisSize = request.getParameter("yAxisSize");
String cnfr = request.getParameter("cnfr");
String charttype = request.getParameter("charttype");
String allcharttype = request.getParameter("allcharttype");
*/
//System.out.println("analyseMenuID="+analyseMenuID);
//System.out.println("xAxis="+xAxis);
//System.out.println("xAxisSize="+xAxisSize);
//System.out.println("yAxis="+yAxis);
//System.out.println("yAxisSize="+yAxisSize);
//System.out.println("charttype="+charttype);
%>
<script type="text/javascript">
window.onload = function(){
//alert("analyseID="+"<%=analyseMenuID%>");
//alert("window.onload="+(menuList===""));
//alert("window.onload="+!menuList +"--"+ menuList!=0 +"--"+  menuList!='');
//alert(!menuList);
//alert(menuList!=0);
//alert(menuList!='');

		if(menuList){

			$.ajax({
				type : "GET",
				url : "getAllAnalyseMenuInfo.do?area=<%=area%>&" + new Date(),
				contentType : "application/json;charset=UTF-8",
				success : function(jsonresult) {
//					alert(jsonresult);
					var data= $.parseJSON(jsonresult);					
					for (var key in data) {
						var val = data[key];
//alert(val.intID+"---"+val.chrName);
//						if(val.intEnable==1||val.intEnable=="1")
						if(val.intParentID!='0'&&val.intParentID!=0){
							menuList[val.intID] = val;
						}
					}
					
					analyseMenuID = "<%=analyseMenuID%>";
					//$("body").mask("正在初始化，请稍候...");
					//sleep(500);
					//alert("analyseMenuID="+analyseMenuID);
					//$("#analyseMenuID").val(analyseMenuID);
					directAnalyse(analyseMenuID);					
				}
			});
		}
}

function directAnalyse(analyseMenuID){	
	var analyseMenuID;
	var charttype;
	var xAxis;
	var xAxisSize;
	var yAxis;
	var yAxisSize;
	var cnfr;
	var chrChart;
	
	for (var key in menuList) {
		var val = menuList[key];			
//		alert("xAxis="+val.chrXAxis);			
		if(analyseMenuID===key)
		{
//			alert(val.chrDefaultChart);
//			alert("analyseID="+analyseID);
			charttype=val.chrDefaultChart;
			xAxis=val.chrXAxis;
			xAxisSize=val.xAxisSize;
			yAxis=val.chrYAxis;
			yAxisSize=val.yAxisSize;
			cnfr=val.intCNFR;
			chrChart=val.chrChart;
//alert("analyseMenuID="+analyseMenuID);
			vm.analysePatent(analyseMenuID,charttype,xAxis,xAxisSize,yAxis,yAxisSize,cnfr,chrChart);
		}
//alert(key+"---------"+val.intID+"','"+val.chrDefaultChart+"','"+val.chrXAxis+"',"+val.xAxisSize+",'"+val.chrYAxis+"',"+val.yAxisSize+",'"+val.intCNFR+"','"+val.chrChart);
	}
	
}
</script>
<%
//}
%>

<%@ include file="../jsp/zljs/include-analyse-jieguo.jsp"%>
