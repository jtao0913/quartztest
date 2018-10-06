<%@ page contentType="text/html; charset=GBK"  errorPage="../../jsp/error.jsp" %>
<%@ page import="com.trs.usermanage.*"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
////定义接受参数
	String trsServer ="" ;  //ip
	String trsServerPort = ""; //连接port
	String trsServerUser = ""; //用户名
	String trsServerPass = ""; //密码
	int    intTrsServerPort=0;
	
	trsServer=request.getParameter("ip");
	trsServerPort=request.getParameter("conport");
	trsServerUser=request.getParameter("conusername");
	trsServerPass=request.getParameter("conpassword");
	intTrsServerPort=Integer.parseInt(trsServerPort);
	
	TRSSource trssource=new TRSSource();

	try //统一异常处理
	{
	        trssource.updateTRSSource(trsServer,intTrsServerPort,trsServerUser,trsServerPass);
		//执行成功页跳转
		String redirectURL ="../../jsp/success.jsp"; //重定向页面 
		session.setAttribute("f_url","javaScript:window.location=\"../system/jsp/dbcon_modif.jsp\";window.close();");
		
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location",redirectURL);
	}
	catch(Exception e)
	{
	}

%>
