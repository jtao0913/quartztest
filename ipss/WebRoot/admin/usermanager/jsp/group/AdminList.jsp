<%@ page contentType="text/html; charset=GBK" errorPage="../common/error.jsp"%>
<%@ include file="../../../../head.jsp" %>
<%@ include file="../../../../zljs/comm/config.jsp"%>
<%
LoginConfig loginConfig; //�û���ǰ��¼����
String username=null;
WASUser wUser = null;
int intUserID = 0;

loginConfig = (LoginConfig)session.getAttribute("loginconfig");
if(loginConfig==null)
{
	throw new WASException("���ĵ�¼�Ѿ�ʧЧ��");
}
username=loginConfig.getLoginInfo().getUserName();
wUser = loginConfig.getLoginInfo().getUser();
intUserID = wUser.getID();

String strAdminName=username;
int adminID=intUserID;
%>
<% 
	//��������
	String strWord;			//�����ؼ��ֺͼ�������
	String strWordEnc;		//�����ؼ��ֺͼ�������(����:ISO_8859_1)
	String strIndex;		//��ǰҳ�����������
	
	int indexPage;			//��ǰҳ���������㣩
	int pageCount;			//��ҳ��
	int num;			//������
	int number;			//����ÿҳ��ʾ������
	String strColor="";		//�����������ɫ
	String color1 = "#eaeff8";
	String color2 = "#d5dff1";
	
	number=10;			//ÿҳ��ʾ10����¼
	indexPage=1;
	
	//�õ���ѯ����͹ؼ���
	strWord = request.getParameter("searchWord");
	if(strWord==null || strWord.equals("") || strWord.trim().equals(""))
	{
		strWord = "";
	}
	else
	{
		strWord = strWord.trim();
	}
	strWord=new String(strWord.getBytes("8859_1"),"GBK");
	
	AdminManage administratormanage=new AdminManage(number,indexPage,strWord,adminID);
	String administratorNames[]=new String[number];
	String administratorMemos[]=new String[number];
	int administratorIDs[]=new int[number];
	
	administratorNames=administratormanage.getAdministratorNames();
	administratorMemos=administratormanage.getAdministratorMemos();
	administratorIDs=administratormanage.getAdministratorIDs();
	num=administratormanage.getCount();
	
	
	StringBuffer str;		//��������ƴ�����ڼ�ҳ����ҳ����¼
	String strGroupName;
	int temp;			//����ÿһҳ����ʼҳ��
	StringBuffer strBfSqlIn = null;
	int i=1;
	
	//��ѯ��¼��
	if( administratorIDs!=null )
	{
		num = administratorIDs.length;
	}
	else
	{
		num = 0;
	}
	
	//�õ�ҳ��
	if((num%number)==0)
	{
		pageCount = num/number;
	}
	else
	{
		pageCount = (int)(num/number)+1;
	}
	
	//�õ�ҳ����
	if(request.getParameter("biaozhi")!=null)
	{
		strIndex = request.getParameter("biaozhi");
		indexPage = Integer.parseInt(strIndex);
		if(indexPage>pageCount)
		{
			indexPage=pageCount;
		}
		if( indexPage < 1 )
		{
			indexPage = 1;
		}
		if(pageCount==0)
		{
			indexPage=1;
		}
	}
	else
	{
		indexPage=1;//��ʼҳ
		if(pageCount==0)
		{
			indexPage=0;
		}
	}
	
	//����ִ�����ݿ������In�ַ���
	strBfSqlIn = new StringBuffer();
	strBfSqlIn.append("('-1',");
	if(administratorIDs!=null)
	{
		for(i=0;i<administratorIDs.length;i++)
		{
			if(i<(indexPage-1)*number || i>=indexPage*number)
			{
			}
			else
			{
				strBfSqlIn.append("'");
				strBfSqlIn.append(administratorIDs[i]);
				strBfSqlIn.append("'");
				strBfSqlIn.append(",");
			}
		}
	}


%>
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<script language="javascript">
<!--
	function checkpageform(form)
	{
		if(form.biaozhi.value=="")
		{
			alert("��ָ��Ҫ�����ҳ����");
			return false;
		}
		if(!isInteger(form.biaozhi.value))
		{
			alert("ָ��Ҫ�����ҳ��������������");
			return false;
		}
		if(form.biaozhi.value<=0 || form.biaozhi.value><%=pageCount%>)
		{
			alert("ָ��Ҫ�����ҳ������������ķ�Χ��");
			return false;
		}
		form.pageIndex.value=form.biaozhi.value-1;
		return true;
	}
	function isInteger(inputVal)
	{
		inputStr = inputVal.toString();
		for(var i=0;i<inputStr.length;i++)
		{
			var oneChar = inputStr.charAt(i);
			if(oneChar=="-" && i==0)
			{
				continue;
			}
			if(oneChar<"0" || oneChar>"9")
			{
				return false;
			}
		}
		return true;
	}
