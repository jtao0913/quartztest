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
				alert("对不起，请输入正确的数据库服务器的服务端口,由数字组成！");
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
		showerror("serverconfig","请输入站点名称!");
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
				showerror("serverconfig","请输入正确的版本!");
				window.sysform.AppServerEdition.focus();
				return false;
			}
		}
	 }
*/	
	var anonyallow = document.all.sysform.logintype[0].checked
	if (anonyallow&&window.sysform.AnonyUserName.value =="" ) 
	{
		showerror("serverconfig","请输入匿名用户登录账号");
		return false;
	}
	if (anonyallow&&window.sysform.AnonyPassword.value =="" ) 
	{
		showerror("serverconfig","请输入匿名用户登录密码");
		return false;
	}
/*	if (window.sysform.AppServerEdition.value =="" ) 
	{
		showerror("serverconfig","请输入所使用的应用服务器的版本!");
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
				showerror("serverconfig","请输入正确的版本!");
				window.sysform.AppServerEdition.focus();
				return false;
			}
		}
	 }
*/	
	if (window.sysform.ReloadTime.value =="" ) 
	{
		showerror("serverconfig","请输入加载配置信息间隔（单位秒）");
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
				showerror("serverconfig","请在高级设置中输入正确的加载配置信息间隔（单位秒）");
				return false;
			}
		}
	 }
	 var intTime;
	 intReloadTime=parseInt(post);
	 if(intReloadTime==0)
	 {
	 	alert("在高级设置中加载时间应该大于0");
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
				showerror("serverconfig","请在高级设置中输入正确的允许登录管理台的IP");
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
		showerror("logconfig","请输入日志所使用的格式");
		window.sysform.LogFormat.focus();
		return false;
	}
	
	if (window.sysform.LogFilePath.value =="" ) 
	{
		showerror("logconfig","请输入日志存放路径");
		window.sysform.LogFilePath.focus();
		return false;
	}

	return true;
}

function fileconfigcheck()
{
	
	if (window.sysform.OutFilePath.value =="" ) 
	{
		showerror("fileconfig","请输入外部文件存放路径");
		window.sysform.OutFilePath.focus();
		return false;
	}
	if (window.sysform.TempPath.value =="" ) 
	{
		showerror("fileconfig","请输入临时文件存放路径");
		window.sysform.TempPath.focus();
		return false;
	}
	if (window.sysform.ErrorFile.value =="" ) 
	{
		showerror("fileconfig","请输入默认报错文件的文件名");
		window.sysform.ErrorFile.focus();
		return false;
	}
/*	if (window.sysform.ErrorConfigFile.value =="" ) 
	{
		showerror("fileconfig","请输入默认报错文件配置文件名");
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
		showerror("templateconfig","请输入显示风格");
		window.sysform.DefaultStyleName.focus();
		return false;
	}
	 if (window.sysform.DefaultOutlineTarget.value =="" ) 
	{
		showerror("templateconfig","请输入默认概览目标");
		window.sysform.DefaultOutlineTarget.focus();
		return false;
	}
	if (window.sysform.DefaultDetailTarget.value =="" ) 
	{
		showerror("templateconfig","请输入默认细览目标");
		window.sysform.DefaultDetailTarget.focus();
		return false;
	}
	//////////////////
	return true;
}
////////////显示隐藏层系统配置菜单
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
		document.all.gaojiset.innerText='隐藏高级设置'
	}
	else
	{
		document.all.dis1.style.display='none'
		document.all.dis2.style.display='none'
		document.all.dis3.style.display='none'
		document.all.dis4.style.display='none'
		document.all.dis5.style.display='none'
		document.all.dis6.style.display='none'
		document.all.gaojiset.innerText='高级设置'
	}
}

function switchwcmconf()
{
	if(document.all.idwcmconf.style.display=="none")
	{
		document.all.idwcmconf.style.display="block";
		document.all.idwcmconfswitch.innerText="隐藏WCM项目属性";
	}
	else
	{
		document.all.idwcmconf.style.display="none";
		document.all.idwcmconfswitch.innerText="WCM项目属性";
	}
}

function customtarget(strType)
{
	if(strType=="outline")
	{
		var strUserInput = prompt("请输入新的概览目标地址，如_left等：","");
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
		var strUserInput = prompt("请输入新的细览目标地址，如_left等：","");
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
	alert("在输入完项目的服务器配置信息之后，请到文件配置模块设置项目所需的文件信息，如果与WCM协同，请在文件配置模块设置WCM项目属性！");
}