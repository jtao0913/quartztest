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
int	nPageNum=15;
String 	strTemp=null, strID="0", strCond1="", strCond2="";
int	nPage=1, nTotol=0, nRec=0, nAll=0, n=0, nID=0;
Connection	conn=null;
String strSql="";
StringBuffer	str = new StringBuffer("");
String strErrorFrom = "usermanager/jsp/group/groupgrant.jsp"; //������Դ
String strPowerCheckMethodName = "getManageUserGroupGrant"; //�����û�Ȩ����֤��ʹ�õ���

try	//ͳһ�쳣����
{
%>
	<!--�жϹ���Ա�Ƿ��Ѿ���¼-->
	<%@ include file="../../inc/checkuser.jsp" %>
	<!--�жϹ���Ա�Ƿ�����û������Ȩ��-->
	<%@ include file="../../inc/checkpower.jsp" %>
<%
	//�û�ID String
	strID = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"id");
	if( strID==null || strID.equals("") || !ValidCheck.isNumber(strID) )
	{
		throw new UNIException(101, "��Ч���û�ID", null);
	}
	else
	{
		nID = Integer.parseInt( strID );
	}

	//ҳ��
	strTemp = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"page");
	if( strTemp!=null && !strTemp.equals("") && ValidCheck.isNumber(strTemp) )
	{
		nPage = Integer.parseInt( strTemp );
	}

	//������Ȩ�޼����ʣ�
	strCond1 = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"grantname");

	strTemp="";
	if( strCond1!=null && !strCond1.equals("") )
	{
		strTemp = " and c.grantname like '%" + ValidCheck.parseSQL(strCond1) + "%'" ;
	}
	else
	{
		strCond1 = "";
	}

	//�����������ʣ�
	strCond2 = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"resourcename");
	if( strCond2!=null && !strCond2.equals("") )
	{
		strTemp = strTemp + " and d.resourcename like '%" + ValidCheck.parseSQL(strCond2) + "%'";
	}
	else
	{
		strCond2 = "";
	}

	conn = DBConnect.getConnection();

	//��ȡ����
	if( strTemp.length() > 0 )
	{
		strSql = "select count(b.ID) as cnt from trs_groupgrantresource b,trs_grant c,trs_resource d,trs_group e where b.GroupID=? and b.GroupID=e.GroupID and b.GrantID=c.GrantID and b.ResourceID=d.ResourceID" + strTemp;
	}
	else
	{
		strSql = "select count(b.ID) as cnt from trs_groupgrantresource b,trs_grant c,trs_resource d,trs_group e where b.GroupID=? and b.GroupID=e.GroupID and b.GrantID=c.GrantID and b.ResourceID=d.ResourceID";
	}

	try
	{
		PreparedStatement PrePareStmt = conn.prepareStatement(strSql);
		PrePareStmt.setInt(1, nID);

		ResultSet rs = PrePareStmt.executeQuery();
		if(rs.next())
		{
			nTotol = rs.getInt("cnt");
		}

		rs.close();
		PrePareStmt.close();
		DBConnect.closeConnection(conn);
		conn=null;
	}
	catch(SQLException e)
	{
		DBConnect.closeConnection(conn);
		conn=null;
		throw new UNIException(124, "��ȡȨ��+��Դ����ʱִ�� SQL ������"+e.getMessage(), e);
	}
	finally
	{
		if( conn!=null )
		{
			DBConnect.closeConnection(conn);
		}
	}
	
	//���㹲�ж���ҳ
	nAll = (nTotol/nPageNum);
	
	if( nTotol%nPageNum > 0 )
	{
		nAll++;
	}

	//���ҳ�ų������ֵ
	if( nPage > nAll )
	{
		nPage = nAll;
	}
	if( nPage < 1 )
	{
		nPage = 1;
	}
%>

