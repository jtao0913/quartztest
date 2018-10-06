function checktree()
{
	if (window.form1.treeName.value=='')
	{
		alert("树名不可为空!");
		window.form1.treeName.focus();
		return false;
	}
	if(confirm("确认当前配置"))
	{
		 window.form1.submit();
		return true;
	}
}