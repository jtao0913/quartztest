<%@ page contentType="text/html;charset=gbk" errorPage="/error.jsp"%>
<%@ page import="java.util.*,com.trs.was.*,com.trs.was.PTools"%>

<%@ include file="../../jsp/zljs/include-head-base.jsp"%>

<%
session.setAttribute("ChannelID_all","");
session.setAttribute("TRSWAS_Hash_mapRS",null);

try{
	String strClass = "";
	strClass = request.getParameter("t");
	/*if(strClass != null && !strClass.equals("") && strClass.equals("IPC"))
	{
		strCHChannel = PTools.getIPCChannel(wc,wUser,0);
	}else
	{
		strCHChannel = PTools.getValidChannel(wc,wUser,0);	//ȡ����Ȩ�޵Ĺ���Ƶ��
	}
	*/
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
<link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css">

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
span{font-size:12px;}
-->
</style>
<Script language="JavaScript">
var vCountry = "0";
</Script>
<script language=javascript src="<%=basePath%>admin/hangye/js/hyjs-logic-y.js"></script>
<Script language=javascript src="<%=basePath%>admin/hangye/js/SimpleTable1.js"></Script>

<script>
function ShowMore(){
	if(document.all.extend.style.display == "none")
	{
		document.all.extend.style.display="";
		document.all.btnMore.src="<%=basePath%>images/operator/btnHide.gif";
		document.all.btnMore.title="������������";
	}
	else
	{
		document.all.extend.style.display="none";
		document.all.btnMore.src="<%=basePath%>images/operator/btnShow.gif";
		document.all.btnMore.title="�����ʾ���������";
	}
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
			//����������/ר����/������,�ж��Ƿ��CN�����û�ӣ��ͼ���
        		if(vCountry == "0")	//��������д˲���
        		{
	        		if(arrInputName[i][2] == "AN")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('����������ֶε����룬���ֶβ�֧���ڲ��߼�����');
	        				return false;
	        			}
	        			else
	        			{
	        				if(strValue.length > 1 && strValue.substring(0,2).toLowerCase() != "cn")
	        					strValue = "CN" + strValue;
	        			}
	        		}
	        		if(arrInputName[i][2] == "PNM")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('���鹫�������棩���ֶε����룬���ֶβ�֧���ڲ��߼�����');
	        				return false;
	        			}
	        			else
	        			{
	        				if(strValue.length > 1 && strValue.substring(0,2).toLowerCase() != "cn")
	        					strValue = "CN" + strValue;
	        			}
	        		}
	        	}
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
//		alert(strdb);
		window.returnValue = rArgs;
		window.close();
	}else{
		alert("�������������");
	}
}
</script>
</head>

<body BGCOLOR="#FFFFFF" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">

<table width="600" border="0" cellpadding="0" cellspacing="0">
<form name="loginform" action="hyjs-jieguo-ys.jsp" method="post" target="_self" onSubmit="return FormSubmit('document.loginform','1')">
<input type="hidden" name="extension" value="">
<input type="hidden" name="issearch" value="on">
<input type="hidden" name="searchword">
<input type="hidden" name="presearchword" value="<TRS:SearchReport type='allsearchword'></TRS:SearchReport>">
<input type="hidden" name="sortfield" value="">
<input type="hidden" name="sRecordNumber" value="">
<input type="hidden" name="searchType" value="0">
<input type="hidden" name="searchFrom" value="0">
<tr>
<td height="43"  class="gray" background="<%=basePath%>image/bg5.jpg">
<input type="hidden" name="channelid" value="">
<input type="hidden" name="searchChannel" value="">
<input type="hidden" value="ON" name="secondsearch"/>
<input type="hidden" name="filtersearch" value="ON"/>
<input type="hidden" name="synonymous" value="ON"/>
<input type="hidden" name="savesearchword" value="ON" id="c4" style="cursor:hand"/>
<input type="hidden" name="cizi" value="2"/>
<input type="hidden" name="sortcolumn" value="RELEVANCE"/>
<input type="hidden" name="R1"/>
<%
String str1=null;
str1=com.trs.was.bbs.RequestParameterOperation.getParameter(request,"channelid");
%>
&nbsp;
<input type="checkbox" value="14"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("14")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel14" style="cursor:hand"><label for="channel14" style="cursor:hand">����ר��</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="15"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("15")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel15" style="cursor:hand"><label for="channel15" style="cursor:hand">ʵ������</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="16"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("16")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel16" style="cursor:hand"><label for="channel16" style="cursor:hand">������</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="17"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("17")!=-1) {%>checked<%}} else {%><%}%> id="channel17" style="cursor:hand"><label for="channel17" style="cursor:hand">������Ȩ</label>&nbsp;&nbsp;&nbsp;&nbsp;	

