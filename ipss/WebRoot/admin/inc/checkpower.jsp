<%
/**
  *	�����û��Ƿ������ʹ�����ܵ�Ȩ�ޣ���ʹ��֮ǰ����������¼�������Ĳ�����
  * 1.�ȵ���(inlcude checkuser.jsp)checkuser����ɶ��û��Ƿ��¼���ж����Ա�֤Ȩ���ж�����ȷ��
  * 2.�������±�����
  		String strErrorFrom = ""; //����ִ��Ȩ����֤��ҳ��
  		String strPowerCheckMethodName = ""; //�����û���֤Ȩ����ʹ�õķ�����
  		//////////////////��������Ӧ��Ȩ����֤�б�///////////////////////////////////////////
  		// ���	| ������ 						| ������Ӧ����֤����                    	//
  		//	1.	| getLoginAdminGrant			| �û��Ƿ��ܵ�¼����̨                  	//
  		//	2.	| getManageAdminGrant			| �û��Ƿ���й������̨��Ȩ��           	//
  		//	3.	| getManageAdminWatchGrant		| �û��Ƿ���й���̨��ص�Ȩ��           	//
  		//	4.	| getManageAppWatchGrant		| �û��Ƿ����Ӧ�ü�ص�Ȩ��				//
  		//	5.	| getManageChannelGrant			| �û��Ƿ����Ƶ�������Ȩ��				//
  		//	6.	| getManageDatasourceGrant		| �õ��û��Ƿ��������Դ�����Ȩ��			//
  		//	7.	| getManageLogSourceGrant		| �û��Ƿ������־Դ�����Ȩ��				//
  		//	8.	| getManageNavigateGrant		| �û��Ƿ���е��������Ȩ��				//
  		//	9.	| getManageProjectGrant			| �û��Ƿ������Ŀ�����Ȩ��				//
  		// 10.	| getManageStyleGrant			| �û��Ƿ������ʾ�������Ȩ��			//
  		// 11.	| getManageSysConfigGrant		| �û��Ƿ����ϵͳ�������õ�Ȩ��			//
  		// 12.	| getManageTemplateGrant		| �û��Ƿ����ģ������Ȩ��				//
  		// 13.	| getManageUserCountGrant		| �û��Ƿ�����û�����ͳ�ƹ����Ȩ��			//
  		// 14.	| getManageUserGrant			| �û��Ƿ�����û������Ȩ��				//
  		// 15.	| getManageUserGroupGrant		| �û��Ƿ�����û�������Ȩ��				//
  		// 16.	| getManageVisitControlGrant	| �û��Ƿ���з��ʿ��ƹ����Ȩ��			//
  		// 17.	| getManageWCMSynchronizeGrant	| �û��Ƿ������ʹWCMͬ�������Ȩ��			//
  		//////////////////////////////////////////////////////////////////////////////////
  	3.�벻Ҫ�������±���
  		WASConfig oPowerCheckWASConfig = null; //�����û���Ȩ����֤ʱ��Ҫʹ�õ�TRS WAS������Ϣ�Ķ���
  		UserMessage nPowerCheckUserMessage = null; //������Ҫ��֤���û����û���Ϣ
  		WASException ePowerCheckWAS = null; //����ִ���û�Ȩ���ж�ʱ��WASException
  		Exception ePowerCheck = null; //����ִ���û�Ȩ���ж�ʱ��Exception
  		WASException ePowerCheckFinalWAS = null; //����ִ���û�Ȩ���ж�������ӳ���WASException
  	4.���õ�ʱ����ŵ�try{�м�
  */
try	//ͳһ�û�Ȩ�޿���ʱ���쳣����
{
	//�������
	WASConfig oPowerCheckWASConfig = null;
	UserMessage nPowerCheckUserMessage = null; 
	
	try //ͳһ�û�Ȩ���ж�ʱ���쳣����
	{
		//��ȡTRS WAS��������Ϣ
		oPowerCheckWASConfig = (WASConfig)application.getAttribute("wasconfig");
		if(oPowerCheckWASConfig==null)
		{
			throw new WASException("10040#�ڴ��б����ϵͳ������Ϣ��û�м��ػ����ڼ���#add_style#");
		}
				
		//�����Ҫ�����û�Ȩ���ж����û�
		nPowerCheckUserMessage = (UserMessage)session.getAttribute("userMessage");
		
		if( !WASGrantCheck.getGrantCheck(strPowerCheckMethodName,oPowerCheckWASConfig,nPowerCheckUserMessage) ) //�����û�ָ����Ȩ���ж�
		{
			//û���û���Ҫ���ҵ�Ȩ��
			throw new WASException("10030#�Բ�����������ָ����Ȩ��#"+strErrorFrom+"#");
		}
	}
	catch(WASException ePowerCheckWAS)
	{
		throw ePowerCheckWAS;
	}
	catch(Exception ePowerCheck)
	{
		throw new WASException("10002#�Բ������ж��û��Ƿ����ָ��Ȩ�޵�ʱ��������#"+strErrorFrom+"#"+ePowerCheck.getMessage());
	}
}
catch(WASException ePowerCheckFinalWAS)
{
	throw ePowerCheckFinalWAS;
}
%>