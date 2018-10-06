<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.trs.usermanage.*"%>
<%
	 GroupManage groupmanage=new GroupManage();
	 String groupName=request.getParameter("groupname");
	 String itemGrants[]=request.getParameterValues("opers");
	 String groupMemo=request.getParameter("memo");
	 String itemGrant=null;
	 if(groupName!=null)
	 {
	     groupName=new String(groupName.getBytes("8859_1"),"GBK");
	 }
	 if(groupMemo!=null)
	 {
	     groupMemo=new String(groupMemo.getBytes("8859_1"),"GBK");
	 }
	 for(int i=0;i<itemGrants.length;i++)
	 {
	   if(i==0)
	   {
	       itemGrant=itemGrants[i];
	   }
	   else
	   {
	       itemGrant=itemGrant+","+itemGrants[i];
	   }
	 }
	 int groupok=0;
	 String tip="Ìí¼Ó³É¹¦!";
	 tip=new String(tip.getBytes("GBK"),"8859_1");
	 groupok=groupmanage.addGroup(groupName,groupMemo,itemGrant,itemGrants);
	 if(groupok==-1)
	 {
	   response.sendRedirect("grouperror.jsp?act=add");
	 }
	 if(groupok==-2)
	 {
	   response.sendRedirect("grouperror.jsp?act=addsame");
	 }
	 response.sendRedirect("../common/success.jsp?tip="+tip+"&act=goon");
%>


