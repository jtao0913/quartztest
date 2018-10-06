<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
%>
<%
        String  act=request.getParameter("act");
        if(act.equals("add"))
        {
          out.println("您的添加信息有误，<a href=\"useCityIPLimit.jsp\">请重试</a>！");
        }
        if(act.equals("addsame"))
        {
          out.println("您添加的IP段说明已存在，请更换新的说明，<a href=\"useCityIPLimit.jsp\">请重试</a>！");
        }
        if(act.equals("mend"))
        {
          out.println("您的修改信息有误，<a href=\"useCityIPLimit.jsp\">请重试</a>！");
        }
        
%>