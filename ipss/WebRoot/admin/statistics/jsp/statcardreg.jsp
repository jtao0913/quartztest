<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="../../../head.jsp" %>
<%@ include file="../../../zljs/comm/config.jsp"%>

<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<META http-equiv="cache-control" content="no-cache ; charset=GBK">
<META http-equiv="expires" content="0 ; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css" type="text/css">
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
          <td width="96%" height="32" align="right"><a href="../../help/statistics_jsp_statsourcelist_help.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/statistics_jsp_statsourcelist_help.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_list.gif" height="32" border="0"></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
    </table></td>    
  </tr>
</table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
  <tr>
    <td align="center" valign="top">
    	<table width="100%" bordercolordark="#ffffff" bordercolorlight="#4787b8" border="0" cellpadding="0" cellspacing="0">
        	<tr align="center"> 
        	  <td colspan="10" nowrap>
			  <form name="stats" action="statcardregaction.jsp" method="get">
			  <table width="100%"   border="1" cellspacing="0" cellpadding="0" bordercolorlight="#4787b8" bordercolordark="#FFFFFF">
                <tr> 
                  <td width="27%"><div align="center">统计时间设定：</div></td>
                  <td width="73%" height="30" colspan="2"> 从 
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
                        </select>
					</td>
                </tr>
                <tr> 
                  <td colspan="3"><div align="center"> 
                      <p> 
                        <input type="submit" name="Submit" value="  统  计  " onclick="checkform();return false;">
                      </p>
                    </div></td>
                </tr>
              </table>
            </form></td>
       	  </tr>
   	  </table>
    </td>
  </tr>
</table>
</body>
</html>
