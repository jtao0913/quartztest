function checkcon()
{
	if (window.form1.ip.value =="" ) 
	{
		alert("�Բ������������ݿ��������IP��ַ!");
		window.form1.ip.focus();
		return false;
	}
	
	if (window.form1.conport.value =="" ) 
	{
		alert("�Բ������������ݿ�������ķ���˿�!");
		window.form1.conport.focus();
		return false;
	}
	post=document.form1.conport.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'))
			{
				alert("�Բ�����������ȷ�����ݿ�������ķ���˿�,��������ɣ�");
				window.form1.conport.focus();
				return false;
			}
		}
	 }


   if (window.form1.conusername.value =="" ) 
	{
		alert("�Բ�����ָ���������ݿ������ʱʹ�õ��û�����");
		window.form1.conusername.focus();
		return false;
	}
	if (window.form1.condb.value =="" ) 
	{
		if(window.form1.contype.options[window.form1.contype.selectedIndex].className!="TRS")
		{
			alert("�Բ�����ָ����ʹ�õ����ݿ�!");
			window.form1.condb.focus();
			return false;
		}
	}
	
	document.form1.submit();
	return true;	
}

function putvalue()
{
	with(document.all.form1)
	{
		var temp
		if(contype.options[window.form1.contype.selectedIndex].className=="TRS")
		{
			conport.value="8888"
		}
		else if(contype.options[window.form1.contype.selectedIndex].className=="ORACLE")
		{
			conport.value="1521"
		}	
		else if(contype.options[window.form1.contype.selectedIndex].className=="MSSQL")
		{
			conport.value="1433"
		}	
		else if(contype.options[window.form1.contype.selectedIndex].className=="MYSQL")
		{
			conport.value="3306"
		}
		else
		{
			conport.value=""
		}
	}
}

function checkmodcon() //����ά�������
{
	if (window.form1.ip.value =="" ) 
	{
		alert("�Բ������������ݿ��������IP��ַ!");
		window.form1.ip.focus();
		return false;
	}
	
	if (window.form1.conport.value =="" ) 
	{
		alert("�Բ������������ݿ�������ķ���˿�!");
		window.form1.conport.focus();
		return false;
	}
	post=document.form1.conport.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'))
			{
				alert("�Բ�����������ȷ�����ݿ�������ķ���˿�,��������ɣ�");
				window.form1.conport.focus();
				return false;
			}
		}
	 }


   if (window.form1.conusername.value =="" ) 
	{
		alert("�Բ�����ָ���������ݿ������ʱʹ�õ��û�����");
		window.form1.conusername.focus();
		return false;
	}
	
	document.form1.submit();
	return true;	
}