<%@ page contentType="text/html;charset=GBK" errorPage="../common/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%
String strAdminName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

int adminID=intUserID;
//**********************ȡ�ù���ԱID�������ڴ�id���û���ʾ����*****************************
%>
<%
      //��ȡ��Ҫ�����û�ID������ؼ���
	  String  searchField=request.getParameter("searchfield");
	  String  searchWord=request.getParameter("searchword");
	  String  strPageIndex=request.getParameter("pageindex");
	  String  strUserIDs[]=request.getParameterValues("sel");
	  String  strGroupID=request.getParameter("groupid");
	  String  searchMark=request.getParameter("searchmark");
	  //����һЩ����
	  int     intPageIndex=0;
	  int     intPageCount=15;
	  if(strPageIndex==null)
	  {
	      intPageIndex=1;
	  }
	  else
	  {
	      intPageIndex=Integer.parseInt(strPageIndex);
	  }
	  int    intGroupID=Integer.parseInt(strGroupID);
	  if(searchWord!=null)
	  {
	    searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	  }
	  //�ж��Ƿ��ĳ���û�����������
	  UserManage usermanage=new UserManage();
	  if(searchMark==null)
	  {
	    if(strUserIDs==null)
	    {
	       usermanage.setGroupUserMulti(intGroupID,intPageCount,intPageIndex,adminID);
	    }
	    else
	    {
	       int intUserIDs[]=new int[strUserIDs.length];
		   for(int i=0;i<strUserIDs.length;i++)
		   {
		      intUserIDs[i]=Integer.parseInt(strUserIDs[i]);
		   }
		   usermanage.updateuser(intGroupID,intUserIDs);
		   usermanage.setGroupUserMulti(intGroupID,intPageCount,intPageIndex,adminID);
	    }
	  }
	  else
	  {
	     String  field="";
		 if(searchField.equals("0"))
		 {
		    field="userName";
		 }
		 if(searchField.equals("1"))
		 {
		    field="realName";
		 }
		 usermanage.setGroupUserMulti(intGroupID,intPageCount,intPageIndex,field,searchWord,adminID);
	  }
	  String userNames[]=usermanage.getUserNames();
	  String realNames[]=usermanage.getRealNames();
	  int    userIDs[]=usermanage.getUserIDs();
	  int    count=usermanage.getCount();
	  int    intPages=usermanage.getPages();
	  //������ֵ��nullת��Ϊ�գ������ѯ���ֿ�ָ��
	  if(searchField==null)
	  {
	      searchField="";
	  }
	  if(searchWord==null)
	  {
	      searchWord="";
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

//ȫѡ���غ���
function allselect()
{
	var i
	
	if( document.all.form2.sel==undefined )
	{
		return;
	}
	if(document.all.form4.selall.checked==true)
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

function sure(n)
{
	if( n==1 )
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
				alert("��ѡ����ӵ�����û���");
				return false;
			}
		}
		else
		{
				if(document.all.form2.sel.checked==false)
				{
					alert("��ѡ����ӵ�����û���");
					return false;
				}
		}

		if (confirm("ȷ��Ҫ���ѡ�е��û���������?"))
		{
			form2.submit();
		}
		else
		{
			return false;
		}		
	}
}
function checkpageform(form)
{
	if(form.page1.value=="")
	{
		alert("��ָ��Ҫ�����ҳ����");
		return false;
	}
	if(!isInteger(form.page1.value))
	{
		alert("ָ��Ҫ�����ҳ��������������");
		return false;
	}
	if(form.page1.value<=0 || form.page1.value><%=intPages%>)
	{
		alert("ָ��Ҫ�����ҳ������������ķ�Χ��");
		return false;
	}
	form.pageindex.value=form.page1.value;
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
-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">����û����Ա</span></td>
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
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <form name="form1" method="post" action="addgroupuser.jsp?groupid=<%=strGroupID%>">
				  <input type="hidden" name="searchmark" value="search">
                  <tr>
			          <td colspan="4" align="center"> 
			            <select name="searchfield">
			              <option value="0" <%if(searchField.equals("0")) out.print("selected");%>>�û���</option>
			              <option value="1" <%if(searchField.equals("1")) out.print("selected");%>>�û�����</option>
			            </select> <input type="text" name="searchword" value="<%=searchWord%>">
			          </td>
	                  <td width="30%"> 
	                    <div align="left"><a href="a" onclick="javascript:event.returnValue=false;submit();"><img src="../../../images/search_list.gif" border="0" width="54" height="18" style="cursor:hand;"></a></div>
	                  </td>
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
		      		    <td width="54" height="18"><%if(intPageIndex==1) {%>��  ҳ<%} else {%><a href="addgroupuser.jsp?pageindex=1&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">�� ҳ</a><%}%></td> 
		                <td width="54"><%if(intPageIndex<=1) {%>��һҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPageIndex-1%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">��һҳ</a><%}%></td> 
		                <td width="54"><%if(intPageIndex==intPages||intPages==0 || intPages==1||intPageIndex>intPages ) {%>��һҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPageIndex+1%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">��һҳ</a><%}%></td>  
		                <td width="55"><%if(intPageIndex==intPages||intPageIndex>intPages) {%>β ҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPages%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">β ҳ</a><%}%></td>
		      		  </tr>
		      		</table>
                </td>
                <td width="105" > 
                  <table width="105" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
                    <form name="formpage" method="post" action="addgroupuser.jsp" onSubmit="javaScript:return checkpageform(this);">
                      <tr> 
                        <td width="15"> �� </td>
                        <td width="45" align="left" valign="top"><input name="page1" type="text" class="10int" size="4"></td>
                        <td width="15"> ҳ </td>
						<td width="30"><input name="imageField2" type="image" src="../../../images/go_list.gif" width="19" height="11" border="0" style="cursor:hand();"></td>
                      </tr>
                      <input type="hidden" name="groupid" value="<%=strGroupID%>">
		              <input type="hidden" name="searchfield" value="<%=searchField%>">
		              <input type="hidden" name="searchword" value="<%=searchWord%>">
					  <input type="hidden" name="pageindex" value="">
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
          <td width="96%" height="32" align="right"><a href="a" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_addgroupuser.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
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
(�� <%=intPageIndex%> ҳ&nbsp;�� <%=intPages%> ҳ <%=count%> ��)

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
	    <form name="form2" method="post" action="addgroupuser.jsp">
		<tr bgcolor="#4787b8"> 
	          <td align="center"  width="10%" ><font color="#ffffff"><b>ѡ��</b></font></td>
	          <td align="center"  width="20%" ><font color="#ffffff"><b>���</b></font></td>
	          <td align="center"  width="35%" ><font color="#ffffff"><b>�û���</b></font></td>
	          <td align="center"  width="35%" ><font color="#ffffff"><b>�û�����</b></font></td>
		</tr>
	<%
	for(int i=0;i<count&&i<userIDs.length;i++)
	{
	%>	
		<tr> 
	          <td align="center" width="10%" > 
	            <input type="checkbox" name="sel" value="<%=userIDs[i]%>"  <%if(userNames[i].equals("admin")) {out.print("disabled");}%>>
		  	  </td>
	          <td align="center" width="20%" ><%=(intPageIndex-1)*intPageCount+i+1%></td>
	          <td align="center" width="35%" ><%=userNames[i]%></td>
	          <td align="center" width="35%" ><%=realNames[i]%></td>          
		</tr>
	<%
	}
	%>
	 		<input type="hidden" name="pageindex" value="<%=intPageIndex%>">
		  	<input type="hidden" name="groupid" value="<%=strGroupID%>">
	      </form>	
	  </table>
    </td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4">
<form name="form4">
  <tr> 
    <td width="58%">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
            <table width="217" cellspacing="0" border="0" cellpadding="0">
		      		  <tr>
		      		    <td width="54" height="18"><%if(intPageIndex==1) {%>��  ҳ<%} else {%><a href="addgroupuser.jsp?pageindex=1&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">�� ҳ</a><%}%></td> 
		                <td width="54"><%if(intPageIndex<=1) {%>��һҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPageIndex-1%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">��һҳ</a><%}%></td> 
		                <td width="54"><%if(intPageIndex==intPages||intPages==0 || intPages==1||intPageIndex>intPages ) {%>��һҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPageIndex+1%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">��һҳ</a><%}%></td>  
		                <td width="55"><%if(intPageIndex==intPages||intPageIndex>intPages) {%>β ҳ<%} else {%><a href="addgroupuser.jsp?pageindex=<%=intPages%>&groupid=<%=strGroupID%>&searchfield=<%=searchField%>&searchword=<%=searchWord%>">β ҳ</a><%}%></td>
		      		  </tr>
		      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap>
       	<input type="checkbox" name="selall" value="checkbox" onclick="allselect()">ȫѡ
        <a onclick="javascript:sure(1);" style="cursor:hand;"><img src="../../../images/ok_blue.gif" border="0"></a>
        <a onclick="javascript:window.close();" style="cursor:hand;"><img src="../../../images/close_blue.gif" border="0"></a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</form>  
</table>
</body>
</html>
