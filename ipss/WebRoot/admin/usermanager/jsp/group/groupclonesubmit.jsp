<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.trs.usermanage.*"%>
<%
	 GroupManage groupmanage=new GroupManage();
	 String groupName=request.getParameter("groupname");
	 String itemGrants[]=request.getParameterValues("opers");
	 String groupMemo=request.getParameter("memo");
	 String itemGrant=null;
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
	 String tip="添加成功!";
	 //tip=new String(tip.getBytes("GBK"),"utf-8");
	 groupok=groupmanage.addGroup(groupName,groupMemo,itemGrant,itemGrants);
	 if(groupok==-1)
	 {
	   response.sendRedirect("grouperror.jsp?act=add");
	 }else if(groupok==-2)
	 {
		 response.sendRedirect("../common/success.jsp?act=addsame");
	   //response.sendRedirect("grouperror.jsp?act=addsame");
	 } else {
		 response.sendRedirect("../common/success.jsp?tip="+tip+"&act=goon");
	 }
	 
%>


