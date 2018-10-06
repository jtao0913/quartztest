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

String wap = DataAccess.get("wap")==null?"0":DataAccess.get("wap");
if(wap.equals("1")&&!showtype.equals("computer")){
%>

<%}%>

<%@ include file="jsp/zljs/include-head.jsp"%>
<%@ include file="jsp/zljs/include-head-nav.jsp"%>

<script src="analyse/echarts.js"></script>
<script src="analyse/theme/shine.js"></script>
<script src="map/shandong/shandong.js"></script>
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
			<input type="text" id="content" name="content" class="input-xxlarge" id="sousou"  placeholder="请输入关键词进行检索"/>
			<button type="button" class="btn btn-warning"  onClick="doQsearch()"><i class="icon-search icon-white"></i>&nbsp;检 索</button>	
			</div>
			<div style="height:10px;"></div>
			<div class="row">
            <ul class="inline">
				<li><label class="radio" style="width: 150px"><input type="radio" name="area" value="cn" checked> SIPO专利（中文）</label></li>
				<li><label class="radio" style="width: 160px"><input type="radio" name="area" value="fr"> 港澳台及海外（英文）</label></li>
			</ul>
		</div>
	</form>
 	</div>	
 </div>
 <!--块状展示-->
 <div style="height:10px"></div>
 

 
 

 
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 1000px;height:700px;margin-left:auto;margin-right:auto;"></div>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'),'macarons');
var data = [	

	{"time": 2008,
		"data":  [
		{name: '济南市', value:[6584,18.92,"济南市"]},
		{name: '青岛市', value:[4767,13.70,"青岛市"]},
		{name: '烟台市', value:[3177,9.13,"烟台市"]},
		{name: '潍坊市', value:[3127,8.99,"潍坊市"]},
		{name: '济宁市', value:[3077,8.84,"济宁市"]},
		{name: '东营市', value:[2285,6.57,"东营市"]},
		{name: '临沂市', value:[1668,4.79,"临沂市"]},
		{name: '淄博市', value:[1582,4.55,"淄博市"]},
		{name: '泰安市', value:[1441,4.14,"泰安市"]},
		{name: '威海市', value:[1405,4.04,"威海市"]},
		{name: '聊城市', value:[1098,3.16,"聊城市"]},
		{name: '莱芜市', value:[900,2.59,"莱芜市"]},
		{name: '日照市', value:[804,2.31,"日照市"]},
		{name: '枣庄市', value:[784,2.25,"枣庄市"]},
		{name: '滨州市', value:[746,2.14,"滨州市"]},
		{name: '菏泽市', value:[694,1.99,"菏泽市"]},
		{name: '德州市', value:[662,1.90,"德州市"]}
		]},

		{"time": 2009,
		"data":  [
		{name: '济南市', value:[8436,19.15,"济南市"]},
		{name: '青岛市', value:[6035,13.70,"青岛市"]},
		{name: '潍坊市', value:[4043,9.18,"潍坊市"]},
		{name: '烟台市', value:[3837,8.71,"烟台市"]},
		{name: '济宁市', value:[3257,7.39,"济宁市"]},
		{name: '东营市', value:[2829,6.42,"东营市"]},
		{name: '临沂市', value:[2317,5.26,"临沂市"]},
		{name: '威海市', value:[2171,4.93,"威海市"]},
		{name: '泰安市', value:[2114,4.80,"泰安市"]},
		{name: '淄博市', value:[1950,4.43,"淄博市"]},
		{name: '聊城市', value:[1144,2.60,"聊城市"]},
		{name: '滨州市', value:[1115,2.53,"滨州市"]},
		{name: '德州市', value:[1045,2.37,"德州市"]},
		{name: '莱芜市', value:[1010,2.29,"莱芜市"]},
		{name: '枣庄市', value:[995,2.26,"枣庄市"]},
		{name: '日照市', value:[889,2.02,"日照市"]},
		{name: '菏泽市', value:[868,1.97,"菏泽市"]}
		]},


		{"time": 2010,
		"data":  [
		{name: '济南市', value:[12093,19.81,"济南市"]},
		{name: '青岛市', value:[8760,14.35,"青岛市"]},
		{name: '烟台市', value:[5183,8.49,"烟台市"]},
		{name: '潍坊市', value:[4687,7.68,"潍坊市"]},
		{name: '济宁市', value:[3916,6.42,"济宁市"]},
		{name: '威海市', value:[3766,6.17,"威海市"]},
		{name: '淄博市', value:[3742,6.13,"淄博市"]},
		{name: '泰安市', value:[3217,5.27,"泰安市"]},
		{name: '临沂市', value:[2622,4.30,"临沂市"]},
		{name: '东营市', value:[2431,3.98,"东营市"]},
		{name: '德州市', value:[1740,2.85,"德州市"]},
		{name: '聊城市', value:[1729,2.83,"聊城市"]},
		{name: '莱芜市', value:[1709,2.80,"莱芜市"]},
		{name: '滨州市', value:[1522,2.49,"滨州市"]},
		{name: '枣庄市', value:[1478,2.42,"枣庄市"]},
		{name: '日照市', value:[1246,2.04,"日照市"]},
		{name: '菏泽市', value:[1197,1.96,"菏泽市"]}
		]},

		{"time": 2011,
		"data":  [
		{name: '济南市', value:[14576,19.70,"济南市"]},
		{name: '青岛市', value:[11445,15.47,"青岛市"]},
		{name: '烟台市', value:[6208,8.39,"烟台市"]},
		{name: '潍坊市', value:[6058,8.19,"潍坊市"]},
		{name: '济宁市', value:[4789,6.47,"济宁市"]},
		{name: '淄博市', value:[4147,5.60,"淄博市"]},
		{name: '威海市', value:[3737,5.05,"威海市"]},
		{name: '泰安市', value:[3562,4.81,"泰安市"]},
		{name: '滨州市', value:[3379,4.57,"滨州市"]},
		{name: '临沂市', value:[2861,3.87,"临沂市"]},
		{name: '东营市', value:[2382,3.22,"东营市"]},
		{name: '日照市', value:[2129,2.88,"日照市"]},
		{name: '德州市', value:[2004,2.71,"德州市"]},
		{name: '莱芜市', value:[1828,2.47,"莱芜市"]},
		{name: '聊城市', value:[1685,2.28,"聊城市"]},
		{name: '菏泽市', value:[1620,2.19,"菏泽市"]},
		{name: '枣庄市', value:[1589,2.15,"枣庄市"]}
		]},

		{"time": 2012,
		"data":  [
		{name: '济南市', value:[19850,19.98,"济南市"]},
		{name: '青岛市', value:[17797,17.92,"青岛市"]},
		{name: '潍坊市', value:[8613,8.67,"潍坊市"]},
		{name: '烟台市', value:[8212,8.27,"烟台市"]},
		{name: '济宁市', value:[6063,6.10,"济宁市"]},
		{name: '淄博市', value:[5395,5.43,"淄博市"]},
		{name: '泰安市', value:[4573,4.60,"泰安市"]},
		{name: '威海市', value:[4374,4.40,"威海市"]},
		{name: '滨州市', value:[4354,4.38,"滨州市"]},
		{name: '临沂市', value:[3512,3.54,"临沂市"]},
		{name: '德州市', value:[2956,2.98,"德州市"]},
		{name: '东营市', value:[2873,2.89,"东营市"]},
		{name: '菏泽市', value:[2427,2.44,"菏泽市"]},
		{name: '枣庄市', value:[2313,2.33,"枣庄市"]},
		{name: '莱芜市', value:[2182,2.20,"莱芜市"]},
		{name: '日照市', value:[1932,1.95,"日照市"]},
		{name: '聊城市', value:[1905,1.92,"聊城市"]}
		]},

		{"time": 2013,
		"data":  [
		{name: '青岛市', value:[25386,21.74,"青岛市"]},
		{name: '济南市', value:[21357,18.29,"济南市"]},
		{name: '潍坊市', value:[11394,9.76,"潍坊市"]},
		{name: '烟台市', value:[7972,6.83,"烟台市"]},
		{name: '济宁市', value:[6823,5.84,"济宁市"]},
		{name: '淄博市', value:[6716,5.75,"淄博市"]},
		{name: '泰安市', value:[4742,4.06,"泰安市"]},
		{name: '威海市', value:[4716,4.04,"威海市"]},
		{name: '滨州市', value:[4346,3.72,"滨州市"]},
		{name: '临沂市', value:[3865,3.31,"临沂市"]},
		{name: '东营市', value:[3645,3.12,"东营市"]},
		{name: '德州市', value:[3492,2.99,"德州市"]},
		{name: '菏泽市', value:[2624,2.25,"菏泽市"]},
		{name: '枣庄市', value:[2518,2.16,"枣庄市"]},
		{name: '聊城市', value:[2454,2.10,"聊城市"]},
		{name: '莱芜市', value:[2433,2.08,"莱芜市"]},
		{name: '日照市', value:[2285,1.96,"日照市"]}
		]},

		{"time": 2014,
		"data":  [
		{name: '青岛市', value:[36226,29.17,"青岛市"]},
		{name: '济南市', value:[22005,17.72,"济南市"]},
		{name: '潍坊市', value:[11502,9.26,"潍坊市"]},
		{name: '烟台市', value:[7874,6.34,"烟台市"]},
		{name: '淄博市', value:[5872,4.73,"淄博市"]},
		{name: '济宁市', value:[5601,4.51,"济宁市"]},
		{name: '威海市', value:[4826,3.89,"威海市"]},
		{name: '泰安市', value:[4623,3.72,"泰安市"]},
		{name: '临沂市', value:[4148,3.34,"临沂市"]},
		{name: '滨州市', value:[3829,3.08,"滨州市"]},
		{name: '东营市', value:[3619,2.91,"东营市"]},
		{name: '德州市', value:[3075,2.48,"德州市"]},
		{name: '菏泽市', value:[2373,1.91,"菏泽市"]},
		{name: '聊城市', value:[2367,1.91,"聊城市"]},
		{name: '枣庄市', value:[2237,1.80,"枣庄市"]},
		{name: '莱芜市', value:[2218,1.79,"莱芜市"]},
		{name: '日照市', value:[1794,1.44,"日照市"]}
		]},

		{"time": 2015,
		"data":  [
		{name: '青岛市', value:[51014,30.49,"青岛市"]},
		{name: '济南市', value:[29884,17.86,"济南市"]},
		{name: '潍坊市', value:[14950,8.94,"潍坊市"]},
		{name: '烟台市', value:[9818,5.87,"烟台市"]},
		{name: '淄博市', value:[8419,5.03,"淄博市"]},
		{name: '济宁市', value:[7984,4.77,"济宁市"]},
		{name: '临沂市', value:[6335,3.79,"临沂市"]},
		{name: '威海市', value:[5920,3.54,"威海市"]},
		{name: '滨州市', value:[4948,2.96,"滨州市"]},
		{name: '泰安市', value:[4490,2.68,"泰安市"]},
		{name: '东营市', value:[4031,2.41,"东营市"]},
		{name: '菏泽市', value:[3627,2.17,"菏泽市"]},
		{name: '德州市', value:[3612,2.16,"德州市"]},
		{name: '聊城市', value:[3468,2.07,"聊城市"]},
		{name: '枣庄市', value:[3199,1.91,"枣庄市"]},
		{name: '莱芜市', value:[2971,1.78,"莱芜市"]},
		{name: '日照市', value:[2628,1.57,"日照市"]}
		]},

		{"time": 2016,
		"data":  [
		{name: '青岛市', value:[51855,29.95,"青岛市"]},
		{name: '济南市', value:[29529,17.05,"济南市"]},
		{name: '潍坊市', value:[16091,9.29,"潍坊市"]},
		{name: '烟台市', value:[10353,5.98,"烟台市"]},
		{name: '济宁市', value:[7982,4.61,"济宁市"]},
		{name: '威海市', value:[7884,4.55,"威海市"]},
		{name: '淄博市', value:[7507,4.34,"淄博市"]},
		{name: '临沂市', value:[6535,3.77,"临沂市"]},
		{name: '滨州市', value:[4654,2.69,"滨州市"]},
		{name: '泰安市', value:[4504,2.60,"泰安市"]},
		{name: '聊城市', value:[4355,2.52,"聊城市"]},
		{name: '东营市', value:[4306,2.49,"东营市"]},
		{name: '菏泽市', value:[4094,2.36,"菏泽市"]},
		{name: '德州市', value:[3927,2.27,"德州市"]},
		{name: '枣庄市', value:[3550,2.05,"枣庄市"]},
		{name: '日照市', value:[3073,1.77,"日照市"]},
		{name: '莱芜市', value:[2961,1.71,"莱芜市"]}
		]},



	{"time": 2017,
	"data":  [
	{name: '青岛市', value:[51156,29.99,"青岛市"]},
	{name: '济南市', value:[29450,17.27,"济南市"]},
	{name: '潍坊市', value:[15127,8.87,"潍坊市"]},
	{name: '烟台市', value:[10782,6.32,"烟台市"]},
	{name: '济宁市', value:[8526,5.00,"济宁市"]},
	{name: '淄博市', value:[7793,4.57,"淄博市"]},
	{name: '威海市', value:[7163,4.20,"威海市"]},
	{name: '临沂市', value:[6629,3.89,"临沂市"]},
	{name: '泰安市', value:[5169,3.03,"泰安市"]},
	{name: '滨州市', value:[4800,2.81,"滨州市"]},
	{name: '聊城市', value:[4411,2.59,"聊城市"]},
	{name: '东营市', value:[4060,2.38,"东营市"]},
	{name: '德州市', value:[3838,2.25,"德州市"]},
	{name: '菏泽市', value:[3495,2.05,"菏泽市"]},
	{name: '枣庄市', value:[3427,2.01,"枣庄市"]},
	{name: '莱芜市', value:[2613,1.53,"莱芜市"]},
	{name: '日照市', value:[2120,1.24,"日照市"]}
	]},






	
	
	
	{"time": 2018,
	"data":  [
	{name: '青岛市', value:[10791,25.50,"青岛市"]},
	{name: '济南市', value:[6504,15.37,"济南市"]},
	{name: '潍坊市', value:[4366,10.32,"潍坊市"]},
	{name: '济宁市', value:[2667,6.30,"济宁市"]},
	{name: '烟台市', value:[2613,6.18,"烟台市"]},
	{name: '淄博市', value:[2228,5.27,"淄博市"]},
	{name: '威海市', value:[2004,4.74,"威海市"]},
	{name: '临沂市', value:[1784,4.22,"临沂市"]},
	{name: '泰安市', value:[1354,3.20,"泰安市"]},
	{name: '东营市', value:[1241,2.93,"东营市"]},
	{name: '聊城市', value:[1138,2.69,"聊城市"]},
	{name: '德州市', value:[1110,2.62,"德州市"]},
	{name: '滨州市', value:[1102,2.60,"滨州市"]},
	{name: '菏泽市', value:[1079,2.55,"菏泽市"]},
	{name: '枣庄市', value:[1009,2.38,"枣庄市"]},
	{name: '莱芜市', value:[727,1.72,"莱芜市"]},
	{name: '日照市', value:[593,1.40,"日照市"]}
	]},


	
]


