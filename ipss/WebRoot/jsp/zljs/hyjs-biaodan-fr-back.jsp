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
	   if (searchsecond.equals("ON")) show="二次检索";
	}
	
	if ((filtersearch!=null) && (filtersearch.length()>0))
	{
	   if (filtersearch.equals("ON")) show="过滤检索";
	}
%>

<html>
<head>
<title>表格检索-<%=website_title%></title>
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
    	obj.btnSelect.value = "取消";
    else
    	obj.btnSelect.value = "全选";
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
		alert("请选择频道");
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
		alert("请输入检索条件");
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

<input name="btnSelect" type="button" value="取消" style="cursor:hand;color: black;background-color:#efefef;font-size:10pt;width:42;height:21;border-style:solid;border-width:1" onclick="Select(document.loginform,'strdb');">

<table width="601" border="0" cellpadding="0" cellspacing="0">

  
<tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="1" background="<%=basePath%>images/blue_bg_ys.gif">
                    <TBODY>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'A');" style="cursor:hand"><input type="button"  class="tablebutton" value="A:专　　利　　 号" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtA"  size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;专利号字段检索支持<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符,字段内各检索词之间进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、输入完整专利号，如键入：<B><font color=red>CH694421</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知专利号前五位为CH69442，应键入：<B><font color=red>CH69442%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知专利号中间几位为69442，应键入：<B><font color=red>%69442%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知专利号不连续的几位为69和21，应键入：<B><font color=red>%69%21%</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'B');" style="cursor:hand"><input type="button"  class="tablebutton" value="B:申　　请　　 号" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtB"  size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;申请号字段检索支持<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符,字段内各检索词之间进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、输入完整申请号，如键入：<B><font color=red>CH20010000254</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知申请号前五位为CH20010，应键入：<B><font color=red>CH20010%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知申请号中间几位为1000025，应键入：<B><font color=red>%1000025%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知申请号不连续的几位为CH2001和254，应键入：<B><font color=red>%CH2001%254%</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'C');" style="cursor:hand"><input type="button"  class="tablebutton" value="C:申　　请　　 日" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtC"  size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;申请日由年、月、日三部分组成，模糊部分可直接略去（不用模糊字符）。<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、申请日为2002年01月01日，，可键入：<B><font color=red>20020101</font></B>或<B><font color=red>2002.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、申请日为2002年01月，可键入：<B><font color=red>200201</font></B>或<B><font color=red>2002.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、申请日为2002年某月01日，可键入：<B><font color=red>2002..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、申请日为某年01月01日，可键入：<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、检索申请日为从2002年到2003年的信息，可键入：<B><font color=red>2002 to 2003</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'D');" style="cursor:hand"><input type="button"  class="tablebutton" value="D:公　　布　　 日" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT name="txtD"  size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;公布日由年、月、日三部分组成，模糊部分可直接略去（不用模糊字符）。<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、公布日为2004年01月08日，，可键入：<B><font color=red>20040101</font></B>或<B><font color=red>2004.01.08</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、公布日为2004年01月，可键入：<B><font color=red>200401</font></B>或<B><font color=red>2004.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、公布日为2004年某月01日，可键入：<B><font color=red>2004..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、公布日为某年01月01日，可键入：<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、检索公布日为从2002年到2003年的信息，可键入：<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'E');" style="cursor:hand"><input type="button"  class="tablebutton" value="E:名　　　　　 称" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtE"  alt="&nbsp;&nbsp;&nbsp;&nbsp;名称字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知名称中包含computer，可键入：<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知名称中包含computer和System，可键入：<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知名称中包含computer或system，可键入：<B><font color=red>computer or system</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'F');" style="cursor:hand"><input type="button"  class="tablebutton" value="F:摘　　　　　 要" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtF"  alt="&nbsp;&nbsp;&nbsp;&nbsp;摘要字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知摘要中包含computer，可键入：<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知摘要中包含computer和System，可键入：<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知摘要中包含computer或system，可键入：<B><font color=red>computer or system</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'G');" style="cursor:hand"><input type="button"  class="tablebutton" value="G:主　分　类　 号" style="width:130"></TD>
                        <TD width="30%" height=32>
						
						<INPUT name="txtG" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;同一专利申请案具有若干个分类号时，其中第一个称为主分类号。主分类号可实行模糊检索。模糊部分应使用<B><font color=red>%</font></B>代替。 <BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知主分类号为A43B5/04，应键入：<B><font color=red>A43B5/04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知主分类号起首部分为A43B5，应键入：<B><font color=red>A43B5%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知主分类号中包含B5/04，应键入：<B><font color=red>%B5/04%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知主分类号中包含B5和04，应键入：<B><font color=red>%B5%04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、若检索主分类号为A43B5/04或A01N43/56，应键入：<B><font color=red>A43B5/04 or A01N43/56</font></B>'" value="<%if(request.getParameter("getclass") != null) out.write(request.getParameter("getclass"));%>">

						
						</TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'H');" style="cursor:hand"><input type="button"  class="tablebutton" value="H:分　　类　　 号" style="width:130"></TD>
                        <TD width="30%" height=32>
						
						<INPUT name="txtH" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;专利申请案的分类号可由《国际专利分类表》查得。主分类号字段支持模糊检索。模糊部分应使用<B><font color=red>%</font></B>代替。 <BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知分类号为A43B5/04，应键入：<B><font color=red>A43B5/04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知分类号起首部分为A43B5，应键入：<B><font color=red>A43B5%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知分类号中包含B5/04，应键入：<B><font color=red>%B5/04%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知分类号中包含B5和04，应键入：<B><font color=red>%B5%04</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、若检索分类号为A43B5/04或A01N43/56，应键入：<B><font color=red>A43B5/04 or A01N43/56</font></B>">
						
						</TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'I');" style="cursor:hand"><input type="button"  class="tablebutton" value="I:申请（专利权）人" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtI"  alt="&nbsp;&nbsp;&nbsp;&nbsp;申请（专利权）人字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知申请（专利权）人为LANGE INT SA，应键入：<B><font color=red>LANGE INT SA</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知申请（专利权）人中包含BONNY PHILIPPE和SINGY ALEXANDRE，应键入：<B><font color=red>BONNY PHILIPPE and SINGY ALEXANDRE</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知申请（专利权）人中包BONNY PHILIPPE或SINGY ALEXANDRE，应键入：<B><font color=red>BONNY PHILIPPE or SINGY ALEXANDRE</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'J');" style="cursor:hand"><input type="button"  class="tablebutton" value="J:发 明（设计）人" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size="20" name="txtJ"  alt="&nbsp;&nbsp;&nbsp;&nbsp;发明（设计）人字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知发明（设计）人为LANGE INT SA，应键入：<B><font color=red>LANGE INT SA</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知发明（设计）人中包含BONNY PHILIPPE和SINGY ALEXANDRE，应键入：<B><font color=red>BONNY PHILIPPE and SINGY ALEXANDRE</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知发明（设计）人中包含BONNY PHILIPPE或SINGY ALEXANDRE，应键入：<B><font color=red>BONNY PHILIPPE or SINGY ALEXANDRE</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'K');" style="cursor:hand"><input type="button"  class="tablebutton" value="K:优　　先　　 权" style="width:130"></TD>
                        <TD width="30%" height=32><INPUT size=20 name="txtK"  alt="&nbsp;&nbsp;&nbsp;&nbsp;主权项字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知主权项中包含computer，可键入：<B><font color=red>computer</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知主权项中包含computer和System，可键入：<B><font color=red>computer and system</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知主权项中包含computer或system，可键入：<B><font color=red>computer or system</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'L');" style="cursor:hand"><input type="button"  class="tablebutton" value="L:同　族　专　 利" style="width:130"></TD>
                        <TD width="30%" height=32 ><INPUT name="txtL" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;同族专利项字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知同族专利项中包含US6354470，可键入：<B><font color=red>US6354470</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知同族专利项中包含US6354470和GR2000100304，可键入：<B><font color=red>US6354470 and GR2000100304</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知同族专利项中包含US6354470或GR2000100304，可键入：<B><font color=red>US6354470 or GR2000100304</font></B>"></TD>
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
		  <p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:returnVal('document.loginform');">生 成</a></p>
		   -->
		  <input style="border:0;background:url(<%=basePath%>images/button_sc.gif);width:66;height:23;cursor:hand" onClick="javascript:returnVal('document.loginform');" type="button" name=submit1>
		 
		  </td>
		<td align="center">
		<!-- 
		<p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:document.loginform.reset();">清 除</a></p>
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
	session.setAttribute("was_exception",wase);   //将新的异常对象保存到session中，以便在报错页error.jsp中获得
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
if(sChannels!=""){//编辑
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