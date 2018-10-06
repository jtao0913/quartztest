<%@ page contentType="text/html; charset=GBK" errorPage="../../../jsp/error.jsp"%>
<%@ include file="../../../inc/head.jsp" %>
<%	//�޸��û�״̬
	int siteID = 0;
	Connection conn = null;
	ConPool	   conPool = null;
	String sid = null;	//�û�sessionID
	String strAbortURL = "connect.jsp";
	String strRetryURL = "consolemonitor.jsp";
	String strErrorFrom = "tools/jsp/monitor/signuser.jsp"; //���������Դ
	String strPowerCheckMethodName = "getManageLogSourceGrant"; //����ִ��Ȩ����֤��ʹ�õķ���
	
	try //ͳһ�쳣����
	{
%>
		<!--�жϹ���Ա�Ƿ��Ѿ���¼-->
		<%@ include file="../../../inc/checkuser.jsp" %>
		<!--�жϹ���Ա�Ƿ���й����Ȩ��-->
		<%@ include file="../../../inc/checkpower.jsp" %>
<%
		MapLoginusers mapLoginusers = (MapLoginusers)application.getAttribute("mapLoginusers");
		if (mapLoginusers == null)
		{
			mapLoginusers = new MapLoginusers();
			application.setAttribute("mapLoginusers",mapLoginusers);
		}
		WASConfig wasConfig = (WASConfig)application.getAttribute("wasconfig"); //���TRS WAS������Ϣ����
		if(wasConfig==null)
		{
			wasConfig = new WASConfig();
			application.setAttribute("wasconfig",wasConfig);
		}
		sid = RequestParameterOperation.getParameter(request,"sid");
		if (sid == null || sid.trim().equals(""))
		{
			throw new  WASException("606#sidΪ��#login.jsp#���ݲ�������Ϊ��(sid)");
		}
		sid = sid.trim();
		UserMessage userMessage = mapLoginusers.getUserBySid(sid);
		if (userMessage == null)
		{
			throw new WASException("600#δ�ܴ�MapLoginusers��ȡ���û���Ϣ#template_edit.jsp#���û����󲻴��ڣ�Null��");
		}
		//mapLoginusers.removeUser(userMessage);
		boolean state = userMessage.getUserState();
		if (state)
		{
			state = false;
		}
		else
		{
			state = true;
		}
		
		userMessage.setUserState(state);
		String strUrl ="consolemonitor.jsp";
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location",strUrl) ;
	}
	catch(WASException wase)
	{
		wase.setAbortURL(strAbortURL);    //���÷���ʱ�ص��û��б�ҳ
		wase.setRetryURL(strRetryURL);    //��������ʱ�ص��½��û�ҳ
		session.setAttribute("was_exception",wase);  
		throw wase;  
	}
	catch(Exception e)
	{
		// ͳһ�쳣���� ������󲿷�
		WASException wase = new WASException("604#�ڲ�����#create_channel_2rdb.jsp#"+e.getMessage()); //�����µ�WASException����
		wase.setAbortURL(strAbortURL);    //���÷���ʱ�ص��û��б�ҳ
		wase.setRetryURL(strRetryURL);    //��������ʱ�ص��½��û�ҳ
		session.setAttribute("was_exception",wase);   //���µ��쳣���󱣴浽session�У��Ա��ڱ���ҳerror.jsp�л��
		throw wase;  
	}
	finally
	{
	//����ִ�в���
		if( conn != null &&  conn instanceof Connection ) 
		{
			DataSourceOperation.close(conn);//�ر����ݿ�����
			conn = null;
		}
	}
%>