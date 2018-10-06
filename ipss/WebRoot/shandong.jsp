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

			<form id="searchForm" class="form-inline" name="searchForm"
				method="post" target="_self">
				<input type="hidden" value="电子" name="content1" /> <input
					type="hidden" id="colname"
					value="申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" name="colname" />
				<!-- 
			<input type="hidden" value="cn" name="area" />
			 -->
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
		</div>
	</div>
	<!--块状展示-->
	<div style="height: 10px"></div>






	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="main"
		style="width: 1500px; height: 420px; margin-left: auto; margin-right: auto;"></div>
	<script type="text/javascript">
	var myChart = echarts.init(document.getElementById('main'),'shine_grey');

	var dataMap = {};
function dataFormatter(obj) {
//'济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'
    var pList = ['济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'];
    var temp;
    for (var year = 2008; year <= 2017; year++) {
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
    //max : 60000,
2009:[2305,1799,412,222,687,1139,505,290,733,620,72,172,347,124,297,266,269],
2008:[2063,1376,463,215,489,927,539,274,383,257,81,143,282,102,217,171,175],
2017:[12142,27260,2947,1148,1150,4624,5215,1786,1900,3302,570,674,1885,950,1455,1815,1206],
2016:[13811,29435,2405,929,1016,4721,5484,1635,1379,3237,1404,759,2218,797,1124,1476,1250],
2015:[14809,31420,2340,878,862,3902,4344,1648,1328,2222,867,699,2306,742,965,1316,1003],
2014:[10458,22309,1473,568,639,3450,3182,1128,2026,2021,301,574,1194,635,618,1286,595],
2013:[7905,10890,1348,467,457,2612,2762,1031,1802,1479,470,421,995,587,456,859,381],
2012:[6126,4914,1393,529,419,2414,1540,827,1921,1372,283,360,898,518,486,771,671],
2011:[3594,2952,793,221,336,1697,807,452,1304,1056,264,204,455,279,306,367,403],
2010:[3270,2387,767,192,433,1253,509,286,1136,913,117,177,436,300,344,307,275]


	});

dataMap.dataSYXX = dataFormatter({
2009:[4495,2470,1052,558,1531,1334,1963,2504,968,985,506,716,1203,588,654,455,350],
2008:[3673,2063,795,431,1336,1172,1494,2504,888,587,347,714,1055,335,715,410,257],
2017:[10429,15096,3291,1586,2402,3674,7086,5123,2507,2640,1154,1515,2696,2047,2131,2190,1443],
2016:[9834,13379,3617,1913,2767,3586,7671,5153,2463,2784,1289,1759,2251,2247,2531,2295,2108],
2015:[9909,12175,4816,1778,2645,4187,7911,5196,2542,2293,1425,1916,2173,2109,2002,2766,2057],
2014:[8090,9423,3162,1214,2646,3255,6298,3794,2156,1731,1219,1384,1490,1812,1337,1984,1377],
2013:[10302,10185,3816,1651,2861,4006,6760,5001,2568,2162,1599,1830,1681,2344,1614,2898,1863],
2012:[10617,9188,3007,1372,2073,4084,5787,4735,2267,1913,1443,1717,1553,1927,1019,2877,1479],
2011:[8814,5805,1954,1113,1727,2619,3993,3840,1896,1741,1673,1485,1478,1337,954,2412,912],
2010:[6560,3905,1464,959,1660,2100,2797,3151,1663,1976,915,1407,1233,1105,1071,813,613]

});

dataMap.dataWGZL = dataFormatter({
2009:[835,1230,283,127,491,1135,1396,377,322,513,281,80,601,300,108,346,210],
2008:[414,920,169,110,394,935,962,262,114,513,366,24,281,197,100,140,225],
2017:[1845,2859,785,414,88,1250,1545,1056,334,669,183,37,1481,532,449,276,623],
2016:[1329,2370,665,426,152,737,1598,619,251,1263,186,67,1356,538,311,262,455],
2015:[1538,2646,509,382,241,686,1454,638,312,849,170,60,1299,455,229,215,389],
2014:[893,1737,715,307,175,489,1256,350,206,544,104,44,980,460,198,180,295],
2013:[946,2330,1046,289,126,604,1360,282,110,641,90,45,711,358,138,259,231],
2012:[1106,2164,552,298,151,1079,868,250,174,750,124,29,735,343,132,471,128],
2011:[696,1613,1087,171,141,1507,968,299,184,664,151,35,654,281,121,435,156],
2010:[1161,1761,1302,255,178,1534,1196,351,237,791,188,48,814,292,117,320,229]
});

dataMap.dataFMSQ = dataFormatter({
2009:[801,536,203,88,120,229,179,85,91,53,30,42,166,33,85,48,39],
2008:[434,408,155,28,66,143,132,37,56,48,10,19,50,28,66,25,37],
2017:[5034,5941,770,279,420,1234,1281,561,428,552,213,387,567,309,376,519,223],
2016:[4555,6671,820,282,371,1309,1338,575,411,600,194,376,710,345,389,621,281],
2015:[3628,4773,754,161,283,1043,1241,502,308,556,166,296,557,306,272,651,178],
2014:[2564,2757,522,148,159,680,766,329,235,530,170,216,484,168,214,379,106],
2013:[2204,1981,506,111,201,750,512,509,262,434,126,137,478,203,246,330,148],
2012:[2001,1531,443,114,230,635,418,251,211,339,82,76,326,168,268,235,145],
2011:[1472,1075,313,84,178,385,290,198,178,276,41,104,274,107,304,165,148],
2010:[1102,707,209,72,160,295,185,128,181,86,26,77,139,43,197,82,80]
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
                '2008','2009','2010','2011', '2012','2013','2014','2015','2016','2017'
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
					'济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'
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
                max: 30000,
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
                center: ['75%', '40%'],
                radius: '28%'
            }
        ]
    },
    options: [
        {
            title: {text: '                      2008山东省专利数据统计',textStyle:{fontSize : 13}},
			tooltip : {'trigger':'axis'},
            series: [
				{data: dataMap.dataFMZL['2008']},
                {data: dataMap.dataSYXX['2008']},
                {data: dataMap.dataWGZL['2008']},
				{data: dataMap.dataFMSQ['2008']},
                {data: [
                    {name: '发明公开', value: dataMap.dataFMZL['2008sum']},
					{name: '实用新型', value: dataMap.dataSYXX['2008sum']},
                    {name: '外观专利', value: dataMap.dataWGZL['2008sum']},
					{name: '发明授权', value: dataMap.dataFMSQ['2008sum']}
                ]}
            ]
        },
        {
            title : {text: '                      2009山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2010山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2011山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2012山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2013山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2014山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2015山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2016山东省专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2017山东省专利数据统计',textStyle:{fontSize : 13}},
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
		location.href = "<%=basePath%>
	mytreehangye.do";
		}
	}
</script>
