<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"  %>
<%@ page import="com.trs.usermanage.*"%>

<%
        //������������ò���
    ParameterSource parametersource=new ParameterSource(1);	//���в�������Դ
	String  foreignImagePath="";				//���⸽ͼ�����ַ
	String  siteTempPath="";				//��ʱ�ļ������ַ
	int     downloadType=0;					//��ժ���ݵ���������
	int     priceMode=0;					//�Ʒ�ģʽ
	int     ipLimit=0;					//�Ƿ�ʹ�ó���������
	int     downPrintNums=0;				//ÿ���ӡ��������
	int     displayNums=0;					//����ÿҳ��ʾ��¼��
	String  fmPublishPath="";				//�������ݷ���·��
	String  xxPublishPath="";				//�������ݷ���·��
	String  wgPublishPath="";				//������ݷ���·��
	String  sqPublishPath="";				//��Ȩ���ݷ���·��
	String  frPublishPath="";				//�������ݷ���·��
	String  siteAppPath="";					//վ��Ӧ�ó���·��
	String  InternetIP="";					//�������ⲿIP��ַ
	String  IntranetIP="";					//�������ڲ�IP��ַ
	String  PDFPath="";						//����˵����ԭ��PDF���·��
	String  EpoUrl="";
	int intHangyeVisitStyle=1;

        foreignImagePath=parametersource.getForeignImagePath();
        siteTempPath=parametersource.getSiteTempPath();
        downloadType=parametersource.getDownloadType();
        priceMode=parametersource.getPriceMode();
        ipLimit=parametersource.getIPLimit();
        downPrintNums=parametersource.getDownPrintNums();
        displayNums=parametersource.getDisplayNums();
        fmPublishPath=parametersource.getFMPublishPath();
        xxPublishPath=parametersource.getXXPublishPath();
        wgPublishPath=parametersource.getWGPublishPath();
        sqPublishPath=parametersource.getSQPublishPath();
        frPublishPath=parametersource.getFRPublishPath();
        siteAppPath=parametersource.getSiteAppPath();
		InternetIP=parametersource.getInternetIP();
		IntranetIP=parametersource.getIntranetIP();
		
        intHangyeVisitStyle=parametersource.getHangyeVisitStyle();
		String FigurePhysicalPath="";//˵���鸽ͼ�������ַ
		FigurePhysicalPath=parametersource.getFigurePhysicalPath();
%>
<!-- ҳ����� -->
<html>
<head>
<title>��������ƽ̨��̨����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/cds_style.css">
<script language="javascript">
function copyname()
{
	document.all.sysform.SitePath.value="/"+document.all.sysform.SiteName.value.toLowerCase();
}
</script>
</head>

<script language="JavaScript" >
<!--
function docheckit()
{
//    if(document.sysform.foreignImagePath.value==""||document.sysform.siteTempPath.value==""||document.sysform.downloadType.value=="")
//    {
//      alert("����������в�����ȫ��");
//      return false;
//    }
    window.sysform.submit();
    return true;
}
function useCityIPLimit()
{
   window.open('useCityIPLimit.jsp','','width=800,height=600,scrollbars=yes');
   return true;
}
//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="91%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td valign="top">
      <table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="97%" valign="top">
            <div align="center"><img src="../images/xtsz.gif">
            </div></td>
          <td width="3%" align="right">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="../../images/topbg_nolist.gif">
        <tr> 
          <td width="5%"><img src="../../images/topl_nolist.gif" width="20" height="29"></td>
          <td width="94%" align="left">
            <table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" class="12hb">
              <tr> 
                <td id="idbutton1" width="89" align="right" valign="top" background="../../images/topbutl_nolist.gif">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr>
                      <td align="center" valign="bottom" background="../../images/topbutl_nolist.gif">ϵͳ��������</td>
                    </tr>
                  </table>
                </td>
                <td>&nbsp;</td>
                <td width="89" id="idbutton5" align="right" valign="top">
                  <table width="89" height="19" border="0" cellpadding="0" cellspacing="0" class="12hb">
                    <tr> 
                      <td align="center" valign="bottom"><a href="../../help/project_jsp_updateproject.htm" onClick="javaScript:event.returnValue=false;window.open('../../help/project_jsp_updateproject.htm','','width=800,height=600,scrollbars=yes');"><img src="../../images/help_nolist.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="1%" align="right"><img src="../../images/topr_nolist.gif" height="29"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EBEBEB">
        <form name="sysform" method="post" action="updateprojectsubmit1.jsp">
        <tr>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
          <td width="98%" valign="top">
            
            <!-- �ļ�����ҳ�� -->
			<table width="100%" border="0" id="fileconfig" style="display:block;" cellspacing="2" cellpadding="2">
              <tr> 
                <td align="right" width="157" nowrap>����������IP��ַ��</td>
                <td width="686"> 
                  <input type="text" name="InternetIP" size="22" value="<%=InternetIP%>"><font color="red">***</font>
                  <input type="hidden" name="foreignImagePath" size="20" value="<%=foreignImagePath%>">
