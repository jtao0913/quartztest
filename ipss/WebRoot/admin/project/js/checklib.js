	function publishfinish_check()			//��Ŀ����ʱһ����ɵ�������
	{
		if(document.form1.increment[1].checked)
		{
			if(document.form1.sel[0].checked||document.form1.sel[1].checked)
			{
			}
			else
			{
				alert("��ѡ�񸲸����в�������ݣ�")	
				return false;
			}	
		}
		if(document.form1.increment[0].checked)
		{
			if(document.form1.appname.value.substring(0,1)==""||document.form1.appname.value.substring(0,1)==" ")
			{
				alert("�����Ӧ��������Ϊ�գ�")
				return false;
			}
			if(document.form1.path.value.substring(0,1)==""||document.form1.path.value.substring(0,1)==" ")
			{
				alert("�����Ӧ��·������Ϊ�գ�")
				return false;
			}
			if(document.form1.path.value.substring(0,1)!="/")
			{
				alert("����/��Ϊ�����Ӧ��·���Ŀ�ͷ��")	
				return false;
			}
			if(document.form1.path.value.length<2)
			{
				alert("�����������Ĳ����Ӧ��·���磺/wassite")
				return false;
			}
			
			var bNoCanUse = true;
			var strText = document.form1.path.value;
			for(var i=0;i<strText.length;i++)
			{
				if( !teststr1(strText.substring(i,i+1)) )
				{
					bNoCanUse = false;
					break;
				} 
			}
			if(!bNoCanUse)
			{
				alert("�����Ӧ��·��������a-z��A-Z��0-9��/�е���Ŀ��ɣ�");
				return false;
			}
		}
		document.form1.action="publishsubmit.jsp";
		document.form1.submit();
		return true;
	}
	
	function updatesitemap_check()			//�½����޸���Ŀ¼ʱ��������
	{
		if (document.form1.name.value=="")
		{
			alert("������ҳ�����ƣ�");
			document.form1.name.focus();
			return false;
		}
		if (document.form1.filename.value=="")
		{
			alert("������ҳ�����ƶ�Ӧ�ı�����ļ�����");
			document.form1.filename.focus();
			return false;
		}
		var bNoCanUse = true;
		var strText = document.form1.filename.value;
		for(var i=0;i<strText.length;i++)
		{
			if( !teststr2(strText.substring(i,i+1)) )
			{
				bNoCanUse = false;
				break;
			} 
		}
		if(!bNoCanUse)
		{
			alert("ҳ�����ƶ�Ӧ�ı�����ļ���������a-z��A-Z��0-9��.�е���Ŀ��ɣ�");
			document.form1.filename.focus();
			return false;
		}
		if (document.all.form1.ishome.checked)
		{
			if(!confirm("�˲�����ȡ������Ŀ��������ҳ���� \n ��ȷ��Ҫ���ñ�ҳΪ��ҳ��"))
			{
				document.all.form1.ishome.checked = false;
			}
		}

		document.form1.submit();
		return true;
	}
	
	function updatesubdir_check()			//�½����޸���Ŀ¼ʱ��������
	{
		var bNoCanUse = true;
		if(document.form1.name.value=="")
		{
			alert("������Ŀ¼��");
			document.form1.name.focus();
			return false;
		}
		var strText = document.form1.name.value;
		for(var i=0;i<strText.length;i++)
		{
			if( !teststr(strText.substring(i,i+1)) )
			{
				bNoCanUse = false;
				break;
			} 
		}
		if(!bNoCanUse)
		{
			alert("�Բ�����Ŀ¼�����Ʊ�����a-z��0-9��A-Z�е���Ŀ���");
			document.form1.name.focus();
			return false;
		}
		
		document.form1.submit();
		return true;
	}
	
	/*---------------------------�ж�ָ�����ַ������Ƿ���a-z0-9�е�һԱ-------------------------------------*/
	function teststr(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}
	
	/*---------------------------�ж�ָ�����ַ������Ƿ���a-z0-9/�е�һԱ-------------------------------------*/
	function teststr1(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9/]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}
	
	/*---------------------------�ж�ָ�����ַ������Ƿ���a-z0-9/�е�һԱ-------------------------------------*/
	function teststr2(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9.]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}