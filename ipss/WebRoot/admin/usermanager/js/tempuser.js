function goto(pageform)
{ 
	var s = new String(pageform.page1.value);

	if(isNaN(pageform.page1.value)||pageform.page1.value==""||s.charAt(0)==" ")
	{
		alert("请输入合法的页数！确保数字前面没有空格！");
		return false;
	}
	pageform.method="post";
	pageform.action="?page="+pageform.page1.value;
	pageform.submit();
}

//全选开关函数
function allselect()
{
	var i
	
	if( document.all.form2.sel==undefined )
	{
		return;
	}
	if(document.all.form3.selall.checked==true || document.all.form4.selall.checked==true)
	{
		if( document.all.form2.sel.length == undefined )
		{
		 	document.all.form2.sel.checked=true;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=true
			}
		}
	}
	else
	{
		if( document.all.form2.sel.length == undefined )
		{
		 	document.all.form2.sel.checked=false;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=false
			}
		}
	}
}
function hideurl()
{
	window.status='WAS41';
	return true
}

function sure()
{
	if(typeof(document.all.form2.sel.length)!="undefined")
	{
		var v=0;
		for(i=0;i<document.all.form2.sel.length;i++)
		{
			if(document.all.form2.sel[i].checked==true)
			{
				v++;
			}
		}
		if(v==0)
		{
			alert("请选中要删除的用户！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要删除的用户！");
				return false;
			}
	}
	
	
	if (confirm("你确信要删除你选中的用户吗?"))
	{
		return true;
	}
	else
	{
		return false;
	}
}
function sureagree()
{
	if(typeof(document.all.form2.sel.length)!="undefined")
	{
		var v=0;
		for(i=0;i<document.all.form2.sel.length;i++)
		{
			if(document.all.form2.sel[i].checked==true)
			{
				v++;
			}
		}
		if(v==0)
		{
			alert("请选中要审核的用户！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要审核的用户！");
				return false;
			}
	}
	if (confirm("你确信要审核你选中的用户吗?"))
	{
		return true;
	}
	else
	{
		return false;
	}
}

function changego1()
{
	document.all.form2.action = "deletenew.jsp";
	return sure();
}
function changego2()
{
	document.all.form2.action = "agree.jsp";
	return sureagree();
}