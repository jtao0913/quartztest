<%@ page language="java" import="java.util.*,com.trs.usermanage.UserManage,com.trs.usermanage.Hangye,com.cnipr.cniprgz.entity.ChannelInfo" pageEncoding="utf-8"%>

<%@ include file="../../jsp/zljs/include-head-base.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
<% 
int intAdminId = Integer.parseInt((String)request.getSession().getAttribute("userid"));

String parentID=request.getAttribute("parentid")==null?"0":request.getParameter("parentid");
//System.out.println("parentID="+parentID);
//strSearchData=searchData.getSearchWord();
//strSearchChannels = searchData.getSearchChannel();
int intMaxSearchCount=request.getAttribute("intMaxSearchCount")==null?0:Integer.parseInt((String)request.getAttribute("intMaxSearchCount"));

int id=0;
String action="";
String chrName="";
int intSequenceNum=0;
String chrMemo="";
String chrExpression="";
String chrFRExpression="";

List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.getAttribute("channelInfoList_cn");
List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.getAttribute("channelInfoList_fr");

String allCNChannelIDs = "";
String allFRChannelIDs = "";

Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
while(iter.hasNext())
{
	ChannelInfo ci = iter.next();
	if(!allCNChannelIDs.equals("")){
		allCNChannelIDs += ",";
	}
	allCNChannelIDs += ci.getIntChannelID();
}

iter = channelInfoList_fr.iterator();
while(iter.hasNext())
{
	ChannelInfo ci = iter.next();
	if(!allFRChannelIDs.equals("")){
		allFRChannelIDs += ",";
	}
	allFRChannelIDs += ci.getIntChannelID();
}

String chrCNChannels=(request.getParameter("CNChannels")==null || ((String)request.getParameter("CNChannels")).trim().equals(""))?allCNChannelIDs:(String)request.getParameter("CNChannels");
//System.out.println("值--："+chrCNChannels);
String chrFRChannels=(request.getParameter("FRChannels")==null || ((String)request.getParameter("FRChannels")).trim().equals(""))?allFRChannelIDs:(String)request.getParameter("FRChannels");
//System.out.println("值--："+chrFRChannels);

if (request.getAttribute("id") != null && !request.getAttribute("id").equals("")){
id=Integer.parseInt((String)request.getAttribute("id"));}
if (request.getAttribute("action") != null && !request.getAttribute("action").equals("")){
action=(String)request.getAttribute("action");}

String intType = request.getParameter("intType");
if(intType==null  || intType.equals(""))
	intType = "1";
//out.println("<br>");
//out.println("action : " + action);
//out.println("<br>");

intSequenceNum = request.getAttribute("SequenceNum")==null?0:Integer.parseInt((String)request.getAttribute("SequenceNum"));
//String chrCNChannelNames=(request.getAttribute("CNChannels")==null || ((String)request.getAttribute("CNChannels")).trim().equals(""))?"14,15,16":(String)request.getAttribute("CNChannels");
//String chrFRChannelNames=(request.getAttribute("FRChannels")==null || ((String)request.getAttribute("FRChannels")).trim().equals(""))?"18,19,20,21,22,23,24,25":(String)request.getAttribute("FRChannels");

chrExpression = request.getAttribute("chrExpression")==null?"":(String)request.getAttribute("chrExpression");
chrFRExpression = request.getAttribute("chrFRExpression")==null?"":(String)request.getAttribute("chrFRExpression");
/*
if(chrExpression!=null && !chrExpression.equals("")){
	chrExpression=getSearchFormat.preprocess(chrExpression);
}
if(chrFRExpression!=null && !chrFRExpression.equals("")){
	chrFRExpression=getSearchFormat.preprocess(chrFRExpression);
}
*/
//chrExpression = chrExpression.replaceAll("'","''").trim();
//chrFRExpression = chrFRExpression.replaceAll("'","''").trim();

if (request.getAttribute("name") != null && !request.getAttribute("name").equals(""))
{chrName=(String)request.getAttribute("name");}
System.out.println(chrName);
if (request.getAttribute("memo") != null && !request.getAttribute("memo").equals(""))
{chrMemo=(String)request.getAttribute("memo");}

