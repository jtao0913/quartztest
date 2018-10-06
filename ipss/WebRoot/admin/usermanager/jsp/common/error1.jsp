<%@ page pageEncoding="GBK"%>
<%@page isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>error</title>
</head>
<%

//取参数
String act=request.getParameter("act");
//out.println("act = "+act);
String strErr="";
if (act.equals("add"))
{
	//out.println("更新用户信息失败");
	strErr="更新用户信息失败";	
}
else if(act.equals("addsame"))
{
	//out.println("重名了,请用其他名字！");
	strErr="重名了,请用其他名字！";	
}
else if(act.equals("mend"))
{
	//out.println("更新用户信息失败");
	strErr="更新用户信息失败";	
}
else if(act.equals("mendsame"))
{
	//out.println("重名了,请用其他名字！");
	strErr="重名了,请用其他名字！";	
}
else if(act.equals("mendareasame"))
{
	//out.println("重名了,请用其他名字！");
	strErr="已经有此地区用户了,请用其他地区！";	
}
%>
<br>

<body>
<table width="500" border="0" align="center">
  <tr>
    <td width="168"><img src="../../images/success.gif"></td>
    <td width="322">
      <div align="center">
        <p><%=strErr%></p>
        <p><br>
          <a href="#" onclick="javascript:history.go(-1)"><img src="../../images/retry.gif" border="0"></a>
          <a href="#" onclick="javascript:self.close()"><img src="../../images/cancel1.gif"  border="0"></a>
        </p>
    </div></td>
  </tr>
</table>
</body>
</html>
