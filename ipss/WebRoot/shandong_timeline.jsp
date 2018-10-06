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
%>



<%@ include file="jsp/zljs/include-head.jsp"%>
<%@ include file="jsp/zljs/include-head-nav.jsp"%>

<script src="analyse/echarts.js"></script>
<script src="analyse/theme/shine_grey.js"></script>
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
 


<div id="main" style="width: 900px;height:420px;margin-left:auto;margin-right:auto;"></div>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'),'shine_grey');

//"青岛市","济南市","烟台市","潍坊市","威海市","淄博市","泰安市"
//2017---170559
var value1 = [
{name: '青岛市', value:51156},
{name: '济南市', value:29450},
{name: '潍坊市', value:15127},
{name: '烟台市', value:10782},
{name: '济宁市', value:8526},
{name: '淄博市', value:7793},
{name: '威海市', value:7163},
{name: '临沂市', value:6629},
{name: '泰安市', value:5169},
{name: '滨州市', value:4800},
{name: '聊城市', value:4411},
{name: '东营市', value:4060},
{name: '德州市', value:3838},
{name: '菏泽市', value:3495},
{name: '枣庄市', value:3427},
{name: '莱芜市', value:2613},
{name: '日照市', value:2120}
];
//2016---173160
var value2 = [
{name: '青岛市', value:51855},
{name: '济南市', value:29529},
{name: '潍坊市', value:16091},
{name: '烟台市', value:10353},
{name: '济宁市', value:7982},
{name: '威海市', value:7884},
{name: '淄博市', value:7507},
{name: '临沂市', value:6535},
{name: '滨州市', value:4654},
{name: '泰安市', value:4504},
{name: '聊城市', value:4355},
{name: '东营市', value:4306},
{name: '菏泽市', value:4094},
{name: '德州市', value:3927},
{name: '枣庄市', value:3550},
{name: '日照市', value:3073},
{name: '莱芜市', value:2961}
];

