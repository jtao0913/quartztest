<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.trs.analyse.*" %>
<%@ page import="java.text.*"%>

<body>
<%
String operation=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"operation");
String userName=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"userName");

String time_from=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"time_from");
String time_to=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"time_to");
/*
out.println(time_from);
out.println("<br>");
out.println(time_to);
out.println("<br>");
*/
String str_path=application.getRealPath("");
//out.println(str_path);
%>
<p>请输入目标文件路径：
<table width="243" border="0" cellspacing="0" cellpadding="0">
<form action="export_submit.jsp">
<input type="hidden" name="operation" value="<%=operation%>">
<input type="hidden" name="userName" value="<%=userName%>">
<input type="hidden" name="time_from" value="<%=time_from%>">
<input type="hidden" name="time_to" value="<%=time_to%>">
  <tr>
    <td width="181"><input name="file_path" type="text" value="<%=str_path.substring(0,3)%>"></td>
    <td width="62"><input type="submit" name="Submit" value="开始生成"></td>
  </tr></form>
</table>

</body>
</html>