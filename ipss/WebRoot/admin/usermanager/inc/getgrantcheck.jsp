<%
/**
  *	���TRS WAS������Ϣ�б�����û���Ȩ��Ϣ�ļ���(GrantCheck)
  * 1.�ڵ���֮ǰ�����������±�����ֵ
  		String strErrorFrom = ""; //����ִ���û���¼�жϵ�ҳ�棬�����Ҫ��checkpower��ͬʹ�õĻ�����ʹ����ͬ��ҳ��
    2.�벻Ҫ�������±���
  		UserMessage oGrantGetUserMessage = null; //��¼�û��ĵ�¼��Ϣ
  		WASConfig oGrantGetWASConfig = null; //��¼TRS WAS��������Ϣ
  		WASException eGrantGetWAS = null; //����ִ���û�Ȩ���ж�ʱ��WASException
  		Exception eGrantGet = null; //����ִ���û�Ȩ���ж�ʱ��Exception
  		WASException eGrantGetFinalWAS = null; //����ִ���û�Ȩ���ж�������׳���WASException
  	3.���õ�ʱ����ŵ�try{�м�
  */

GrantCheck m_grant = null;

try //ͳһ���GrantCheckʱ���쳣
{
	try{
		//����û��ĵ�¼��Ϣ
		UserMessage oGrantGetUserMessage = (UserMessage)session.getAttribute("userMessage");//��ǰ�û�
		if (oGrantGetUserMessage == null)
		{
			throw new  WASException("5000#�Բ�����û�е�¼���ߵ�¼��ʱ#"+strErrorFrom+"#δ��¼���ߵ�¼��ʱ��sessionΪ�ջ���session��ʱ��");
		}
		
		//���TRS WAS��������Ϣ
		WASConfig oGrantGetWASConfig = (WASConfig)application.getAttribute("wasconfig");
		if( oGrantGetWASConfig==null )
		{
			oGrantGetWASConfig = new WASConfig();
			application.setAttribute("wasconfig",oGrantGetWASConfig);
		}
		
		//�����TRS WAS�б����grant����
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
		throw new WASException("604#�ڲ�����#"+strErrorFrom+"#"+eGrantGet.getMessage());  
	}
}
catch(WASException eGrantGetFinalWAS)
{
	UNIException eCheckUNI = new UNIException(eGrantGetFinalWAS.getErrorNumber(),eGrantGetFinalWAS.getErrorDetail(),eGrantGetFinalWAS);
	throw eCheckUNI;
}
%>