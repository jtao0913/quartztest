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
				<li><label class="radio" style="width: 150px"><input type="radio" name="area" value="cn" checked> CNIPA专利（中文）</label></li>
				<li><label class="radio" style="width: 160px"><input type="radio" name="area" value="fr"> 港澳台及海外（英文）</label></li>
			</ul>
		</div>
	</form>
 	</div>
 </div>
 <!--块状展示-->
 <div style="height:10px"></div>






<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<script src="analyse/echarts.js"></script>
<script src="analyse/theme/shine_grey.js"></script>

<div id="main" style="width: 1600px;height:420px;margin-left:auto;margin-right:auto;"></div>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'),'shine_grey');

var dataMap = {};
function dataFormatter(obj) {
//'济南市','青岛市','淄博市','枣庄市','东营市','烟台市','潍坊市','济宁市','泰安市','威海市','日照市','莱芜市','临沂市','德州市','聊城市','滨州市','菏泽市'
    var pList = ["北京市","天津市","河北省","山西省","内蒙古自治区","辽宁省","吉林省","黑龙江省","上海市","江苏省","浙江省","安徽省","福建省","江西省","山东省","河南省","湖北省","湖南省","广东省","广西壮族自治区","海南省","重庆市","四川省","贵州省","云南省","西藏自治区","陕西省","甘肃省","青海省","宁夏回族自治区","新疆维吾尔自治区","中国台湾","中国香港","中国澳门"];
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
    //max : 60000,
2009:[25069,5219,2167,1588,611,5680,1737,2779,17210,19265,12258,3044,2982,1124,10259,3629,4405,3774,28522,956,324,2359,4420,916,1453,38,3938,810,145,164,464,0,0,0],
2018:[19158,7295,2896,2016,466,5386,1717,2147,10853,46779,21657,18243,5549,2237,12994,8358,11183,5960,42228,9246,344,4067,18457,3068,1554,64,5686,1270,227,650,680,0,0,0],
2017:[99284,28515,13348,6289,2677,21584,7411,13475,55813,162555,83970,91977,24070,9575,70029,31558,39739,25473,165187,38061,1341,28287,47737,12395,7575,233,22498,5272,1166,2826,3201,0,0,0],
2016:[83469,27522,10714,5195,2056,17830,5719,12548,44021,144431,69189,73652,19901,5716,73080,20167,26859,17103,113581,27528,912,24012,37247,7744,5780,150,19795,4487,916,1552,2620,2179,0,0],
2015:[79723,22812,8917,5514,1913,19604,5126,11588,42048,136608,56255,61809,14271,5110,71651,19173,21810,14686,88976,29124,1010,18092,33056,7432,5394,88,24201,4050,812,1871,2380,9853,0,0],
2014:[70206,15790,6836,5381,1678,17111,4290,9325,37487,121481,41915,42121,10658,3695,52457,14243,16841,10938,70069,15944,857,11488,22838,3838,4154,92,16792,3589,540,1073,1795,3539,0,0],
2013:[54282,12234,6039,5124,1613,16579,3714,7089,33736,107184,34973,22060,8647,3156,34922,9594,12457,10083,58433,7547,836,8833,15744,3281,3388,72,14377,2604,317,983,1819,0,0,0],
2012:[45086,11140,5303,4569,1312,13156,3739,5616,32692,82974,27581,13586,7492,2661,25444,9171,9665,9146,52051,3811,762,7267,12145,2638,3235,97,10842,2089,214,598,1305,0,0,0],
2011:[31922,7804,3228,2535,936,7936,2464,3695,23367,41863,17539,6421,4974,1787,15491,6020,6283,5894,39680,1635,511,4392,7529,1251,2007,64,6586,1273,195,280,857,0,0,0],
2010:[28859,6235,2947,2263,762,7554,2092,3725,20159,30976,15611,4458,4108,1597,13102,4996,6310,4621,34508,1352,522,3611,6134,1134,2011,70,5359,1060,163,223,731,0,0,0]


	});