</td>
              </tr>
              <tr> 
                <td align="right" width="157">����������IP��ַ��</td>
                <td> 
                  <input type="text" name="IntranetIP" size="22" value="<%=IntranetIP%>"><font color="red">***</font>
                  <input type="hidden" name="siteTempPath" size="20" value="<%=foreignImagePath%>">
				</td>
              </tr>
              <tr style="display:none;"> 
                <td align="right" width="157">��ҵ�������ʷ�ʽ��</td>
                <td> 
                  <select name="hangye_visit_style" size="1">
                    <option value="2" <%if(intHangyeVisitStyle==2){%>selected<%}%>>ֻ�ܷ�����Ȩ����ҵ��Ϣ</option>
					<!--option value="3" <%if(intHangyeVisitStyle==2){%>selected<%}%>>ֻ�ܷ�����Ȩ����ҵ��Ϣ</option-->
					<option value="1" <%if(intHangyeVisitStyle==1){%>selected<%}%>>ȫ��Ȩ��</option>
                  </select>
				</td>
              </tr>
			  <tr>
			  	<td align="right" width="157" nowrap>˵���鸽ͼ���·����</td>
				<td><input type="text" name="FigurePhysicalPath" size="30" value="<%=FigurePhysicalPath%>"> 
				���磺E:\XmlData</td>
			  </tr>
             		  
			  <input type="hidden" name="downloadType"  value="1">
			  <input type="hidden" name="fmPublishPath" size="20" value="<%=fmPublishPath%>">
			  <input type="hidden" name="sqPublishPath" size="20" value="<%=sqPublishPath%>">
			  <input type="hidden" name="wgPublishPath" size="20" value="<%=wgPublishPath%>">
			  <input type="hidden" name="xxPublishPath" size="20" value="<%=xxPublishPath%>">
			  <input type="hidden" name="frPublishPath" size="20" value="<%=frPublishPath%>">
			  <input type="hidden" name="priceMode"  value="0" <%if(priceMode==0) out.print("checked");%>>
			  <input type="hidden" name="siteAppPath" size="20" value="<%=siteAppPath%>">
			  <input type="hidden" name="downPrintNums" size="20" value="<%=downPrintNums%>">
			  <input type="hidden" name="displayNums" size="20" value="<%=displayNums%>">
			  
                <!--tr id="dis5"> 
                  <td align="right" width="213">��ժ�������ͣ�</td>
                  <td>
                    <table>
                      <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                <td align="right" width="213">FM���ݷ���·����</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">SQ���ݷ���·����</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">WG���ݷ���·����</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">XX���ݷ���·����</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">�������ݷ���·����</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">�Ʒ�ģʽ��</td>
                <td> 
                  <table>
                      <tr>
                        <td>��ҳ�Ʒ�</td>
                        <td>�����Ʒ�</td>
                      </tr>
                    </table>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">���������ƣ�</td>
                <td>
				  <table>
                      <tr>
                        <td><input type="radio" name="ipLimit"  value="0"  >��ʹ�ó�����</td>
                        <td><input type="radio" name="ipLimit"  value="1"  onClick="useCityIPLimit();return true;">ʹ�ó�����</td>
                      </tr>
                    </table>
                  </td>
              </tr>
			  <tr align="center">
			     <td colspan="2">
				   <table id="cityIP" style="display:none " width="100%">
				     <tr>
				        <td align="right" width="211"> IP�Σ�</td>
						<td> </td>
				     </tr>
				   </table>
				 </td>
			  </tr>
			  <tr> 
                <td align="right" width="213">ÿ���ӡ��������</td>
                <td> 
                  
                    <font color="red">ҳ������</font></td>
              </tr>
			  <tr> 
                <td align="right" width="213">����ÿҳ��ʾ��¼������</td>
                <td> 
                  
                    �� </td>
              </tr>
			  <tr> 
                <td align="right" width="213">վ��Ӧ�ó���·����</td>
                <td> 
                  
                  </td>
              </tr-->
              <tr> 
                <td align="center" colspan="2"> 
                <img src="../images/wancheng.gif" style="cursor:hand"  width="47" height="20" onClick="return docheckit();">
                <img src="../images/reset.gif" style="cursor:hand"  width="47" height="20" onclick="window.sysform.reset();">  
                </td>
              </tr>
			  
            </table>
          </td>
          <td width="1%" bgcolor="#A8C5E2">&nbsp;</td>
        </tr>
        </form>
      </table>
      <table width="100%" height="23" border="0" cellpadding="0" cellspacing="0" background="../../images/topb_nolist.gif">
        <tr> 
          <td width="27%"><img src="../../images/bl_nolist.gif" width="20" height="23"></td>
          <td align="right"><img src="../../images/br_nolist.gif" width="21" height="23"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
