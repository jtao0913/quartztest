<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>

<%@ page import="com.trs.usermanage.*"%>
 
<%
//LoginConfig loginConfig; //�û���ǰ��¼����
 
%>
<%
    String strGroupIDs[]=request.getParameterValues("sel");
 
	GroupManage groupmanage=new GroupManage();
	for(int i=0;i<strGroupIDs.length;i++)
	{
	   groupmanage.deleteGroup(Integer.parseInt(strGroupIDs[i]));
	}
	response.sendRedirect("grouplist.jsp");
%>