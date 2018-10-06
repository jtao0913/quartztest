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
		strCHChannel = PTools.getValidChannel(wc,wUser,0);	//取具有权限的国内频道
	}
	*/
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
		document.all.btnMore.title="点击隐藏运算符";
	}
	else
	{
		document.all.extend.style.display="none";
		document.all.btnMore.src="<%=basePath%>images/operator/btnShow.gif";
		document.all.btnMore.title="点击显示更多运算符";
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
			//如果是申请号/专利号/公开号,判断是否加CN，如果没加，就加上
        		if(vCountry == "0")	//国内项才有此操作
        		{
	        		if(arrInputName[i][2] == "AN")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('请检查申请号字段的输入，此字段不支持内部逻辑检索');
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
	        				alert('请检查公开（公告）号字段的输入，此字段不支持内部逻辑检索');
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
		alert("请输入检索条件");
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
<input type="checkbox" value="14"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("14")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel14" style="cursor:hand"><label for="channel14" style="cursor:hand">发明专利</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="15"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("15")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel15" style="cursor:hand"><label for="channel15" style="cursor:hand">实用新型</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="16"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("16")!=-1) {%>checked<%}} else {%>checked<%}%> id="channel16" style="cursor:hand"><label for="channel16" style="cursor:hand">外观设计</label>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="17"  name="strdb"  <%if (str1!=null) {%><%if (str1.indexOf("17")!=-1) {%>checked<%}} else {%><%}%> id="channel17" style="cursor:hand"><label for="channel17" style="cursor:hand">发明授权</label>&nbsp;&nbsp;&nbsp;&nbsp;	

</td></tr>


