<%@ page pageEncoding="GBK"%>
<%@page isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>error</title>
</head>
<%

//ȡ����
String act=request.getParameter("act");
//out.println("act = "+act);
String strErr="";
if (act.equals("add"))
{
	//out.println("�����û���Ϣʧ��");
	strErr="�����û���Ϣʧ��";	
}
else if(act.equals("addsame"))
{
	//out.println("������,�����������֣�");
	strErr="������,�����������֣�";	
}
else if(act.equals("mend"))
{
	//out.println("�����û���Ϣʧ��");
	strErr="�����û���Ϣʧ��";	
}
else if(act.equals("mendsame"))
{
	//out.println("������,�����������֣�");
	strErr="������,�����������֣�";	
}
else if(act.equals("mendareasame"))
{
	//out.println("������,�����������֣�");
	strErr="�Ѿ��д˵����û���,��������������";	
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
