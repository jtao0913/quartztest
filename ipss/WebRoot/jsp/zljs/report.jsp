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
<script src="<%=basePath%>/analyse/theme/shine.js"></script>

<script type="text/javascript">
function imag2(id,one,name){
	var myChart = echarts.init(document.getElementById(id),"shine");
	var source = new Array();
	source[0]=new Array('product',name);
	var i=1;
	for(var p in one){
		source[i]=new Array();
		source[i][0]=p;
		source[i][1]=one[p];
		i++;
	}
	var series = new Array();
	var h=JSON.parse("{\"type\": \"bar\"}");
	series[0]=h;
	iamge(myChart,source,series);
	var picInfo = myChart.getDataURL();
	saveImage(id,picInfo);
}

function imag(id,one){
	var myChart = echarts.init(document.getElementById(id),"shine");
	var source = new Array();
	source[0]=new Array('product');

	var a;
	for(var b in one){
		a=one[b];
		break;
	}
	var leng=0;
	for(var x in a){
		leng++;
	}
	for(var b in one){
		var tem=0;
		for(var c in one[b]){
			tem++;
		}
		if(tem>leng){
			a=one[b];
		}else{
			tem=0;
		}
	}
	
	var i=1;
	for(var t in a){
		if(t!="广东省"){
			t=t.replace(/\&nbsp;/g," ")
			source[0][i]=t;
			i++;
		}
	}
	if(a["广东省"]!=null){
		source[0][i]="广东省";
	}
	
	var i=1;
	for(var p in one){
		source[i]=new Array(p);
		var j=1;
		for(var t in a){
			if(t!="广东省"){
				source[i][j]=one[p][t];
				j++;
			}
		}
		if(one[p]["广东省"]!=null){
			source[i][j]=one[p]["广东省"];
		}
		i++;
	}
	
	var series = new Array();
	var h=JSON.parse("{\"type\": \"bar\"}");
	for(var p in one){
		var f=0;
		for(var t in a){
			series[f]=h;
			f++;
		}
		break;
	}
	iamge(myChart,source,series);
	var picInfo = myChart.getDataURL();
	saveImage(id,picInfo);
}

function saveImage(id,picInfo){
	$.ajax({
		type : "POST",
		url :  "<%=basePath%>/SaveImageServlet",
		data : {
			'id' : id,
			'date' : picInfo,
		},
		"dataType" : "json",
		"success" : function(result) {
			console.info(result);
		}
	});
}

function chart2(id,one,menu){
	var math=id.replace("Excle","");
	$("#menu"+math).val(menu);
	var htm=$("#"+id).html();
	var htm="<tr><th>编号</th><th>"+menu+"</th>";
	for(var a in one){
		htm=htm+"<th>"+a+"</th>";
	}
	htm=htm+"</tr>";
	htm=htm+"<tr><td>1</td><td>广东省</td>";
	for(var a in one){
		htm=htm+"<td>"+one[a]+"</td>";
	}
	htm=htm+"</tr>";
	$("#"+id).html(htm);
}

