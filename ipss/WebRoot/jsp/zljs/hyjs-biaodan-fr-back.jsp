<%@ page contentType="text/html;charset=gbk" errorPage="/error.jsp"%>
<%@ page import="com.trs.was.*"%>
<%@ page import="com.trs.was.config.*"%>

<%@ include file="../../jsp/zljs/include-head-base.jsp"%>

<%
session.setAttribute("ChannelID_all","");
session.setAttribute("TRSWAS_Hash_mapRS",null);
String strFRChannel = "";

try
{
	
	String searchsecond=new String();
	String show=new String();
	searchsecond=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"secondsearch");
	
	String filtersearch=request.getParameter("filtersearch");
	
	if ((searchsecond!=null) && (searchsecond.length()>0))
	{
	   if (searchsecond.equals("ON")) show="���μ���";
	}
	
	if ((filtersearch!=null) && (filtersearch.length()>0))
	{
	   if (filtersearch.equals("ON")) show="���˼���";
	}
%>

<html>
<head>
<title>������-<%=website_title%></title>
<link href="<%=basePath%>css/cnipr.css" rel="stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
var vCountry = "1";
</script>
<link href="<%=basePath%>css/style-old.css" rel="stylesheet" type="text/css">
<Script src="<%=basePath%>admin/hangye/js/hyjs-logic-y.js"></Script>
<Script src="<%=basePath%>admin/hangye/js/SimpleTable1.js"></Script>
<Script src="<%=basePath%>js/muti.js"></Script>
<script>
function Select(obj, item) 
{
    for (var i=0;i<obj.elements.length;i++)
    {
        var e = obj.elements[i];
        if (e.name == item)
    	   e.checked=Flag;
    }
    Flag=!Flag;
    if(!Flag)
    	obj.btnSelect.value = "ȡ��";
    else
    	obj.btnSelect.value = "ȫѡ";
}
function returnVal(SearchForm)
{
    var strdb="";
    for(var e=0;e<document.loginform.strdb.length;e++)
    {
		if(document.loginform.strdb[e].checked)
		{
			strdb=strdb+document.loginform.strdb[e].value+",";
		}
	} 
	strdb=strdb.substring(0,strdb.length-1);

	if(strdb=="")
	{
		alert("��ѡ��Ƶ��");
		return false;
	}
	
	var searchword = document.loginform.txtSearchWord.value;
	searchword = searchword.replace(/(^\s*)|(\s*$)/g, "")

	if(searchword=="")
	{
//alert(arrInputName.length);
        for(var i = 0; i < arrInputName.length; i++)
        {
        	var tmpInput = eval(SearchForm + "." + arrInputName[i][0]);
        	var strValue = TrimSpace(tmpInput.value);
//alert(strValue);
			
        	if(strValue != null && strValue != "")
        	{
        		arrInputName[i][4] = arrInputName[i][3].toLowerCase() + "=(" + strValue + ")";
        	}
        }

        for(var i = 0; i < arrInputName.length; i++)
        {
        	if(arrInputName[i][4] != null && arrInputName[i][4] != "")
        	{
        		arrInputName[i][4] = arrInputName[i][4].replace(' * ',' and ');
        		arrInputName[i][4] = arrInputName[i][4].replace(' + ',' or ');
				arrInputName[i][4] = arrInputName[i][4].replace(' - ',' not ');
        		if(searchword != null && searchword != "")
        			searchword += " and " + arrInputName[i][4];
        		else
        			searchword = arrInputName[i][4];
        	}
        }
	}

	if(searchword!="")
	{
		var rArgs = new Array(searchword,strdb);
		window.returnValue = rArgs;
		window.close();
	}else{
		alert("�������������");
	}
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	scrollbar-face-color:ffffff; 
	scrollbar-shadow-color:C1C1BB; 
	scrollbar-highlight-color:C1C1BB; 
	scrollbar-3dlight-color:EBEBE4; 
	scrollbar-darkshadow-color:EBEBE4; 
	scrollbar-track-color:F4F4F0; 
	scrollbar-arrow-color:CACAB7; 
}
.style1 {
	color: #0000FF;
	font-size: 12px;
}
span{font-size:12px;}
.tablebutton
{
	cursor:hand; 
	width=115;
	border:none;
	background-color:transparent;
	vertical-algin:center; 
	height:20;
	padding:3 0 0 0;
	font-size:9pt;
}
-->
</style></HEAD>
<body BGCOLOR="#FFFFFF" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" style="overflow-y:auto">

