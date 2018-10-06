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
    var pList = ['鄞州区','余姚市','慈溪市','宁海县','象山县','海曙区','奉化区','北仑区','江北区','镇海区'];
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
2009:[546,264,297,100,37,121,84,264,244,190],
2018:[1257,472,686,91,325,215,156,271,295,257],
2017:[4290,1914,2671,488,486,892,497,1362,1426,1500],
2016:[4560,1497,1472,441,380,610,379,1138,1201,2612],
2015:[3944,1100,1293,621,339,383,592,1432,954,1239],
2014:[3140,1044,1050,325,120,251,481,767,913,810],
2013:[2541,854,1239,272,159,400,277,647,811,722],
2012:[1676,459,855,151,90,294,125,466,533,564],
2011:[728,320,448,114,59,202,86,285,434,354],
2010:[612,326,406,117,76,143,100,280,323,293]


	});

dataMap.dataSYXX = dataFormatter({
	2009:[1661,718,1164,284,155,237,227,587,392,418],
	2018:[1302,605,1302,383,1040,260,242,488,286,253],
	2017:[3941,1520,3704,1040,1295,484,844,1627,1138,935],
	2016:[4488,1641,3666,1015,1900,485,813,2042,1264,1170],
	2015:[4739,1959,4252,1068,3559,561,843,2528,1336,2238],
	2014:[5298,1956,4324,991,1642,925,980,2177,1311,2303],
	2013:[9012,2285,5657,952,1714,3029,1892,2302,1007,2041],
	2012:[7104,1496,3666,745,846,1415,1253,1607,877,927],
	2011:[4190,1420,2971,556,755,549,736,1231,508,558],
	2010:[2785,1305,2207,377,576,381,448,1013,460,704]

});

dataMap.dataWGZL = dataFormatter({
	2009:[2327,1711,1792,755,61,301,281,375,471,193],
	2018:[953,815,957,370,50,125,49,273,114,80],
	2017:[5562,2181,3439,1578,147,407,327,764,387,304],
	2016:[6955,2711,3262,1934,127,331,306,780,477,289],
	2015:[7532,2456,3188,1915,143,269,364,954,736,461],
	2014:[5983,5261,3912,1613,100,287,283,846,306,490],
	2013:[8031,10114,5546,1090,67,342,329,938,868,645],
	2012:[12631,9312,8208,1322,562,651,476,960,1120,1145],
	2011:[8469,4103,4844,899,63,379,254,581,1599,343],
	2010:[4073,3008,2608,1171,143,395,303,625,789,439]
});

dataMap.dataFMSQ = dataFormatter({
	2009:[174,86,126,17,29,56,23,125,108,44],
	2018:[377,110,128,42,17,63,31,116,112,123],
	2017:[1612,596,606,225,110,226,161,577,632,654],
	2016:[1848,686,658,219,134,245,159,554,615,600],
	2015:[1579,535,616,189,98,233,205,499,616,491],
	2014:[456,138,201,56,49,61,42,133,152,156],
	2013:[744,182,291,76,47,113,60,163,356,225],
	2012:[547,204,292,78,44,114,57,207,320,250],
	2011:[559,214,246,62,38,84,40,159,206,149],
	2010:[292,115,191,41,27,74,42,129,145,58]
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
                	'鄞州区','余姚市','慈溪市','宁海县','象山县','海曙区','奉化区','北仑区','江北区','镇海区'
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
                max: 12631,
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
            title : {text: '                      2009宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2010宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2011宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2012宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2013宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2014宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2015宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2016宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2017宁波市专利数据统计',textStyle:{fontSize : 13}},
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
            title : {text: '                      2018宁波市专利数据统计',textStyle:{fontSize : 13}},
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