</td></tr>


<tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="1" background="<%=basePath%>images/blue_bg_ys.gif">
                    <TBODY>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'A');" style="cursor:hand"><input type="button"  class="tablebutton" value="A:�� �루ר������" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT id="txtA" name="txtA" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;������ֶμ���֧��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ�,�ֶ��ڸ�������֮�����<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1��������������ţ�����룺<B><font color=red>CN02144686.5</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪�����ǰ��λΪ02144��Ӧ���룺<B><font color=red>CN02144%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪������м伸λΪ2144��Ӧ���룺<B><font color=red>%2144%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪����Ų������ļ�λΪ021��468��Ӧ���룺<B><font color=red>%021%468%</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'B');" style="cursor:hand"><input type="button"  class="tablebutton" value="B:�ꡡ���롡 ����" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtB" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;���������ꡢ�¡�����������ɣ�ģ�����ֿ�ֱ����ȥ������ģ���ַ�����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1��������Ϊ2002��01��01�գ����ɼ��룺<B><font color=red>20020101</font></B>��<B><font color=red>2002.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2��������Ϊ2002��01�£��ɼ��룺<B><font color=red>200201</font></B>��<B><font color=red>2002.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3��������Ϊ2002��ĳ��01�գ��ɼ��룺<B><font color=red>2002..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4��������Ϊĳ��01��01�գ��ɼ��룺<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5������������Ϊ��2002�굽2003�����Ϣ���ɼ��룺<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'C');" style="cursor:hand"><input type="button"  class="tablebutton" value="C:�� �������棩��" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtC" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;���������棩���ֶ�֧��ģ��������ģ������λ�ڹ��������棩�����׻��м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ�,λ�ڹ��������棩��ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪���������棩��ΪCN1387751��Ӧ���룺<B><font color=red>CN1387751</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪���������棩��ǰ�漸λΪCN13877���ɼ��룺<B><font color=red>CN13877</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪���������棩���а���13877���ɼ��룺<B><font color=red>%13877</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'D');" style="cursor:hand"><input type="button"  class="tablebutton" value="D:�� �������棩��" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtD" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;���������棩�����ꡢ�¡�����������ɣ�ģ�����ֿ�ֱ����ȥ������ģ���ַ�����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1�����������棩��Ϊ2003��01��01�գ����ɼ��룺<B><font color=red>20030101</font></B>��<B><font color=red>2003.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2�����������棩��Ϊ2003��01�£��ɼ��룺<B><font color=red>200301</font></B>��<B><font color=red>2003.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3�����������棩��Ϊ2003��ĳ��01�գ��ɼ��룺<B><font color=red>2003..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4�����������棩��Ϊĳ��01��01�գ��ɼ��룺<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5���������������棩��Ϊ��2002�굽2003�����Ϣ���ɼ��룺<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'E');" style="cursor:hand"><input type="button"  class="tablebutton" value="E:������������ ��" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size=20 name="txtE" alt="&nbsp;&nbsp;&nbsp;&nbsp;�����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>��<B><font color=red>not</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�����а�����������ɼ��룺<B><font color=red>�����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪�����а����������Ӧ�ã��ɼ��룺<B><font color=red>����� and Ӧ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪�����а������������ƣ��ɼ��룺<B><font color=red>����� or ����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪�����а��������������������ʱ���ɼ���<B><font color=red>����� not ����</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'F');" style="cursor:hand"><input type="button"  class="tablebutton" value="F:ժ���������� Ҫ" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size=20 name="txtF" alt="&nbsp;&nbsp;&nbsp;&nbsp;ժҪ�ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>��<B><font color=red>not</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪ժҪ�а�����������ɼ��룺<B><font color=red>�����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ժҪ�а����������Ӧ�ã��ɼ��룺<B><font color=red>����� and Ӧ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪ժҪ�а������������ƣ��ɼ��룺<B><font color=red>����� or ����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪�����а��������������������ʱ���ɼ���<B><font color=red>����� not ����</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'G');" style="cursor:hand"><input type="button"  class="tablebutton" value="G:�����֡��ࡡ ��" style="width:130"></TD>
                        <TD width="30%" height=30>
						<INPUT name="txtG" size=20 alt="&nbsp;&nbsp;&nbsp;&nbsp;ͬһר�����밸�������ɸ������ʱ�����е�һ����Ϊ������š�������ſ�ʵ��ģ��������ģ������Ӧʹ��<B><font color=red>%</font></B>���档 <BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�������ΪG06F15/16��Ӧ���룺<B><font color=red>G06F15/16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪����������ײ���ΪG06F��Ӧ���룺<B><font color=red>G06F%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��������а���15/16��Ӧ���룺<B><font color=red>%15/16%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪��������а���15��16��Ӧ���룺<B><font color=red>%15%16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5���������������ΪG06F15/16��G06F15/17��Ӧ���룺<B><font color=red>G06F15/16 or G06F15/17</font></B>">
                        </TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'H');" style="cursor:hand"><input type="button"  class="tablebutton" value="H:�֡����ࡡ ����" style="width:130"></TD>
                        <TD width="30%" height=30>
						<INPUT size=20 name="txtH" alt="&nbsp;&nbsp;&nbsp;&nbsp;ר�����밸�ķ���ſ��ɡ�����ר���������á���������ֶ�֧��ģ��������ģ������Ӧʹ��<B><font color=red>%</font></B>���档 <BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�����ΪG06F15/16��Ӧ���룺<B><font color=red>G06F15/16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��������ײ���ΪG06F��Ӧ���룺<B><font color=red>G06F%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪������а���15/16��Ӧ���룺<B><font color=red>%15/16%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4����֪������а���15��16��Ӧ���룺<B><font color=red>%15%16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5�������������ΪG06F15/16��G06F15/17��Ӧ���룺<B><font color=red>G06F15/16 or G06F15/17</font></B>">
						</TD>
                      </TR>
					  <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'I');" style="cursor:hand"><input type="button"  class="tablebutton" value="I:���루ר��Ȩ����" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size="20" name="txtI" alt="&nbsp;&nbsp;&nbsp;&nbsp;���루ר��Ȩ�����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪���루ר��Ȩ����Ϊ��ˮ����Ӧ���룺<B><font color=red>��ˮ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪���루ר��Ȩ�����а�����ѧƽ�Ͳܹ�Ⱥ��Ӧ���룺<B><font color=red>��ѧƽ and �ܹ�Ⱥ</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪���루ר��Ȩ�����а�����ΰ�ϻ������Ӧ���룺<B><font color=red>��ΰ�� or �����</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'J');" style="cursor:hand"><input type="button"  class="tablebutton" value="J:�� ������ƣ���" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size="20" name="txtJ" alt="&nbsp;&nbsp;&nbsp;&nbsp;��������ƣ����ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��������ƣ���Ϊ��ˮ����Ӧ���룺<B><font color=red>��ˮ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��������ƣ����а�����ѧƽ�Ͳܹ�Ⱥ��Ӧ���룺<B><font color=red>��ѧƽ and �ܹ�Ⱥ</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��������ƣ����а�����ΰ�ϻ������Ӧ���룺<B><font color=red>��ΰ�� or �����</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'K');" style="cursor:hand"><input type="button"  class="tablebutton" value="K:������Ȩ�� ����"></TD>
                        <TD width="30%" height=32><INPUT id="txtK" field="cl" size=20 name="txtK" alt="&nbsp;&nbsp;&nbsp;&nbsp;��Ȩ���ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��Ȩ���а�����������ɼ��룺<B><font color=red>�����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��Ȩ���а����������Ӧ�ã��ɼ��룺<B><font color=red>����� and Ӧ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��Ȩ���а������������ƣ��ɼ��룺<B><font color=red>����� or ����</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'L');" style="cursor:hand"><input type="button"  class="tablebutton" value="L:�ء��������� ַ"></TD>
                        <TD width="30%" height=22><INPUT id="txtL" field="ar" name="txtL" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;��ַ�ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��ַ�а�������ʡ��ɽ�У��ɼ��룺<B><font color=red>����ʡ��ɽ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪��ַ�а�������ʡ�Ͱ�ɽ�У��ɼ��룺<B><font color=red>����ʡ and ��ɽ��</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪��ַ�а�����ɽ�л�����У��ɼ��룺<B><font color=red>��ɽ�� or ������</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'M');" style="cursor:hand"><input type="button"  class="tablebutton" value="M:ר�� �� �� ����"></TD>
                        <TD width="30%" height=32 ><INPUT id="txtM" field="agc" name="txtM" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;ר����������ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪ר����������а�����������ɼ��룺<B><font color=red>��������</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ר����������а��������Ϳ���ɼ��룺<B><font color=red>���� and ����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪ר����������а������������������Է���ɼ��룺<B><font color=red>�������� or ������Է</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'N');" style="cursor:hand"><input type="button"  class="tablebutton" value="N:�������� ����"></TD>
                        <TD width="30%" height=32><INPUT id="txtN" field="agt" name="txtN" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;�������ֶ�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪�������а�������죬�ɼ��룺<B><font color=red>�����</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪�������а��������������ң��ɼ��룺<B><font color=red>����� and ������</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3����֪�������а�������������÷���ɼ��룺<B><font color=red>����� or ����÷</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'P');" style="cursor:hand"><input type="button"  class="tablebutton" value="P:�š����ȡ� ��Ȩ"></TD>
                        <TD width="30%" height="32"><INPUT id="txtP" field="pr" name="txtP" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;����Ȩ�ֶ��а�����ʾ�������ĸ�ͱ�ʾ��ŵ����֣�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���λ���ַ������׻�ĩβʱģ���ַ���ʡ�ԡ��ֶ��ڸ�������֮��ɽ���<B><font color=red>and</font></B>��<B><font color=red>or</font></B>����<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪ר������Ȩ���Ϊ02112242��Ӧ���룺<B><font color=red>02112242</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2����֪ר������Ȩ����Ϊ�й�������Ȩ���Ϊ02112242��Ӧ���룺<B><font color=red>CN and 02112242</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="���������߼������м�����ֶδ���" onClick="insertItem(obj, 'Q');" style="cursor:hand"><input type="button"  class="tablebutton" value="Q:��  ʡ  ��  ��"></TD>
                        <TD width="30%" height="32"><INPUT id="txtQ" field="co" name="txtQ" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;��ʡ�����ֶ��а�����ʾ��ʡ����ĸ�ͱ�ʾ��ŵ����֣�֧��ģ��������ģ������ʱӦ����ѡ�ùؼ��֣���������������޹����ס�ģ������λ���ַ����м�ʱӦʹ��<B><font color=red>?</font></B>���浥���ַ�,<B><font color=red>%</font></B>�������ַ���<BR><BR><B>����ʾ����</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1����֪��ʡ����Ϊ����(32)��Ӧ���룺<B><font color=red>����%</font></B>��<B><font color=red>%32%</font></B><BR>"></TD>
                      </TR>

