<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.trs.usermanage.DBConnect" %>
<%
class toTxt{
	private  Connection connection = null;
	
		public void init(javax.servlet.jsp.JspWriter out,javax.servlet.http.HttpServletRequest request) throws Exception {
			out.println("<title>用jsp种树</title>");
			//dowith(request);
			
			String sdir=request.getParameter("txtSavePath");
//			String filePath="D:"+ File.separator;
			String filePath=sdir+ File.separator;

			
			FileOutputStream fos = new FileOutputStream(filePath+"navtable.txt");
			OutputStreamWriter osw = new OutputStreamWriter(fos);
			BufferedWriter bw = new BufferedWriter(osw);
			
			
		Connection conn = null;
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;

			conn = DBConnect.getConnection();
			String strSQL = "select * from ipr_navtable where intType=1";
			
			PrePareStmt = conn.prepareStatement(strSQL);
		    rs = PrePareStmt.executeQuery();
	
			
			while(rs.next())
			{
				String str="";
				String strdes=null;
				
				strdes = new StringBuffer().append(rs.getInt("intID"))
						.append(",")
						.append("\""+rs.getString("chrName").trim()+"\"")
						.append(",")
						.append("\""+(rs.getString("chrExpression")==null ? "" : rs.getString("chrExpression")).trim()+"\"")
						.append(",")
						.append("\""+(rs.getString("chrFRExpression")==null ? "" : rs.getString("chrFRExpression")).trim()+"\"")
						.append(",null,")
						.append(rs.getInt("intParentID"))
						.append(",")
						.append(rs.getInt("intType"))
						.append(",")
						.append("\""+(rs.getString("chrMemo")==null ? "" : rs.getString("chrMemo")).trim()+"\"")
						.toString();        	
	
			
				bw.write(strdes, 0, strdes.length());
				bw.newLine(); // 断行
			}
			bw.close();
		}	
}
%>
<%
		String sdir=request.getParameter("txtSavePath");
		toTxt totxt = new toTxt();
		if(sdir!=null){
			totxt.init(out, request);
		}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'navtable.jsp' starting page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<object id=PatTifAcTiveX1 height=0 width=0 classid="clsid:C7D7CC85-4485-41AC-BBFB-39BD95481DAE" border="0"></object>
<script>
function getSavePath()
{
	var strSavePath = PatTifAcTiveX1.CtrGetPath();
	if(strSavePath != null && strSavePath != "")
		document.all.txtSavePath.value = strSavePath;
}
function formsubmit()
{
	var sdir=document.form1.txtSavePath.value;
	sdir=sdir.replace(/(^\s*)|(\s*$)/g, "");
	if(sdir==null || sdir==""){
		alert("请选择文件保存路径");
		return false;
	}
}
String.prototype.trim=function(){
        return this.replace(/(^\s*)|(\s*$)/g, "");
}
</script>
  </head>
  
  <body>
    <table>
<tr height="28">
<form name="form1" method="post" action="">
      <td align="left"><input type="text" name="txtSavePath" value=""><input id="btnPath" type=button value="浏览.." onclick="getSavePath()" style="width:48px"></td>
   	  <td><input type="submit" name="Submit" value="生成行业信息" onClick="return formsubmit()"></td>
</form>
</tr>
</table>
  </body>
</html>