var option = {
//   backgroundColor: '#25499F',
   baseOption: {
       animationDurationUpdate: 1000,
       animationEasingUpdate: 'quinticInOut',
       timeline: {
           axisType: 'category',
           orient: 'vertical',
           autoPlay: true,
           inverse: true,
           playInterval: 1000,
           left: null,
           right: 5,
           top: 20,
           bottom: 20,
           width: 46,
           height: null,
           label: {
               normal: {
                   textStyle: {
                       color: '#ddd'
                   }
               },
               emphasis: {
                   textStyle: {
                       color: '#fff'
                   }
               }
           },
           symbol: 'none',
           lineStyle: {
               color: '#555'
           },
           checkpointStyle: {
               color: '#bbb',
               borderColor: '#777',
               borderWidth: 1
           },
           controlStyle: {
               showNextBtn: false,
               showPrevBtn: false,
               normal: {
                   color: '#666',
                   borderColor: '#666'
               },
               emphasis: {
                   color: '#aaa',
                   borderColor: '#aaa'
               }
           },
           data: data.map(function(ele) {
               return ele.time
           })
       },
       backgroundColor: '#25499F',
       title: {
           text: '2009-2018年山东省专利情况',
           subtext: '单位:件',
           left: 'center',
           top: 'top',
           textStyle: {
               fontSize: 25,
               color: 'rgba(255,255,255, 0.9)'
           }
       },
       tooltip: {
           formatter: function(params) {
               if ('value' in params.data) {
                   return params.data.value[2] + ': ' + params.data.value[0];
               }
           }
       },
       grid: {
           left: 10,
           right: '45%',
           top: '70%',
           bottom: 5
       },
       xAxis: {},
       yAxis: {},
       series: [{
           id: 'map',
           type: 'map',
           map: '山东',
           mapType: '山东',
           top: '5%',

           layoutCenter:['50%','50%'],        //地图中心点位置['50%','50%']代表在最中间
           layoutSize: '70%',        //地图大小，此处设置为100%
           
           //bottom: '25%',
           //left: '5%',
           //right: '10%',
           itemStyle: {
               normal: {
                   areaColor: '#323c48',
                   borderColor: '#404a59'
               },
               emphasis: {
                   label: {
                       show: true
                   },
                   areaColor: 'rgba(255,255,255, 0.5)'
               }
           },
           data: []
       }, {
           id: 'bar',
           type: 'bar',
           tooltip: {
               show: false
           },
           label: {
               normal: {
                   show: true,
                   position: 'right',
                   textStyle: {
                       color: '#ddd'
                   }
               }
           },
           data: []
       }, {
           id: 'pie',
           type: 'pie',
           radius: ['12%', '20%'],
           center: ['75%', '85%'],
           //roseType: 'area',
           tooltip: {
               formatter: '{b} {d}%'
           },
           data: [],
           label: {
               normal: {
                   textStyle: {
                       color: '#ddd'
                   }
               }
           },
           labelLine: {
               normal: {
                   lineStyle: {
                       color: '#ddd'
                   }
               }
           },
           itemStyle: {
               normal: {
                   borderColor: 'rgba(0,0,0,0.3)',
                   borderSize: 1
               }
           }
       }]
   },
   options: []
}