dataMap.dataSYXX = dataFormatter({
	2009:[9858,4003,4366,1943,792,8393,1875,3239,13065,21446,24482,3929,4761,1498,22333,6537,6148,4050,27122,1512,325,3121,6177,1246,1303,34,3294,759,92,275,1201,0,0,0],
	2018:[13779,9022,7152,2391,1745,5055,1948,2825,11948,42511,41212,12823,13644,5961,20877,12429,9533,6507,52429,2605,430,6407,10518,2733,3521,79,5269,2055,490,945,1737,0,0,0],
	2017:[46015,32391,21796,7724,4447,15823,6672,11395,39941,126492,114324,38296,39602,17612,67010,35818,28842,20339,168889,7764,1231,23260,33616,7984,10085,257,17014,6636,1079,3344,5592,0,0,0],
	2016:[45374,31185,19977,6455,4087,15901,6294,12144,34759,118861,127070,39915,42270,18028,67647,32693,27979,18639,118988,6768,1164,30835,32584,6590,8292,134,17331,5133,882,1896,4892,0,0,0],
	2015:[45684,27946,18767,5989,3664,15473,5511,12145,32587,118088,120971,40201,33336,13043,67900,32321,24404,18335,102569,6990,1051,24779,30734,6892,7104,51,15752,4378,672,1252,4978,7723,0,0],
	2014:[43746,19920,14025,5500,2845,13452,4442,10968,30548,100457,99147,36451,20764,7306,52372,22853,19423,15860,82227,6055,806,15662,23602,5071,5282,45,15361,3430,346,1021,3823,3687,0,0],
	2013:[36967,19299,13691,6008,2592,16705,4154,13291,32427,104547,111931,38282,23795,6272,63142,22499,20859,16090,82055,5182,722,17505,26601,4237,4565,47,14356,3360,295,925,3283,0,0,0],
	2012:[23597,13198,10303,4375,1806,14466,3384,8952,28165,72774,79430,24821,16246,4362,57060,17525,15074,12481,62722,3273,472,13197,17983,2863,3238,40,8773,2271,209,488,2288,0,0,0],
	2011:[19434,8477,7415,3156,1384,13327,2912,5838,23302,51217,56123,15590,12513,3106,43753,13224,11369,8694,50305,2537,313,8728,12683,1982,2264,21,7076,1400,140,430,2003,0,0,0],
	2010:[15344,6310,6424,2796,1172,11672,2739,4112,20004,37126,43648,7547,8771,2304,33392,10027,9381,7161,40760,1962,307,5788,11877,1712,1860,53,5529,1064,129,272,1860,0,0,0]

});

dataMap.dataWGZL = dataFormatter({
	2009:[3299,1433,1445,642,499,1481,566,663,13444,56861,47477,3084,5104,914,8635,3463,3180,2277,40873,787,192,3077,10751,478,1014,252,1260,221,186,585,471,0,0,0],
	2018:[2622,1241,1109,290,330,892,442,532,8102,24907,28633,1338,3660,568,6126,3033,1503,1444,30269,634,102,1512,7221,259,618,31,652,161,141,273,300,0,0,0],
	2017:[14868,3476,8552,1177,965,2966,1361,1879,12186,59181,70767,7470,19982,13185,14426,11667,6613,9671,117787,2962,465,5380,19027,2697,1892,121,8778,1695,261,241,1515,0,0,0],
	2016:[15524,3502,7913,1081,998,2956,1419,2019,10040,76063,72774,6927,18158,11520,12585,10169,6058,8770,103617,3224,373,7281,20785,1866,1968,55,24261,1628,195,169,1373,0,0,0],
	2015:[12461,4195,6910,1508,937,2777,918,2310,9727,96745,86649,6468,21095,8629,12072,9481,5524,8646,98878,2325,481,9384,23553,5587,2018,106,9696,1127,323,153,2718,1669,0,0],
	2014:[7297,2866,3569,1323,679,2113,779,1946,8207,78163,76325,6757,14069,5125,8933,6375,3660,6419,75495,1635,365,6194,17766,4221,1248,52,2471,825,154,149,757,571,0,0],
	2013:[5916,3098,3227,1474,834,2438,866,5783,8765,137952,87979,10076,12471,3216,9566,5332,5312,6363,75425,1663,198,5983,18113,2991,1243,28,2775,723,123,129,1218,0,0,0],
	2012:[5813,2883,2375,1218,585,2372,839,8337,11156,186113,91982,12671,9599,2364,9354,5000,4731,6220,66100,1555,205,4692,18328,2340,1113,88,1732,557,230,156,609,0,0,0],
	2011:[4964,2392,2151,779,471,2271,678,3588,15464,118638,61388,14077,6597,1540,9163,3515,4478,4302,55739,1062,128,4619,11650,617,947,43,1507,312,310,80,336,0,0,0],
	2010:[5682,2242,2242,878,579,2786,764,903,21498,80051,60790,5517,7165,1382,10775,4007,4848,3938,61895,1035,238,4375,17639,747,1147,60,2037,370,128,732,360,0,0,0]
});

