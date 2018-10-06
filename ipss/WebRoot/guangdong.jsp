<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ include file="jsp/zljs/include-head-base.jsp"%>
<%
	if (areacode != null && areacode.equals("000")) {
%>
<!-- 
<div class="clearfix"  style="text-align:center;background: #D8D8D8;border: 1px solid #000;padding:4px;">
	本网站是内部演示测试版本，随时可能关闭，敬请知晓！如有疑问请点击联系工作人员。<a href="http://www.cnipr.com/fw/fwtd/" target="_blank">点击联系</a>
</div>
 -->
<%
	}
%>
<%
	String showtype = request.getParameter("showtype") == null ? "" : request.getParameter("showtype");//computer

	String wap = DataAccess.get("wap") == null ? "0" : DataAccess.get("wap");
	if (wap.equals("1") && !showtype.equals("computer")) {
%>
<script src="<%=basePath%>wap/js/uaredirect.js"></script>
<script type="text/javascript">uaredirect("wap/");</script>
<%
	}
%>

<%@ include file="jsp/zljs/include-head.jsp"%>
<%@ include file="jsp/zljs/include-head-nav.jsp"%>

<script src="analyse/echarts.js"></script>
<script src="analyse/theme/shine_grey.js"></script>
<head>
<%
	String hangyeID = (String) session.getAttribute("hangye");
	hangyeID = request.getSession().getAttribute("hangye") == null
			? ""
			: (String) request.getSession().getAttribute("hangye");
//out.println("hangyeID="+hangyeID);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=website_title%>-专利检索查询,专利搜索下载</title>
<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
<meta name="description"
	content="<%=SetupAccess.getProperty("title")%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
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
	background:url(images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/x003.jpg) no-repeat 0 0;
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
<body>
	&nbsp;

	<!--LOGO-->
	<div style="height: 100px"></div>
	<div class="container">
		<div class="row text-center">
			<!-- 
 	<img src="common/com_2/img/index/logo.png" width="460"  height="75" />
	-->
			<img
				src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/logo.png" />

			<!-- 
 	<%if (hangyeID.equals("")) {%>
 	<img src="images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/logo.png"  />
 	<%} else {%>
 	<img src="images/liaoning/<%=hangyeID%>.png"  />
 	<%}%>
 	 -->
		</div>
	</div>
	<!--搜索-->
	<div style="height: 20px"></div>
	<div class="container">
		<div class="row text-center">
<!-- 
			<form id="searchForm1" class="form-inline" name="searchForm1"
				method="post" target="_self">
				<input type="hidden" value="电子" name="content1" /> <input
					type="hidden" id="colname"
					value="申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" name="colname" />

				<input type="hidden" id="strWhere" name="strWhere" /> <input
					type="hidden" id="simpleSearch" name="simpleSearch" value="1" /> <input
					type="hidden" id="presearchword" name="presearchword" /> <input
					type="hidden" id="savesearchword" name="savesearchword" value="ON">
				<input type="hidden" id="strChannels" name="strChannels" /> <input
					type="hidden" id="strSortMethod" name="strSortMethod"
					value="RELEVANCE" /> <input type="hidden" name="strDefautCols"
					value="主权项, 名称, 摘要" /> <input type="hidden" name="strStat"
					value="" /> <input type="hidden" name="iHitPointType" value="115" />
				<input type="hidden" id="searchKind" name="searchKind"
					value="tableSearch" /> <input type="hidden" id="bContinue"
					name="bContinue" value="" /> <input type="hidden"
					id="trsLastWhere" name="trsLastWhere" /> <input type="hidden"
					value="" name="channelid" /> <span class="help-inline muted">快速检索&nbsp;</span>
				<div class="input-append">
					<input type="text" id="content" name="content"
						class="input-xxlarge" id="sousou" placeholder="请输入关键词进行检索" />
					<button type="button" class="btn btn-warning" onClick="doQsearch()">
						<i class="icon-search icon-white"></i>&nbsp;检 索
					</button>
				</div>
				<div style="height: 10px;"></div>
				<div class="row">
					<ul class="inline">
						<li><label class="radio" style="width: 150px"><input
								type="radio" name="area" value="cn" checked> SIPO专利（中文）</label></li>
						<li><label class="radio" style="width: 160px"><input
								type="radio" name="area" value="fr"> 港澳台及海外（英文）</label></li>
					</ul>
				</div>
			</form>
 -->
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
				<li><label class="radio" style="width: 150px"><input type="radio" name="area" value="cn" checked> SIPO专利（中文）</label></li>
				<li><label class="radio" style="width: 160px"><input type="radio" name="area" value="fr"> 港澳台及海外（英文）</label></li>
			</ul>
		</div>
	</form>
			
		</div>
	</div>
	<!--块状展示-->
	<div style="height: 10px"></div>


	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="main"
		style="width: 1200px; height: 400px; margin-left: auto; margin-right: auto;"></div>
	<script type="text/javascript">
	var myChart = echarts.init(document.getElementById('main'),'shine_grey');

	var dataMap = {};
