	function publishfinish_check()			//项目部署时一次完成的输入检测
	{
		if(document.form1.increment[1].checked)
		{
			if(document.form1.sel[0].checked||document.form1.sel[1].checked)
			{
			}
			else
			{
				alert("请选择覆盖已有部署的内容！")	
				return false;
			}	
		}
		if(document.form1.increment[0].checked)
		{
			if(document.form1.appname.value.substring(0,1)==""||document.form1.appname.value.substring(0,1)==" ")
			{
				alert("部署的应用名不能为空！")
				return false;
			}
			if(document.form1.path.value.substring(0,1)==""||document.form1.path.value.substring(0,1)==" ")
			{
				alert("部署的应用路径不能为空！")
				return false;
			}
			if(document.form1.path.value.substring(0,1)!="/")
			{
				alert("请以/作为部署的应用路径的开头！")	
				return false;
			}
			if(document.form1.path.value.length<2)
			{
				alert("请输入完整的部署的应用路径如：/wassite")
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
				alert("部署的应用路径必须由a-z、A-Z、0-9和/中的字目组成！");
				return false;
			}
		}
		document.form1.action="publishsubmit.jsp";
		document.form1.submit();
		return true;
	}
	
	function updatesitemap_check()			//新建或修改虚目录时的输入检测
	{
		if (document.form1.name.value=="")
		{
			alert("请输入页面名称！");
			document.form1.name.focus();
			return false;
		}
		if (document.form1.filename.value=="")
		{
			alert("请输入页面名称对应的保存的文件名！");
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
			alert("页面名称对应的保存的文件名必须由a-z、A-Z、0-9和.中的字目组成！");
			document.form1.filename.focus();
			return false;
		}
		if (document.all.form1.ishome.checked)
		{
			if(!confirm("此操作会取消本项目其它的首页设置 \n 你确信要设置本页为首页吗？"))
			{
				document.all.form1.ishome.checked = false;
			}
		}

		document.form1.submit();
		return true;
	}
	
	function updatesubdir_check()			//新建或修改虚目录时的输入检测
	{
		var bNoCanUse = true;
		if(document.form1.name.value=="")
		{
			alert("请输入目录名");
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
			alert("对不起，子目录的名称必须由a-z、0-9、A-Z中的字目组成");
			document.form1.name.focus();
			return false;
		}
		
		document.form1.submit();
		return true;
	}
	
	/*---------------------------判断指定的字符串中是否含有a-z0-9中的一员-------------------------------------*/
	function teststr(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}
	
	/*---------------------------判断指定的字符串中是否含有a-z0-9/中的一员-------------------------------------*/
	function teststr1(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9/]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}
	
	/*---------------------------判断指定的字符串中是否含有a-z0-9/中的一员-------------------------------------*/
	function teststr2(strTestStr)
	{
	   	var oRegExp = new RegExp("[a-z0-9.]","ig");
	   	var bTest = oRegExp.test(strTestStr);
		return bTest;
	}