/*
if (request.getParameter("chrExpression") != null && !request.getParameter("chrExpression").equals("")){
chrExpression=new String(request.getParameter("chrExpression").getBytes("8859_1"),"GBK");
}

if (request.getParameter("chrFRExpression") != null && !request.getParameter("chrFRExpression").equals("")){
chrFRExpression=new String(request.getParameter("chrFRExpression").getBytes("8859_1"),"GBK");
}
*/

Hangye hangye=new Hangye();

try{
//	chrCNChannels=(request.getAttribute("CNChannels")==null || ((String)request.getAttribute("CNChannels")).trim().equals(""))?"14,15,16":(String)request.getAttribute("CNChannels");
//	chrFRChannels=(request.getAttribute("FRChannels")==null || ((String)request.getAttribute("FRChannels")).trim().equals(""))?"18,19,20,21,22,23,24,25":(String)request.getAttribute("FRChannels");
	//System.out.println("hangye.getTRSTableIDs之前："+chrCNChannels);
//	chrCNChannels=hangye.getTRSTableIDs(chrCNChannels);
	//System.out.println("hangye.getTRSTableIDs之后："+chrCNChannels);
//	chrFRChannels=hangye.getTRSTableIDs(chrFRChannels);

	chrExpression = chrExpression.replaceAll("'","''").trim();
	chrFRExpression = chrFRExpression.replaceAll("'","''").trim();

	if (action.equals("newnode"))
	{
//int intParentID,String chrName,String chrMemo,String chrExpression,String chrFRExpression,String strAdminName
//System.out.println("com.trs.was.taglib.SearchReport-->searchData.getAllSearchWord() = " + searchData.getAllSearchWord());
//System.out.println("$$$$$$$$$$$$$$chrCNChannels = " + chrCNChannels);
//System.out.println("$$$$$$$$$$$$$$chrFRChannels = " + chrFRChannels);
//System.out.println("$$$$$$$$$$$$$$ = " + id);
		int addok=hangye.insertInfo(id,intSequenceNum,chrName,chrMemo,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels,intAdminId,intType);
		if(addok==1){

//System.out.println("parentID="+parentID);
%>		
<script>
	//parent.window.topFrame.location.reload();
	alert("您已经成功的向数据库添加了这条数据！");
	//history.go(-1);
	parent.window.topFrame.location.href="<%=basePath%>admin/hangye/list.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=parentID%>&intType=<%=intType%>";
	parent.window.mainFrame.location.href="<%=basePath%>admin/hangye/detail.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=parentID%>&intType=<%=intType%>";
</script>
<%				
		}
		if(addok==-1){
%>		
<script>
	alert("添加数据失败，请检查！");
</script>
<%
		}
	}
	else if (action.equals("editnode"))
	{
		int addok=hangye.editInfo(id,intSequenceNum,chrName,chrMemo,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels,intAdminId);
		if(addok==1){
%>		
<script>
	alert("您已经成功的修改了这条数据！");
	//history.go(-1);
	parent.window.topFrame.location.href="<%=basePath%>admin/hangye/list.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=parentID%>&intType=<%=intType%>";
	parent.window.mainFrame.location.href="<%=basePath%>admin/hangye/detail.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=parentID%>&intType=<%=intType%>";
</script>
<%				
		}
		if(addok==-1){
%>		
<script>
	alert("修改数据失败，请检查！");
	parent.window.mainFrame.location.href="<%=basePath%>admin/hangye/detail.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&intType=<%=intType%>";
</script>
<%
		}
	}
	else if (action.equals("deletenode")){
		hangye.deleteAll(id,intAdminId);
%>
<script>
//list.jsp刷新
	alert("您已经成功的从数据库中删除了这条数据！");
	//history.go(-1);
	//top.window.mainFrame.form1.Submit1.disabled=true;
	parent.window.topFrame.location.href="<%=basePath%>admin/hangye/list.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&parentid=<%=parentID%>&intType=<%=intType%>";
	parent.window.mainFrame.location.href="<%=basePath%>admin/hangye/detail.jsp?intMaxSearchCount=<%=intMaxSearchCount%>&intType=<%=intType%>";
</script>
<%		
	}
}
catch(Exception ex)
{

}
%>
  </body>
</html>