function dataFormatter(obj) {
//'济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'

	var pList = ['广州市','深圳市','珠海市','汕头市','佛山市','韶关市','湛江市','肇庆市','江门市','茂名市','惠州市','梅州市','汕尾市','河源市','阳江市','清远市','东莞市','中山市','潮州市','揭阳市','云浮市'];
    var temp;
    for (var year = 2009; year <= 2018; year++) {
        var max = 0;
        var sum = 0;
        temp = obj[year];
        for (var i = 0, l = temp.length; i < l; i++) {
            max = Math.max(max, temp[i]);
            sum += temp[i];
            obj[year][i] = {
                name : pList[i],
                value : temp[i]
            }
        }
        obj[year + 'max'] = Math.floor(max / 100) * 100;
        obj[year + 'sum'] = sum;
    }
    return obj;
}

dataMap.dataFMZL = dataFormatter({
2009:[4244,18851,511,223,1711,67,202,80,317,69,208,52,17,22,16,31,1207,548,69,60,17],
2018:[8191,15009,2136,489,5631,256,177,440,2566,691,2496,85,171,92,34,259,5127,2260,153,107,74],
2017:[34607,61750,7476,1214,20797,558,621,1449,3117,1046,5634,161,377,334,132,556,18459,6030,286,293,290],
2016:[21319,41794,6143,790,13415,705,480,653,2602,681,5149,144,158,296,85,363,12919,5309,251,159,166],
2015:[15566,35538,4401,1413,9912,401,440,437,1948,470,3295,184,90,165,71,201,9687,4253,250,169,85],
2014:[12637,34158,2786,1606,5028,311,293,297,1454,400,2376,122,69,146,54,152,5327,2386,292,110,65],
2013:[10500,29464,2073,978,3162,250,246,264,1023,169,1463,96,88,95,47,163,6001,1846,263,176,66],
2012:[8807,27971,1393,1058,2977,273,253,279,1018,123,1514,113,75,92,63,101,4066,1414,263,123,75],
2011:[6084,22538,932,347,2195,115,204,224,589,88,1035,105,52,65,32,68,3824,956,94,98,35],
2010:[5366,21967,598,243,1985,99,211,135,457,80,447,58,46,27,31,47,1721,799,94,69,28]
});

dataMap.dataSYXX = dataFormatter({
2009:[3965,8929,982,595,3983,169,242,110,894,101,447,73,31,90,158,48,4343,1636,195,90,41],
2018:[10014,18151,2249,732,7123,318,382,513,1228,268,1791,310,360,413,127,415,9815,3218,160,293,234],
2017:[32117,44573,8001,2014,19698,687,1753,1406,4384,823,6245,864,463,1217,381,1330,30109,11094,541,715,474],
2016:[23033,34804,5782,1816,14262,835,1371,1168,2791,555,4469,821,227,726,268,917,16766,6935,488,525,429],
2015:[16528,32435,4029,1574,13371,793,961,888,2403,498,4526,2366,157,386,267,475,13376,6346,552,453,185],
2014:[13415,24888,4145,1428,11424,735,485,874,2188,466,3395,869,210,337,301,286,10684,5089,433,408,167],
2013:[12756,24798,3379,1935,10029,976,474,867,2200,464,2667,673,364,282,259,305,13024,5153,661,593,196],
2012:[9346,19792,3038,1374,7901,444,399,763,1741,235,2019,301,119,134,231,278,9996,3747,456,310,98],
2011:[7596,16155,1862,950,6505,288,305,446,1547,200,1490,223,69,205,216,203,7984,3368,341,276,76],
2010:[5714,13283,1452,880,5462,283,285,256,1260,124,885,154,58,85,226,116,7024,2696,314,152,51]
});