function goto(pageform)
{ 
	var s = new String(pageform.page1.value);

	if(isNaN(pageform.page1.value)||pageform.page1.value==""||s.charAt(0)==" ")
	{
		alert("������Ϸ���ҳ����ȷ������ǰ��û�пո�");
		return false;
	}
	pageform.method="post";
	pageform.action="?biaozhi="+pageform.page1.value+"&searchWord="+document.all.form0.searchword.value;
	pageform.submit();
}

//ȫѡ���غ���
function allselect()
{
	var i
	
	if( typeof(document.all.form2.sel)=="undefined" )
	{
		return;
	}
	if( document.all.idselall.value=="0" )
	{
		if( typeof(document.all.form2.sel.length) == "undefined" )
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
		document.all.idselall.value = "1";
	}
	else
	{
		if( typeof(document.all.form2.sel.length) == "undefined" )
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
		document.all.idselall.value = "0";
	}
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
			alert("��ѡ��Ҫɾ�����û��飡");
			return false;
		}
	}
	else
	{
		alert("��ѡ��Ҫɾ�����û��飡");
		/*
			if(document.all.form2.sel.checked==false)
			{
				alert("��ѡ��Ҫɾ�����û��飡");
				return false;
			}
		*/
	}
	
	
	if (confirm("ȷ��Ҫɾ��ѡ�е��û�����?"))
	{
		form2.submit();
	}
	else
	{
		return false;
	}
}
-->
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">�� �� Ա �� �� �� ��</span></td>
          <td width="11" valign="top">&nbsp;</td>
          <td width="24" valign="top">&lt;&lt;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
          	<table width="100%" height="4" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          		<tr>
          			<td height="4"></td>
          		</tr>
          	</table>
            <table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="7%" align="left" valign="top"><img src="../../../images/tl_list.gif" width="20" height="28"></td>
                <td width="93%"> 
                  <table width="350" height="23" border="0" cellpadding="0" cellspacing="0" class="12green">
                    <form name="form1" method="post" action="AdminList.jsp">
					<tr> 
                        <td>����Ա���ƣ�<input type="text" name="searchWord" size="15" value="<%=strWord%>"></td>
                        <td width="68"><input name="imageField" type="image" src="../../../images/search_list.gif" width="52" height="21" border="0"></td>
                    </tr>
					</form>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="top">
            <table width="361" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr align="left">
              	<td width="20">&nbsp;</td>
              	<td width="236" height="18">
              		<table width="217" cellspacing="0" border="0" cellpadding="0">
              		  <tr>
              		    <td width="54" height="18"><%if(indexPage>1){%><a href="grouplist.jsp?biaozhi=0&searchWord=">��  ҳ</a><%}else{%>��  ҳ<%}%></td>
                        <td width="54"><%if(indexPage>1){%><a href="grouplist.jsp?biaozhi=<%=indexPage-1%>&searchWord=">��һҳ</a><%}else{%>��һҳ<%}%></td>
                        <td width="54"><%if((pageCount-indexPage)>0){%><a href="grouplist.jsp?biaozhi=<%=indexPage+1%>&searchWord=">��һҳ</a><%}else{%>��һҳ<%}%></td>
                        <td width="55"><%if((pageCount-indexPage)>0){%><a href="grouplist.jsp?biaozhi=<%=pageCount%>&searchWord=">β ҳ</a><%}else{%>β ҳ<%}%></td>
              		  </tr>
              		</table>
                </td>
                <td width="105" > 
                  <table width="105" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
                    <form name="formpage" method="post" action="grouplist.jsp" onSubmit="javaScript:return checkpageform(this);">
                      <tr> 
                        <td width="15"> �� </td>
                        <td width="45" align="left" valign="top"><input name="biaozhi" type="text" class="10int" size="4"></td>
                        <td width="15"> ҳ </td>
						<td width="30"><input name="imageField2" type="image" src="../../../images/go_list.gif" width="19" height="11" border="0" style="cursor:hand();"></td>
                      </tr>
                      <input type="hidden" name="searchWord" value="">
                      <input type="hidden" name="pageIndex" value="0">
                    </form>
                   </table>
                </td>          
			  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="AddAdmin.jsp" onClick="javaScript:event.returnValue=false;window.open('AddAdmin.jsp','','width=800,height=600,scrollbars=yes');"><img src="../../../images/xjyh.gif" height="32" border="0"></a><a href="../../../help/usermanager_jsp_group_grouplist.htm" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_grouplist.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
          <td width="4%" height="32">&nbsp;</td>
        </tr>
        <tr> 
          <td height="20" align="right" valign="top">
            <table width="220" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
              <tr>       
                <td align="right" valign="top">
                  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td></td>
                    </tr>
                  </table>
