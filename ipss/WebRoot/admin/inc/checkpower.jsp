<%
/**
  *	进行用户是否具有行使管理功能的权限，在使用之前，需完成以下几个方面的操作：
  * 1.先调用(inlcude checkuser.jsp)checkuser来完成对用户是否登录的判定，以保证权限判定的正确性
  * 2.申明以下变量：
  		String strErrorFrom = ""; //定义执行权限验证的页面
  		String strPowerCheckMethodName = ""; //定义用户验证权限所使用的方法名
  		//////////////////方法名对应的权限验证列表///////////////////////////////////////////
  		// 序号	| 方法名 						| 方法对应的验证内容                    	//
  		//	1.	| getLoginAdminGrant			| 用户是否能登录管理台                  	//
  		//	2.	| getManageAdminGrant			| 用户是否具有管理管理台的权限           	//
  		//	3.	| getManageAdminWatchGrant		| 用户是否具有管理台监控的权限           	//
  		//	4.	| getManageAppWatchGrant		| 用户是否具有应用监控的权限				//
  		//	5.	| getManageChannelGrant			| 用户是否具有频道管理的权限				//
  		//	6.	| getManageDatasourceGrant		| 得到用户是否具有数据源管理的权限			//
  		//	7.	| getManageLogSourceGrant		| 用户是否具有日志源管理的权限				//
  		//	8.	| getManageNavigateGrant		| 用户是否具有导航管理的权限				//
  		//	9.	| getManageProjectGrant			| 用户是否具有项目管理的权限				//
  		// 10.	| getManageStyleGrant			| 用户是否具有显示风格管理的权限			//
  		// 11.	| getManageSysConfigGrant		| 用户是否具有系统参数设置的权限			//
  		// 12.	| getManageTemplateGrant		| 用户是否具有模板管理的权限				//
  		// 13.	| getManageUserCountGrant		| 用户是否具有用户入账统计管理的权限			//
  		// 14.	| getManageUserGrant			| 用户是否具有用户管理的权限				//
  		// 15.	| getManageUserGroupGrant		| 用户是否具有用户组管理的权限				//
  		// 16.	| getManageVisitControlGrant	| 用户是否具有访问控制管理的权限			//
  		// 17.	| getManageWCMSynchronizeGrant	| 用户是否具有行使WCM同步管理的权限			//
  		//////////////////////////////////////////////////////////////////////////////////
  	3.请不要定义以下变量
  		WASConfig oPowerCheckWASConfig = null; //定义用户的权限验证时需要使用的TRS WAS配置信息的对象
  		UserMessage nPowerCheckUserMessage = null; //定义需要验证的用户的用户信息
  		WASException ePowerCheckWAS = null; //定义执行用户权限判定时的WASException
  		Exception ePowerCheck = null; //定义执行用户权限判定时的Exception
  		WASException ePowerCheckFinalWAS = null; //定义执行用户权限判定中最后扔出的WASException
  	4.调用的时候，请放到try{中间
  */
try	//统一用户权限控制时的异常处理
{
	//定义变量
	WASConfig oPowerCheckWASConfig = null;
	UserMessage nPowerCheckUserMessage = null; 
	
	try //统一用户权限判定时的异常处理
	{
		//获取TRS WAS的配置信息
		oPowerCheckWASConfig = (WASConfig)application.getAttribute("wasconfig");
		if(oPowerCheckWASConfig==null)
		{
			throw new WASException("10040#内存中保存的系统配置信息还没有加载或正在加载#add_style#");
		}
				
		//获得需要进行用户权限判定的用户
		nPowerCheckUserMessage = (UserMessage)session.getAttribute("userMessage");
		
		if( !WASGrantCheck.getGrantCheck(strPowerCheckMethodName,oPowerCheckWASConfig,nPowerCheckUserMessage) ) //进行用户指定的权限判定
		{
			//没有用户需要查找的权限
			throw new WASException("10030#对不起，您不具有指定的权限#"+strErrorFrom+"#");
		}
	}
	catch(WASException ePowerCheckWAS)
	{
		throw ePowerCheckWAS;
	}
	catch(Exception ePowerCheck)
	{
		throw new WASException("10002#对不起，在判断用户是否具有指定权限的时候发生错误！#"+strErrorFrom+"#"+ePowerCheck.getMessage());
	}
}
catch(WASException ePowerCheckFinalWAS)
{
	throw ePowerCheckFinalWAS;
}
%>