dataMap.dataWGZL = dataFormatter({
2009:[4991,7988,809,2753,7575,112,186,171,2213,121,381,189,99,141,674,88,7584,2978,1173,573,74],
2018:[5658,10070,457,2074,3694,321,429,220,1099,356,1191,189,156,173,665,140,3062,3470,953,715,167],
2017:[18677,30899,2028,7201,12148,661,1057,755,3614,923,3781,703,426,621,1766,417,10138,14871,3567,3143,391],
2016:[17879,22964,1524,5931,11532,1300,1095,561,3569,930,4260,682,389,456,1234,552,8454,14333,3217,2394,361],
2015:[15334,21490,1466,5590,11029,1056,1301,647,3340,1291,4114,705,448,435,1047,419,9815,14249,2527,2203,372],
2014:[10181,16523,1453,4939,9731,810,660,407,3074,684,3136,498,263,245,853,298,8220,9247,2289,1687,297],
2013:[10268,16181,1123,5325,9169,487,505,388,3130,577,2940,611,499,231,945,289,9439,8977,2247,1828,266],
2012:[8445,14811,1225,4711,8731,915,407,344,2938,410,1769,496,270,163,702,345,9000,6741,1980,1473,224],
2011:[6782,10518,1290,2985,8502,313,242,326,3494,158,763,421,174,146,627,134,10589,5829,1320,957,169],
2010:[6991,11118,985,4738,10496,152,388,233,3935,170,570,298,180,103,997,273,12255,5476,1830,596,111]
});

dataMap.dataFMSQ = dataFormatter({
2009:[1513,8620,200,81,646,27,48,23,104,14,64,17,13,16,10,5,231,87,25,29,11],
2018:[2466,5407,779,95,1204,37,41,45,156,22,337,11,20,26,23,39,1662,363,13,20,12],
2017:[9353,18947,2473,388,4881,141,195,199,590,115,1451,97,25,69,32,134,4737,1367,94,64,27],
2016:[7698,18607,1730,363,3315,118,175,214,523,168,1244,77,46,58,34,84,3606,1144,95,74,39],
2015:[6032,15834,1174,307,1937,102,136,152,477,98,771,41,47,30,22,102,2509,871,90,70,38],
2014:[4498,12035,590,225,1111,55,116,145,301,56,530,80,15,21,6,49,1595,491,111,60,31],
2013:[4221,11636,502,213,1061,61,123,114,297,46,464,44,24,26,7,49,1494,475,81,53,28],
2012:[4005,13267,501,192,1161,38,147,98,344,38,276,58,22,18,15,47,1300,461,68,67,16],
2011:[2880,11564,291,141,914,32,100,54,211,18,100,29,6,5,8,17,690,330,38,41,13],
2010:[1880,9170,193,108,632,39,65,30,136,12,42,25,3,14,6,14,400,142,22,33,5]
});

