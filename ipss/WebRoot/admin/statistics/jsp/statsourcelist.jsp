<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.text.*"%>

<%
        java.util.Date today = new java.util.Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String time = formatter.format(today);
		String year_from=null,month_from=null,day_from=null;
		String year_to=null,month_to=null,day_to=null;
		int    int_year_from=0,int_month_from=0;
		day_from="01";
		year_to=time.substring(0,4);
		month_to=time.substring(5,7);
		day_to=time.substring(8,10);
		int_year_from=Integer.parseInt(year_to)-1;
		int_month_from=Integer.parseInt(month_to)-1==0 ? 1:Integer.parseInt(month_to)-1;
		year_from=String.valueOf(int_year_from);
		month_from=String.valueOf(int_month_from);
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0;charset=GBK">
<link href="../../../analyse/css/analyse.css" rel="stylesheet" type="text/css" ></link>
<Script language="JavaScript">
<!--
	function isInteger(inputVal)
	{
		inputStr = inputVal.toString();
		for(var i=0;i<inputStr.length;i++)
		{
			var oneChar = inputStr.charAt(i);
			if(oneChar=="-" && i==0)
			{
				continue;
			}
			if(oneChar<"0" || oneChar>"9")
			{
				return false;
			}
		}
		return true;
	}
	function checkform()
	{
	  var year_from=document.stats.year1.value;
	  var month_from=document.stats.month1.value;
	  var day_from=document.stats.day1.value;
	  var year_to=document.stats.year2.value;
	  var month_to=document.stats.month2.value;
	  var day_to=document.stats.day2.value;
	  if(!isInteger(year_from)||!isInteger(month_from)||!isInteger(day_from)||!isInteger(year_to)||!isInteger(month_to)||!isInteger(day_to))
	  {
	     alert("请输入有效日期格式！");
		 return false;
	  }
	  if(month_from>12||month_from<1||month_to>12||month_to<1)
	  {
	     alert("请输入有效的日期格式！");
		 return false;
	  }
	  if(day_from>31||day_from<1||day_to>31||day_to<1)
	  {
         alert("请输入有效日期格式！");
		 return false;	  
	  }
	  document.stats.submit();
	  return true;
	}
//-->
</Script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">平 台 访 问 统 计 </span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">   	
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="../../help/statistics_jsp_statsourcelist_help.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/statistics_jsp_statsourcelist_help.htm','','width=800,height=600,scrollbars=yes');"><!--img src="../../images/help_list.gif" height="32" border="0"--></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
    </table></td>    
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
  <tr>
    <td align="center" valign="top">
    	<table width="100%" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
        	<tr align="center"> 
        	  <td colspan="10" nowrap>
			  <form name="stats" action="result.jsp" method="post">
			  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF">
                <tr>
                  <td width="27%"><div align="center">统计时间设定：</div></td>
                  
                  <td height="30" colspan="2"> 从 
                    <select name="year1" onChange="hideday()">
                      <option value="2004">2004</option>
                      <option value="2005">2005</option>
                      <option value="2006">2006</option>
                      <option value="2007">2007</option>
                      <option value="2008">2008</option>
                      <option value="2009">2009</option>
                      <option value="2010">2010</option>
                      <option value="2011">2011</option>
                      <option value="2012">2012</option>
                      <option value="2013">2013</option>
                    </select>
                    年 
                    <select name="month1" onChange="hideday()">
                      <option value="01" selected>1</option>
                      <option value="02">2</option>
                      <option value="03">3</option>
                      <option value="04">4</option>
                      <option value="05">5</option>
                      <option value="06">6</option>
                      <option value="07">7</option>
                      <option value="08">8</option>
                      <option value="09">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select>
                    月 
                    <select name="day1" onChange="return check()">
                      <script language="javascript">
                  for(var k=1;k<32;k++)
                  {
                	if(k<10)
                  	{
				if (k==1) {
				document.write("<option value='0"+k+"' selected>")
	                  	document.write(k+"</option>")
				} else {
				document.write("<option value='0"+k+"'>")
	                  	document.write(k+"</option>")
				}

                  	}
                  	else
                  	{
	                  	document.write("<option value='"+k+"'>")
	                  	document.write(k+"</option>")
                  	}
                  }
                  </script>
                    </select>
                    到 
                    <select name="year2" onChange="hideday1()">
                      <script language="javascript">
                  for(var m=1;m<9;m++)
                  {
              		var a = 2000;
              		var b = new Date()
              		var c
              		c = b.getYear()
              		a+=m
                  	if(a==c)
                  	{
	                  	document.write("<option value='"+a+"' selected>")
	                  	document.write(a+"</option>")
                  	}
                  	else
                  	{
	                  	document.write("<option value='"+a+"'>")
	                  	document.write(a+"</option>")
                  	}
                  }					
					</script>
                    </select>
                    年 
                    <select name="month2" onChange="hideday1()">
                      <script language="javascript">
                  for(var m=1;m<13;m++)
                  {
              		var b = new Date()
              		var c
              		c = b.getMonth()+1
			
                  	if(m==c)
                  	{
	                  	if(m<10)
	                  	{
	                  		document.write("<option value='0"+m+"' selected>")
	                  	}
	                  	else
	                  	{
	                  		document.write("<option value='"+m+"' selected>")
	                  	}
	                  	document.write(m+"</option>")
                  	}
                  	else
                  	{
	                  	if(m<10)
	                  	{
	                  		document.write("<option value='0"+m+"'>")
	                  	}
	                  	else
	                  	{
		                  	document.write("<option value='"+m+"'>")
		                }
	                  	document.write(m+"</option>")
                  	}                  }					
					</script>
                    </select>
                    月 
                    <select name="day2" onChange="return check()">
                      <script language="javascript">
                  for(var m=1;m<32;m++)
                  {

              		var b = new Date()
              		var c
              		c = b.getDate()
                  	if(m==c)
                  	{
	                  	if(m<10)
	                  	{
	                  		document.write("<option value='0"+m+"' selected>")
	                  	}
	                  	else
	                  	{
	                  		document.write("<option value='"+m+"' selected>")
	                  	}
	                  	document.write(m+"</option>")
                  	}
                  	else
                  	{
	                  	if(m<10)
	                  	{
	                  		document.write("<option value='0"+m+"'>")
	                  	}
	                  	else
	                  	{
	                  		document.write("<option value='"+m+"'>")
	                  	}
	                  	document.write(m+"</option>")
                  	}
                  }
                  </script>
                    </select></td>
                </tr>
                <tr>
                  <td><div align="center">统计项目选择：</div></td>
                  <td height="30" colspan="2">
                    <table width="250" border="0">
                      <tr>
                        <td width="67"><input name="operation" type="radio" value="all" id="id_all" checked>
                          <label for="id_all" style="cursor:hand"/>全部</td>
                        <td width="67"><input type="radio" name="operation" value="print" id="id_print">
                          <label for="id_print" style="cursor:hand"/>打印</td>
                        <td width="67"><input type="radio" name="operation" value="download" id="id_download">
                        <label for="id_download" style="cursor:hand"/>下载</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td><div align="center">请输入要统计用户名：</div></td>
                  <td height="24" colspan="2"><input name="userName" type="text" size="15">