<form name="loginform" action="hyjs-jieguo-fr.jsp" method="post" target="_self" onSubmit="return FormSubmit('document.loginform','1')">
<input type="hidden" value="ON" name="secondsearch">
<input type="hidden" name="filtersearch" value="ON">
<input type="hidden" name="synonymous" id="c3" style="cursor:hand">
<input type="hidden" name="savesearchword" value="ON" id="c4" style="cursor:hand">
<input type="hidden" name="sortcolumn" value="RELEVANCE">
<input type="hidden" name="R1">
<input type="hidden" name="extension" value=""/>
<input type="hidden" name="channelid" value=""/>
<input type="hidden" name="sRecordNumber" value=""/>
<input type="hidden" name="searchChannel" value=""/>
<input type="hidden" name="searchType" value="1"/>
<input type="hidden" name="searchFrom" value="0"/>
<input type="hidden" name="issearch" value="on"/>
<input type="hidden" name="searchword"/>     
<input type="hidden" name="sortfield" value=""/>

<ul style="list-style:none;margin:0;">
<%
com.opensymphony.xwork2.ActionContext _cxt = com.opensymphony.xwork2.ActionContext.getContext();
java.util.Map<String, Object> _application = _cxt.getApplication();
%>

<%
String frChannels = com.cnipr.cniprgz.commons.Util.getCheckedPatentTableIDsByArea(_application,"fr");

String OtherPatent = com.cnipr.cniprgz.commons.DataAccess.getProperty("OtherPatent");
if(OtherPatent!=null&&OtherPatent.equals("1")){	
	frChannels = com.cnipr.cniprgz.commons.Util.getPatentTableIDsByArea(_application,"fr");
}
%>

<%

String[] arrFRChannel = frChannels.split(",");

for(int i=0;i<arrFRChannel.length;i++){
%>
<li style="display:inline"><input type="checkbox" value="<%=arrFRChannel[i]%>" id="strdb<%=arrFRChannel[i]%>" name="strdb"/><label for="strdb<%=arrFRChannel[i]%>" style="cursor:hand"><%=com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,arrFRChannel[i])%></label></li>
<%
}
%>
</ul>

<input name="btnSelect" type="button" value="ȡ��" style="cursor:hand;color: black;background-color:#efefef;font-size:10pt;width:42;height:21;border-style:solid;border-width:1" onclick="Select(document.loginform,'strdb');">