option = {
    baseOption: {
        timeline: {
            // y: 0,
			//width:'90%',
			//lineStyle:{color: '#666', width: 1, type: 'dashed'},
            axisType: 'category',
            // realtime: false,
            // loop: false,
            autoPlay: true,
			
            // currentIndex: 2,
            playInterval: 1000,
            controlStyle: {
				normal : { color : '#333'},
				emphasis : { color : '#1e90ff'},
             //     position: 'left'
                    position: 'center'
            },
            data: [
                '2009','2010','2011', '2012','2013','2014','2015','2016','2017','2018'
            ],
            label: {
                formatter : function(s) {
                    return (new Date(s)).getFullYear();
                }
            }
        },
        title: {
            subtext: ''
        },
        tooltip: {},
        legend: {
            x: 'center',
            data: ['发明公开', '实用新型', '外观专利','发明授权']
        },
        calculable : true,
        grid: {
            top: 60,
            bottom: 90
        },
		
        toolbox: {    
			//显示策略，可选为：true（显示） | false（隐藏），默认值为false    
			show: true,    
			//启用功能，目前支持feature，工具箱自定义功能回调处理    
			feature: {    
			//辅助线标志    
			mark: {show: true},  
			}
			}, 

		
		
        xAxis: [
            {
                'type':'category',
                'axisLabel':{'interval':0},
                'data':[
                	'广州市','深圳市','珠海市','汕头市','佛山市','韶关市','湛江市','肇庆市','江门市','茂名市','惠州市','梅州市','汕尾市','河源市','阳江市','清远市','东莞市','中山市','潮州市','揭阳市','云浮市'
                ],
                splitLine:{show: true},//去除网格线
				splitArea : {show : true}//保留网格区域
            }
        ],
        yAxis: [
            {
				splitLine:{show: false},//去除网格线
				splitArea : {show : true},//保留网格区域
                type: 'value', 
                name: '公开量（件）',
                // max: 53500
                max: 60000,
						splitArea:{
							show:true,
						},
            }
        ],
        series: [
            {name: '发明公开', type: 'bar',
				markPoint : {
					data : [
						{type : 'max', name : '最大值'},
						 {type : 'min', name : '最小值'}
					]
				},
				markLine : {
					data : [
						{type : 'average', name : '平均值'}
					]
				},
				itemStyle: {
                    emphasis: {
                        barBorderRadius: 7
                    },
                    normal: {
                        barBorderRadius: 7
                 }
            }},
			{name: '实用新型', type: 'bar',
			        markPoint : {
                data : [
                    {type : 'max', name : '最大值'},
                    {type : 'min', name : '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name : '平均值'}
                ]
            },
				itemStyle: {
                    emphasis: {
                        barBorderRadius: 7
                    },
                    normal: {
                        barBorderRadius: 7
                    }
                }},             
            {name: '外观专利', type: 'bar',
			    markPoint : {
					data : [
						{type : 'max', name : '最大值'},
						 {type : 'min', name : '最小值'}
					]
				},
				markLine : {
					data : [
						{type : 'average', name : '平均值'}
					]
				},
				itemStyle: {
                    emphasis: {
                        barBorderRadius: 7
                    },
                    normal: {
                        barBorderRadius: 7
                    }
                }
			},
            {name: '发明授权', type: 'bar',
			    markPoint : {
					data : [
						{type : 'max', name : '最大值'},
						 {type : 'min', name : '最小值'}
					]
				},
				markLine : {
					data : [
						{type : 'average', name : '平均值'}
					]
				},
				itemStyle: {
                    emphasis: {
                        barBorderRadius: 7
                    },
                    normal: {
                        barBorderRadius: 7
                    }
                }
			},
			{
                name: '占比',
                type: 'pie',
                center: ['75%', '35%'],
                radius: '28%'
            }
        ]
    },
    options: [
        {
            title : {text: '                      2009广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2009']},
                {data: dataMap.dataSYXX['2009']},
                {data: dataMap.dataWGZL['2009']},
				{data: dataMap.dataFMSQ['2009']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2009sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2009sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2009sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2009sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2010广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2010']},
				{data: dataMap.dataSYXX['2010']},
                {data: dataMap.dataWGZL['2010']},
				{data: dataMap.dataFMSQ['2010']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2010sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2010sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2010sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2010sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2011广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2011']},
                {data: dataMap.dataSYXX['2011']},
                {data: dataMap.dataWGZL['2011']},
				{data: dataMap.dataFMSQ['2011']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2011sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2011sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2011sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2011sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2012广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2012']},
                {data: dataMap.dataSYXX['2012']},
                {data: dataMap.dataWGZL['2012']},
				{data: dataMap.dataFMSQ['2012']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2012sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2012sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2012sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2012sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2013广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2013']},
                {data: dataMap.dataSYXX['2013']},
                {data: dataMap.dataWGZL['2013']},
				{data: dataMap.dataFMSQ['2013']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2013sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2013sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2013sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2013sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2014广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2014']},
                {data: dataMap.dataSYXX['2014']},
                {data: dataMap.dataWGZL['2014']},
				{data: dataMap.dataFMSQ['2014']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2014sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2014sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2014sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2014sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2015广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2015']},
                {data: dataMap.dataSYXX['2015']},
                {data: dataMap.dataWGZL['2015']},
				{data: dataMap.dataFMSQ['2015']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2015sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2015sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2015sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2015sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2016广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
				{data: dataMap.dataFMZL['2016']},
                {data: dataMap.dataSYXX['2016']},
                {data: dataMap.dataWGZL['2016']},
				{data: dataMap.dataFMSQ['2016']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2016sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2016sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2016sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2016sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2017广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
			{data: dataMap.dataFMZL['2017']},
                 {data: dataMap.dataSYXX['2017']},
                {data: dataMap.dataWGZL['2017']},
				{data: dataMap.dataFMSQ['2017']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2017sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2017sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2017sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2017sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2018广东省专利数据统计',textStyle:{fontSize : 13}},
            series : [
			{data: dataMap.dataFMZL['2018']},
                 {data: dataMap.dataSYXX['2018']},
                {data: dataMap.dataWGZL['2018']},
				{data: dataMap.dataFMSQ['2018']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2018sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2018sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2018sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2018sum']}
                ]}
            ]
        }
    ]
};

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
	
	function _doQsearch(){
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
				$("#strChannels").val("14,15,16");
				$("#strSources").val("14,15,16");
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
//	var username = $('#username').attr('title');
//alert('username='+username);	
	if(username!=''){
//alert('username为空');
//		$('#username').val()='guest';
//		$('#password').val()='123456';
		$("#username").attr("value",username);//清空内容 
		$("#password").attr("value","123456");
		initLoginRequestData();
		location.href = "<%=basePath%>
	mytreehangye.do";
		}
	}
</script>