for (var i = 0; i < data.length; i++) {
   //计算其余省份GDP
   var restPercent = 100;
   var restValue = 0;
   data[i].data.forEach(function(ele) {
       restPercent = restPercent - ele.value[1];
   });
   restValue = data[i].data[0].value[0] * (restPercent / data[i].data[0].value[1]);
   console.log(restPercent);
   console.log(restValue);
   option.options.push({
       visualMap: [{
           //type:'continous',
           //type: 'continuous',
           calculable: true,
           dimension: 0,
           left: 10,
           top: 'center',
           itemWidth: 12,
           min: data[i].data[9].value[0],
           max: data[i].data[0].value[0],
           text: ['High', 'Low'],
           textStyle: {
               color: '#ddd'
           },
           inRange: {
//               color: ['lightskyblue', 'yellow', 'orangered', 'red']
               color: ['lightskyblue', 'yellow', 'orangered']
           }
       }],
       xAxis: {
           type: 'value',
           boundaryGap: [0, 0.1],
           axisLabel: {
               show: false,
           },
           splitLine: {
               show: false
           }
       },
       yAxis: {
           type: 'category',
           axisLabel: {
               show: false,
               textStyle: {
                   color: '#ddd'
               }
           },

           data: data[i].data.map(function(ele) {
               return ele.value[2]
           }).reverse()
       },
       series: [{
           id: 'map',
           data: data[i].data
       }, {
           id: 'bar',
           label: {
               normal: {
                   position: 'right',
                   formatter: '{b} : {c}'
               }
           },
           data: data[i].data.map(function(ele) {
               return ele.value[0]
           }).sort(function(a, b) {
               return a > b
           })
       }, {
           id: 'pie',
           data: data[i].data.map(function(ele) {
               return {
                   name: ele.value[2],
                   value: ele.value
               }
           }).concat({
               name: '其他',
               value: restValue
           }),
       }]
   })
}

myChart.setOption(option);
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
    		window.location.href="<%=basePath%>showFlztSearchForm.do";
    	}else if(url==1){
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
			var area = $('input[name="area"]:checked').val();
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
