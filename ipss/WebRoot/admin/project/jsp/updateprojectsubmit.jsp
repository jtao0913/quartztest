<%@ page contentType="text/html; charset=GBK"  errorPage="../../jsp/error.jsp" %>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
        String SMTPServer=null;
        String strSMTPServerPort=null;
        int    SMTPServerPort=0;
        String SMTPServerUser=null;
        String SMTPServerPass=null;
        String strSMTPVerify=null;
        int    SMTPVerify=0;
        String SMTPReplyAddress=null;
        SMTPSource smtpsource=new SMTPSource();
        
        SMTPServer=request.getParameter("SMTPServer");
        strSMTPServerPort=request.getParameter("SMTPServerPort");
        SMTPServerUser=request.getParameter("SMTPServerUser");
        SMTPServerPass=request.getParameter("SMTPServerPass");
        strSMTPVerify=request.getParameter("SMTPServerVerify");
        SMTPReplyAddress=request.getParameter("SMTPReplyMailAddress");
        
        SMTPServerPort=Integer.parseInt(strSMTPServerPort);
        SMTPVerify=Integer.parseInt(strSMTPVerify);
        
        try
        {
          smtpsource.updateSMTPSource(SMTPServer,SMTPServerPort,SMTPServerUser,SMTPServerPass,SMTPVerify,SMTPReplyAddress);
	  
	  //执行成功页跳转
	  String redirectURL ="../../jsp/success.jsp"; //重定向页面 
	  session.setAttribute("f_url","javaScript:window.location=\"../project/jsp/updateproject.jsp\";window.close();");
	
	  response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	  response.setHeader("Location",redirectURL);
	}
	catch(Exception e)
	{}
%>
