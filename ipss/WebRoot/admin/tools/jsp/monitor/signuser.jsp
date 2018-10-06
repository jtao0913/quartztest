<%@ page contentType="text/html; charset=GBK" errorPage="../../../jsp/error.jsp"%>
<%@ include file="../../../inc/head.jsp" %>
<%	//修改用户状态
	int siteID = 0;
	Connection conn = null;
	ConPool	   conPool = null;
	String sid = null;	//用户sessionID
	String strAbortURL = "connect.jsp";
	String strRetryURL = "consolemonitor.jsp";
	String strErrorFrom = "tools/jsp/monitor/signuser.jsp"; //定义错误来源
	String strPowerCheckMethodName = "getManageLogSourceGrant"; //定义执行权限验证所使用的方法
	
	try //统一异常处理
	{
%>
		<!--判断管理员是否已经登录-->
		<%@ include file="../../../inc/checkuser.jsp" %>
		<!--判断管理员是否具有管理的权限-->
		<%@ include file="../../../inc/checkpower.jsp" %>
<%
		MapLoginusers mapLoginusers = (MapLoginusers)application.getAttribute("mapLoginusers");
		if (mapLoginusers == null)
		{
			mapLoginusers = new MapLoginusers();
			application.setAttribute("mapLoginusers",mapLoginusers);
		}
		WASConfig wasConfig = (WASConfig)application.getAttribute("wasconfig"); //获得TRS WAS配置信息对象
		if(wasConfig==null)
		{
			wasConfig = new WASConfig();
			application.setAttribute("wasconfig",wasConfig);
		}
		sid = RequestParameterOperation.getParameter(request,"sid");
		if (sid == null || sid.trim().equals(""))
		{
			throw new  WASException("606#sid为空#login.jsp#传递参数类型为空(sid)");
		}
		sid = sid.trim();
		UserMessage userMessage = mapLoginusers.getUserBySid(sid);
		if (userMessage == null)
		{
			throw new WASException("600#未能从MapLoginusers中取得用户信息#template_edit.jsp#该用户对象不存在（Null）");
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
		wase.setAbortURL(strAbortURL);    //设置放弃时回到用户列表页
		wase.setRetryURL(strRetryURL);    //设置重试时回到新建用户页
		session.setAttribute("was_exception",wase);  
		throw wase;  
	}
	catch(Exception e)
	{
		// 统一异常处理 处理错误部分
		WASException wase = new WASException("604#内部错误#create_channel_2rdb.jsp#"+e.getMessage()); //构造新的WASException对象
		wase.setAbortURL(strAbortURL);    //设置放弃时回到用户列表页
		wase.setRetryURL(strRetryURL);    //设置重试时回到新建用户页
		session.setAttribute("was_exception",wase);   //将新的异常对象保存到session中，以便在报错页error.jsp中获得
		throw wase;  
	}
	finally
	{
	//必须执行部分
		if( conn != null &&  conn instanceof Connection ) 
		{
			DataSourceOperation.close(conn);//关闭数据库连结
			conn = null;
		}
	}
%>