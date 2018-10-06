<%@ page contentType="text/html;charset=UTF-8" errorPage="/error.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>专利信息服务平台</title>

<script language="JavaScript" src="js/statistic_account.js"></script>
<style type="text/css">
	body{font-size:11pt;}
	td{font-size:11pt;}
	.exheading {font-weight: bold; cursor: hand}
	.Arraw {color:#FFFFFF; cursor:hand; font-family:Webdings; font-size:14pt}
</style>
<script language="JavaScript" type="text/javascript">
<!--
function userStatusSubmit()
{
   document.form1.action="";
   document.form1.submit();
}
-->
</script>
</head>

<body topmargin="0"  leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#FAFFFF">
<center>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
   <tr> 
     <td ><div align="center"><img src="<%=basePath%>images/user/index_38.gif" width="620"></div></td>
   </tr>
    <tr style="display:none;"> 
       <td height="19"><div align="center"><img src="<%=basePath%>images/user/index_35.gif" width=286 height=19 alt=""></div></td>
     </tr>
</table>
<br>
<%
int intCHCount = 0;
int intFRCount = 0;

intCHCount=(Integer)request.getSession().getAttribute("intCHCount");
intFRCount=(Integer)request.getSession().getAttribute("intFRCount");

//out.print("您的国内数据剩余权限为： "+intCHCount+"页");
//out.print("，您的国外数据剩余权限为: "+intFRCount+"页");


%>
<br>

<form name="form1" method="post" action="<%=basePath%>user.do?method=getUserLogs">
<table width="100%" border="1"  cellspacing="1" cellpadding="0" bordercolorlight="#4787b8">

	<tr  height="32" style="display:none;">
		<td>统计时间：</td>
		<td>从
			<select name="startyear" onChange="hideday()">
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
                        <select name="startmonth" onChange="hideday()">
                          <option value="01">1</option>
                          <option value="02">2</option>
                          <option value="03">3</option>
                          <option value="04">4</option>
                          <option value="05">5</option>
                          <option value="06" selected>6</option>
                          <option value="07">7</option>
                          <option value="08">8</option>
                          <option value="09">9</option>
                          <option value="10">10</option>
                          <option value="11">11</option>
                          <option value="12">12</option>
                        </select>
                        月 
                        <select name="startday" onChange="return check()">
                          <script language="javascript">
                  for(var k=1;k<32;k++)
                  {
                	if(k<10)
                  	{
				if (k==6) {
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
                        <select name="endyear" onChange="hideday1()">
					<script language="javascript">
                  for(var m=1;m<15;m++)
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
                                      <select name="endmonth" onChange="hideday1()">
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
                                      <select name="endday" onChange="return check()">
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
	<tr style="display:none;">
		<td colspan="2" align="center" height="25">
			<input type="submit" name="statlogs"  value="统计日志">
        <input type="reset" name="reset" value="还 原">
        <input type="button" name="Submit4" value="关 闭" onClick="javascript:window.close();"> </td>
	</tr>
	<tr >
		
      <td colspan="2" align="center" height="25"> 
        <input type="button" name="Submit" value="修改密码" onClick="javascript:window.open('passwdchange.jsp');">
        <input type="button" name="Submit2" value="修改信息" onClick="javascript:window.open('<%=basePath%>user.do?method=getChangeInfoPage');">
        <input type="button" name="Submit3" value="用户状态" onClick="javascript:window.open('userstatus.jsp');"> </td>
	</tr>
</table>
</form>
<p align="center" style="display:none;">所有统计数据的统计时间：2005年6月6日系统升级——<%=(new java.util.Date()).getYear()+1900%>年<%=(new java.util.Date()).getMonth()+1%>月<%=(new java.util.Date()).getDate()%>日<%=(new java.util.Date()).getHours()%>时<%=(new java.util.Date()).getMinutes()%>分
</body>
</html>