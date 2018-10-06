<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<%@ include file="include-head-base.jsp"%>

<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/analyse/echarts.js"></script>
<script type="text/javascript" src="<%=basePath%>/analyse/echarts.min1.js"></script>
<script type="text/javascript" src="<%=basePath%>/analyse/china.js"></script>

<script type="text/javascript">
function getRandom(min, max){
    var r = Math.random() * (max - min);
    var re = Math.round(r + min);
    re = Math.max(Math.min(re, max), min)
     
    return re;
}
var random = getRandom(0, 100);

function convertundefined(excelId){
	var data = [];
	var mytable = document.getElementById(excelId);
	for(var i=0,rows=mytable.rows.length; i<rows; i++){
		for(var j=0,cells=mytable.rows[i].cells.length; j<cells; j++){
			if (mytable.rows[i].cells[j].innerHTML == "undefined"){
				mytable.rows[i].cells[j].innerHTML="0";
			}
		}
	}
}

window.onload=function() {
//	全球专利总量分析
	func1_1();
//	func1_2_2();
//	func2_5_1();
}
function iamge(myChart,source){
	myChart.setOption({
		animation:false,
	    legend: {},
	    tooltip: {},
	    dataset: {
	        source: source
	    },
	    xAxis: {type: 'category'},
	    yAxis: {},
	    series: [
	        {type: 'bar'},
	        {type: 'bar'},
	        {type: 'bar'}
	    ]
	});
}

function func1_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_1,2015,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {//响应成功时候的回调函数
			var one=JSON.parse(result);
			var myChart = echarts.init(document.getElementById('pic1'));
			//将json数据转为图片需要的数组数据
			var source = new Array();
			source[0]=new Array('product');
			for(var p in one){
				var i=1;
				for(var t in one[p]){
					source[0][i]=t;
					i++;
				}
				break;
			}
			var i=1;
			for(var p in one){
				source[i]=new Array(p);
				var j=1;
				for(var t in one[p]){
					source[i][j]=one[p][t];
					j++;
				}
				i++;
			}
			iamge(myChart,source);
			//获取图片base64码并存到隐藏域中
			var picInfo = myChart.getDataURL();
			$("#repor #onepic").val(picInfo);
			//表格填充
			var htm=$("#Excle0").html();
			var htm="<tr><th>编号</th><th>区域</th>";
			for(var a in one){
				htm=htm+"<th>"+a+"年</th>";
			}
			htm=htm+"</tr>";
			var a;
			for(var b in one){
				a=one[b];
				break;
			}
			var th=1;
			for(var w in a){
				htm=htm+"<tr><td>"+th+"</td><td>"+w+"</td>";
				for(var t in one){
					htm=htm+"<td>"+one[t][w]+"</td>";
				}
				htm=htm+"</tr>";
				th++;
			}
			$("#Excle0").html(htm);
			//获取表格信息并存到隐藏域中
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl0").val(htm);
			//将表格描述增加到隐藏域中
			for(var i=1;i<29;i++){
				$("#repor #dec"+i).val($("#des"+i).val());
			}
			convertundefined("Excle0");
			func1_2_1();
		}
	});
}
//1.2.1区域构成分析
function func1_2_1() {	
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_2_1,2016,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//			alert(result);
			var one=JSON.parse(result);
			$("#temp1").attr("style","display: none;");
			$("#temp2").attr("style","display: block;");
			//表格填充
			var htm=$("#Excle1").html();
			var htm="<tr><th>编号</th><th>区域</th>";
			for(var a in one){
				htm=htm+"<th>"+a+"年</th>";
			}
			htm=htm+"</tr>";
			var a;
			for(var b in one){
				a=one[b];
				break;
			}
			var th=1;
			for(var w in a){
				htm=htm+"<tr><td>"+th+"</td><td>"+w+"</td>";
				for(var t in one){
					htm=htm+"<td>"+one[t][w]+"</td>";
				}
				htm=htm+"</tr>";
				th++;
			}
			$("#Excle1").html(htm);
			//获取表格信息并存到隐藏域中
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl1").val(htm);
			convertundefined("Excle1");
			func1_2_2();
		}
	});
}
//1.2.2区域技术分析
function func1_2_2() {
$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_2_2,2016,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var one=JSON.parse(result);
			$("#temp3").attr("style","display: none;");
			$("#temp4").attr("style","display: block;");
			//表格填充
			var htm=$("#Excle2").html();
			var htm="<tr><th>编号</th><th>区域</th>";
			for(var a in one){
				htm=htm+"<th>"+a+"年</th>";
			}
			htm=htm+"</tr>";
			var a;
			for(var b in one){
				a=one[b];
				break;
			}
			var th=1;
			for(var w in a){
				htm=htm+"<tr><td>"+th+"</td><td>"+w+"</td>";
				for(var t in one){
					var tem=JSON.stringify(one[t][w]);
					if(tem!=null){
						tem=tem.replace("{","");tem=tem.replace("}","");
						tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
					}
					htm=htm+"<td>"+tem+"</td>";
				}
				htm=htm+"</tr>";
				th++;
			}
			$("#Excle2").html(htm);
			//获取表格信息并存到隐藏域中
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl2").val(htm);
			convertundefined("Excle2");
			func1_2_3();
		}
	});
}
//1.2.3区域申请人分析
function func1_2_3() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_2_3,2016,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp5").attr("style","display: none;");
			$("#temp6").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle63").html(Exl1[0]);$("#Excle64").html(Exl1[1]);$("#Excle65").html(Exl1[2]);
			var num=66;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				$("#Excle"+num).html(p);
				num=num+4;
			}
			num=67;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem=JSON.stringify(a[p]);
				tem=tem.replace("{","");tem=tem.replace("}","");
				tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
				$("#Excle"+num).html(tem);
				num=num+4;
			}
			num=68;
			for(var p in b){//遍历json对象的每个key/value对,p为key
				var tem=JSON.stringify(b[p]);
				tem=tem.replace("{","");tem=tem.replace("}","");
				tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
				$("#Excle"+num).html(tem);
				num=num+4;
			}
			num=69;
			for(var p in c){//遍历json对象的每个key/value对,p为key
				var tem=JSON.stringify(c[p]);
				tem=tem.replace("{","");tem=tem.replace("}","");
				tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
				$("#Excle"+num).html(tem);
				num=num+4;
			}
			var htm=$("#Excle64").html();
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl64").val(htm);
			func1_3_1();
		}	
	});
}
//1.3.1技术构成分析
function func1_3_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_3_1,2016,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp7").attr("style","display: none;");
			$("#temp8").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle90").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle90").html(htm);
			
			var mytable = document.getElementById("Excle90");
