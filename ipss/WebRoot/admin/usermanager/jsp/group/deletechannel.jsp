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
                String   channelIDs[]=request.getParameterValues("sel");
                Resource resource=new Resource();
                for(int i=0;i<channelIDs.length;i++)
                {
                  resource.deleteChannel(Integer.parseInt(channelIDs[i]));
                }
                response.sendRedirect("ChannelList.jsp");
%>