function chart(id,one,menu){
	var math=id.replace("Excle","");
	var i_math=parseInt(math);
//alert("math:"+i_math+";i_math<=7:"+(i_math<=7));
	$("#menu"+math).val(menu);
	var htm=$("#"+id).html();
	var htm="<tr><th>编号</th><th>"+menu+"</th>";
	for(var a in one){
		htm=htm+"<th>"+a+"</th>";
	}
	htm=htm+"</tr>";
	var a;
	for(var b in one){
		a=one[b];
		break;
	}
	
	var leng=0;
	for(var x in a){
		leng++;
	}
	for(var b in one){
		var tem=0;
		for(var c in one[b]){
			tem++;
		}
		if(tem>leng){
			a=one[b];
		}else{
			tem=0;
		}
	}
	
	var th=1;
	for(var w in a){
		if(w!="广东省"){
			htm=htm+"<tr><td>"+th+"</td><td>"+w+"</td>";
			for(var t in one){
				var tem=JSON.stringify(one[t][w]);
				if(tem!=null){
					tem=tem.replace("{","");tem=tem.replace("}","");
					tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
					if(tem.indexOf("省",2)>0){
//alert(tem);
						if(i_math<=7){
//alert("before:"+tem);
							tem=tem.replace("广东省","中国-广东省");
//alert("after:"+tem);
						}						
//tem=tem.replace("广东省","中国-广东省");
					}
				}else{
					tem=0;
				}
				htm=htm+"<td>"+tem+"</td>";
			}
			htm=htm+"</tr>";
			th++;
		}
	}
	if(a["广东省"]!=null){
//alert("2...");
		htm=htm+"<tr><td>"+th+"</td><td>广东省</td>";
		for(var t in one){
			var tem=JSON.stringify(one[t]["广东省"]);
			if(tem!=null){
				tem=tem.replace("{","");tem=tem.replace("}","");
				tem=tem.replace(/\"/g,"");tem=tem.replace(/\,/g,"</br>");
			}else{
				tem=0;
			}
			htm=htm+"<td>"+tem+"</td>";
		}
		htm=htm+"</tr>";
	}
//alert(htm)
	$("#"+id).html(htm);
}

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
//	func3_7_2();
}
function iamge(myChart,source,series){
	myChart.setOption({
		animation:false,
	    legend: {},
	    tooltip: {},
	    dataset: {
	        source: source
	    },
	    xAxis: {type: 'category'},
	    yAxis: {},
	    series: series
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
			imag("pic1",one);
			/* //获取图片base64码并存到隐藏域中
			var myChart = echarts.init(document.getElementById('pic1'));
			var picInfo = myChart.getDataURL();
			$("#repor #img1").val(picInfo); */
			//表格填充
			chart("Excle0",one,"区域");
			//将表格信息存到隐藏域中
			$("#ecl0").val(result);
			//将表格描述增加到隐藏域中
			for(var i=0;i<29;i++){
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
			var one=JSON.parse(result);
			imag("pic2",one);
			$("#temp1").attr("style","display: none;");
			$("#temp2").attr("style","display: block;");
			//表格填充
			chart("Excle1",one,"区域");
			convertundefined("Excle1");
			//获取表格信息并存到隐藏域中
			$("#ecl1").val(result);
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
			chart("Excle2",one,"区域");
			convertundefined("Excle2");
			//获取表格信息并存到隐藏域中
			$("#ecl2").val(result);
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
//alert(result);
			var one=JSON.parse(result);
			$("#temp5").attr("style","display: none;");
			$("#temp6").attr("style","display: block;");
			//表格填充
			chart("Excle3",one,"区域");
			convertundefined("Excle3");
			//获取表格信息并存到隐藏域中
			$("#ecl3").val(result);
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
			var one=JSON.parse(result);
			imag("pic3",one);
			$("#temp7").attr("style","display: none;");
			$("#temp8").attr("style","display: block;");
			//表格填充
			chart("Excle4",one,"技术");
			convertundefined("Excle4");
			//获取表格信息并存到隐藏域中
			$("#ecl4").val(result);
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
			var one=JSON.parse(result);
			$("#temp9").attr("style","display: none;");
			$("#temp10").attr("style","display: block;");
			//表格填充
			chart("Excle5",one,"技术");
			convertundefined("Excle5");
			//获取表格信息并存到隐藏域中
			$("#ecl5").val(result);
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
			var one=JSON.parse(result);
			$("#temp11").attr("style","display: none;");
			$("#temp12").attr("style","display: block;");
			//表格填充
			chart("Excle6",one,"技术");
			convertundefined("Excle6");
			//获取表格信息并存到隐藏域中
			$("#ecl6").val(result);
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
//alert(result);
			var one=JSON.parse(result);
			imag("pic4",one);
			$("#temp13").attr("style","display: none;");
			$("#temp14").attr("style","display: block;");
			//表格填充
			chart("Excle7",one,"申请人");
			convertundefined("Excle7");
			//获取表格信息并存到隐藏域中
			$("#ecl7").val(result);
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
			imag("pic5",one);
			/* imag("pic2",one);
			var myChart = echarts.init(document.getElementById('pic2'));
			//获取图片base64码并存到隐藏域中
			var picInfo = myChart.getDataURL();
			$("#repor #twopic").val(picInfo); */
			//表格填充
			chart("Excle8",one,"区域");
			convertundefined("Excle8");
			//获取表格信息并存到隐藏域中
			$("#ecl8").val(result);
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
			var one=JSON.parse(result);
			imag("pic6",one);
			$("#temp15").attr("style","display: none;");
			$("#temp16").attr("style","display: block;");
			//表格填充
			chart("Excle9",one,"类型");
			convertundefined("Excle9");
			//获取表格信息并存到隐藏域中
			$("#ecl9").val(result);
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
			var one=JSON.parse(result);
			$("#temp17").attr("style","display: none;");
			$("#temp18").attr("style","display: block;");
			//表格填充
			chart("Excle10",one,"区域");
			convertundefined("Excle10");
			//获取表格信息并存到隐藏域中
			$("#ecl10").val(result);
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
			var one=JSON.parse(result);
			imag("pic7",one);
			$("#temp19").attr("style","display: none;");
			$("#temp20").attr("style","display: block;");
			//表格填充
			chart("Excle11",one,"技术");
			convertundefined("Excle11");
			//获取表格信息并存到隐藏域中
			$("#ecl11").val(result);
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
			var one=JSON.parse(result);
			$("#temp21").attr("style","display: none;");
			$("#temp22").attr("style","display: block;");
			//表格填充
			chart("Excle12",one,"技术");
			convertundefined("Excle12");
			//获取表格信息并存到隐藏域中
			$("#ecl12").val(result);
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
			var one=JSON.parse(result);
			$("#temp23").attr("style","display: none;");
			$("#temp24").attr("style","display: block;");
			//表格填充
			chart("Excle13",one,"技术");
			convertundefined("Excle13");
			//获取表格信息并存到隐藏域中
			$("#ecl13").val(result);
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
			var one=JSON.parse(result);
			imag("pic8",one);
			$("#temp25").attr("style","display: none;");
			$("#temp26").attr("style","display: block;");
			//表格填充
			chart("Excle14",one,"申请人");
			convertundefined("Excle14");
			//获取表格信息并存到隐藏域中
			$("#ecl14").val(result);
			func2_6_1();
		}
	});
}
//2.6.1发明人构成分析
function func2_6_1() {
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
			var one=JSON.parse(result);
			imag("pic9",one);
			$("#temp27").attr("style","display: none;");
			$("#temp28").attr("style","display: block;");
			//表格填充
			chart("Excle15",one,"发明人");
			convertundefined("Excle15");
			//获取表格信息并存到隐藏域中
			$("#ecl15").val(result);
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
			var one=JSON.parse(result);
			imag("pic10",one);
			$("#temp29").attr("style","display: none;");
			$("#temp30").attr("style","display: block;");
			//表格填充
			chart("Excle16",one,"法律状态");
			convertundefined("Excle16");
			//获取表格信息并存到隐藏域中
			$("#ecl16").val(result);
			func2_7_2();
		}
	});
}
//2.7.2法律状态区域构成分析
function func2_7_2() {
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
			var one=JSON.parse(result);
			chart("Excle17",one,"地区");
			$("#temp31").attr("style","display: none;");
			$("#temp32").attr("style","display: block;");
			//将表格数据存入隐藏域
			$("#ecl17").val(result);		
			func3_1();
		}
	});
}
//3.1专利总量分析
function func3_1() {
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
			imag2("pic11",one,"广东省");
			//表格填充
			chart2("Excle18",one,"区域");
			$("#temp31").attr("style","display: none;");
			$("#temp32").attr("style","display: block;");
			convertundefined("Excle18");
			//获取表格信息并存到隐藏域中
			$("#ecl18").val(result);
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
			imag("pic12",one);
			$("#temp33").attr("style","display: none;");
			$("#temp34").attr("style","display: block;");
			//表格填充
			chart("Excle19",one,"类型");
			convertundefined("Excle19");
			//获取表格信息并存到隐藏域中
			$("#ecl19").val(result);
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
			var one=JSON.parse(result);
			$("#temp35").attr("style","display: none;");
			$("#temp36").attr("style","display: block;");
			//表格填充
			chart("Excle20",one,"区域");
			convertundefined("Excle20");
			//获取表格信息并存到隐藏域中
			$("#ecl20").val(result);
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
		"success" : function(result) {//响应成功时候的回调函数
//			alert(result);
			var one=JSON.parse(result);
//			alert(one);
			imag("pic13",one);
			$("#temp37").attr("style","display: none;");
			$("#temp38").attr("style","display: block;");
			//表格填充
			chart("Excle21",one,"技术");
			convertundefined("Excle21");
			//获取表格信息并存到隐藏域中
			$("#ecl21").val(result);
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
			var one=JSON.parse(result);
			$("#temp39").attr("style","display: none;");
			$("#temp40").attr("style","display: block;");
			//表格填充
			chart("Excle22",one,"技术");
			convertundefined("Excle22");
			//获取表格信息并存到隐藏域中
			$("#ecl22").val(result);
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
			var one=JSON.parse(result);
			$("#temp41").attr("style","display: none;");
			$("#temp42").attr("style","display: block;");
			//表格填充
			chart("Excle23",one,"技术");
			convertundefined("Excle23");
			//获取表格信息并存到隐藏域中
			$("#ecl23").val(result);
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
			var one=JSON.parse(result);
			imag("pic14",one);
			$("#temp43").attr("style","display: none;");
			$("#temp44").attr("style","display: block;");
			//表格填充
			chart("Excle24",one,"申请人");
			convertundefined("Excle24");
			//获取表格信息并存到隐藏域中
			$("#ecl24").val(result);
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
			var one=JSON.parse(result);
			imag("pic15",one);
			$("#temp45").attr("style","display: none;");
			$("#temp46").attr("style","display: block;");
			//表格填充
			chart("Excle25",one,"申请人");
			convertundefined("Excle25");
			//获取表格信息并存到隐藏域中
			$("#ecl25").val(result);
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
			imag("pic16",one);
			$("#temp47").attr("style","display: none;");
			$("#temp48").attr("style","display: block;");
			//表格填充
			chart("Excle26",one,"法律状态");
			convertundefined("Excle26");
			//获取表格信息并存到隐藏域中
			$("#ecl26").val(result);
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
			var one=JSON.parse(result);
			//var a=Exl1['有效'];var b=Exl1['无效'];var c=Exl1['在审'];//var d=Exl1['不确定'];
			$("#temp49").attr("style","display: none;");
			$("#temp50").attr("style","display: block;");
			//表格填充
			chart("Excle27",one,"法律状态");
			convertundefined("Excle27");
			//chart("Excle27",one,"区域");
			/* var htm= $("#Excle27").html();
			var hang=1;
			for(var p in a){//遍历json对象的每个key/value对,p为key
				htm=htm+"<tr><td>"+p+"</td><td>"+a[p]+"</td><td>"+b[p]+"</td><td>"+c[p]+"</td></tr>";
			}
			$("#Excle27").html(htm);			
			//将表格数据存入隐藏域
			*/
			$("#ecl27").val(result); 
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
	<form id="repor" name="repor" action="<%=basePath%>SearchReportServlet" method="post" target="_blank">
	<div style="width:1000px;">
	<h2>${session.chrGDHyName}分析报告</h2>
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
	<div id="pic2" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="区域构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
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
		<table id="Excle2" style="width: 70%;">
		</table>
		</div>
	<h2>1.2.3 区域申请人分析</h2>
	<textarea rows="3" cols="80" id="des4" name="des4" onblur="blur4()">通过对区域申请人的分析，可以看出相关国家或地区的个人或集体在相关行业的布局以及在相关行业的实力。</textarea>
	<div id="temp5" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="区域申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp6" style="display: none;">
		<table id="Excle3" style="width: 800px;">
		</table>
		</div>
	<h2>1.3 技术分析</h2>
	<h2>1.3.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des5" name="des5" onblur="blur5()">通过对技术构成的分析，可以看出相关行业技术的发展状况，以及此产业在行业中发展的状况和占据的位置。</textarea>
	<div id="pic3" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp7" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp8" style="display: none;">
		<table id="Excle4" style="width: 70%;">
		</table>
		</div>
	<h2>1.3.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des6" name="des6" onblur="blur6()">通过对技术区域的分析，可以查看该国家或地区在相关技术产业的专利布局状况以及相关技术产业的发展状况。</textarea>
	<div id="temp9" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp10" style="display: none;">
		<table id="Excle5" style="width: 70%;">
		</table>
		</div>
	<h2>1.3.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des7" name="des7" onblur="blur7()">通过对技术申请人的分析，可以看出有哪些个人或集体在相关技术产业有布局并且能够查看这些个人或集体在相关技术产业的专利布局状况。</textarea>
	<div id="temp11" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp12" style="display: none;">
		<table id="Excle6" style="width: 70%;">
		</table>
		</div>
	<h2>1.4 申请人分析</h2>
	<h2>1.4.1 申请人构成分析</h2>
	<textarea rows="3" cols="80" id="des8" name="des8" onblur="blur8()">通过对申请人构成的分析，可以看出相关个人或集体历年以来的专利申请状况，从而看出该个人或集体在相关产业的专利布局状况。</textarea>
	<div id="pic4" style="width: 1000px;height:400px;border: solid 1px;">
		<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp13" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp14" style="display: none;">
		<table id="Excle7" style="width: 70%;">
		</table>
		</div>
	<h2>第二章 中国专利监测分析</h2>
	<h2>2.1 专利总量分析</h2>
	<textarea rows="3" cols="80" id="des9" name="des9" onblur="blur9()">通过对中国专利总量的分析，可以看出在一定时间段内全球专利的数量趋势，查看在大趋势下有无反常趋势数据。</textarea>
	<div id="pic5" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利总量分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<table id="Excle8" style="width: 70%;">
	</table>
	<h2>2.2 专利类型分析</h2>
	<textarea rows="3" cols="80" id="des10" name="des10" onblur="blur10()">通过对专利类型的分析，可以看出近几年专利主要属于什么类型，借此可判断相关行业的发展态势。</textarea>
	<div id="pic6" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp15" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp16" style="display: none;">
		<table id="Excle9" style="width: 70%;">
		</table>
		</div>
	<h2>2.3 国省分布状况分析</h2>
	<h2>2.3.1 省市分布分析</h2>
	<textarea rows="3" cols="80" id="des11" name="des11" onblur="blur11()">通过对省市分布的分析，可以看出我国各省市在相关行业的专利布局状况。</textarea>
	<div id="temp17" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="省市分布分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp18" style="display: none;">
		<table id="Excle10" style="width: 70%;">
		</table>
		</div>
	<h2>2.4 技术分析</h2>
	<h2>2.4.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des12" name="des12" onblur="blur12()">通过对技术构成的分析，可以看出我国在相关行业的各个产业的详细发展状况。</textarea>
	<div id="pic7" style="width: 1000px;height:400px;border: solid 1px;">
		<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp19" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp20" style="display: none;">
		<table id="Excle11" style="width: 70%;">
		</table>
		</div>
	<h2>2.4.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des13" name="des13" onblur="blur13()">通过对技术区域的分析，可以看出在相关产业具体到我国相关省份的具体状况，查看该省份在相关产业的专利布局状况。</textarea>
	<div id="temp21" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术区域分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp22" style="display: none;">
		<table id="Excle12" style="width: 70%;">
		</table>
		</div>
	<h2>2.4.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des14" name="des14" onblur="blur14()">通过对技术申请人的分析，可以看出国内部分个人或集体在相关产业的专利布局状况。</textarea>
	<div id="temp23" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp24" style="display: none;">
		<table id="Excle13" style="width: 70%;">
		</table>
		</div>
	<h2>2.5 申请人分析</h2>
	<h2>2.5.1 申请人构成分析</h2>
	<textarea rows="3" cols="80" id="des15" name="des15" onblur="blur15()">通过对申请人构成的分析，可以看出部分组织或个人在相关行业的实力，以及在相关行业的专利布局。</textarea>
	<div id="pic8" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp25" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp26" style="display: none;">
		<table id="Excle14" style="width: 70%;">
		</table>
		</div>
	<h2>2.6 发明人分析</h2>
	<h2>2.6.1 发明人构成分析</h2>
	<textarea rows="3" cols="80" id="des16" name="des16" onblur="blur16()">通过对发明人构成的分析，可以看出该发明人在相关领域的创新能力，申请较多的表明该发明人在该领域创新能力较强。</textarea>
	<div id="pic9" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp27" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp28" style="display: none;">
		<table id="Excle15" style="width: 70%;">
		</table>
		</div>
	<h2>2.7 法律状态分析</h2>
	<h2>2.7.1 法律状态总体构成分析</h2>
	<textarea rows="3" cols="80" id="des17" name="des17" onblur="blur17()">通过对法律状态总体构成的分析，可以看出在相关领域的技术实力，一般来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="pic10" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="法律状态总体构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp29" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="法律状态总体构成构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp30" style="display: none;">
		<table id="Excle16" style="width: 70%;">
		</table>
		</div>
	<h2>2.7.2 法律状态区域构成分析</h2>
	<textarea rows="3" cols="80" id="des18" name="des18" onblur="blur18()">通过对法律状态区域构成的分析，可以看出中国各个省份在相关领域的技术实力，一般来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp31" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp32" style="display: none;">
		<table id="Excle17" style="width: 70%;">
			<tr>
				<th>区域</th><th>有效</th><th>失效</th><th>待审</th>
			</tr>
		</table>
		</div>
	<h2>第三章 广东省专利监测分析</h2>
	<h2>3.1 专利总量分析</h2>
	<textarea rows="3" cols="80" id="des19" name="des19" onblur="blur19()">通过对广东省专利总量的分析，可以看出在一定时间段内全球专利的数量趋势，查看在大趋势下有无反常趋势数据。</textarea>
	<div id="pic11" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利总量分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<table id="Excle18" style="width: 70%;">
		<!-- <tr>
			<th>编号</th><th>地域</th><th id="Excle171">2018年</th><th id="Excle172">2017年</th><th id="Excle173">2016年</th>
		</tr>
		<tr>
			<td>1</td><td>广东省</td><td id="Excle174">加载中</td><td id="Excle175">加载中</td><td id="Excle176">加载中</td>
		</tr> -->
	</table>
	<h2>3.2 专利类型分析</h2>
	<textarea rows="3" cols="80" id="des20" name="des20" onblur="blur20()">通过对专利类型的分析，可以看出近几年专利主要属于什么类型，借此可判断相关行业的发展态势。</textarea>
	<div id="pic12" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp33" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp34" style="display: none;">
		<table id="Excle19" style="width: 70%;">
			<!-- <tr>
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
			</tr> -->
		</table>
		</div>
	<h2>3.3 地区分析</h2>
	<textarea rows="3" cols="80" id="des21" name="des21" onblur="blur21()">通过对地区分布的分析，可以看出广东省内各市区在相关行业的专利布局状况。</textarea>
	<div id="temp35" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="地区分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp36" style="display: none;">
		<table id="Excle20" style="width: 70%;">
			<!-- <tr>
				<th>排名</th><th>区域</th><th id="Excle191">2018年</th><th id="Excle192">2017年</th><th id="Excle193">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.4 技术分析</h2>
	<h2>3.4.1 技术构成分析</h2>
	<textarea rows="3" cols="80" id="des22" name="des22" onblur="blur22()">通过对技术构成的分析，可以看出广东省在相关行业的各个产业的详细发展状况。</textarea>
	<div id="pic13" style="width: 1000px;height:400px;border: solid 1px;">
		<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp37" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp38" style="display: none;">
		<table id="Excle21" style="width: 70%;">
			<!-- <tr>
				<th>序号</th><th>技术</th><th id="Excle195">2018年</th><th id="Excle196">2017年</th><th id="Excle197">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.4.2 技术区域分析</h2>
	<textarea rows="3" cols="80" id="des23" name="des23" onblur="blur23()">通过对技术区域的分析，可以看出在相关产业具体到相关各个市的具体状况，查看该市在相关产业的专利布局状况。</textarea>
	<div id="temp39" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术区域分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp40" style="display: none;">
		<table id="Excle22" style="width: 70%;">
			<!-- <tr>
				<th>序号</th><th>技术</th><th id="Excle199">2018年</th><th id="Excle200">2017年</th><th id="Excle201">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.4.3 技术申请人分析</h2>
	<textarea rows="3" cols="80" id="des24" name="des24" onblur="blur24()">通过对技术申请人的分析，可以看出省内部分个人或集体在相关产业的专利布局状况。</textarea>
	<div id="temp41" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="技术申请人分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp42" style="display: none;">
		<table id="Excle23" style="width: 70%;">
			<!-- <tr>
				<th>序号</th><th>技术</th><th id="Excle203">2018年</th><th id="Excle204">2017年</th><th id="Excle205">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.5 申请人分析</h2>
	<h2>3.5.1 申请人构成分析</h2>
	<textarea rows="3" cols="80" id="des25" name="des25" onblur="blur25()">通过对申请人构成的分析，可以看出部分组织或个人在相关行业的实力，以及在相关行业的专利布局。</textarea>
	<div id="pic14" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp43" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="申请人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp44" style="display: none;">
		<table id="Excle24" style="width: 70%;">
			<!-- <tr>
				<th>排名</th><th>申请人</th><th id="Excle207">2018年</th><th id="Excle208">2017年</th><th id="Excle209">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.6 发明人分析</h2>
	<h2>3.6.1 发明人构成分析</h2>
	<textarea rows="3" cols="80" id="des26" name="des26" onblur="blur26()">通过对发明人构成的分析，可以看出该发明人在相关领域的创新能力，申请较多的表明该发明人在该领域创新能力较强。</textarea>
	<div id="pic15" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp45" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="发明人构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp46" style="display: none;">
		<table id="Excle25" style="width: 70%;">
			<!-- <tr>
				<th>排名</th><th>发明人</th><th id="Excle211">2018年</th><th id="Excle212">2017年</th><th id="Excle213">2016年</th>
			</tr> -->
		</table>
		</div>
	<h2>3.7 法律状态分析</h2>
	<h2>3.7.1 法律状态总体构成分析</h2>
	<textarea rows="3" cols="80" id="des27" name="des27" onblur="blur27()">通过对法律状态总体构成的分析，可以看出在相关领域的技术实力，一般来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="pic16" style="width: 600px;height:400px;border: solid 1px;">
		<img alt="法律状态总体构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 190px;">
	</div>
	<div id="temp47" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="法律状态总体构成分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp48" style="display: none;">
		<table id="Excle26" style="width: 70%;">
			<!-- <tr>
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
			</tr> -->
			<!-- <tr>
				<td>不确定(截止表格对应月份日期前)</td><td id="Excle227">加载中</td><td id="Excle228">加载中</td><td id="Excle229">加载中</td>
			</tr> -->
		</table>
		</div>
	<h2>3.7.2 法律状态区域构成分析</h2>
	<textarea rows="3" cols="80" id="des28" name="des28" onblur="blur28()">通过对法律状态区域构成的分析，可以看出中国各个省份在相关领域的技术实力，一般来说有效数量的专利越多，在该领域的技术实力越强。</textarea>
	<div id="temp49" style="width: 800px;height: 210px;border: solid 1px;">
	<img alt="专利类型分析" src="../../image/sleep.gif" style="height: 20px;padding-top: 90px;">
	</div>
	<div id="temp50" style="display: none;">
		<table id="Excle27" style="width: 70%;">
			<!-- <tr>
				<th>区域</th><th>有效</th><th>失效</th><th>在审</th>
			</tr> -->
		</table>
		</div>
	</div>
	<div style="height: 10px"></div>
		<c:forEach var="i" begin="0" end="28">
			<input type="hidden" name="menu${i }" id="menu${i }" value="kong">
		</c:forEach>
	
		<c:forEach var="i" begin="0" end="28">
			<input type="hidden" name="ecl${i }" id="ecl${i }" value="kong">
		</c:forEach>
		
		<c:forEach var="j" begin="0" end="30">
			<input type="hidden" name="dec${j }" id="dec${j }" value="null">
		</c:forEach>
		
		<input type="submit" name="sub" id="sub" disabled="disabled" value="请稍等，报告正在生成中"/>
	</form>
	</center>
</body>
</html>