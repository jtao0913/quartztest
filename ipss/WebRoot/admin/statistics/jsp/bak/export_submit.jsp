<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.analyse.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String operation=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"operation");
String userName=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"userName");
String time_from=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"time_from");
String time_to=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"time_to");

String file_path=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"file_path");

//file_path="D:\\bb.txt";

DBConn dbconn=new DBConn();
ResultSet rs = null;
String strSQL="";
String  strGrant="0";
            if(operation.equals("print"))
            {
               strSQL="select intGrantID from ipr_grant where chrGrantName like '%打印%'";
               rs = dbconn.executeQuery(strSQL);
               while(rs.next())
               {
                   strGrant=strGrant+","+rs.getString("intGrantID");
               }
            }
            if(operation.equals("download"))
            {
               strSQL="select intGrantID from ipr_grant where chrGrantName like '%下载%'";
               rs = dbconn.executeQuery(strSQL);
               while(rs.next())
               {
                   strGrant=strGrant+","+rs.getString("intGrantID");
               }
            }
            if(operation.equals("all"))
            {
               strSQL="select intGrantID from ipr_grant where chrGrantName like '%下载%' or chrGrantName like '%打印%'";
               rs = dbconn.executeQuery(strSQL);
               while(rs.next())
               {
                   strGrant=strGrant+","+rs.getString("intGrantID");
               }
            }
//------------------------------------------
boolean b0=false;
String str_ex="";
try{
		FileOutputStream fos = new FileOutputStream(file_path);
		OutputStreamWriter osw = new OutputStreamWriter(fos);
		BufferedWriter bw = new BufferedWriter(osw);

//------------------------------------------
	strSQL="select ipr_all_logs.chrAPO,ipr_all_logs.dtVisitTime,ipr_all_logs.chrUserName,ipr_all_logs.chrAPO,"
			+"ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant "
			+"where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime<='"+time_to
			+"' and ipr_all_logs.dtVisitTime>='"+time_from+"' and ipr_all_logs.chrUserName like '%"+userName
			+"%' and ipr_all_logs.intGrantID in("+strGrant+") order by dtVisitTime desc";
			
//System.out.println(strSQL);
			
rs = dbconn.executeQuery(strSQL);
String strdes="";
            while(rs.next())
            {
strdes = new StringBuffer().append(rs.getString("ipr_all_logs.chrUserName"))
		.append("   ").append(rs.getString("ipr_all_logs.dtVisitTime"))
		.append("   ").append(rs.getString("ipr_grant.chrGrantName")+" "+rs.getString("ipr_all_logs.chrAPO")+" "+" 第"+rs.getString("ipr_all_logs.intAPOPage")+"页").toString();

//System.out.println(strdes);	
	
		bw.write(strdes, 0, strdes.length());
		bw.newLine();
/*			
                userNames[i]=rs.getString("ipr_all_logs.chrUserName");
                visitTimes[i]=rs.getString("ipr_all_logs.dtVisitTime");
                strOperation=rs.getString("ipr_grant.chrGrantName");
                strAPO=rs.getString("ipr_all_logs.chrAPO");
                strAPOPage=rs.getString("ipr_all_logs.intAPOPage");
                operationAlls[i]=strOperation+" "+strAPO+" "+" 第"+strAPOPage+"页";
*/
				strdes="";
            }
			bw.close();
			b0=true;
}catch(FileNotFoundException ex){
//out.println("请正确填写文件路径");
str_ex=ex.toString();
//out.println(ex.toString());
}
if(b0==true){
%>
<script>
window.close();
</script>
<%}else{%>
<script>
alert("请正确填写文件路径");
window.close();
</script>
<%}%>