//			var rows=mytable.rows.length;
//			alert("rows="+rows);			
			var data = [];
			for(var i=0,rows=mytable.rows.length; i<rows; i++){
//				alert("mytable.rows["+i+"].cells.length="+mytable.rows[i].cells.length);
				for(var j=0,cells=mytable.rows[i].cells.length; j<cells; j++){
//					alert("mytable.rows[i].cells["+j+"].innerHTML="+mytable.rows[i].cells[j].innerHTML);
//					a[i][j] = mytable.rows[i].cells[j].innerHTML;
					if(mytable.rows[i].cells[j].innerHTML==null){
						mytable.rows[i].cells[j].innerHTML="0";
					}	
				}
			}
			
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl93").val(htm);
			func1_3_2();
		}	
	});
}
//1.3.2技术区域分析
function func1_3_2() {
//	alert("func1_3_2......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_3_2,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp9").attr("style","display: none;");
			$("#temp10").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle95").html(Exl1[0]);$("#Excle96").html(Exl1[1]);$("#Excle97").html(Exl1[2]);
			var htm= $("#Excle94").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle94").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl94").val(htm);
			func1_3_3();
		}	
	});
}
//1.3.3技术申请人分析
function func1_3_3() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_3_3,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp11").attr("style","display: none;");
			$("#temp12").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle99").html(Exl1[0]);$("#Excle100").html(Exl1[1]);$("#Excle101").html(Exl1[2]);
			var htm= $("#Excle98").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle98").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl98").val(htm);
			func1_4_1();
		}	
	});
}
//1.4.1申请人构成分析
function func1_4_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_1_4_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//			alert(result);
			
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp13").attr("style","display: none;");
			$("#temp14").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle102").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle102").html(htm);
			
			convertundefined("Excle102");
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl102").val(htm);
			func2_1();
		}
	});
}

