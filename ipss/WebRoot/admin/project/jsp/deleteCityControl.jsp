<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
        String  ipMemo=request.getParameter("ipMemo");
        if(ipMemo!=null)
	{
	  ipMemo=new String(ipMemo.getBytes("8859_1"),"GBK");
	}
	IPLimit iplimit=new IPLimit();
	if(iplimit.deleteIPLimit(ipMemo)==-1)
	{
	     response.sendRedirect("iperror.jsp?act=delete");
	}
	response.sendRedirect("useCityIPLimit.jsp");
%>