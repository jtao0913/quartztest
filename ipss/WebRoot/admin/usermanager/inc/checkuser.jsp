<%
/**
  *	�����û��Ƿ��Ѿ���¼���жϣ���ʹ��֮ǰ����������¼�������Ĳ�����
  * 1.�ڵ���֮ǰ�����������±�����ֵ
  		String strErrorFrom = ""; //����ִ���û���¼�жϵ�ҳ�棬�����Ҫ��checkpower��ͬʹ�õĻ�����ʹ����ͬ��ҳ��
    2.�벻Ҫ�������±���
  		MapLoginusers oCheckMapLoginusers = null; //��¼��ǰ�������û���Ϣ
  		UserMessage oCheckUserMessage = null; //��¼�û��ĵ�¼��Ϣ
  		WASConfig oCheckWASConfig = null; //��¼TRS WAS��������Ϣ
  		WASException eCheckWAS = null; //����ִ���û�Ȩ���ж�ʱ��WASException
  		Exception eCheck = null; //����ִ���û�Ȩ���ж�ʱ��Exception
  		WASException eCheckFinalWAS = null; //����ִ���û�Ȩ���ж�������׳���WASException
  	3.���õ�ʱ����ŵ�try{�м�
  */
try //ͳһ�û��Ƿ��¼ʱ���쳣
{
	try{
		//��������û���Ϣ
		MapLoginusers oCheckMapLoginusers = (MapLoginusers)application.getAttribute("mapLoginusers");//���е�¼�û�
		if (oCheckMapLoginusers == null)
		{
			oCheckMapLoginusers = new MapLoginusers();
			application.setAttribute("mapLoginusers",oCheckMapLoginusers);
		}
	
		//����û��ĵ�¼��Ϣ
		UserMessage oCheckUserMessage = (UserMessage)session.getAttribute("userMessage");//��ǰ�û�
		if (oCheckUserMessage == null)
		{
			throw new  WASException("5000#�Բ�����û�е�¼���ߵ�¼��ʱ#"+strErrorFrom+"#δ��¼���ߵ�¼��ʱ��sessionΪ�ջ���session��ʱ��");
		}
	
		if (!oCheckUserMessage.getUserState())//�����û��Ƿ��ڿ���״̬����������ã����µ�ǰ�������û��б�
		{
	  	 	oCheckUserMessage.setMapLoginUser(oCheckMapLoginusers);//�����û��б�
	   		oCheckUserMessage.removeUserFromLoginusers();
	   		session.removeAttribute("userMessage");
	  	 	throw new WASException("600#��ǰ��¼��Ч#"+strErrorFrom+"#���ڷǷ���¼���߱�����Ա�ܾ���¼");
		}
	}
	catch(WASException eCheckWAS)
	{
		throw eCheckWAS;
	}
	catch(Exception eCheck)
	{
		throw new WASException("604#�ڲ�����#"+strErrorFrom+"#"+eCheck.getMessage());  
	}
}
catch(WASException eCheckFinalWAS)
{
	UNIException eCheckUNI = new UNIException(eCheckFinalWAS.getErrorNumber(),eCheckFinalWAS.getErrorDetail(),eCheckFinalWAS);
	throw eCheckUNI;
}
%>