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
          out.println("���������Ϣ����<a href=\"useCityIPLimit.jsp\">������</a>��");
        }
        if(act.equals("addsame"))
        {
          out.println("����ӵ�IP��˵���Ѵ��ڣ�������µ�˵����<a href=\"useCityIPLimit.jsp\">������</a>��");
        }
        if(act.equals("mend"))
        {
          out.println("�����޸���Ϣ����<a href=\"useCityIPLimit.jsp\">������</a>��");
        }
        
%>