<table width="601" border="0" cellpadding="0" cellspacing="0">

  
<tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="1" background="<%=basePath%>images/blue_bg_ys.gif">
                    <TBODY>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'A');" style="cursor:hand"><input type="button"  class="tablebutton" value="A:ר���������� ��" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtA"  size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;ר�����ֶμ���֧��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ�,�ֶ��ڸ�������֮�����<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����������ר���ţ�����룺<B><font color=red>CH694421</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ר����ǰ��λΪCH69442��Ӧ���룺<B><font color=red>CH69442%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪ר�����м伸λΪ69442��Ӧ���룺<B><font color=red>%69442%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪ר���Ų������ļ�λΪ69��21��Ӧ���룺<B><font color=red>%69%21%</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'B');" style="cursor:hand"><input type="button"  class="tablebutton" value="B:�ꡡ���롡�� ��" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtB"  size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;������ֶμ���֧��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ�,�ֶ��ڸ�������֮�����<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1��������������ţ�����룺<B><font color=red>CH20010000254</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪�����ǰ��λΪCH20010��Ӧ���룺<B><font color=red>CH20010%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪������м伸λΪ1000025��Ӧ���룺<B><font color=red>%1000025%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪����Ų������ļ�λΪCH2001��254��Ӧ���룺<B><font color=red>%CH2001%254%</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'C');" style="cursor:hand"><input type="button"  class="tablebutton" value="C:�ꡡ���롡�� ��" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtC"  size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;���������ꡢ�¡�����������ɣ�ģ�����ֿ�ֱ����ȥ������ģ���ַ�����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1��������Ϊ2002��01��01�գ����ɼ��룺<B><font color=red>20020101</font></B>��<B><font color=red>2002.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2��������Ϊ2002��01�£��ɼ��룺<B><font color=red>200201</font></B>��<B><font color=red>2002.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3��������Ϊ2002��ĳ��01�գ��ɼ��룺<B><font color=red>2002..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4��������Ϊĳ��01��01�գ��ɼ��룺<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5������������Ϊ��2002�굽2003�����Ϣ���ɼ��룺<B><font color=red>2002 to 2003</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'D');" style="cursor:hand"><input type="button"  class="tablebutton" value="D:������������ ��" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtD"  size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;���������ꡢ�¡�����������ɣ�ģ�����ֿ�ֱ����ȥ������ģ���ַ�����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1��������Ϊ2004��01��08�գ����ɼ��룺<B><font color=red>20040101</font></B>��<B><font color=red>2004.01.08</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2��������Ϊ2004��01�£��ɼ��룺<B><font color=red>200401</font></B>��<B><font color=red>2004.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3��������Ϊ2004��ĳ��01�գ��ɼ��룺<B><font color=red>2004..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4��������Ϊĳ��01��01�գ��ɼ��룺<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5������������Ϊ��2002�굽2003�����Ϣ���ɼ��룺<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'E');" style="cursor:hand"><input type="button"  class="tablebutton" value="E:������������ ��" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtE"  alt="&nbsp;&nbsp;&nbsp;&nbsp;�����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�����а���computer���ɼ��룺<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪�����а���computer��System���ɼ��룺<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪�����а���computer��system���ɼ��룺<B><font color=red>computer or system</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'F');" style="cursor:hand"><input type="button"  class="tablebutton" value="F:ժ���������� Ҫ" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtF"  alt="&nbsp;&nbsp;&nbsp;&nbsp;ժҪ�ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪ժҪ�а���computer���ɼ��룺<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ժҪ�а���computer��System���ɼ��룺<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪ժҪ�а���computer��system���ɼ��룺<B><font color=red>computer or system</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'G');" style="cursor:hand"><input type="button"  class="tablebutton" value="G:�����֡��ࡡ ��" style="width:130"></TD>
                        <TD width="30%" height=32>
						
						<INPUT name="txtG" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;ͬһר�����밸�������ɸ������ʱ�����е�һ����Ϊ������š�������ſ�ʵ��ģ��������ģ������Ӧʹ��<B><font color=red>%</font></B>���档 <BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�������ΪA43B5/04��Ӧ���룺<B><font color=red>A43B5/04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪����������ײ���ΪA43B5��Ӧ���룺<B><font color=red>A43B5%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��������а���B5/04��Ӧ���룺<B><font color=red>%B5/04%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪��������а���B5��04��Ӧ���룺<B><font color=red>%B5%04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5���������������ΪA43B5/04��A01N43/56��Ӧ���룺<B><font color=red>A43B5/04 or A01N43/56</font></B>'" value="<%if(request.getParameter("getclass") != null) out.write(request.getParameter("getclass"));%>">

						
						</TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'H');" style="cursor:hand"><input type="button"  class="tablebutton" value="H:�֡����ࡡ�� ��" style="width:130"></TD>
                        <TD width="30%" height=32>
						
						<INPUT name="txtH" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;ר�����밸�ķ���ſ��ɡ�����ר���������á���������ֶ�֧��ģ��������ģ������Ӧʹ��<B><font color=red>%</font></B>���档 <BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�����ΪA43B5/04��Ӧ���룺<B><font color=red>A43B5/04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��������ײ���ΪA43B5��Ӧ���룺<B><font color=red>A43B5%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪������а���B5/04��Ӧ���룺<B><font color=red>%B5/04%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪������а���B5��04��Ӧ���룺<B><font color=red>%B5%04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5�������������ΪA43B5/04��A01N43/56��Ӧ���룺<B><font color=red>A43B5/04 or A01N43/56</font></B>">
						
						</TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'I');" style="cursor:hand"><input type="button"  class="tablebutton" value="I:���루ר��Ȩ����" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtI"  alt="&nbsp;&nbsp;&nbsp;&nbsp;���루ר��Ȩ�����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪���루ר��Ȩ����ΪLANGE INT SA��Ӧ���룺<B><font color=red>LANGE INT SA</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪���루ר��Ȩ�����а���BONNY PHILIPPE��SINGY ALEXANDRE��Ӧ���룺<B><font color=red>BONNY PHILIPPE and SINGY ALEXANDRE</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪���루ר��Ȩ�����а�BONNY PHILIPPE��SINGY ALEXANDRE��Ӧ���룺<B><font color=red>BONNY PHILIPPE or SINGY ALEXANDRE</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'J');" style="cursor:hand"><input type="button"  class="tablebutton" value="J:�� ������ƣ���" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtJ"  alt="&nbsp;&nbsp;&nbsp;&nbsp;��������ƣ����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��������ƣ���ΪLANGE INT SA��Ӧ���룺<B><font color=red>LANGE INT SA</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��������ƣ����а���BONNY PHILIPPE��SINGY ALEXANDRE��Ӧ���룺<B><font color=red>BONNY PHILIPPE and SINGY ALEXANDRE</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��������ƣ����а���BONNY PHILIPPE��SINGY ALEXANDRE��Ӧ���룺<B><font color=red>BONNY PHILIPPE or SINGY ALEXANDRE</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'K');" style="cursor:hand"><input type="button"  class="tablebutton" value="K:�š����ȡ��� Ȩ" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size=20 name="txtK"  alt="&nbsp;&nbsp;&nbsp;&nbsp;��Ȩ���ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��Ȩ���а���computer���ɼ��룺<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��Ȩ���а���computer��System���ɼ��룺<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��Ȩ���а���computer��system���ɼ��룺<B><font color=red>computer or system</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'L');" style="cursor:hand"><input type="button"  class="tablebutton" value="L:ͬ���塡ר�� ��" style="width:130"></TD>
                        <TD width="30%" height=32 ><INPUT name="txtL" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;ͬ��ר�����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪ͬ��ר�����а���US6354470���ɼ��룺<B><font color=red>US6354470</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ͬ��ר�����а���US6354470��GR2000100304���ɼ��룺<B><font color=red>US6354470 and GR2000100304</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪ͬ��ר�����а���US6354470��GR2000100304���ɼ��룺<B><font color=red>US6354470 or GR2000100304</font></B>"></TD>
                      </TR>
                    </TBODY>
                  </TABLE>
	
	</td>
