function docheck()
{
    post=document.sysform.SMTPServerPort.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'))
			{
				alert("�Բ�����������ȷ�����ݿ�������ķ���˿�,��������ɣ�");
				window.sysform.SMTPServerPort.focus();
				return false;
			}
		}
	 }
    window.sysform.submit();
    return true;
}



function showerror(panel,message)
{
	showselect(panel);
	alert(message);
}

function sysinfocheck()
{

	if (window.sysform.SiteName.value =="" ) 
	{
		showerror("serverconfig","������վ������!");
		window.sysform.SiteName.focus();
		return false;
	}
	
/*	var post=document.sysform.AppServerEdition.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'||char=='.'))
			{
				showerror("serverconfig","��������ȷ�İ汾!");
				window.sysform.AppServerEdition.focus();
				return false;
			}
		}
	 }
*/	
	var anonyallow = document.all.sysform.logintype[0].checked
	if (anonyallow&&window.sysform.AnonyUserName.value =="" ) 
	{
		showerror("serverconfig","�����������û���¼�˺�");
		return false;
	}
	if (anonyallow&&window.sysform.AnonyPassword.value =="" ) 
	{
		showerror("serverconfig","�����������û���¼����");
		return false;
	}
/*	if (window.sysform.AppServerEdition.value =="" ) 
	{
		showerror("serverconfig","��������ʹ�õ�Ӧ�÷������İ汾!");
		window.sysform.AppServerEdition.focus();
		return false;
	}
	var post=document.sysform.AppServerEdition.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'||char=='.'))
			{
				showerror("serverconfig","��������ȷ�İ汾!");
				window.sysform.AppServerEdition.focus();
				return false;
			}
		}
	 }
*/	
	if (window.sysform.ReloadTime.value =="" ) 
	{
		showerror("serverconfig","���������������Ϣ�������λ�룩");
		return false;
	}
	post=document.sysform.ReloadTime.value; 
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'))
			{
				showerror("serverconfig","���ڸ߼�������������ȷ�ļ���������Ϣ�������λ�룩");
				return false;
			}
		}
	 }
	 var intTime;
	 intReloadTime=parseInt(post);
	 if(intReloadTime==0)
	 {
	 	alert("�ڸ߼������м���ʱ��Ӧ�ô���0");
		return false;	
	 }
	 
/*	post=document.sysform.AdminAllowIP.value; 
	//ips=post.split(",")
	
	if (post!="" ) 
	{
		for(i=0;i<post.length;i++)
		{
			char=post.charAt(i);
			if(!('0'<=char&&char<='9'|| char =="." || char ==";" || char =="*"))
			{
				showerror("serverconfig","���ڸ߼�������������ȷ�������¼����̨��IP");
				return false;
			}
			
		}
	 }
*/	
	return true;
}

function logconfigcheck()
{
	
	if (window.sysform.LogFormat.value =="" ) 
	{
		showerror("logconfig","��������־��ʹ�õĸ�ʽ");
		window.sysform.LogFormat.focus();
		return false;
	}
	
	if (window.sysform.LogFilePath.value =="" ) 
	{
		showerror("logconfig","��������־���·��");
		window.sysform.LogFilePath.focus();
		return false;
	}

	return true;
}

function fileconfigcheck()
{
	
	if (window.sysform.OutFilePath.value =="" ) 
	{
		showerror("fileconfig","�������ⲿ�ļ����·��");
		window.sysform.OutFilePath.focus();
		return false;
	}
	if (window.sysform.TempPath.value =="" ) 
	{
		showerror("fileconfig","��������ʱ�ļ����·��");
		window.sysform.TempPath.focus();
		return false;
	}
	if (window.sysform.ErrorFile.value =="" ) 
	{
		showerror("fileconfig","������Ĭ�ϱ����ļ����ļ���");
		window.sysform.ErrorFile.focus();
		return false;
	}
/*	if (window.sysform.ErrorConfigFile.value =="" ) 
	{
		showerror("fileconfig","������Ĭ�ϱ����ļ������ļ���");
		window.sysform.ErrorConfigFile.focus();
		return false;
	}
*/
	return true;
}


function templatecheck()
{
	if (window.sysform.DefaultStyleName.value =="" ) 
	{
		showerror("templateconfig","��������ʾ���");
		window.sysform.DefaultStyleName.focus();
		return false;
	}
	 if (window.sysform.DefaultOutlineTarget.value =="" ) 
	{
		showerror("templateconfig","������Ĭ�ϸ���Ŀ��");
		window.sysform.DefaultOutlineTarget.focus();
		return false;
	}
	if (window.sysform.DefaultDetailTarget.value =="" ) 
	{
		showerror("templateconfig","������Ĭ��ϸ��Ŀ��");
		window.sysform.DefaultDetailTarget.focus();
		return false;
	}
	//////////////////
	return true;
}
////////////��ʾ���ز�ϵͳ���ò˵�
function showselect(objname)
{
	var serverconfig = document.getElementById("serverconfig");
	var logconfig = document.getElementById("logconfig");
	var fileconfig = document.getElementById("fileconfig");
	var templateconfig = document.getElementById("templateconfig");

	if (objname == "serverconfig")
	{
		serverconfig.style.display='block';
		logconfig.style.display='none';
		fileconfig.style.display='none';
		templateconfig.style.display='none';
	}
	if (objname == "logconfig")
	{
		serverconfig.style.display='none';
		logconfig.style.display='block';
		fileconfig.style.display='none';
		templateconfig.style.display='none';
		initAllDebug();
	}
	if (objname == "fileconfig")
	{
		serverconfig.style.display='none';
		logconfig.style.display='none';
		fileconfig.style.display='block';
		templateconfig.style.display='none';
	}
	if (objname == "templateconfig")
	{
		serverconfig.style.display='none';
		logconfig.style.display='none';
		fileconfig.style.display='none';
		templateconfig.style.display='block';
	}
}