<tr><td colspan="4">
<table width="100%" cellSpacing="0" cellPadding="0" align="left" border="0" borderColorDark="#ffffff" bgColor="#ffffff" class="t1">
<tr align=left> 
<td valign="middle">
	<!-- 
	<p class="tab" style="width:43px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" and "> and </p>
	<p class="tab" style="width:37px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" or "> or </p>
	<p class="tab" style="width:43px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" not "> not </p>
	<p class="tab" style="width:20px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" ( "> ( </p>
	<p class="tab" style="width:20px;cursor: pointer;float: left;" align="center" onclick="insertAtCaret(this)" value=" ) "> ) </p>
	 -->
		 
		<IMG src="<%=basePath%>images/operator/and.gif" 
            style="CURSOR: hand" onclick="insertAtCaret(this)" value=" and " >
            <IMG src="<%=basePath%>images/operator/or.gif" 
            style="CURSOR: hand" onclick="insertAtCaret(this)" value=" or ">
            <IMG src="<%=basePath%>images/operator/not.gif" 
            style="CURSOR: hand" onclick="insertAtCaret(this)" value=" not ">
            <IMG 
            src="<%=basePath%>images/operator/left.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" ( ">
            <IMG 
            src="<%=basePath%>images/operator/right.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" ) ">
            <!--  
            <img 
			id="btnMore" border="0" onClick="ShowMore()" src="<%=basePath%>images/operator/btnShow.gif" alt="�����ʾ���������" style="cursor:hand">
			-->
			</TD>

