<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts-all-3.js"></script>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
<script type="text/javascript">
/* window.setTimeout(one,800);
window.setTimeout(two,2800); */
var exp="${sessionScope.strWhere}";
window.onload=function() {
	$.ajax({
		type : "GET",
		url :  "/ipss/patentAnalysisXY.do",
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'exp' : exp,
			'xAxis' : "申请年",
			'yAxis' : "",
			'xAxisSize' : 5,
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			//alert(result);
			var one=JSON.parse(result)
			//var two=JSON.parse(one.results);
			//alert(one.results['2010年']);
			var myChart = echarts.init(document.getElementById('main'));
			var option = {
			        title: {
			            text: '申请趋势分析'
			        },
			        tooltip: {},
			        legend: {
			            data:['数量']
			        },
			        xAxis: {
			            data: ["2010","2011","2012","2013","2014"]
			        },
			        yAxis: {},
			        series: [{
			            name: '数量',
			            type: 'bar',
			            data: [ one.results['2010年'], one.results['2011年'], one.results['2012年'], one.results['2013年'], one.results['2014年'] ]
			        }]
			    };
			myChart.setOption(option);
			
			two();
		}
	});
}

function two() {
	$.ajax({
		type : "GET",
		url :  "/ipss/patentAnalysisXY.do",
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'exp' : exp,
			'xAxis' : "申请年",
			'yAxis' : "",
			'xAxisSize' : 10,
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			//alert(result);
			var one=JSON.parse(result)
			//var two=JSON.parse(one.results);
			//alert(one.results['2010年']);
			var myChart = echarts.init(document.getElementById('main2'));
			var option = {
			        title: {
			            text: '申请趋势分析'
			        },
			        tooltip: {},
			        legend: {
			            data:['数量']
			        },
			        xAxis: {
			            data: ["2005","2006","2007","2008","2009","2010","2011","2012","2013","2014"]
			        },
			        yAxis: {},
			        series: [{
			            name: '数量',
			            type: 'bar',
			            data: [one.results['2005年'], one.results['2006年'], one.results['2007年'], one.results['2008年'], one.results['2009年']
			            	,one.results['2010年'], one.results['2011年'], one.results['2012年'], one.results['2013年'], one.results['2014年'] ]
			        }]
			    };
			myChart.setOption(option);
		}
	});
}

function three() {
	$.ajax({
		type : "GET",
		url :  "/ipss/patentAnalysisXY.do",
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'exp' : exp,
			'xAxis' : "申请人",
			'yAxis' : "",
			'xAxisSize' : 20,
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			//alert(result);
			var one=JSON.parse(result)
			//var two=JSON.parse(one.results);
			//alert(one.results['2010年']);
			var myChart = echarts.init(document.getElementById('main3'));
			var option = {
			        title: {
			            text: '申请趋势分析'
			        },
			        tooltip: {},
			        legend: {
			            data:['数量']
			        },
			        xAxis: {
			            data: ["2005","2006","2007","2008","2009","2010","2011","2012","2013","2014"]
			        },
			        yAxis: {},
			        series: [{
			            name: '数量',
			            type: 'bar',
			            data: [one.results['2005年'], one.results['2006年'], one.results['2007年'], one.results['2008年'], one.results['2009年']
			            	,one.results['2010年'], one.results['2011年'], one.results['2012年'], one.results['2013年'], one.results['2014年'] ]
			        }]
			    };
			myChart.setOption(option);
		}
	});
}
</script>
<title>报告预览</title>
</head>
<body>
	<h1>全球专利监测分析</h1>
	
	<div id="main" style="width: 600px;height:400px;"></div>
	<script type="text/javascript">
	// 基于准备好的dom，初始化echarts实例
    // 指定图表的配置项和数据
    
    // 使用刚指定的配置项和数据显示图表。
    
	</script>
	<button onclick="one()">点击</button>
	<h2>专利总量分析</h2>
	<div id="main2" style="width: 600px;height:400px;"></div>
	<div id="all"></div>
	<h2>区域构成分析</h2>
	<div id="area"></div>
</body>
</html>