//2.1专利总量分析
function func2_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {//响应成功时候的回调函数
			var one=JSON.parse(result);
			var myChart = echarts.init(document.getElementById('pic2'));
			myChart.setOption({
				animation:false,
			    legend: {},
			    tooltip: {},
			    dataset: {
			        source: [
			            ['product', '中国', '广东省'],
			            ['2018', one['2018']['中国'], one['2018']['广东省']],
			            ['2017', one['2017']['中国'], one['2017']['广东省']],
			            ['2016', one['2016']['中国'], one['2017']['广东省']],
			        ]
			    },
			    xAxis: {type: 'category'},
			    yAxis: {},
			    series: [
			        {type: 'bar'},
			        {type: 'bar'},
			    ]
			});
			//获取图片base64码并存到隐藏域中
			var picInfo = myChart.getDataURL();
			$("#repor #twopic").val(picInfo);
			//表格填充
			$("#Excle110").html(one['2018']['中国']);$("#Excle111").html(one['2017']['中国']);$("#Excle112").html(one['2016']['中国']);
			$("#Excle113").html(one['2018']['广东省']);$("#Excle114").html(one['2017']['广东省']);$("#Excle115").html(one['2016']['广东省']);
			//获取表格信息并存到隐藏域中
			for(var i=110;i<116;i++){
				$("#ecl"+i).val($("#Excle"+i).html());
			}
			func2_2();
		}
	});
}
//2.2专利类型分析
function func2_2() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_2,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {//响应成功时候的回调函数
//alert("func2_2......"+result);
			var one=JSON.parse(result);
			$("#temp15").attr("style","display: none;");
			$("#temp16").attr("style","display: block;");
			//表格填充
			$("#Excle120").html(one['2018']['发明公布']);$("#Excle121").html(one['2017']['发明公布']);$("#Excle122").html(one['2016']['发明公布']);
			$("#Excle123").html(one['2018']['实用新型']);$("#Excle124").html(one['2017']['实用新型']);$("#Excle125").html(one['2016']['实用新型']);
			$("#Excle126").html(one['2018']['外观设计']);$("#Excle127").html(one['2017']['外观设计']);$("#Excle128").html(one['2016']['外观设计']);
			$("#Excle1260").html(one['2018']['发明授权']);$("#Excle1261").html(one['2017']['发明授权']);$("#Excle1262").html(one['2016']['发明授权']);
			//获取表格信息并存到隐藏域中
			for(var i=120;i<129;i++){
				$("#ecl"+i).val($("#Excle"+i).html());
			}
			func2_3_1();
		}
	});
}
//2.3.1省市分布分析
function func2_3_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_3_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert("func2_3_1......"+result);
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp17").attr("style","display: none;");
			$("#temp18").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle129").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle129").html(htm);
			
			convertundefined("Excle129");
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl129").val(htm);
			func2_4_1();
		}
	});
}
//2.4.1技术构成分析
function func2_4_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_4_1,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp19").attr("style","display: none;");
			$("#temp20").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle133").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle133").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl133").val(htm);
			func2_4_2();
		}
	});
}
//2.4.2技术区域分析
function func2_4_2() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_4_2,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp21").attr("style","display: none;");
			$("#temp22").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle95").html(Exl1[0]);$("#Excle96").html(Exl1[1]);$("#Excle97").html(Exl1[2]);
			var htm= $("#Excle137").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle137").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl137").val(htm);
			func2_4_3();
		}	
	});
}
//2.4.3技术申请人分析
function func2_4_3() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_4_3,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp23").attr("style","display: none;");
			$("#temp24").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle95").html(Exl1[0]);$("#Excle96").html(Exl1[1]);$("#Excle97").html(Exl1[2]);
			var htm= $("#Excle141").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle141").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl141").val(htm);
			func2_5_1();
		}	
	});
}
//2.5.1申请人构成分析
function func2_5_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_5_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert(result);
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp25").attr("style","display: none;");
			$("#temp26").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle145").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle145").html(htm);
			convertundefined("Excle145");
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl145").val(htm);
			func2_6_1();
		}
	});
}
//2.6.1发明人构成分析
function func2_6_1() {
//	alert("func2_6_1......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_6_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp27").attr("style","display: none;");
			$("#temp28").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle149").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle149").html(htm);
			convertundefined("Excle149");
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl149").val(htm);
			func2_7_1();
		}
	});
}
//2.7.1法律状态总体构成分析
function func2_7_1() {
//	alert("func2_7_1......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_7_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert("func2_7_1......"+result);
			var one=JSON.parse(result);
			$("#temp29").attr("style","display: none;");
			$("#temp30").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			$("#Excle157").html(one['2018']['有效']);$("#Excle158").html(one['2017']['有效']);$("#Excle159").html(one['2016']['有效']);
			$("#Excle160").html(one['2018']['无效']);$("#Excle161").html(one['2017']['无效']);$("#Excle162").html(one['2016']['无效']);
			$("#Excle163").html(one['2018']['在审']);$("#Excle164").html(one['2017']['在审']);$("#Excle165").html(one['2016']['在审']);
//			$("#Excle166").html(one['2018']['不确定']);$("#Excle167").html(one['2017']['不确定']);$("#Excle168").html(one['2016']['不确定']);
			//获取表格信息
			var htm= $("#Excle153").html();
			$("#Excle153").html(htm);
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl153").val(htm);
			func2_7_2();
		}
	});
}
//2.7.2法律状态区域构成分析
function func2_7_2() {
//	alert("func2_7_2......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_2_7_2,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert("func2_7_2......"+result);		
			var Exl1=JSON.parse(result);
			var a=Exl1['有效'];var b=Exl1['无效'];var c=Exl1['在审'];//var d=Exl1['不确定'];
			$("#temp31").attr("style","display: none;");
			$("#temp32").attr("style","display: block;");
			var htm= $("#Excle169").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
//				htm=htm+"<tr><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td><td>"+d[p]+"</td></tr>";
				htm=htm+"<tr><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
			}
			$("#Excle169").html(htm);
			convertundefined("Excle169");
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl169").val(htm);		
		
			func3_1();
		}
	});
}
//3.1专利总量分析
function func3_1() {
//alert("func3_1......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {//响应成功时候的回调函数
			var one=JSON.parse(result);
//alert("func3_1......"+result);
			var myChart = echarts.init(document.getElementById('pic3'));
			myChart.setOption({
				animation:false,
			    legend: {},
			    tooltip: {},
			    dataset: {
			    /*
			    	source: [
			            ['product', '广东省'],
			            ['2018', one['2018']['广东省']],
			            ['2017', one['2017']['广东省']],
			            ['2016', one['2017']['广东省']],
			        ]
			    */
			        source: [
			            ['product', '广东省'],
			            ['2018', one['2018']],
			            ['2017', one['2017']],
			            ['2016', one['2017']],
			        ]
			    },
			    xAxis: {type: 'category'},
			    yAxis: {},
			    series: [
			        {type: 'bar'},
			    ]
			});
			//获取图片base64码并存到隐藏域中
			var picInfo = myChart.getDataURL();
			$("#repor #threepic").val(picInfo);
			//表格填充
//			$("#Excle174").html(one['2018']['广东省']);$("#Excle175").html(one['2017']['广东省']);$("#Excle176").html(one['2016']['广东省']);
			$("#Excle174").html(one['2018']);$("#Excle175").html(one['2017']);$("#Excle176").html(one['2016']);
			//获取表格信息并存到隐藏域中
			
			for(var i=174;i<177;i++){
				$("#ecl"+i).val($("#Excle"+i).html());
			}
			
			func3_2();
		}
	});
}
//3.2专利类型分析
function func3_2() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_2,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {//响应成功时候的回调函数
			var one=JSON.parse(result);
			$("#temp33").attr("style","display: none;");
			$("#temp34").attr("style","display: block;");
			//表格填充
			$("#Excle181").html(one['2018']['发明公布']);$("#Excle182").html(one['2017']['发明公布']);$("#Excle183").html(one['2016']['发明公布']);
			$("#Excle184").html(one['2018']['实用新型']);$("#Excle185").html(one['2017']['实用新型']);$("#Excle186").html(one['2016']['实用新型']);
			$("#Excle187").html(one['2018']['外观设计']);$("#Excle188").html(one['2017']['外观设计']);$("#Excle189").html(one['2016']['外观设计']);
			//获取表格信息并存到隐藏域中
			for(var i=181;i<190;i++){
				$("#ecl"+i).val($("#Excle"+i).html());
			}
			func3_3();
		}
	});
}
//3.3地区分析
function func3_3() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_3,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp35").attr("style","display: none;");
			$("#temp36").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle190").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle190").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl190").val(htm);
			func3_4_1();
		}
	});
}
//3.4.1技术构成分析
function func3_4_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_4_1,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp37").attr("style","display: none;");
			$("#temp38").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle194").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle194").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl194").val(htm);
			func3_4_2();
		}
	});
}
//3.4.2技术区域分析
function func3_4_2() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_4_2,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp39").attr("style","display: none;");
			$("#temp40").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle95").html(Exl1[0]);$("#Excle96").html(Exl1[1]);$("#Excle97").html(Exl1[2]);
			var htm= $("#Excle198").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle198").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl198").val(htm);
			func3_4_3();
		}
	});
}
//3.4.3技术申请人分析
function func3_4_3() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_4_3,2014,2018,",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp41").attr("style","display: none;");
			$("#temp42").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle95").html(Exl1[0]);$("#Excle96").html(Exl1[1]);$("#Excle97").html(Exl1[2]);
			var htm= $("#Excle202").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				var tem1=JSON.stringify(a[p]);
				tem1=tem1.replace("{","");tem1=tem1.replace("}","");
				tem1=tem1.replace(/\"/g,"");tem1=tem1.replace(/\,/g,"</br>");
				var tem2=JSON.stringify(a[p]);
				tem2=tem2.replace("{","");tem2=tem1.replace("}","");
				tem2=tem2.replace(/\"/g,"");tem2=tem1.replace(/\,/g,"</br>");
				var tem3=JSON.stringify(a[p]);
				tem3=tem3.replace("{","");tem3=tem3.replace("}","");
				tem3=tem3.replace(/\"/g,"");tem3=tem3.replace(/\,/g,"</br>");
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+tem1+"</td><td>"+tem2+"</td><td>"+tem3+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle202").html(htm);
			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl202").val(htm);
			func3_5_1();
		}	
	});
}
//3.5.1申请人构成分析
function func3_5_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_5_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert("func3_5_1......"+result);
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp43").attr("style","display: none;");
			$("#temp44").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle206").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle206").html(htm);
			convertundefined("Excle206");
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl206").val(htm);
			func3_6_1();
		}
	});
}
//3.6.1发明人构成分析
function func3_6_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_6_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var Exl1=JSON.parse(result);
			var a=Exl1[2018];var b=Exl1[2017];var c=Exl1[2016];
			$("#temp45").attr("style","display: none;");
			$("#temp46").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			var htm= $("#Excle210").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+hang+"</td><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
				hang=hang+1;
			}
			$("#Excle210").html(htm);
			convertundefined("Excle210");
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl210").val(htm);
			func3_7_1();
		}
	});
}
//3.7.1法律状态总体构成分析
function func3_7_1() {
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_7_1,2014,2018",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
			var one=JSON.parse(result);
			$("#temp47").attr("style","display: none;");
			$("#temp48").attr("style","display: block;");
			//填充表格  第一行未定（时间是否固定不确定）
			//$("#Excle91").html(Exl1[0]);$("#Excle92").html(Exl1[1]);$("#Excle93").html(Exl1[2]);
			$("#Excle218").html(one['2018']['有效']);$("#Excle219").html(one['2017']['有效']);$("#Excle220").html(one['2016']['有效']);
			$("#Excle221").html(one['2018']['无效']);$("#Excle222").html(one['2017']['无效']);$("#Excle223").html(one['2016']['无效']);
			$("#Excle224").html(one['2018']['在审']);$("#Excle225").html(one['2017']['在审']);$("#Excle226").html(one['2016']['在审']);
//			$("#Excle227").html(one['2018']['不确定']);$("#Excle228").html(one['2017']['不确定']);$("#Excle229").html(one['2016']['不确定']);
			//获取表格信息
			var htm= $("#Excle214").html();
			$("#Excle214").html(htm);
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl214").val(htm);
			func3_7_2();
		}
	});
}
//3.7.2法律状态区域构成分析
function func3_7_2() {
//alert("func3_7_2......");
	$.ajax({
		type : "GET",
		url :  "<%=basePath%>/patentAnalysisXYcopy.do?"+random,
		data : {
			'dbs' : "fmzl_ft,syxx_ft,wgzl_ab,fmsq_ft",
			'hangye' : "gd_zbzz_3_7_2",
			'xAxis' : "",
			'yAxis' : "",
			'xAxisSize' : "",
			'yAxisSize' : "",
			'cnfr' : ""
		},
		"dataType" : "json",
		"success" : function(result) {// 响应成功时候的回调函数
//alert(result);
			var Exl1=JSON.parse(result);
			var a=Exl1['有效'];var b=Exl1['无效'];var c=Exl1['在审'];//var d=Exl1['不确定'];
			$("#temp49").attr("style","display: none;");
			$("#temp50").attr("style","display: block;");
			var htm= $("#Excle230").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
//				htm=htm+"<tr><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td><td>"+d[p]+"</td></tr>";
				htm=htm+"<tr><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
			}
			$("#Excle230").html(htm);			
			//将表格数据存入隐藏域
			htm=htm.replace(/\</g,"{");
			htm=htm.replace(/\>/g,"}");
			$("#ecl230").val(htm);
			//底部按钮控制，全部方法完成后放在最后一个方法最后
			$("#sub").val("生成报告");$("#sub").attr("disabled",false);
		}
	});
}
</script>
<script type="text/javascript">
	function blur1(){
		$("#repor #dec1").val($("#des1").val());
    }
	function blur2(){
		$("#repor #dec2").val($("#des2").val());
    }
	function blur3(){
		$("#repor #dec3").val($("#des3").val());
    }
	function blur4(){
		$("#repor #dec4").val($("#des4").val());
    }
	function blur5(){
		$("#repor #dec5").val($("#des5").val());
    }
	function blur6(){
		$("#repor #dec6").val($("#des6").val());
    }
	function blur7(){
		$("#repor #dec7").val($("#des7").val());
    }
	function blur8(){
		$("#repor #dec8").val($("#des8").val());
    }
	function blur9(){
		$("#repor #dec9").val($("#des9").val());
    }
	function blur10(){
		$("#repor #dec10").val($("#des10").val());
    }
	function blur11(){
		$("#repor #dec11").val($("#des11").val());
    }
	function blur12(){
		$("#repor #dec12").val($("#des12").val());
    }
	function blur13(){
		$("#repor #dec13").val($("#des13").val());
    }
	function blur14(){
		$("#repor #dec14").val($("#des14").val());
    }
	function blur15(){
		$("#repor #dec15").val($("#des15").val());
    }
	function blur16(){
		$("#repor #dec16").val($("#des16").val());
    }
	function blur17(){
		$("#repor #dec17").val($("#des17").val());
    }
	function blur18(){
		$("#repor #dec18").val($("#des18").val());
    }
	function blur19(){
		$("#repor #dec19").val($("#des19").val());
    }
	function blur20(){
		$("#repor #dec20").val($("#des20").val());
    }
	function blur21(){
		$("#repor #dec21").val($("#des21").val());
    }
	function blur22(){
		$("#repor #dec22").val($("#des22").val());
    }
	function blur23(){
		$("#repor #dec23").val($("#des23").val());
    }
	function blur24(){
		$("#repor #dec24").val($("#des24").val());
    }
	function blur25(){
		$("#repor #dec25").val($("#des25").val());
    }
	function blur26(){
		$("#repor #dec26").val($("#des26").val());
    }
	function blur27(){
		$("#repor #dec27").val($("#des27").val());
    }
	function blur28(){
		$("#repor #dec28").val($("#des28").val());
    }
