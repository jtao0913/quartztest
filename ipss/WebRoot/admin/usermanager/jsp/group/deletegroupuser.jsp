<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //�û���ǰ��¼����
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("���ĵ�¼�Ѿ�ʧЧ��");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<%
        //������������ò���
        String[]   strUserIDs=request.getParameterValues("sel"); 
		String     strGroupID=request.getParameter("groupid");
        UserManage usermanage=new UserManage();
        for(int i=0;i<strUserIDs.length;i++)
        {
            usermanage.deleteUser(Integer.parseInt(strUserIDs[i]));
        }
        response.sendRedirect("groupuser.jsp?groupid="+strGroupID);
%>