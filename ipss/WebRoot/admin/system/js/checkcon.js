function checkcon()
{
	if (window.form1.ip.value =="" ) 
	{
		alert("对不起，请输入数据库服务器的IP地址!");
		window.form1.ip.focus();
		return false;
	}
	
	if (window.form1.conport.value =="" ) 
	{
		alert("对不起，请输入数据库服务器的服务端口!");
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
				alert("对不起，请输入正确的数据库服务器的服务端口,由数字组成！");
				window.form1.conport.focus();
				return false;
			}
		}
	 }


   if (window.form1.conusername.value =="" ) 
	{
		alert("对不起，请指定连接数据库服务器时使用的用户名！");
		window.form1.conusername.focus();
		return false;
	}
	if (window.form1.condb.value =="" ) 
	{
		if(window.form1.contype.options[window.form1.contype.selectedIndex].className!="TRS")
		{
			alert("对不起，请指定所使用的数据库!");
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

function checkmodcon() //连接维护表单检查
{
	if (window.form1.ip.value =="" ) 
	{
		alert("对不起，请输入数据库服务器的IP地址!");
		window.form1.ip.focus();
		return false;
	}
	
	if (window.form1.conport.value =="" ) 
	{
		alert("对不起，请输入数据库服务器的服务端口!");
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
				alert("对不起，请输入正确的数据库服务器的服务端口,由数字组成！");
				window.form1.conport.focus();
				return false;
			}
		}
	 }


   if (window.form1.conusername.value =="" ) 
	{
		alert("对不起，请指定连接数据库服务器时使用的用户名！");
		window.form1.conusername.focus();
		return false;
	}
	
	document.form1.submit();
	return true;	
}