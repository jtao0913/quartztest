<%@ page contentType="text/html; charset=GBK"  errorPage="../../jsp/error.jsp" %>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
////������ܲ���
	String trsServer ="" ;  //ip
	String trsServerPort = ""; //����port
	String trsServerUser = ""; //�û���
	String trsServerPass = ""; //����
	int    intTrsServerPort=0;
	
	trsServer=request.getParameter("ip");
	trsServerPort=request.getParameter("conport");
	trsServerUser=request.getParameter("conusername");
	trsServerPass=request.getParameter("conpassword");
	intTrsServerPort=Integer.parseInt(trsServerPort);
	
	TRSSource trssource=new TRSSource();

	try //ͳһ�쳣����
	{
	        trssource.updateTRSSource(trsServer,intTrsServerPort,trsServerUser,trsServerPass);
		//ִ�гɹ�ҳ��ת
		String redirectURL ="../../jsp/success.jsp"; //�ض���ҳ�� 
		session.setAttribute("f_url","javaScript:window.location=\"../system/jsp/dbcon_modif.jsp\";window.close();");
		
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location",redirectURL);
	}
	catch(Exception e)
	{
	}

%>
