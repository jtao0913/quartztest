<%
/**
  *	获得TRS WAS配置信息中保存的用户授权信息的集合(GrantCheck)
  * 1.在调用之前，请设置以下变量的值
  		String strErrorFrom = ""; //定义执行用户登录判断的页面，如果需要和checkpower共同使用的话，请使用相同的页面
    2.请不要定义以下变量
  		UserMessage oGrantGetUserMessage = null; //记录用户的登录信息
  		WASConfig oGrantGetWASConfig = null; //记录TRS WAS的配置信息
  		WASException eGrantGetWAS = null; //定义执行用户权限判定时的WASException
  		Exception eGrantGet = null; //定义执行用户权限判定时的Exception
  		WASException eGrantGetFinalWAS = null; //定义执行用户权限判定后最后抛出的WASException
  	3.调用的时候，请放到try{中间
  */

GrantCheck m_grant = null;

try //统一获得GrantCheck时的异常
{
	try{
		//获得用户的登录信息
		UserMessage oGrantGetUserMessage = (UserMessage)session.getAttribute("userMessage");//当前用户
		if (oGrantGetUserMessage == null)
		{
			throw new  WASException("5000#对不起，您没有登录或者登录超时#"+strErrorFrom+"#未登录或者登录超时（session为空或者session超时）");
		}
		
		//获得TRS WAS的配置信息
		WASConfig oGrantGetWASConfig = (WASConfig)application.getAttribute("wasconfig");
		if( oGrantGetWASConfig==null )
		{
			oGrantGetWASConfig = new WASConfig();
			application.setAttribute("wasconfig",oGrantGetWASConfig);
		}
		
		//获得在TRS WAS中保存的grant对象
		m_grant = oGrantGetWASConfig.getGrant();
		if( m_grant==null )
		{
			m_grant = new GrantCheck();
			oGrantGetWASConfig.setGrant(m_grant);
		}
	}
	catch(WASException eGrantGetWAS)
	{
		throw eGrantGetWAS;
	}
	catch(Exception eGrantGet)
	{
		throw new WASException("604#内部错误#"+strErrorFrom+"#"+eGrantGet.getMessage());  
	}
}
catch(WASException eGrantGetFinalWAS)
{
	UNIException eCheckUNI = new UNIException(eGrantGetFinalWAS.getErrorNumber(),eGrantGetFinalWAS.getErrorDetail(),eGrantGetFinalWAS);
	throw eCheckUNI;
}
%>