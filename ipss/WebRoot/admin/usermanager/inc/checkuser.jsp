<%
/**
  *	进行用户是否已经登录的判断，在使用之前，需完成以下几个方面的操作：
  * 1.在调用之前，请设置以下变量的值
  		String strErrorFrom = ""; //定义执行用户登录判断的页面，如果需要和checkpower共同使用的话，请使用相同的页面
    2.请不要定义以下变量
  		MapLoginusers oCheckMapLoginusers = null; //记录当前的在线用户信息
  		UserMessage oCheckUserMessage = null; //记录用户的登录信息
  		WASConfig oCheckWASConfig = null; //记录TRS WAS的配置信息
  		WASException eCheckWAS = null; //定义执行用户权限判定时的WASException
  		Exception eCheck = null; //定义执行用户权限判定时的Exception
  		WASException eCheckFinalWAS = null; //定义执行用户权限判定后最后抛出的WASException
  	3.调用的时候，请放到try{中间
  */
try //统一用户是否登录时的异常
{
	try{
		//获得在线用户信息
		MapLoginusers oCheckMapLoginusers = (MapLoginusers)application.getAttribute("mapLoginusers");//所有登录用户
		if (oCheckMapLoginusers == null)
		{
			oCheckMapLoginusers = new MapLoginusers();
			application.setAttribute("mapLoginusers",oCheckMapLoginusers);
		}
	
		//获得用户的登录信息
		UserMessage oCheckUserMessage = (UserMessage)session.getAttribute("userMessage");//当前用户
		if (oCheckUserMessage == null)
		{
			throw new  WASException("5000#对不起，您没有登录或者登录超时#"+strErrorFrom+"#未登录或者登录超时（session为空或者session超时）");
		}
	
		if (!oCheckUserMessage.getUserState())//检验用户是否处于可用状态，如果不可用，更新当前的载线用户列表
		{
	  	 	oCheckUserMessage.setMapLoginUser(oCheckMapLoginusers);//更新用户列表
	   		oCheckUserMessage.removeUserFromLoginusers();
	   		session.removeAttribute("userMessage");
	  	 	throw new WASException("600#当前登录无效#"+strErrorFrom+"#由于非法登录或者被管理员拒绝登录");
		}
	}
	catch(WASException eCheckWAS)
	{
		throw eCheckWAS;
	}
	catch(Exception eCheck)
	{
		throw new WASException("604#内部错误#"+strErrorFrom+"#"+eCheck.getMessage());  
	}
}
catch(WASException eCheckFinalWAS)
{
	UNIException eCheckUNI = new UNIException(eCheckFinalWAS.getErrorNumber(),eCheckFinalWAS.getErrorDetail(),eCheckFinalWAS);
	throw eCheckUNI;
}
%>