<html>
<head>
<title>TRS���ݷַ���������CDS�� V4.5</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<script language="javascript">
<!--
function goto(pageform)
{ 
	var s = new String(pageform.page1.value);

	if(isNaN(pageform.page1.value)||pageform.page1.value==""||s.charAt(0)==" ")
	{
		alert("������Ϸ���ҳ����ȷ������ǰ��û�пո�");
		return false;
	}
	pageform.method="post";
	pageform.action="?page="+pageform.page1.value+"&id="+document.all.form0.id.value+"&grantname="+document.all.form0.grantname.value+"&resourcename="+document.all.form0.resourcename.value;
	pageform.submit();
}


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
				alert("��ѡ��Ҫɾ������Ȩ��");
				return false;
			}
		}
		else
		{
				if(document.all.form2.sel.checked==false)
				{
					alert("��ѡ��Ҫɾ������Ȩ��");
					return false;
				}
		}
		
		document.all.form2.submit();
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
	if(form.page1.value<=0 || form.page1.value><%=nAll%>)
	{
		alert("ָ��Ҫ�����ҳ������������ķ�Χ��");
		return false;
	}
	form.pageIndex.value=form.page1.value-1;
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

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">
      <table width="487" height="25" border="0" cellpadding="0" cellspacing="0" background="../../../images/biaotibg_list.gif" class="14r">
        <tr> 
          <td width="505" align="right" valign="top"><span class="14r">�û�����ӵ�е�Ȩ��</span></td>
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
                <td width="93%">&nbsp;                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="top">
            <table width="361" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr align="left">
              	<td width="20">&nbsp;</td>
              	<td width="236" height="18">&nbsp;           		</td>
                <td width="105" >&nbsp;                </td>          
			  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right"><a href="../../../help/usermanager_jsp_group_groupgrant.htm" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_group_groupgrant.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td>
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
      <table cellspacing=0 bordercolordark="#ffffff" width="100%" bordercolorlight="#4787b8" border="1">
	      <form name="form2" method="post" action="deletegroupgrant.jsp">
			<tr> 
			  <td colspan="5" align="center" >
	  	        <select size="16" multiple name="opers" style="width=360">
                          <option>����ר������</option>
                          <option>����ר��ϸ��</option>
                          <option>����ר������</option>
                          <option>����ר������״̬</option>
                          <option>����ר����Ȩ��Ϣ</option>
                          <option>ʵ�����ͼ���</option>
                          <option>ʵ������ϸ��</option>
                          <option>ʵ����������</option>
                          <option>ʵ�����ͷ���״̬</option>
                          <option>ʵ��������Ȩ��Ϣ</option>
                        </select>
			  </td>
            </tr>
	<%
	
		//��ȡ�б�����
		if( strTemp.length() > 0 )
		{
			strSql = "select b.ID,c.grantname,d.resourcename,e.groupname,h.resourcetypename from trs_groupgrantresource b,trs_grant c,trs_resource d,trs_group e,trs_resourcetype h where b.GroupID=? and b.GroupID=e.GroupID and b.GrantID=c.GrantID and b.ResourceID=d.ResourceID and d.ResourceTypeID=h.ResourceTypeID" + strTemp;
		}
		else
		{
			strSql = "select b.ID,c.grantname,d.resourcename,e.groupname,h.resourcetypename from trs_groupgrantresource b,trs_grant c,trs_resource d,trs_group e,trs_resourcetype h where b.GroupID=? and b.GroupID=e.GroupID and b.GrantID=c.GrantID and b.ResourceID=d.ResourceID and d.ResourceTypeID=h.ResourceTypeID";
		}
	
		conn = DBConnect.getConnection();
		try
		{
			PreparedStatement PrePareStmt = conn.prepareStatement(strSql);
			PrePareStmt.setInt(1, nID);
	
			ResultSet rs = PrePareStmt.executeQuery();
			while( rs.next() )
			{
				nRec++;
				
				if( nRec <= (nPage-1) * nPageNum )
				{
					continue;
				}
				
				if( nRec > (nPage) * nPageNum )
				{
					break;
				}
				
	%>	
	<%
			}
			rs.close();
			PrePareStmt.close();
			DBConnect.closeConnection(conn);
			conn=null;
		}
		catch(SQLException e)
		{
			DBConnect.closeConnection(conn);
			conn=null;
			throw new UNIException(125, "��ȡȨ��+��Դʱִ�� SQL ������"+e.getMessage(), e);
		}
		finally
		{
			if(conn!=null)
			{
				DBConnect.closeConnection(conn);
			}
		}
	}
	catch(UNIException eUNI)
	{
		throw eUNI;
	}
	%>     
	 		<input type="hidden" name="page" value="<%=nPage%>">
		  	<input type="hidden" name="id" value="<%=strID%>">
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
          <td width="236">&nbsp;            </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap>
       	<input type="checkbox" name="selall" value="checkbox" onclick="allselect()">ȫѡ
        <a onclick="javascript:sure(1);" style="cursor:hand;"><img src="../../../images/xiugai.gif" width="47" height="20" border="0"></a>
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
