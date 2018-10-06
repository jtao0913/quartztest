<%@ page contentType="text/html; charset=GBK" errorPage="../../jsp/error.jsp"  %>
<%@ page import="com.trs.usermanage.*"%>

<%
        //定义服务器配置参数
    ParameterSource parametersource=new ParameterSource(1);	//运行参数数据源
	String  foreignImagePath="";				//国外附图物理地址
	String  siteTempPath="";				//临时文件物理地址
	int     downloadType=0;					//文摘数据的下载类型
	int     priceMode=0;					//计费模式
	int     ipLimit=0;					//是否使用城域网控制
	int     downPrintNums=0;				//每天打印下载数量
	int     displayNums=0;					//概览每页显示记录数
	String  fmPublishPath="";				//发明数据发布路径
	String  xxPublishPath="";				//新型数据发布路径
	String  wgPublishPath="";				//外观数据发布路径
	String  sqPublishPath="";				//授权数据发布路径
	String  frPublishPath="";				//国外数据发布路径
	String  siteAppPath="";					//站点应用程序路径
	String  InternetIP="";					//服务器外部IP地址
	String  IntranetIP="";					//服务器内部IP地址
	String  PDFPath="";						//国外说明书原文PDF存放路径
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
		String FigurePhysicalPath="";//说明书附图的物理地址
		FigurePhysicalPath=parametersource.getFigurePhysicalPath();
%>
<!-- 页面设计 -->
<html>
<head>
<title>检索服务平台后台管理</title>
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
//      alert("您必须把所有参数填全！");
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
                      <td align="center" valign="bottom" background="../../images/topbutl_nolist.gif">系统参数配置</td>
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
            
            <!-- 文件配置页面 -->
			<table width="100%" border="0" id="fileconfig" style="display:block;" cellspacing="2" cellpadding="2">
              <tr> 
                <td align="right" width="157" nowrap>服务器外网IP地址：</td>
                <td width="686"> 
                  <input type="text" name="InternetIP" size="22" value="<%=InternetIP%>"><font color="red">***</font>
                  <input type="hidden" name="foreignImagePath" size="20" value="<%=foreignImagePath%>">
</td>
              </tr>
              <tr> 
                <td align="right" width="157">服务器内网IP地址：</td>
                <td> 
                  <input type="text" name="IntranetIP" size="22" value="<%=IntranetIP%>"><font color="red">***</font>
                  <input type="hidden" name="siteTempPath" size="20" value="<%=foreignImagePath%>">
				</td>
              </tr>
              <tr style="display:none;"> 
                <td align="right" width="157">行业导航访问方式：</td>
                <td> 
                  <select name="hangye_visit_style" size="1">
                    <option value="2" <%if(intHangyeVisitStyle==2){%>selected<%}%>>只能访问授权的行业信息</option>
					<!--option value="3" <%if(intHangyeVisitStyle==2){%>selected<%}%>>只能访问授权的行业信息</option-->
					<option value="1" <%if(intHangyeVisitStyle==1){%>selected<%}%>>全部权限</option>
                  </select>
				</td>
              </tr>
			  <tr>
			  	<td align="right" width="157" nowrap>说明书附图存放路径：</td>
				<td><input type="text" name="FigurePhysicalPath" size="30" value="<%=FigurePhysicalPath%>"> 
				例如：E:\XmlData</td>
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
                  <td align="right" width="213">文摘下载类型：</td>
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
                <td align="right" width="213">FM数据发布路径：</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">SQ数据发布路径：</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">WG数据发布路径：</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">XX数据发布路径：</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">国外数据发布路径：</td>
                <td> 
                  <font color="red">***</font>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">计费模式：</td>
                <td> 
                  <table>
                      <tr>
                        <td>按页计费</td>
                        <td>按件计费</td>
                      </tr>
                    </table>
                </td>
              </tr>
			  <tr> 
                <td align="right" width="213">城域网控制：</td>
                <td>
				  <table>
                      <tr>
                        <td><input type="radio" name="ipLimit"  value="0"  >不使用城域网</td>
                        <td><input type="radio" name="ipLimit"  value="1"  onClick="useCityIPLimit();return true;">使用城域网</td>
                      </tr>
                    </table>
                  </td>
              </tr>
			  <tr align="center">
			     <td colspan="2">
				   <table id="cityIP" style="display:none " width="100%">
				     <tr>
				        <td align="right" width="211"> IP段：</td>
						<td> </td>
				     </tr>
				   </table>
				 </td>
			  </tr>
			  <tr> 
                <td align="right" width="213">每天打印下载数：</td>
                <td> 
                  
                    <font color="red">页（件）</font></td>
              </tr>
			  <tr> 
                <td align="right" width="213">概览每页显示记录条数：</td>
                <td> 
                  
                    条 </td>
              </tr>
			  <tr> 
                <td align="right" width="213">站点应用程序路径：</td>
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