//2015---167298
var value3 = [
{name: '青岛市', value:51014},
{name: '济南市', value:29884},
{name: '潍坊市', value:14950},
{name: '烟台市', value:9818},
{name: '淄博市', value:8419},
{name: '济宁市', value:7984},
{name: '临沂市', value:6335},
{name: '威海市', value:5920},
{name: '滨州市', value:4948},
{name: '泰安市', value:4490},
{name: '东营市', value:4031},
{name: '菏泽市', value:3627},
{name: '德州市', value:3612},
{name: '聊城市', value:3468},
{name: '枣庄市', value:3199},
{name: '莱芜市', value:2971},
{name: '日照市', value:2628}
];
//2014---124189
var value4 = [
{name: '青岛市', value:36226},
{name: '济南市', value:22005},
{name: '潍坊市', value:11502},
{name: '烟台市', value:7874},
{name: '淄博市', value:5872},
{name: '济宁市', value:5601},
{name: '威海市', value:4826},
{name: '泰安市', value:4623},
{name: '临沂市', value:4148},
{name: '滨州市', value:3829},
{name: '东营市', value:3619},
{name: '德州市', value:3075},
{name: '菏泽市', value:2373},
{name: '聊城市', value:2367},
{name: '枣庄市', value:2237},
{name: '莱芜市', value:2218},
{name: '日照市', value:1794}
];
//2013---116768
var value5 = [
{name: '青岛市', value:25386},
{name: '济南市', value:21357},
{name: '潍坊市', value:11394},
{name: '烟台市', value:7972},
{name: '济宁市', value:6823},
{name: '淄博市', value:6716},
{name: '泰安市', value:4742},
{name: '威海市', value:4716},
{name: '滨州市', value:4346},
{name: '临沂市', value:3865},
{name: '东营市', value:3645},
{name: '德州市', value:3492},
{name: '菏泽市', value:2624},
{name: '枣庄市', value:2518},
{name: '聊城市', value:2454},
{name: '莱芜市', value:2433},
{name: '日照市', value:2285}
];
//2012---99331
var value6 = [
{name: '济南市', value:19850},
{name: '青岛市', value:17797},
{name: '潍坊市', value:8613},
{name: '烟台市', value:8212},
{name: '济宁市', value:6063},
{name: '淄博市', value:5395},
{name: '泰安市', value:4573},
{name: '威海市', value:4374},
{name: '滨州市', value:4354},
{name: '临沂市', value:3512},
{name: '德州市', value:2956},
{name: '东营市', value:2873},
{name: '菏泽市', value:2427},
{name: '枣庄市', value:2313},
{name: '莱芜市', value:2182},
{name: '日照市', value:1932},
{name: '聊城市', value:1905}
];
//2011---73999
var value7 = [
{name: '济南市', value:14576},
{name: '青岛市', value:11445},
{name: '烟台市', value:6208},
{name: '潍坊市', value:6058},
{name: '济宁市', value:4789},
{name: '淄博市', value:4147},
{name: '威海市', value:3737},
{name: '泰安市', value:3562},
{name: '滨州市', value:3379},
{name: '临沂市', value:2861},
{name: '东营市', value:2382},
{name: '日照市', value:2129},
{name: '德州市', value:2004},
{name: '莱芜市', value:1828},
{name: '聊城市', value:1685},
{name: '菏泽市', value:1620},
{name: '枣庄市', value:1589}
];
//2010---61038
var value8 = [
{name: '济南市', value:12093},
{name: '青岛市', value:8760},
{name: '烟台市', value:5183},
{name: '潍坊市', value:4687},
{name: '济宁市', value:3916},
{name: '威海市', value:3766},
{name: '淄博市', value:3742},
{name: '泰安市', value:3217},
{name: '临沂市', value:2622},
{name: '东营市', value:2431},
{name: '德州市', value:1740},
{name: '聊城市', value:1729},
{name: '莱芜市', value:1709},
{name: '滨州市', value:1522},
{name: '枣庄市', value:1478},
{name: '日照市', value:1246},
{name: '菏泽市', value:1197}
];
//2009---44055
var value9 = [
{name: '济南市', value:8436},
{name: '青岛市', value:6035},
{name: '潍坊市', value:4043},
{name: '烟台市', value:3837},
{name: '济宁市', value:3257},
{name: '东营市', value:2829},
{name: '临沂市', value:2317},
{name: '威海市', value:2171},
{name: '泰安市', value:2114},
{name: '淄博市', value:1950},
{name: '聊城市', value:1144},
{name: '滨州市', value:1115},
{name: '德州市', value:1045},
{name: '莱芜市', value:1010},
{name: '枣庄市', value:995},
{name: '日照市', value:889},
{name: '菏泽市', value:868}
];
//2018---42310
/*
var value10 = [
{name: '青岛市', value:10791},
{name: '济南市', value:6504},
{name: '潍坊市', value:4366},
{name: '济宁市', value:2667},
{name: '烟台市', value:2613},
{name: '淄博市', value:2228},
{name: '威海市', value:2004},
{name: '临沂市', value:1784},
{name: '泰安市', value:1354},
{name: '东营市', value:1241},
{name: '聊城市', value:1138},
{name: '德州市', value:1110},
{name: '滨州市', value:1102},
{name: '菏泽市', value:1079},
{name: '枣庄市', value:1009},
{name: '莱芜市', value:727},
{name: '日照市', value:593}
];
*/
//2008---34801
var value10 = [
{name: '济南市', value:6584},
{name: '青岛市', value:4767},
{name: '烟台市', value:3177},
{name: '潍坊市', value:3127},
{name: '济宁市', value:3077},
{name: '东营市', value:2285},
{name: '临沂市', value:1668},
{name: '淄博市', value:1582},
{name: '泰安市', value:1441},
{name: '威海市', value:1405},
{name: '聊城市', value:1098},
{name: '莱芜市', value:900},
{name: '日照市', value:804},
{name: '枣庄市', value:784},
{name: '滨州市', value:746},
{name: '菏泽市', value:694},
{name: '德州市', value:662}
]
/*
var nameMap = {
		'United States of America':'美国',
		'China':'中国',
		'United Kingdom':'英国',
		'Russia':'俄罗斯',
		'South Korea':'韩国',
		'Germany':'德国',
		'France':'法国',
		'Italy':'意大利'
};
*/
option = {
    timeline: {
        playInterval: 1000,
        loop: true,
        bottom: "0.1%",
        symbolSize: 10,
        autoPlay: true,
        
        axisType: 'category',
        data: ['2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017']  
    },
    baseOption: {
        /*
    	visualMap: {
            max: 51855,
            calculable: true,
            inRange: {
                color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
            }
        },*/
		visualMap : {
			min : 0,
			max : 51855,
			text : [ '高', '低' ],
			realtime : false,
			calculable : true,
			inRange : {
				color : [ 'lightskyblue', 'yellow', 'orangered' ]
			}
		},
        series: [{
            type: 'map',
            map:'山东',
            roam: true,
            label: {
                normal: {
                    show: true
                },
                emphasis: {
                    textStyle: {
                        color: '#fff'
                    }
                }
            },
            
        }]
    },
    options: [{ title: {text: '                      2008山东省专利数据统计',textStyle:{fontSize : 13}},
        series: {
            data: value10
        } 
    }, { title: {text: '                      2009山东省专利数据统计',textStyle:{fontSize : 13}},
        series: {
            data: value9
        }
    }, { title: {text: '                      2010山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value8}}
    , { title: {text: '                      2011山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value7}}
    , { title: {text: '                      2012山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value6}}
    , { title: {text: '                      2013山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value5}}
    , { title: {text: '                      2014山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value4}}
    , { title: {text: '                      2015山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value3}}
    , { title: {text: '                      2016山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value2}}
    , { title: {text: '                      2017山东省专利数据统计',textStyle:{fontSize : 13}},series: {data: value1}}
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
		location.href = "<%=basePath%>mytreehangye.do";
	}
}
</script>