</tr>

<tr>
<td colspan="4">
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
<TR align=left> 
<TD>
<!-- 
	<p class="tab" style="width:43px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" and "> and </p>
	<p class="tab" style="width:37px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" or "> or </p>
	<p class="tab" style="width:43px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" not "> not </p>
	<p class="tab" style="width:20px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" ( "> ( </p>
	<p class="tab" style="width:20px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" ) "> ) </p>
 -->
 
			<IMG src="<%=basePath%>images/operator/and.gif" 
             style="CURSOR: hand" onclick="insertAtCaret(this)" value=" and " ><IMG src="<%=basePath%>images/operator/or.gif" 
            style="CURSOR: hand" onclick="insertAtCaret(this)" value=" or "><IMG src="<%=basePath%>images/operator/not.gif" 
           style="CURSOR: hand" onclick="insertAtCaret(this)" value=" not "><IMG 
            src="<%=basePath%>images/operator/left.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" ( "><IMG 
            src="<%=basePath%>images/operator/right.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" ) ">

			</TD>
            </TR>
</TABLE>
</td>
</tr>

<tr>
  <td>
<textarea name="txtSearchWord" cols="83" rows="4"></textarea>
  </td>
  </tr>
  
<tr><td>

<table width="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
<tr><td height="5" colspan="2">

		</td></tr>
        <tr> 
        <td align="center">
		
		<table width="200" height="60" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <td align="center">
		   <!--
		  <p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:returnVal('document.loginform');">�� ��</a></p>
		   -->
		  <input style="border:0;background:url(<%=basePath%>images/button_sc.gif);width:66;height:23;cursor:hand" onClick="javascript:returnVal('document.loginform');" type="button" name=submit1>
		 
		  </td>
		<td align="center">
		<!-- 
		<p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:document.loginform.reset();">�� ��</a></p>
			 -->
		<input type="reset" style="border:0;background:url(<%=basePath%>images/button_clear.gif);width:66;height:23;cursor:hand" value="">
	
		</td></tr>
		</table>

		</td>
		</tr>
		</table>
</td></tr>
</table>
</form>
</body>

<%
}
catch(Exception exp)
{
	WASException wase = new WASException(exp.getMessage());
	session.setAttribute("was_exception",wase);   //���µ��쳣���󱣴浽session�У��Ա��ڱ���ҳerror.jsp�л��
	throw wase;  
}
finally
{
	com.trs.was.PTools.freeWASResultSet(request);
}
%>
<Script language="JavaScript">
//var obj = document.loginform.txtComb;
var obj = document.loginform.txtSearchWord;
var vCountry = "1";
</Script>
<script>
var oMyObject = window.dialogArguments;

var sExpression = oMyObject.Expression;
document.getElementById("txtSearchWord").value = sExpression;

var sChannels = oMyObject.Channels;
if(sChannels!=""){//�༭
	var arrdb = document.getElementsByName("strdb");
	for(i=0;i<arrdb.length;i++){
		arrdb[i].checked = false;
	}
	
	var arrFRChannel = sChannels.split(",");
	for(i=0;i<arrFRChannel.length;i++){
		var obj = document.getElementById("strdb"+arrFRChannel[i]);
		if(obj!=null){
			obj.checked = true;
		}		
	}
}
</script>