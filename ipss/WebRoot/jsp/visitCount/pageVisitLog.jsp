<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>访问量统计</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" href="<%=basePath%>admin/css/style.css" type="text/css">
<style type="text/css">
<!--
A:link {color: blue;text-decoration: none;font-size: 9pt;}
A:visited {color:blue;text-decoration: none;font-size: 9pt;}
A:active {color:blue;text-decoration: none;font-size: 9pt;}
A:hover {color: blue;text-decoration: underline;font-size: 9pt;} 
body {
	background-color: #f0f7ff;
}
-->
</style>
<script type="text/javascript" src="<%=basePath%>js/datepicker/WdatePicker.js"></script>
  </head>
  
  <body>

  <div>
  <a href="visitCount.do?method=getPageVisitLog"><span style="color:red">首页访问量统计</span></a> 
  <a href="visitCount.do?method=getMemberVisitLog">会员访问统计</a> 
  </div>
  
  <br/>
  <center>
  <form action="visitCount.do?method=getPageVisitLog" method='post' >
  	起始时间：<input type='text' name='startTime' value="" onfocus="WdatePicker({isShowWeek:true})"/>
  	终止时间：<input type='text' name='endTime' value="" onfocus="WdatePicker({isShowWeek:true})"/>
  	<input type='submit' value="  查   询  "/>
  </form>
  </center>
  
  <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
    <tr bgcolor="#C2C6DA">
   <td height="35" colspan=2>本站首页总访问量：${requestScope.pagevisitLog['main'].totalVisitCount}</td></tr> 
    </table> 
    <br/>
 <div style="height:300px"> 
   <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
    <tr bgcolor="#C2C6DA"> 
   <td height="35" colspan=2>全领域代码数据库</td></tr> 
   <tr><td height="35">栏目名称</td><td height="35">访问次数</td></tr> 
    
  		<tr>
  		<td width="34%" height="20"> 
         	中国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['中国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	美国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['美国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	日本
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['日本']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	英国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['英国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	德国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['德国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	法国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['法国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	瑞士
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['瑞士']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	欧洲
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['欧洲']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	WIPO
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['WIPO']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	韩国
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['韩国']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	俄罗斯
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['俄罗斯']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	东南亚
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['东南亚']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	阿拉伯
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['阿拉伯']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	台湾省
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['台湾省']}</td>
  		</tr> 
  	 
  		<tr>
  		<td width="34%" height="20"> 
         	香港特区
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['all'].pageVisitMap['香港特区']}</td>
  		</tr> 
  	 
  		<tr>
	  		<td width="34%" height="20"> 
	         	 合计
	  		</td> 
	  		<td>&nbsp;${requestScope.pagevisitLog['all'].totalVisitCount}</td>
  		</tr> 
    	<tr><td align="right" colspan="2"> 
  	 
  	</td></tr>
    </table> 
    <br/>
    <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
    <tr bgcolor="#C2C6DA"> 
   <td height="35" colspan=2>重点行业专利数据库</td></tr>
   <tr><td height="35">栏目名称</td><td height="35">访问次数</td></tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	家电
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['家电']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	汽车摩托车
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['汽车摩托车']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	中国中药
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['中国中药']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	世界医药
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['世界医药']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	精细化工
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['精细化工']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	电池
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['电池']}</td>
  		</tr> 
  
  		<tr>
  		<td width="34%" height="20"> 
         	陶瓷
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].pageVisitMap['陶瓷']}</td>
  		</tr> 
        <tr>
	  		<td width="34%" height="20"> 
	         	 合计
	  		</td> 
	  		<td>&nbsp;${requestScope.pagevisitLog['MajorIndustries'].totalVisitCount}</td>
  		</tr> 
    	<tr><td align="right" colspan="2">  
  	</td></tr>
    </table> 
     <br/><br/><br/>
     
     <table width="90%"  border="1" align="center" valign="top" cellpadding="2" cellspacing="0" bgcolor="#EBEBEB" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
    <tr bgcolor="#C2C6DA"> 
   <td height="35" colspan=2>地方特色行业数据库</td></tr> 
   <tr><td height="35">栏目名称</td><td height="35">访问次数</td></tr> 
  		<tr>
  		<td width="34%" height="20"> 
         	阳江：五金刀剪
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['areaIndustries'].pageVisitMap['阳江：五金刀剪']}</td>
  		</tr> 
  		<tr>
  		<td width="34%" height="20"> 
         	开平：水暖卫浴
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['areaIndustries'].pageVisitMap['开平：水暖卫浴']}</td>
  		</tr> 
  		<tr>
  		<td width="34%" height="20"> 
         	韶关：液压件
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['areaIndustries'].pageVisitMap['韶关：液压件']}</td>
  		</tr> 
  		<tr>
  		<td width="34%" height="20"> 
         	珠海：打印耗材
  		</td> 
  		<td>&nbsp;${requestScope.pagevisitLog['areaIndustries'].pageVisitMap['珠海：打印耗材']}</td>
  		</tr> 
  		<tr>
	  		<td width="34%" height="20"> 
	         	 合计
	  		</td> 
	  		<td>&nbsp;${requestScope.pagevisitLog['areaIndustries'].totalVisitCount}</td>
  		</tr> 
    	<tr><td align="right" colspan="2">  	 
  	</td></tr>
    </table> 
     <br/><br/><br/>
  </div>  
  </body>
</html>