function displayid()
{
	if(document.sysform.logintype[0].checked)
	{
		document.all.anonyid.style.display='none'	
		document.all.anonypwd.style.display='none'
	}
	else
	{
		document.all.anonyid.style.display='block'	
		document.all.anonypwd.style.display='block'		
	}
}

function hideid()
{
	if(document.sysform.logintype[0].checked==false)
	{
		document.all.anonyid.style.display='none'	
		document.all.anonypwd.style.display='none'
	}
	else
	{
		document.all.anonyid.style.display='block'	
		document.all.anonypwd.style.display='block'
	}
	
}

function displayset()
{
	if(document.all.dis1.style.display=='none')	
	{
		document.all.dis1.style.display='block'
		document.all.dis2.style.display='block'
		document.all.dis3.style.display='block'
		document.all.dis4.style.display='block'
		document.all.dis5.style.display='block'
		document.all.dis6.style.display='block'
		document.all.gaojiset.innerText='���ظ߼�����'
	}
	else
	{
		document.all.dis1.style.display='none'
		document.all.dis2.style.display='none'
		document.all.dis3.style.display='none'
		document.all.dis4.style.display='none'
		document.all.dis5.style.display='none'
		document.all.dis6.style.display='none'
		document.all.gaojiset.innerText='�߼�����'
	}
}

function switchwcmconf()
{
	if(document.all.idwcmconf.style.display=="none")
	{
		document.all.idwcmconf.style.display="block";
		document.all.idwcmconfswitch.innerText="����WCM��Ŀ����";
	}
	else
	{
		document.all.idwcmconf.style.display="none";
		document.all.idwcmconfswitch.innerText="WCM��Ŀ����";
	}
}

function customtarget(strType)
{
	if(strType=="outline")
	{
		var strUserInput = prompt("�������µĸ���Ŀ���ַ����_left�ȣ�","");
		if(strUserInput!=null && strUserInput!="")
		{
			var oOption = document.createElement("option");
			oOption.value=strUserInput;
			oOption.text = strUserInput;
			document.all.iddefaultoutlinetarget.options.add(oOption);
		}
	}
	if(strType=="detail")
	{
		var strUserInput = prompt("�������µ�ϸ��Ŀ���ַ����_left�ȣ�","");
		if(strUserInput!=null && strUserInput!="")
		{
			var oOption = document.createElement("option");
			oOption.value=strUserInput;
			oOption.text = strUserInput;
			document.all.iddefaultdetailtarget.options.add(oOption);
		}
	}
}

function getAllDebug()
{
	var bChecked = true;
	var iIndex = 0;
	for(var i=0;i<window.sysform.debug.length;i++)
	{
		if(window.sysform.debug[i].value=="0")
		{
			iIndex = i;
			break;
		}
	}	
	for(var i=0;i<window.sysform.debug.length;i++)
	{
		if(window.sysform.debug[i].value!="0")
		{
			if(!window.sysform.debug[iIndex].checked)
			{
				window.sysform.debug[i].checked=false;
			}
			else
			{
				window.sysform.debug[i].checked=true;
			}
		}
	}
}

function initAllDebug()
{
	var bChecked = true;
	var iIndex = 0;
	for(var i=0;i<window.sysform.debug.length;i++)
	{
		if(window.sysform.debug[i].value!="0")
		{
			bChecked = bChecked&&window.sysform.debug[i].checked;
		}
		else
		{
			iIndex = i;
		}
	}
	if(bChecked)
	{
		window.sysform.debug[iIndex].checked = true;
	}
}

function showbackground(label,value)
{
	var strLabels = new Array("idbutton1","idbutton2","idbutton3","idbutton4");
	var strDefaultValues = new Array("../../images/topbut_nolist.gif","../../images/topbut_nolist.gif","../../images/topbut_nolist.gif","../../images/topbut_7_nolist.gif");
	for(var i=0;i<strLabels.length;i++)
	{
		if(label != strLabels[i])
		{
			eval("document.all."+strLabels[i]+".background='"+strDefaultValues[i]+"'");
		}
		else
		{
			eval("document.all."+label+".background='"+value+"'");
		}
	}
}

function initPage()
{
	alert("����������Ŀ�ķ�����������Ϣ֮���뵽�ļ�����ģ��������Ŀ������ļ���Ϣ�������WCMЭͬ�������ļ�����ģ������WCM��Ŀ���ԣ�");
}