<td>
<div id="extend" style="display:none">
<table border="0" cellpadding="0" cellspacing="0">
			<tr>
			<td><IMG src="<%=basePath%>images/operator/xor.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" xor "><IMG 
            src="<%=basePath%>images/operator/adj.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" adj "><IMG 
            src="<%=basePath%>images/operator/equ.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" equ/10 "><IMG 
            src="<%=basePath%>images/operator/nor.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" xor/10 "><IMG 
            src="<%=basePath%>images/operator/pre_10.gif" style="CURSOR: hand" onclick="insertAtCaret(this)" value=" pre/10 "></TD>
            </tr>
</table>
</div>
       			  </TD>
                </TR>
		</table>
</td></tr>

</TBODY>
</TABLE>

	</td>
  </tr>
  <tr>
  <td>
<textarea id="txtSearchWord" name="txtSearchWord" cols="83" rows="4"></textarea>
  </td>
  </tr>
  <tr>
    <td align="center">
	<table width="200" height="30" border="0" cellpadding="0" cellspacing="0">
		<tr>
		  <td align="center" >
		  
		  <input style="border:0;background:url(<%=basePath%>images/button_sc.gif);width:66;height:23;cursor:hand" onClick="javascript:returnVal('document.loginform');" type="button" name=submit1>
		 
		     <!--
		   <p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:returnVal('document.loginform');">�� ��</a></p>
		   -->
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
</form>

