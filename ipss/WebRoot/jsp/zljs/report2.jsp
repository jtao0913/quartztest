<%@ page language="java" contentType="application/msword; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% response.setHeader("Content-Disposition", "attachment;filename=GDReporter.doc"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../js/jquery-1.4.2.min.js"></script>
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
	<img src="${pic4 }">
	<center>
	<br></br><br></br><br></br><br></br><br></br>
	<div style="height: 50px;"></div>
	<h1>广东省战略新兴产业</h1>
	<h1>全领域专利实时监测系统分析报告</h1>
	<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>
	<p style="font-size: 20px; font-family:KaiTi;">广东省知识产权研究与发展中心</p>
	<p>${date }</p>
	<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>
	<br></br><br></br><br></br>
	<h1>第一章 全球专利监测分析</h1>
	<h2>1.1 专利总量分析</h2>
	${dec1 }
	<img alt="专利总量分析" src="${pic1 }" style="width: 600px;height: 400px;">
	<table style="width: 800px;">
		<tr>
			<th>编号</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>世界</td><td>${map1.ecl0 }</td><td>${map1.ecl1 }</td><td>${map1.ecl2 }</td>
		</tr>
		<tr>
			<td>2</td><td>中国</td><td>${map1.ecl3 }</td><td>${map1.ecl4 }</td><td>${map1.ecl5 }</td>
		</tr>
		<tr>
			<td>3</td><td>广东省</td><td>${map1.ecl6 }</td><td>${map1.ecl7 }</td><td>${map1.ecl8 }</td>
		</tr>
	</table>
	<h2>1.2 区域分析</h2>
	<h2>1.2.1 区域构成分析</h2>
	${dec2 }
	<table style="width: 800px;">
		<tr>
			<th>排名</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>${map2.ecl12 }</td><td>${map2.ecl13 }</td><td>${map2.ecl14 }</td><td>${map2.ecl15 }</td>
		</tr>
		<tr>
			<td>2</td><td>${map2.ecl16 }</td><td>${map2.ecl17 }</td><td>${map2.ecl18 }</td><td>${map2.ecl19 }</td>
		</tr>
		<tr>
			<td>3</td><td>${map2.ecl20 }</td><td>${map2.ecl21 }</td><td>${map2.ecl22 }</td><td>${map2.ecl23 }</td>
		</tr>
		<tr>
			<td>4</td><td>${map2.ecl24 }</td><td>${map2.ecl25 }</td><td>${map2.ecl26 }</td><td>${map2.ecl27 }</td>
		</tr>
		<tr>
			<td>5</td><td>${map2.ecl28 }</td><td>${map2.ecl29 }</td><td>${map2.ecl30 }</td><td>${map2.ecl31 }</td>
		</tr>
		<tr>
			<td>6</td><td>${map2.ecl32 }</td><td>${map2.ecl33 }</td><td>${map2.ecl34 }</td><td>${map2.ecl35 }</td>
		</tr>
	</table>
	<h2>1.2.2 区域技术分析</h2>
	${dec3 }
	<table style="width: 800px;">
		<tr>
			<th>排名</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>${map3.ecl39 }</td><td>${map3.ecl40 }</td><td>${map3.ecl41 }</td><td>${map3.ecl42 }</td>
		</tr>
		<tr>
			<td>2</td><td>${map3.ecl43 }</td><td>${map3.ecl44 }</td><td>${map3.ecl45 }</td><td>${map3.ecl46 }</td>
		</tr>
		<tr>
			<td>3</td><td>${map3.ecl47 }</td><td>${map3.ecl48 }</td><td>${map3.ecl49 }</td><td>${map3.ecl50 }</td>
		</tr>
		<tr>
			<td>4</td><td>${map3.ecl51 }</td><td>${map3.ecl52 }</td><td>${map3.ecl53 }</td><td>${map3.ecl54 }</td>
		</tr>
		<tr>
			<td>5</td><td>${map3.ecl55 }</td><td>${map3.ecl56 }</td><td>${map3.ecl57 }</td><td>${map3.ecl58 }</td>
		</tr>
		<tr>
			<td>6</td><td>${map3.ecl59 }</td><td>${map3.ecl60 }</td><td>${map3.ecl61 }</td><td>${map3.ecl62 }</td>
		</tr>
	</table>
	<h2>1.2.3 区域申请人分析</h2>
	${dec4 }
	<table style="width: 800px;">
		<tr>
			<th>排名</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>${map4.ecl64 }</td><td>${map4.ecl65 }</td><td>${map4.ecl66 }</td><td>${map4.ecl67 }</td>
		</tr>
		<tr>
			<td>2</td><td>${map4.ecl68 }</td><td>${map4.ecl69 }</td><td>${map4.ecl70 }</td><td>${map4.ecl71 }</td>
		</tr>
		<tr>
			<td>3</td><td>${map4.ecl72 }</td><td>${map4.ecl73 }</td><td>${map4.ecl74 }</td><td>${map4.ecl75 }</td>
		</tr>
		<tr>
			<td>4</td><td>${map4.ecl76 }</td><td>${map4.ecl77 }</td><td>${map4.ecl78 }</td><td>${map4.ecl79 }</td>
		</tr>
		<tr>
			<td>5</td><td>${map4.ecl80 }</td><td>${map4.ecl81 }</td><td>${map4.ecl82 }</td><td>${map4.ecl83 }</td>
		</tr>
		<tr>
			<td>6</td><td>${map4.ecl84 }</td><td>${map4.ecl85 }</td><td>${map4.ecl86 }</td><td>${map4.ecl87 }</td>
		</tr>
	</table>
	<h2>1.3 技术分析</h2>
	<h2>1.3.1 技术构成分析</h2>
	${dec5 }
	<table id="Excle4" style="width: 800px;">
		${htm1 }
	</table>
	<h2>1.3.2 技术区域分析</h2>
	${dec6 }
	<table id="Excle5" style="width: 800px;">
		${htm2 }
	</table>
	<h2>1.3.3 技术申请人分析</h2>
	${dec7 }
	<table id="Excle6" style="width: 800px;">
		${htm3 }
	</table>
	<h2>1.4 申请人分析</h2>
	<h2>1.4.1 构成申请人分析</h2>
	${dec8 }
	<table id="Excle7" style="width: 800px;">
		${htm4 }
	</table>
	<h2>第二章 中国专利监测分析</h2>
	<h2>2.1 专利总量分析</h2>
	${dec9 }
	<img alt="中国专利总量分析" src="${pic2 }" style="width: 600px;height: 400px;">
	<table style="width: 800px;">
		<tr>
			<th>编号</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>中国</td><td>${map5.ecl110 }</td><td>${map5.ecl111 }</td><td>${map5.ecl112 }</td>
		</tr>
		<tr>
			<td>2</td><td>广东省</td><td>${map5.ecl113 }</td><td>${map5.ecl114 }</td><td>${map5.ecl115 }</td>
		</tr>
	</table>
	<h2>2.2 专利类型分析</h2>
	${dec10 }
	<table style="width: 800px;">
		<tr>
			<th>编号</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>发明</td><td>${map6.ecl120 }</td><td>${map6.ecl121 }</td><td>${map6.ecl122 }</td>
		</tr>
		<tr>
			<td>2</td><td>新型</td><td>${map6.ecl123 }</td><td>${map6.ecl124 }</td><td>${map6.ecl125 }</td>
		</tr>
		<tr>
			<td>3</td><td>外观</td><td>${map6.ecl126 }</td><td>${map6.ecl127 }</td><td>${map6.ecl128 }</td>
		</tr>
	</table>
	<h2>2.3 国省分布状况分析</h2>
	<h2>2.3.1 省市分布分析</h2>
	${dec11 }
	<table style="width: 800px;">
		${htm5 }
	</table>
	<h2>2.4 技术分析</h2>
	<h2>2.4.1 技术构成分析</h2>
	${dec12 }
	<table style="width: 800px;">
		${htm6 }
	</table>
	<h2>2.4.2 技术区域分析</h2>
	${dec13 }
	<table style="width: 800px;">
		${htm7 }
	</table>
		</div>
	<h2>2.4.3 技术申请人分析</h2>
	${dec14 }
	<table style="width: 800px;">
		${htm8 }
	</table>
	<h2>2.5 申请人分析</h2>
	<h2>2.5.1 申请人构成分析</h2>
	${dec15 }
	<table style="width: 800px;">
		${htm9 }
	</table>
	<h2>2.6 发明人分析</h2>
	<h2>2.6.1 发明人构成分析</h2>
	${dec16 }
	<table style="width: 800px;">
		${htm10 }
	</table>
	<h2>2.7 法律状态分析</h2>
	<h2>2.7.1 法律状态总体构成构成分析</h2>
	${dec17 }
	<table style="width: 800px;">
		${htm11 }
	</table>
	<h2>2.7.2 法律状态区域构成分析</h2>
	${dec18 }
	<table style="width: 800px;">
		${htm12 }
	</table>
	<h2>第三章 广东省专利监测分析</h2>
	<h2>3.1 专利总量分析</h2>
	${dec19 }
	<img alt="广东省专利总量分析" src="${pic3 }" style="width: 600px;height: 400px;">
	<table style="width: 800px;">
		<tr>
			<th>编号</th><th>区域</th><th>2018年</th><th>2017年</th><th>2016年</th>
		</tr>
		<tr>
			<td>1</td><td>广东省</td><td>${map7.ecl174 }</td><td>${map7.ecl175 }</td><td>${map7.ecl176 }</td>
		</tr>
	</table>
	<h2>3.2 专利类型分析</h2>
	${dec20 }
	<table id="Excle17" style="width: 800px;">
		<tr>
			<th>排名</th><th>类型</th><th id="Excle178">2018年</th><th id="Excle179">2017年</th><th id="Excle180">加载中</th>
		</tr>
		<tr>
			<td>1</td><td>发明</td><td id="Excle181">${map8.ecl181 }</td><td id="Excle182">${map8.ecl182 }</td><td id="Excle183">${map8.ecl183 }</td>
		</tr>
		<tr>
			<td>2</td><td>新型</td><td id="Excle184">${map8.ecl184 }</td><td id="Excle185">${map8.ecl185 }</td><td id="Excle186">${map8.ecl186 }</td>
		</tr>
		<tr>
			<td>3</td><td>外观</td><td id="Excle187">${map8.ecl187 }</td><td id="Excle188">${map8.ecl188 }</td><td id="Excle189">${map8.ecl189 }</td>
		</tr>
	</table>
	<h2>3.3 地区分析</h2>
	${dec21 }
	<table style="width: 800px;">
		${htm13 }
	</table>
	<h2>3.4 技术分析</h2>
	<h2>3.4.1 技术构成分析</h2>
	${dec22 }
	<table style="width: 800px;">
		${htm14 }
	</table>
	<h2>3.4.2 技术区域分析</h2>
	${dec23 }
	<table style="width: 800px;">
		${htm15 }
	</table>
	<h2>3.4.3 技术申请人分析</h2>
	${dec24 }
	<table style="width: 800px;">
		${htm16 }
	</table>
	<h2>3.5 申请人分析</h2>
	<h2>3.5.1 申请人构成分析</h2>
	${dec25 }
	<table style="width: 800px;">
		${htm17 }
	</table>
	<h2>3.6 发明人分析</h2>
	<h2>3.6.1 发明人构成分析</h2>
	${dec26 }
	<table style="width: 800px;">
		${htm18 }
	</table>
	<h2>3.7 法律状态分析</h2>
	<h2>3.7.1 法律状态总体构成构成分析</h2>
	${dec27 }
	<table style="width: 800px;">
		${htm19 }
	</table>
	<h2>3.7.2 法律状态区域构成分析</h2>
	${dec28 }
	<table style="width: 800px;">
		${htm20 }
	</table>
	</div>
	<div style="height: 10px"></div>
	</center>
</body>
</html>