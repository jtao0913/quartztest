<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.trs.usermanage.*"%>
<%
     String strGroupID=request.getParameter("groupid");
	 int    intGroupID=Integer.parseInt(strGroupID);
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
	 String tip="修改成功!";
	// tip=new String(tip.getBytes("GBK"),"8859_1");
	 groupok=groupmanage.updateGroup(intGroupID,groupName,groupMemo,itemGrant,itemGrants);
	 if(groupok==-1)
	 {
	   response.sendRedirect("grouperror.jsp?act=mend");
	 }
	 if(groupok==-2)
	 {
	   response.sendRedirect("grouperror.jsp?act=mendsame");
	 }
	 response.sendRedirect("../common/success.jsp?tip="+tip);
%>


