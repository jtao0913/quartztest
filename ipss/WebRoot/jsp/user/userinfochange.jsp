<%@ page import="com.cnipr.cniprgz.entity.IprUser" contentType="text/html;charset=GBK" errorPage="error.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IprUser userInfo = (IprUser)request.getAttribute("userInfo");
String realName = "";
String phone= "";
String mobile="";
String fax="";
String email="";
String department="";
String address="";
if (userInfo != null) {
	realName = (String)request.getSession().getAttribute("username");
	phone= (userInfo.getChrPhone() == null) ? "" : userInfo.getChrPhone();
	mobile= (userInfo.getChrMobile() == null) ? "" : userInfo.getChrMobile();
	fax= (userInfo.getChrFax() == null) ? "" : userInfo.getChrFax();
	email= (userInfo.getChrEmail() == null) ? "" : userInfo.getChrEmail();
	department= (userInfo.getChrDepartment() == null) ? "" : userInfo.getChrDepartment();
	address= (userInfo.getChrAddress() == null) ? "" : userInfo.getChrAddress();
}

String changeInfoResult = (String)request.getAttribute("changeInfoResult");

%>
<html>
<head>
<title>�޸��û���Ϣ</title>
<meta http-equiv="Content-Type" content="text/html;charset=GBK">
<link rel="stylesheet" href="was_style.css" type="text/css">
<SCRIPT language="javascript">
<!--
function checkform()
{
	//��֤�û�����
	if(formuserinfo.realname.value=="") 
	{
		alert("�Բ���û�������û�������");
		formuserinfo.realname.focus();
		return false;
	}
	else
	{
		if(formuserinfo.realname.value.length>32)
		{
			alert("�Բ����û�����̫����");
			formuserinfor.realname.focus();
			return false;
		}
		var bNotAllBlank=false;
		for(var i=0;i<formuserinfo.realname.value.length;i++)
		{
			if(formuserinfo.realname.value.charAt(i)!=' ')
			{
				bNotAllBlank = true;
				break;
			}
		}
		if(!bNotAllBlank)
		{
			alert("�Բ����û�����ȫ���ɿո���ɣ�");
			formuserinfo.realname.focus();
			return false;
		}
	}
	//��֤�û������Email��ַ
	if(formuserinfo.email.value=="")
	{
    	alert("��û��������������Email��ַ���������룡");
    	formuserinfo.email.focus();
    	return false;
	}
	else
	{
    	var email_Value = formuserinfo.email.value;
		var email_strArray = email_Value.split("@");
		var isTrue = 0;
		var i;
    	if((email_strArray.length==2)&&(email_Value.length>=3)){
			isTrue = 1;
			for(i=0;i<10;i++){
				if(email_strArray[i]==""){
					isTrue = 0;
					break;
				}
			}
		}
		if(isTrue==0){
			alert("�������Email��ַ����ȷ:"+email_Value+"�������������룡");
			formuserinfo.email.focus();
			return false;
		}
	}
	
	formuserinfo.submit();
	return true;
}
-->
</SCRIPT>
</head>

<body topmargin="0"  leftmargin="0" marginwidth="0" marginheight="0"  bgcolor="#FAFFFF">
<center>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr> 
      <td width="100%" align="center"><img src="<%=basePath%>images/index_40.gif" ></td>
   </tr>
   <tr> 
      <td height="19"><div align="center"><img src="<%=basePath%>images/index_43.gif" width=288 height=20 alt=""></div></td>
   </tr>
</table>
<!--h3>ר������ϵͳ���û�ע��</h3-->
 <form name="formuserinfo" method="post" action="<%=basePath%>changeInfoPage.do" onSubmit="checkform();return false;">
<table width="70%" border="1" cellspacing="0" cellpadding="0" bordercolor="#666666" bordercolordark="#FFFFFF">
<tr>
	<td>
	<table width="100%" border="0" cellspacing="2" cellpadding="1">
       
          <tr  bgcolor="#C9EAF8"> 
            <td colspan="2" height="25"><font color="#000000"><b>�޸��û�����Ϣ��</b></font></td>
          </tr>
          <tr bgcolor="#C9EAF8"> 
            <td align="right">�û�������</td>
            <td align="left"><input name="realname" type="text" maxlength="32" value="<%=realName%>"> 
              <font color="#FF0000">* 32���ַ�����</font> </td>
          </tr>
          <tr bgcolor="#efefef"> 
            <td align="right">�绰���룺</td>
            <td align="left"><input name="phone" type="text" value="<%=phone%>"> 
              <font color="#FF0000">&nbsp;����д��Ч�ĵ绰����</font></td>
          </tr>
          <tr bgcolor="#C9EAF8"> 
            <td align="right">�ֻ����룺</td>
            <td align="left"><input name="mobile" type="text" value="<%=mobile%>"> 
              <font color="#FF0000">&nbsp;����д��Ч�Ĵ������</font> </td>
          </tr>
		  <tr bgcolor="#efefef"> 
            <td align="right">������룺</td> 
            <td align="left"><input name="fax" type="text" value="<%=fax%>"> 
              <font color="#FF0000">&nbsp;����д��Ч�Ĵ������</font></td>
          </tr>
          <tr bgcolor="#C9EAF8"> 
            <td align="right">�����ʼ���</td>
            <td align="left"><input name="email" type="text" value="<%=email%>"> 
              <font color="#FF0000">*����д��Ч���ʼ���ַ</font> </td>
          </tr>
          <tr bgcolor="#efefef"> 
            <td align="right">������λ��</td>
            <td align="left"><input name="department" type="text" value="<%=department%>"> 
            </td>
          </tr>
          <tr bgcolor="#C9EAF8"> 
            <td width="35%" align="right">��ϵ��ַ��</td>
            <td width="72%" align="left"><input name="address" type="text" value="<%=address%>"> 
            </td>
          </tr>
          <tr bgcolor="#efefef"> 
            <td colspan="2" height="40" align="center"> <input type="submit" name="sub" value="ȷ ��">
              <input type="button" name="button" value="�� ��" onClick="window.close()">
            </td>
          </tr>
        
      </table>
	</td>
</tr>
</table>
</form>
</center>
</body>
<% if (changeInfoResult != null) {
          		String result = "";
          		if (changeInfoResult.equals("1")) {
					result = "�޸ĳɹ���";
				} else {
					result = "�޸�ʧ�ܣ�";
				}
          %>
          <script>alert('<%=result%>');</script>
<%} %>
</html>