dataMap.dataFMSQ = dataFormatter({
	2009:[9101,1973,682,611,181,1976,738,1116,6006,5035,4787,793,800,377,2828,1126,1496,1765,11784,321,73,817,1631,337,474,8,1321,216,38,48,118,0,0,0],
	2018:[10236,1220,1110,528,197,1591,632,954,4752,9004,6572,3002,1901,521,4466,1925,2488,1899,11740,913,113,1445,2432,387,506,21,1995,309,71,120,176,0,0,0],
	2017:[46092,5849,4926,2378,846,7711,3058,4948,20680,41517,28757,12443,8722,2238,19094,7918,10878,7909,45379,4555,359,6131,11369,1875,2259,42,8775,1341,240,657,943,0,0,0],
	2016:[41442,5273,4309,2478,874,6928,2485,4386,3902,41621,26494,15736,7135,1981,19848,6746,8588,7183,39412,5112,394,5028,10582,2046,2154,38,7503,1341,300,545,968,0,0,0],
	2015:[32920,4304,3583,2257,742,4296,2062,3810,16364,33098,21630,9928,5339,1458,15675,5055,7159,6315,30840,3659,401,3674,8443,1397,1915,35,6404,1152,175,419,881,5967,0,0],
	2014:[23141,3266,2244,1545,483,3966,1439,2429,11539,19321,6784,5119,3337,1029,10427,3492,4767,4110,22121,1866,360,2340,5584,1020,1438,50,4870,811,106,240,568,1776,0,0],
	2013:[21608,3311,2094,1387,605,4031,1578,2386,11329,17750,11567,4381,3146,962,9138,3299,4201,3777,21019,1304,467,2505,4811,808,1390,46,4402,813,92,182,557,0,0,0],
	2012:[20188,3355,1939,1336,554,4015,1600,2499,11432,15883,11709,2884,2900,912,7473,3264,4113,3327,22139,902,414,2438,4433,666,1297,61,4100,709,103,141,454,0,0,0],
	2011:[15275,2392,1404,1040,356,2981,1085,1871,8710,10448,8928,1910,1840,635,5592,2324,2984,2445,17482,603,235,1788,3064,564,948,20,2906,519,74,100,274,0,0,0],
	2010:[10451,1785,837,693,238,2217,748,1376,6479,6820,5925,1038,1100,362,3769,1397,1833,1838,12971,396,163,1003,2044,416,607,12,1742,326,31,57,169,0,0,0]
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
			//dataZoom，框选区域缩放，自动与存在的dataZoom控件同步，分别是启用，缩放后退
			/*
			dataZoom: {    
				show: true,    
				title: {    
				dataZoom: '区域缩放',    
				dataZoomReset: '区域缩放后退'    
				}    
			},
*/			
			//数据视图，打开数据视图，可设置更多属性,readOnly 默认数据视图为只读(即值为true)，可指定readOnly为false打开编辑功能    
			//dataView: {show: true, readOnly: true},    
			//magicType，动态类型切换，支持直角系下的折线图、柱状图、堆积、平铺转换    
			//magicType: {show: true, type: ['line', 'bar']},    
			//restore，还原，复位原始图表    
			//restore: {show: true},    
			//saveAsImage，保存图片（IE8-不支持）,图片类型默认为'png'    
			//saveAsImage: {show: true}    
			}
			}, 

		
		
        xAxis: [
            {
                'type':'category',
                'axisLabel':{'interval':0},
                'data':[
                	"北京市","\n天津市","河北省","\n山西省","内蒙古自治区","\n辽宁省","吉林省","\n黑龙江省","上海市","\n江苏省","浙江省","\n安徽省","福建省","\n江西省","山东省","\n河南省","湖北省","\n湖南省","广东省","\n广西壮族自治区","海南省","\n重庆市","四川省","\n贵州省","云南省","\n西藏自治区","陕西省","\n甘肃省","青海省","\n宁夏回族自治区","新疆维吾尔自治区","\n中国台湾","中国香港","\n中国澳门"
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
                max: 190000,
						splitArea:{
							show:true,
						},
            }
        ],
        series: [
            {name: '发明公开', type: 'bar',
			/*
                    'markLine':{
                        symbol : ['arrow','none'],
                        symbolSize : [4, 2],
                        itemStyle : {
                            normal: {
                                lineStyle: {color:'orange'},
                                barBorderColor:'orange',
                                label:{
                                    position:'left',
                                    formatter:function(params){
                                        return Math.round(params.value);
                                    }
                                }
                            }
                        },
                        'data':[{'type':'average','name':'平均值'}]
                    },*/
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
            title: {text: '                      2008中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2009中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2010中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2011中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2012中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2013中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2014中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2015中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2016中国专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2017中国专利数据统计',textStyle:{fontSize : 13}},
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
