function checktree()
{
	if (window.form1.treeName.value=='')
	{
		alert("��������Ϊ��!");
		window.form1.treeName.focus();
		return false;
	}
	if(confirm("ȷ�ϵ�ǰ����"))
	{
		 window.form1.submit();
		return true;
	}
}