<%
			str = new StringBuffer("(�� ");
			str.append( String.valueOf(indexPage) );
			str.append(" ҳ&nbsp;�� ");
			str.append(pageCount+" ҳ&nbsp��");
			str.append(num).append("����¼)");
			out.println(str.toString());
%>
                </td>
              </tr>
            </table>
          </td>
          <td height="20">&nbsp;</td>
        </tr>
      </table>
    </td>    
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">
		  	  <table cellspacing=0 bordercolordark=#ffffff width="100%" bordercolorlight=#4787b8 border=1>
		    <tbody> <form name="form2" method="post" action="deleteadmin.jsp">
		      <tr bgcolor="#4787b8"> 
		      <td width="6%" nowrap>&nbsp;</td>
		      <td width="7%" align="center" nowrap><font color="#ffffff"><b>�� ��</b></font></td>
		      <td width="20%" align="center" nowrap><font color="#ffffff"><b>����Ա����</b></font></td>
		      <td width="25%" align="center" nowrap><font color="#ffffff"><b>����Ա˵��</b></font></td>
		      <td width="7%" align="center" nowrap><font color="#ffffff"><b>�޸�</b></font></td>
		    </tr>
		   <%
		   
			temp = (indexPage-1)*number;//ÿһҳ����ʼҳ��
			i=1;
			for(i=1;i<num+1;i++)
			{
			%>
			<tr>
			      <td width="6%" align="center"> 
		        	<input type="checkbox" name="sel" value="<%=administratorIDs[i-1]%>" <%if(administratorNames[i-1].equals("admin")) out.println("disabled");%>>
		      	      </td>
				<%
						out.print("<td width='7%' align='center' >"+(temp+i)+"</td>");
						out.print("<td width='20%' align='left' >"+administratorNames[i-1]+"</td>");
						out.print("<td width='30%' align='left' >"+administratorMemos[i-1]+"&nbsp;</td>");
				%>
			<td width="7%" align="center"><a href="updateadmin.jsp?id=<%=administratorIDs[i-1]%>" onClick="javaScript:event.returnValue=false;window.open('updateadmin.jsp?adminid=<%=administratorIDs[i-1]%>','','width=800,height=600,scrollbars=yes');"><img src="../../../images/icon_edit.gif" border="0"></a></td>
			</tr>
			<%		
			}
			%>
			
			
			
			
		 </form>
		  </tbody>  
		  </table> 
	</td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4">
  <tr> 
    <td width="58%" valign="top">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
            <table width="217" cellspacing="0" border="0" cellpadding="0">
      		  <tr>
      		    <td width="54" height="18"><%if(indexPage>1){%><a href="grouplist.jsp?biaozhi=0&searchWord=">��  ҳ</a><%}else{%>��  ҳ<%}%></td>
                <td width="54"><%if(indexPage>1){%><a href="grouplist.jsp?biaozhi=<%=indexPage-1%>&searchWord=">��һҳ</a><%}else{%>��һҳ<%}%></td>
                <td width="54"><%if((pageCount-indexPage)>0){%><a href="grouplist.jsp?biaozhi=<%=indexPage+1%>&searchWord=">��һҳ</a><%}else{%>��һҳ<%}%></td>
                <td width="55"><%if((pageCount-indexPage)>0){%><a href="grouplist.jsp?biaozhi=<%=pageCount%>&searchWord=">β ҳ</a><%}else{%>β ҳ<%}%></td>
      		  </tr>
      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
    	<input type="hidden" name="selall" id="idselall" value="0">
    	<img src="../../../images/selectall.gif" border="0" style="cursor:hand;" onClick="allselect()"> <a onclick="javascript:sure();"><img src="../../../images/delete_blue.gif" border="0" style="cursor:hand;"></a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</table>
</body>
</html>