</script>
<style type="text/css">
table {
  margin-top:15px;
  border-collapse:collapse;
  border:1px solid #aaa;
  width:100%;
}
table th {
  vertical-align:baseline;
  padding:5px 15px 5px 6px;
  background-color:#3F3F3F;
  border:1px solid #3F3F3F;
  text-align:left;
  color:#fff;
}
table td {
  vertical-align:text-top;
  padding:6px 15px 6px 6px;
  border:1px solid #aaa;
}
table tr:nth-child(odd) {
  background-color:#F5F5F5;
}
table tr:nth-child(even) {
  background-color:#fff;
}
</style>
<title>报告预览</title>
</head>
<body>
	<center>
	<form id="repor" name="repor" action="/ipss/SearchReportServlet" method="post" target="_blank">
	<div style="width: 1000px;">
	<h1>第一章 全球专利监测分析</h1>
	<h2>1.1 专利总量分析</h2>
	<textarea rows="3" cols="80" id="des1" name="des1" onblur="blur1()">通过对全球专利总量的分析，可以看出在一定时间段内全球专利的数量趋势，查看在大趋势下有无反常趋势数据。</textarea>
	<div id="pic1" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利总量分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<table id="Excle0" style="width: 70%;">
	</table>
	<h2>1.2 区域分析</h2>
	<h2>1.2.1 区域构成分析</h2>
	<textarea rows="3" cols="80" id="des2" name="des2" onblur="blur2()">通过分析全球区域构成，可以看出在相关行业有哪些国家或地区占据优势，数量的多少代表了该国家或地区所在领域的技术发展状况。</textarea>
	<div id="temp1" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="区域构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp2" style="display: none;">
		<table id="Excle1" style="width: 70%;">
		</table>
		</div>
	<h2>1.2.2 区域技术分析</h2>
	<textarea rows="3" cols="80" id="des3" name="des3" onblur="blur3()">通过对区域技术的分析，可以看出该国家或地区在相关领域的详细技术发展状况。</textarea>
	<div id="temp3" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="区域技术分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp4" style="display: none;">
		<table id="Excle2" style="width: 800px;">
		</table>
		</div>
	<h2>1.2.3 区域申请人分析</h2>
	<textarea rows="3" cols="80" id="des4" name="des4" onblur="blur4()">通过对区域申请人的分析，可以看出相关国家或地区的个人或集体在相关行业的布局以及在相关行业的实力。</textarea>
	<div id="temp5" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="区域申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp6" style="display: none;">
		<table id="Excle64" style="width: 800px;">
			<tr>
				<th>排名</th><th>区域</th><th id="Excle63">2018年</th><th>2017年</th><th id="Excle65">2016年</th>
			</tr>
			<tr>
				<td>1</td><td id="Excle66">加载中</td><td id="Excle67">加载中</td><td id="Excle68">加载中</td><td id="Excle69">加载中</td>
			</tr>
			<tr>
				<td>2</td><td id="Excle70">加载中</td><td id="Excle71">加载中</td><td id="Excle72">加载中</td><td id="Excle73">加载中</td>
			</tr>
			<tr>
				<td>3</td><td id="Excle74">加载中</td><td id="Excle75">加载中</td><td id="Excle76">加载中</td><td id="Excle77">加载中</td>
			</tr>
			<tr>
				<td>4</td><td id="Excle78">加载中</td><td id="Excle79">加载中</td><td id="Excle80">加载中</td><td id="Excle81">加载中</td>
			</tr>
			<tr>
				<td>5</td><td id="Excle82">加载中</td><td id="Excle83">加载中</td><td id="Excle84">加载中</td><td id="Excle85">加载中</td>
			</tr>
			<tr>
				<td>6</td><td id="Excle86">加载中</td><td id="Excle87">加载中</td><td id="Excle88">加载中</td><td id="Excle89">加载中</td>
			</tr>
		</table>
		</div>
	<h2>1.3 技术分析</h2>
	<h2>1.3.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des5" name="des5" onblur="blur5()">通过对技术构成的分析，可以看出相关行业技术的发展状况，以及此产业在行业中发展的状况和占据的位置。</textarea>
	<div id="temp7" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp8" style="display: none;">
		<table id="Excle90" style="width: 800px;">
			<tr>
				<th>排名</th><th>技术</th><th>2018年</th><th>2017年</th><th>2016年</th>
			</tr>
		</table>
		</div>
	<h2>1.3.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des6" name="des6" onblur="blur6()">通过对技术区域的分析，可以查看该国家或地区在相关技术产业的专利布局状况以及相关技术展业的发展状况。</textarea>
	<div id="temp9" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp10" style="display: none;">
		<table id="Excle94" style="width: 800px;">
			<tr>
				<th>排名</th><th>技术</th><th id="Excle95">2018年</th><th id="Excle96">2017年</th><th id="Excle97">2016年</th>
			</tr>
		</table>
		</div>
	<h2>1.3.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des7" name="des7" onblur="blur7()">通过对技术申请人的分析，可以看出在有哪些个人或集体在相关技术产业有布局并且能够查看这些个人或集体在相关技术产业的专利布局状况。</textarea>
	<div id="temp11" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp12" style="display: none;">
		<table id="Excle98" style="width: 800px;">
			<tr>
				<th>排名</th><th>技术</th><th id="Excle99">2018年</th><th id="Excle100">2017年</th><th id="Excle101">2016年</th>
			</tr>
		</table>
		</div>
	<h2>1.4 申请人分析</h2>
	<h2>1.4.1 构成申请人分析</h2>
	<textarea rows="3" cols="80" id="des8" name="des8" onblur="blur8()">通过对申请人构成的分析，可以看出相关个人或集体历年以来的专利申请状况，从而看出该个人或集体在相关产业的专利布局状况。</textarea>
	<div id="temp13" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="构成申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp14" style="display: none;">
		<table id="Excle102" style="width: 800px;">
			<tr>
				<th>排名</th><th>申请人</th><th id="Excle103">2018年</th><th id="Excle104">2017年</th><th id="Excle105">2016年</th>
			</tr>
		</table>
		</div>
	<h2>第二章 中国专利监测分析</h2>
	<h2>2.1 专利总量分析</h2>
	<textarea rows="3" cols="80" id="des9" name="des9" onblur="blur9()">通过对中国专利总量的分析，可以看出在一定时间段内全球专利的数量趋势，查看在大趋势下有无反常趋势数据。</textarea>
	<div id="pic2" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利总量分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<table id="Excle106">
		<tr>
			<th>编号</th><th>地域</th><th id="Excle107">2018年</th><th id="Excle108">2017年</th><th id="Excle109">2016年</th>
		</tr>
		<tr>
			<td>1</td><td>中国</td><td id="Excle110">加载中</td><td id="Excle111">加载中</td><td id="Excle112">加载中</td>
		</tr>
		<tr>
			<td>2</td><td>广东省</td><td id="Excle113">加载中</td><td id="Excle114">加载中</td><td id="Excle115">加载中</td>
		</tr>
	</table>
	<h2>2.2 专利类型分析</h2>
	<textarea rows="3" cols="80" id="des10" name="des10" onblur="blur10()">通过对专利类型的分析，可以看出近几年专利主要属于什么类型，借此可判断相关行业的发展态势。</textarea>
	<div id="temp15" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp16" style="display: none;">
		<table id="Excle116" style="width: 800px;">
			<tr>
				<th>排名</th><th>类型</th><th id="Excle117">2018年</th><th id="Excle118">2017年</th><th id="Excle119">2016年</th>
			</tr>
			<tr>
				<td>1</td><td>发明公布</td><td id="Excle120">加载中</td><td id="Excle121">加载中</td><td id="Excle122">加载中</td>
			</tr>
			<tr>
				<td>2</td><td>实用新型</td><td id="Excle123">加载中</td><td id="Excle124">加载中</td><td id="Excle125">加载中</td>
			</tr>
			<tr>
				<td>3</td><td>外观设计</td><td id="Excle126">加载中</td><td id="Excle127">加载中</td><td id="Excle128">加载中</td>
			</tr>
			<tr>
				<td>3</td><td>发明授权</td><td id="Excle1260">加载中</td><td id="Excle1261">加载中</td><td id="Excle1262">加载中</td>
			</tr>
		</table>
		</div>
	<h2>2.3 国省分布状况分析</h2>
	<h2>2.3.1 省市分布分析</h2>
	<textarea rows="3" cols="80" id="des11" name="des11" onblur="blur11()">通过对省市分布的分析，可以看出我国各省市在相关行业的专利布局状况。</textarea>
	<div id="temp17" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="省市分布分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp18" style="display: none;">
		<table id="Excle129" style="width: 800px;">
			<tr>
				<th>编号</th><th>区域</th><th id="Excle130">加载中</th><th id="Excle131">加载中</th><th id="Excle132">加载中</th>
			</tr>
		</table>
		</div>
	<h2>2.4 技术分析</h2>
	<h2>2.4.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des12" name="des12" onblur="blur12()">通过对技术构成的分析，可以看出我国在相关行业的各个产业的详细发展状况。</textarea>
	<div id="temp19" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp20" style="display: none;">
		<table id="Excle133" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle134">2018年</th><th id="Excle135">2017年</th><th id="Excle136">2018</th>
			</tr>
		</table>
		</div>
	<h2>2.4.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des13" name="des13" onblur="blur13()">通过对技术区域的分析，可以看出在相关产业具体到我国相关省份的具体状况，查看该省份在相关产业的专利布局状况。</textarea>
	<div id="temp21" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术区域分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp22" style="display: none;">
		<table id="Excle137" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle138">2018年</th><th id="Excle139">2017年</th><th id="Excle140">2016年</th>
			</tr>
		</table>
		</div>
	<h2>2.4.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des14" name="des14" onblur="blur14()">通过对技术申请人的分析，可以看出国内部分个人或集体在相关产业的专利布局状况。</textarea>
	<div id="temp23" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp24" style="display: none;">
		<table id="Excle141" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle142">2018年</th><th id="Excle143">2017年</th><th id="Excle144">2016年</th>
			</tr>
		</table>
		</div>
	<h2>2.5 申请人分析</h2>
	<h2>2.5.1 申请人构成分析</h2>
	<textarea rows="3" cols="80" id="des15" name="des15" onblur="blur15()">通过对申请人构成的分析，可以看出部分组织或个人在相关行业的实力，以及在相关行业的专利布局。</textarea>
	<div id="temp25" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp26" style="display: none;">
		<table id="Excle145" style="width: 800px;">
			<tr>
				<th>排名</th><th>申请人</th><th id="Excle146">2018年</th><th id="Excle147">2017年</th><th id="Excle148">2016年</th>
			</tr>
		</table>
		</div>
	<h2>2.6 发明人分析</h2>
	<h2>2.6.1 发明人构成分析</h2>
	<textarea rows="3" cols="80" id="des16" name="des16" onblur="blur16()">通过对发明人构成的分析，可以看出该发明人在相关领域的创新能力，申请较多的表明该发明人在该领域创新能力较强。</textarea>
	<div id="temp27" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp28" style="display: none;">
		<table id="Excle149" style="width: 800px;">
			<tr>
				<th>排名</th><th>发明人</th><th id="Excle150">加载中</th><th id="Excle151">加载中</th><th id="Excle152">加载中</th>
			</tr>
		</table>
		</div>
	<h2>2.7 法律状态分析</h2>
	<h2>2.7.1 法律状态总体构成构成分析</h2>
	<textarea rows="3" cols="80" id="des17" name="des17" onblur="blur17()">通过对法律状态总体构成的分析，可以看出在相关领域的技术实力，一把来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp29" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="法律状态总体构成构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp30" style="display: none;">
		<table id="Excle153" style="width: 800px;">
			<tr>
				<th>法律状态</th><th id="Excle154">2018年</th><th id="Excle155">2017年</th><th id="Excle156">2016年</th>
			</tr>
			<tr>
				<td>有效(截止表格对应月份日期前)</td><td id="Excle157">加载中</td><td id="Excle158">加载中</td><td id="Excle159">加载中</td>
			</tr>
			<tr>
				<td>失效(截止表格对应月份日期前)</td><td id="Excle160">加载中</td><td id="Excle161">加载中</td><td id="Excle162">加载中</td>
			</tr>
			<tr>
				<td>在审(截止表格对应月份日期前)</td><td id="Excle163">加载中</td><td id="Excle164">加载中</td><td id="Excle165">加载中</td>
			</tr>
			<!-- <tr>
				<td>不确定(截止表格对应月份日期前)</td><td id="Excle166">加载中</td><td id="Excle167">加载中</td><td id="Excle168">加载中</td>
			</tr> -->
		</table>
		</div>
	<h2>2.7.2 法律状态区域构成分析</h2>
	<textarea rows="3" cols="80" id="des18" name="des18" onblur="blur18()">通过对法律状态区域构成的分析，可以看出中国各个省份在相关领域的技术实力，一把来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp31" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp32" style="display: none;">
		<table id="Excle169" style="width: 800px;">
			<tr>
				<th>区域</th><th>有效</th><th>失效</th><th>在审</th>
			</tr>
		</table>
		</div>
	<h2>第三章 广东省专利监测分析</h2>
	<h2>3.1 专利总量分析</h2>
	<textarea rows="3" cols="80" id="des19" name="des19" onblur="blur19()">通过对广东省专利总量的分析，可以看出在一定时间段内全球专利的数量趋势，查看在大趋势下有无反常趋势数据。</textarea>
	<div id="pic3" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利总量分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<table id="Excle170">
		<tr>
			<th>编号</th><th>地域</th><th id="Excle171">2018年</th><th id="Excle172">2017年</th><th id="Excle173">2016年</th>
		</tr>
		<tr>
			<td>1</td><td>广东省</td><td id="Excle174">加载中</td><td id="Excle175">加载中</td><td id="Excle176">加载中</td>
		</tr>
	</table>
	<h2>3.2 专利类型分析</h2>
	<textarea rows="3" cols="80" id="des20" name="des20" onblur="blur20()">通过对专利类型的分析，可以看出近几年专利主要属于什么类型，借此可判断相关行业的发展态势。</textarea>
	<div id="temp33" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp34" style="display: none;">
		<table id="Excle177" style="width: 800px;">
			<tr>
				<th>排名</th><th>类型</th><th id="Excle178">2018年</th><th id="Excle179">2017年</th><th id="Excle180">2016年</th>
			</tr>
			<tr>
				<td>1</td><td>发明</td><td id="Excle181">加载中</td><td id="Excle182">加载中</td><td id="Excle183">加载中</td>
			</tr>
			<tr>
				<td>2</td><td>新型</td><td id="Excle184">加载中</td><td id="Excle185">加载中</td><td id="Excle186">加载中</td>
			</tr>
			<tr>
				<td>3</td><td>外观</td><td id="Excle187">加载中</td><td id="Excle188">加载中</td><td id="Excle189">加载中</td>
			</tr>
		</table>
		</div>
	<h2>3.3 地区分析</h2>
	<textarea rows="3" cols="80" id="des21" name="des21" onblur="blur21()">通过对地区分布的分析，可以看出广东省内各市在相关行业的专利布局状况。</textarea>
	<div id="temp35" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="地区分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp36" style="display: none;">
		<table id="Excle190" style="width: 800px;">
			<tr>
				<th>排名</th><th>区域</th><th id="Excle191">2018年</th><th id="Excle192">2017年</th><th id="Excle193">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.4 技术分析</h2>
	<h2>3.4.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des22" name="des22" onblur="blur22()">通过对技术构成的分析，可以看出广东省在相关行业的各个产业的详细发展状况。</textarea>
	<div id="temp37" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp38" style="display: none;">
		<table id="Excle194" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle195">2018年</th><th id="Excle196">2017年</th><th id="Excle197">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.4.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des23" name="des23" onblur="blur23()">通过对技术区域的分析，可以看出在相关产业具体到相关各个市的具体状况，查看该市在相关产业的专利布局状况。</textarea>
	<div id="temp39" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术区域分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp40" style="display: none;">
		<table id="Excle198" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle199">2018年</th><th id="Excle200">2017年</th><th id="Excle201">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.4.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des24" name="des24" onblur="blur24()">通过对技术申请人的分析，可以看出省内部分个人或集体在相关产业的专利布局状况。</textarea>
	<div id="temp41" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp42" style="display: none;">
		<table id="Excle202" style="width: 800px;">
			<tr>
				<th>序号</th><th>技术</th><th id="Excle203">2018年</th><th id="Excle204">2017年</th><th id="Excle205">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.5 申请人分析</h2>
	<h2>3.5.1 申请人构成分析</h2>
	<textarea rows="3" cols="80" id="des25" name="des25" onblur="blur25()">通过对申请人构成的分析，可以看出部分组织或个人在相关行业的实力，以及在相关行业的专利布局。</textarea>
	<div id="temp43" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp44" style="display: none;">
		<table id="Excle206" style="width: 800px;">
			<tr>
				<th>排名</th><th>申请人</th><th id="Excle207">2018年</th><th id="Excle208">2017年</th><th id="Excle209">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.6 发明人分析</h2>
	<h2>3.6.1 发明人构成分析</h2>
	<textarea rows="3" cols="80" id="des26" name="des26" onblur="blur26()">通过对发明人构成的分析，可以看出该发明人在相关领域的创新能力，申请较多的表明该发明人在该领域创新能力较强。</textarea>
	<div id="temp45" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp46" style="display: none;">
		<table id="Excle210" style="width: 800px;">
			<tr>
				<th>排名</th><th>发明人</th><th id="Excle211">2018年</th><th id="Excle212">2017年</th><th id="Excle213">2016年</th>
			</tr>
		</table>
		</div>
	<h2>3.7 法律状态分析</h2>
	<h2>3.7.1 法律状态总体构成构成分析</h2>
	<textarea rows="3" cols="80" id="des27" name="des27" onblur="blur27()">通过对法律状态总体构成的分析，可以看出在相关领域的技术实力，一把来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp47" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="法律状态总体构成构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp48" style="display: none;">
		<table id="Excle214" style="width: 800px;">
			<tr>
				<th>法律状态</th><th id="Excle215">2018年</th><th id="Excle216">2017年</th><th id="Excle217">2016年</th>
			</tr>
			<tr>
				<td>有效(截止表格对应月份日期前)</td><td id="Excle218">加载中</td><td id="Excle219">加载中</td><td id="Excle220">加载中</td>
			</tr>
			<tr>
				<td>失效(截止表格对应月份日期前)</td><td id="Excle221">加载中</td><td id="Excle222">加载中</td><td id="Excle223">加载中</td>
			</tr>
			<tr>
				<td>在审(截止表格对应月份日期前)</td><td id="Excle224">加载中</td><td id="Excle225">加载中</td><td id="Excle226">加载中</td>
			</tr>
			<!-- <tr>
				<td>不确定(截止表格对应月份日期前)</td><td id="Excle227">加载中</td><td id="Excle228">加载中</td><td id="Excle229">加载中</td>
			</tr> -->
		</table>
		</div>
	<h2>3.7.2 法律状态区域构成分析</h2>
	<textarea rows="3" cols="80" id="des28" name="des28" onblur="blur28()">通过对法律状态区域构成的分析，可以看出中国各个省份在相关领域的技术实力，一把来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp49" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp50" style="display: none;">
		<table id="Excle230" style="width: 800px;">
			<tr>
				<th>区域</th><th>有效</th><th>失效</th><th>在审</th>
			</tr>
		</table>
		</div>
	</div>
	<div style="height: 10px"></div>
	
		<input type="hidden" name="onepic" id="onepic" value="null">
		<input type="hidden" name="twopic" id="twopic" value="null">
		<input type="hidden" name="threepic" id="threepic" value="null">
		<c:forEach var="i" begin="0" end="230">
			<input type="hidden" name="ecl${i }" id="ecl${i }" value="kong">
		</c:forEach>
		
		<c:forEach var="j" begin="1" end="30">
			<input type="hidden" name="dec${j }" id="dec${j }" value="null">
		</c:forEach>
		
		<input type="submit" name="sub" id="sub" disabled="disabled" value="请稍等，报告正在生成中"/>
	</form>
	</center>
</body>
</html>