（留空表示全部）</td>
                </tr>
                <tr>
                  <td height="25" colspan="3"><div align="center">
                    
                    <table width="400" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><div align="center">
                          <input type="submit" name="Submit" value="  统  计  " onClick="checkform();return false;">
                        </div></td>
                        <!--td><div align="center">
                          <input  type="button" name="Submit" value="导出统计结果" onClick="javascript:openModalwin()">
                        </div></td-->
                      </tr>
                    </table>
                  </div></td>
                </tr>
              </table>
			  </form></td>
       	  </tr>
   	  </table>
    </td>
  </tr>
</table>
<form name="Outline" method="post" action="download.jsp" target="_blank">
<input type="hidden" name="operation" value="">
<input type="hidden" name="userName" value="">
<input type="hidden" name="time_from" value="">
<input type="hidden" name="time_to" value="">
<input type="hidden" name="zipfile" value="">
</form>
</body>
</html>
<script>
function openModalwin()
{ 
//alert(document.stats.operation.value);
var operation;
var userName;
	  
    for (var i=0;i<document.stats.elements.length;i++)
    {
        var e = document.stats.elements[i];
        if (e.name == 'operation' && e.checked==true){
//			alert(e.value);
			operation=e.value;
		}
        if (e.name == 'userName'){
//			alert(e.value);
			userName=e.value;
		}
        if (e.name == 'year1'){
//			alert(e.value);
			year_from=e.value;
		}
        if (e.name == 'month1'){
//			alert(e.value);
			month_from=e.value;
		}
        if (e.name == 'day1'){
//			alert(e.value);
			day_from=e.value;
		}
        if (e.name == 'year2'){
//			alert(e.value);
			year_to=e.value;
		}
        if (e.name == 'month2'){
//			alert(e.value);
			month_to=e.value;
		}
        if (e.name == 'day2'){
//			alert(e.value);
			day_to=e.value;
		}
		if (e.name == 'file_path'){
			file_path=e.value;
		}
	}
var time_from=year_from+"-"+month_from+"-"+day_from+" 00:00:00";
var time_to=year_to+"-"+month_to+"-"+day_to+" 23:59:59";
	
	document.Outline.zipfile.value="yes";
	document.Outline.operation.value=operation;
	document.Outline.userName.value=userName;
	document.Outline.time_from.value=time_from;
	document.Outline.time_to.value=time_to;
	document.Outline.submit();
} 
</script>