</table>
</body>

<%
}
catch(Exception exp)
{
	//exp.printStackTrace();
	WASException wase = new WASException(exp.getMessage());
	session.setAttribute("was_exception",wase);   //���µ��쳣���󱣴浽session�У��Ա��ڱ���ҳerror.jsp�л��
	throw wase;  
}
finally
{
	com.trs.was.PTools.freeWASResultSet(request);
}
%>
<Script language=javascript src="js/sx.js"></Script>

<script>
var obj = document.loginform.txtSearchWord;

var oMyObject = window.dialogArguments;

var sExpression = oMyObject.Expression;
document.getElementById("txtSearchWord").value = sExpression;


var sChannels = oMyObject.Channels;
//alert(sExpression+"............................."+sChannels);

if(sChannels!=""){//�༭
//	var obj_13 = document.getElementById("channel13");
//	obj_13.checked = false;
	var obj_14 = document.getElementById("channel14");
	obj_14.checked = false;
	var obj_15 = document.getElementById("channel15");
	obj_15.checked = false;
	var obj_16 = document.getElementById("channel16");
	obj_16.checked = false;
	var obj_17 = document.getElementById("channel17");
	obj_17.checked = false;

//	if(sChannels.indexOf("2;3;4")!=-1){
//		obj_13.checked = true;
//	}
	if(sChannels.indexOf("14")!=-1){
		obj_14.checked = true;
	}
	if(sChannels.indexOf("15")!=-1){
		obj_15.checked = true;
	}
	if(sChannels.indexOf("16")!=-1){
		obj_16.checked = true;
	}
	if(sChannels.indexOf("17")!=-1){
		obj_17.checked = true;
	}
}
</script>