<tr><td>
<table width="100%" border="0" cellpadding="0" cellspacing="1" background="<%=basePath%>images/blue_bg_ys.gif">
                    <TBODY>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'A');" style="cursor:hand"><input type="button"  class="tablebutton" value="A:申 请（专利）号" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT id="txtA" name="txtA" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;申请号字段检索支持<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符,字段内各检索词之间进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、输入完整申请号，如键入：<B><font color=red>CN02144686.5</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知申请号前五位为02144，应键入：<B><font color=red>CN02144%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知申请号中间几位为2144，应键入：<B><font color=red>%2144%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知申请号不连续的几位为021和468，应键入：<B><font color=red>%021%468%</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'B');" style="cursor:hand"><input type="button"  class="tablebutton" value="B:申　　请　 　日" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtB" size="20"  alt="&nbsp;&nbsp;&nbsp;&nbsp;申请日由年、月、日三部分组成，模糊部分可直接略去（不用模糊字符）。<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、申请日为2002年01月01日，，可键入：<B><font color=red>20020101</font></B>或<B><font color=red>2002.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、申请日为2002年01月，可键入：<B><font color=red>200201</font></B>或<B><font color=red>2002.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、申请日为2002年某月01日，可键入：<B><font color=red>2002..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、申请日为某年01月01日，可键入：<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、检索申请日为从2002年到2003年的信息，可键入：<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'C');" style="cursor:hand"><input type="button"  class="tablebutton" value="C:公 开（公告）号" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtC" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;公开（公告）号字段支持模糊检索。模糊部分位于公开（公告）号起首或中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符,位于公开（公告）号末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知公开（公告）号为CN1387751，应键入：<B><font color=red>CN1387751</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知公开（公告）号前面几位为CN13877，可键入：<B><font color=red>CN13877</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知公开（公告）号中包含13877，可键入：<B><font color=red>%13877</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'D');" style="cursor:hand"><input type="button"  class="tablebutton" value="D:公 开（公告）日" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT name="txtD" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;公开（公告）日由年、月、日三部分组成，模糊部分可直接略去（不用模糊字符）。<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、公开（公告）日为2003年01月01日，，可键入：<B><font color=red>20030101</font></B>或<B><font color=red>2003.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、公开（公告）日为2003年01月，可键入：<B><font color=red>200301</font></B>或<B><font color=red>2003.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、公开（公告）日为2003年某月01日，可键入：<B><font color=red>2003..01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、公开（公告）日为某年01月01日，可键入：<B><font color=red>.01.01</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、检索公开（公告）日为从2002年到2003年的信息，可键入：<B><font color=red>2002 to 2003</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'E');" style="cursor:hand"><input type="button"  class="tablebutton" value="E:名　　　　　 称" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size=20 name="txtE" alt="&nbsp;&nbsp;&nbsp;&nbsp;名称字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>、<B><font color=red>not</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知名称中包含计算机，可键入：<B><font color=red>计算机</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知名称中包含计算机和应用，可键入：<B><font color=red>计算机 and 应用</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知名称中包含计算机或控制，可键入：<B><font color=red>计算机 or 控制</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知名称中包含计算机，不包含电子时，可键入<B><font color=red>计算机 not 电子</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'F');" style="cursor:hand"><input type="button"  class="tablebutton" value="F:摘　　　　　 要" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size=20 name="txtF" alt="&nbsp;&nbsp;&nbsp;&nbsp;摘要字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>、<B><font color=red>not</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知摘要中包含计算机，可键入：<B><font color=red>计算机</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知摘要中包含计算机和应用，可键入：<B><font color=red>计算机 and 应用</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知摘要中包含计算机或控制，可键入：<B><font color=red>计算机 or 控制</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知名称中包含计算机，不包含电子时，可键入<B><font color=red>计算机 not 电子</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'G');" style="cursor:hand"><input type="button"  class="tablebutton" value="G:主　分　类　 号" style="width:130"></TD>
                        <TD width="30%" height=30>
						<INPUT name="txtG" size=20 alt="&nbsp;&nbsp;&nbsp;&nbsp;同一专利申请案具有若干个分类号时，其中第一个称为主分类号。主分类号可实行模糊检索。模糊部分应使用<B><font color=red>%</font></B>代替。 <BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知主分类号为G06F15/16，应键入：<B><font color=red>G06F15/16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知主分类号起首部分为G06F，应键入：<B><font color=red>G06F%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知主分类号中包含15/16，应键入：<B><font color=red>%15/16%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知主分类号中包含15和16，应键入：<B><font color=red>%15%16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、若检索主分类号为G06F15/16或G06F15/17，应键入：<B><font color=red>G06F15/16 or G06F15/17</font></B>">
                        </TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'H');" style="cursor:hand"><input type="button"  class="tablebutton" value="H:分　　类　 　号" style="width:130"></TD>
                        <TD width="30%" height=30>
						<INPUT size=20 name="txtH" alt="&nbsp;&nbsp;&nbsp;&nbsp;专利申请案的分类号可由《国际专利分类表》查得。主分类号字段支持模糊检索。模糊部分应使用<B><font color=red>%</font></B>代替。 <BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知分类号为G06F15/16，应键入：<B><font color=red>G06F15/16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知分类号起首部分为G06F，应键入：<B><font color=red>G06F%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知分类号中包含15/16，应键入：<B><font color=red>%15/16%</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;4、已知分类号中包含15和16，应键入：<B><font color=red>%15%16</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;5、若检索分类号为G06F15/16或G06F15/17，应键入：<B><font color=red>G06F15/16 or G06F15/17</font></B>">
						</TD>
                      </TR>
					  <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'I');" style="cursor:hand"><input type="button"  class="tablebutton" value="I:申请（专利权）人" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size="20" name="txtI" alt="&nbsp;&nbsp;&nbsp;&nbsp;申请（专利权）人字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知申请（专利权）人为丁水波，应键入：<B><font color=red>丁水波</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知申请（专利权）人中包含顾学平和曹光群，应键入：<B><font color=red>顾学平 and 曹光群</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知申请（专利权）人中包含吴伟南或李会民，应键入：<B><font color=red>吴伟南 or 李会民</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=30 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'J');" style="cursor:hand"><input type="button"  class="tablebutton" value="J:发 明（设计）人" style="width:130"></TD>
                        <TD width="30%" height=30><INPUT size="20" name="txtJ" alt="&nbsp;&nbsp;&nbsp;&nbsp;发明（设计）人字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知发明（设计）人为丁水波，应键入：<B><font color=red>丁水波</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知发明（设计）人中包含顾学平和曹光群，应键入：<B><font color=red>顾学平 and 曹光群</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知发明（设计）人中包含吴伟南或李会民，应键入：<B><font color=red>吴伟南 or 李会民</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'K');" style="cursor:hand"><input type="button"  class="tablebutton" value="K:主　　权　 　项"></TD>
                        <TD width="30%" height=32><INPUT id="txtK" field="cl" size=20 name="txtK" alt="&nbsp;&nbsp;&nbsp;&nbsp;主权项字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知主权项中包含计算机，可键入：<B><font color=red>计算机</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知主权项中包含计算机和应用，可键入：<B><font color=red>计算机 and 应用</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知主权项中包含计算机或控制，可键入：<B><font color=red>计算机 or 控制</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'L');" style="cursor:hand"><input type="button"  class="tablebutton" value="L:地　　　　　 址"></TD>
                        <TD width="30%" height=22><INPUT id="txtL" field="ar" name="txtL" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;地址字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知地址中包含辽宁省鞍山市，可键入：<B><font color=red>辽宁省鞍山市</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知地址中包含辽宁省和鞍山市，可键入：<B><font color=red>辽宁省 and 鞍山市</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知地址中包含鞍山市或德阳市，可键入：<B><font color=red>鞍山市 or 德阳市</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'M');" style="cursor:hand"><input type="button"  class="tablebutton" value="M:专利 代 理 机构"></TD>
                        <TD width="30%" height=32 ><INPUT id="txtM" field="agc" name="txtM" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;专利代理机构字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知专利代理机构中包含长春科宇，可键入：<B><font color=red>长春科宇</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知专利代理机构中包含长春和科宇，可键入：<B><font color=red>长春 and 科宇</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知专利代理机构中包含长春科宇或沈阳科苑，可键入：<B><font color=red>长春科宇 or 沈阳科苑</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'N');" style="cursor:hand"><input type="button"  class="tablebutton" value="N:代　　理　 　人"></TD>
                        <TD width="30%" height=32><INPUT id="txtN" field="agt" name="txtN" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;代理人字段支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知代理人中包含李恩庆，可键入：<B><font color=red>李恩庆</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知代理人中包含李恩庆和马守忠，可键入：<B><font color=red>李恩庆 and 马守忠</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;3、已知代理人中包含李恩庆或周秀梅，可键入：<B><font color=red>李恩庆 or 周秀梅</font></B>"></TD>
                      </TR>
                      <TR> 
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'P');" style="cursor:hand"><input type="button"  class="tablebutton" value="P:优　　先　 　权"></TD>
                        <TD width="30%" height="32"><INPUT id="txtP" field="pr" name="txtP" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;优先权字段中包含表示国别的字母和表示编号的数字，支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符，位于字符串起首或末尾时模糊字符可省略。字段内各检索词之间可进行<B><font color=red>and</font></B>、<B><font color=red>or</font></B>运算<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知专利优先权编号为02112242，应键入：<B><font color=red>02112242</font></B><BR>&nbsp;&nbsp;&nbsp;&nbsp;2、已知专利优先权国家为中国且优先权编号为02112242，应键入：<B><font color=red>CN and 02112242</font></B>"></TD>
                        <TD UNSELECTABLE="On" align=left width="20%" height=32 title="点击在组合逻辑检索中加入此字段代码" onClick="insertItem(obj, 'Q');" style="cursor:hand"><input type="button"  class="tablebutton" value="Q:国  省  代  码"></TD>
                        <TD width="30%" height="32"><INPUT id="txtQ" field="co" name="txtQ" size="20" alt="&nbsp;&nbsp;&nbsp;&nbsp;国省代码字段中包含表示国省的字母和表示编号的数字，支持模糊检索，模糊检索时应尽量选用关键字，以免检索出过多无关文献。模糊部分位于字符串中间时应使用<B><font color=red>?</font></B>代替单个字符,<B><font color=red>%</font></B>代替多个字符。<BR><BR><B>检索示例：</B><BR>&nbsp;&nbsp;&nbsp;&nbsp;1、已知国省代码为江苏(32)，应键入：<B><font color=red>江苏%</font></B>或<B><font color=red>%32%</font></B><BR>"></TD>
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
			id="btnMore" border="0" onClick="ShowMore()" src="<%=basePath%>images/operator/btnShow.gif" alt="点击显示更多运算符" style="cursor:hand">
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
		   <p class="bt" style="margin:0px;padding-top:6px;height:23px;width:67px;float:left;"><a href="#" onclick="javascript:returnVal('document.loginform');">生 成</a></p>
		   -->
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
</form>

</table>
</body>

<%
}
catch(Exception exp)
{
	//exp.printStackTrace();
	WASException wase = new WASException(exp.getMessage());
	session.setAttribute("was_exception",wase);   //将新的异常对象保存到session中，以便在报错页error.jsp中获得
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

if(sChannels!=""){//编辑
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