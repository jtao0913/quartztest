<%@ page import="com.cnipr.cniprgz.commons.Util" contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<html>
<head>

<SCRIPT type="text/javascript">

<%
String path = request.getContextPath();
int VIEWGBTIFNUM = Integer.parseInt(SetupAccess.getProperty(SetupConstant.VIEWSWGBTIFNUM)) ; 
%>
rnd.today=new Date(); 
rnd.seed=rnd.today.getTime(); 

function rnd() { 
	rnd.seed = (rnd.seed*9301+49297) % 233280; 
　return rnd.seed/(233280.0); 
}; 

function rand(number) { 
　return Math.ceil(rnd()*number); 
}; 

function ListHTML(){
//alert('aaa');
	var xmlHttp = GetXmlHttp();
	var url = "keep_alive.jsp?" + rand(9999);

	xmlHttp.open("GET",url,false);
	
	xmlHttp.onreadystatechange = function Listoption()
	{
		if(xmlHttp.readyState == 4)
		{
			if(xmlHttp.status == 200) 
			{
				//document.all.servertime.value=xmlHttp.responseText;
				//alert(xmlHttp.responseText);
				setTimeout(ListHTML,300000);
			}
		}
	}
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
	xmlHttp.send();
}

function GetXmlHttp(){
    var XmlHttp = null;
    /*@cc_on @*/
    /*@if (@_jscript_version >= 5)
    // JScript gives us Conditional compilation, we can cope with old IE versions.
    // and security blocked creation of the objects.
    try {
        XmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            XmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e2) {
            XmlHttp = null;
        }
    }
    @end @*/
    if (!XmlHttp && typeof XMLHttpRequest != 'undefined') {
        XmlHttp = new XMLHttpRequest();
    }
    if (!XmlHttp){
        alert("不支持XMLHTTP功能，请使用兼容浏览器。");
        return false;
    } else {
        return XmlHttp;
    }
}
ListHTML();
</script>

<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript" src="../../../js/jquery-1.3.2.min.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

	select.menudefine
	{
		color: #000000;
		background-color: #ffffff;
		font-size: 12px;
		border-right: appworkspace 1px solid;
		border-top: appworkspace 1px solid;
		border-left: appworkspace 1px solid;
		border-bottom: appworkspace 1px solid;
		font-family: Verdana, 宋体;
		margin-left: 1px;
		margin-right: 1px;
		padding-top: 1px;
		padding-bottom: 1px;
	}
.style4 {font-size: 13px}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
<!--
var rwin = null;
var g_fIsSP2 = false;
function browserVersion()
{
   g_fIsSP2 = (window.navigator.userAgent.indexOf("SV1") != -1);
/*
   if (g_fIsSP2)
   {
   //This browser is Internet Explorer in SP2. 
   }
   else
   {
   //This browser is not Internet Explorer in SP2.
   }
*/
}


function CheckButtonStatus()
{
if(document.all.txtCurrentPage.value == null || document.all.txtCurrentPage.value == "")
	document.all.txtCurrentPage.value = "1";

if(parseInt(document.all.txtCurrentPage.value) <= 1)
	document.all.btnPrev.disabled = true;
else
	document.all.btnPrev.disabled = false;
	
if(parseInt(document.all.txtCurrentPage.value) >= parseInt(document.all.lbCountPage.innerText))
	document.all.btnNext.disabled = true;
else
	document.all.btnNext.disabled = false;
	
document.all.lbCurrentPage.innerText = document.all.txtCurrentPage.value;


}

function Zoom(rate)
{
	if(rate <= 0)
		return;
	window.parent.mainFrame.document.all.PatTifAcTiveX1.SetImageScale(rate);
}

function Rotary(str)
{
	window.parent.mainFrame.document.all.PatTifAcTiveX1.CtrRotary();
}

function MoveTo()
{
	if(document.all.txtCurrentPage.value == null || document.all.txtCurrentPage.value == "")
		document.all.txtCurrentPage.value = "1";
	else
	{
		if(parseInt(document.all.txtCurrentPage.value) > parseInt(document.all.lbCountPage.innerText) || parseInt(document.all.txtCurrentPage.value) < 1)
			document.all.txtCurrentPage.value = "1";
	}
	
	var tmpPage = document.all.txtCurrentPage.value;
	var tmpUrl = CreateUrl(tmpPage);
	window.status="正在接收数据...";
	SetReadUrl(tmpUrl, document.PatentInfo.strAPO.value);
//	CheckButtonStatus();
}

function nextpage()
{
	if(document.all.txtCurrentPage.value == null || document.all.txtCurrentPage.value == "")
		document.all.txtCurrentPage.value = "1";
	else
	{
		if(parseInt(document.all.txtCurrentPage.value) < parseInt(document.all.lbCountPage.innerText))
			document.all.txtCurrentPage.value = parseInt(document.all.txtCurrentPage.value)+1;
		else
			return;
	}
	
	var tmpPage = document.all.txtCurrentPage.value;
	
	var tmpUrl = CreateUrl(tmpPage);
	
//alert(tmpPage);
//alert(tmpUrl);
//CheckButtonStatus();
	document.all.btnNext.disabled = true;
	window.status="正在接收数据...";
	
	//alert(tmpUrl);
	
	SetReadUrl(tmpUrl, document.PatentInfo.strAPO.value);
//top.window.mainFrame.location.reload();
}

function ViewFeiPage()
{
	 
 	var sUrl = window.parent.document.PatentInfo.strUrl.value; 
 	var zero = ""; 
 	for(var i=0;i<<%=VIEWGBTIFNUM%>;i++)
	{
		zero +="0";
	}
	sUrl = sUrl.substring(0,sUrl.lastIndexOf('/')+1)+zero+".tif";   
	window.status="正在接收数据..."; 
	SetReadUrl(sUrl, document.PatentInfo.strAPO.value);
	$("#ViewFeiPage").hide();
	$("#ViewGBPage").show();
}

function ViewGBPage()
{
	 
 	var sUrl = window.parent.document.PatentInfo.strUrl.value; 
	 
	window.status="正在接收数据..."; 
	SetReadUrl(sUrl, document.PatentInfo.strAPO.value);
	$("#ViewFeiPage").show();
	$("#ViewGBPage").hide();
}

function prevpage()
{
	if(document.all.txtCurrentPage.value == null || document.all.txtCurrentPage.value == "")
		document.all.txtCurrentPage.value = "1";
	else
	{
		if(parseInt(document.all.txtCurrentPage.value) > 1)
			document.all.txtCurrentPage.value = parseInt(document.all.txtCurrentPage.value)-1;
		else
			return;
	}
//	CheckButtonStatus();
	document.all.btnPrev.disabled = true;
	
	var tmpPage = document.all.txtCurrentPage.value;
	var tmpUrl = CreateUrl(tmpPage);
	window.status="正在接收数据...";
	
	//alert(tmpPage);
	//alert(tmpUrl);
	
	SetReadUrl(tmpUrl, document.PatentInfo.strAPO.value);
}

function SetReadUrl(strUrl, strAPO)
{	
	 
	window.parent.mainFrame.document.all.PatTifAcTiveX1.SetNetTifPath(strUrl,'aaaaa', strAPO);
	window.parent.mainFrame.document.body.scrollTop=0;
}

function Refresh()
{
	window.parent.mainFrame.document.all.PatTifAcTiveX1.CtrFrash();
}

function CreateUrl(str)
{
	 
	var sUrl = window.parent.document.PatentInfo.strUrl.value;
	var sPage = str;
	
	var sCurPage = sUrl.substring(sUrl.lastIndexOf('/')+1,sUrl.lastIndexOf('.'));
	var intCurPage = parseInt(sCurPage);
	sUrl = sUrl.substring(0,sUrl.lastIndexOf('/')+1);
	
	var intNowPage = intCurPage + parseInt(sPage)-1;
    var strNowPage = intNowPage+"";
    
    
	for(var i=0;i<(<%=VIEWGBTIFNUM%>-strNowPage.length);i++)
	{
		sUrl = sUrl + "0";
	}
	sUrl = sUrl + strNowPage + ".tif";
	document.PatentInfo.strUrl.value = sUrl;
	return sUrl;
}

function Print()
{	
	var m_strUrl = document.PatentInfo.strUrl.value;
	var m_strPage = document.all.lbCountPage.innerText;
	var m_strAPO = document.PatentInfo.strAPO.value;
	var m_strCurrentPage = document.all.lbCurrentPage.innerText;

	/*if(m_strUrl.indexOf("WG")>-1)
	{
		var inargs=new Array(m_strUrl, m_strAPO, m_strPage, "wgShow");
	}
	else
	{
		var inargs=new Array(m_strUrl, m_strAPO, m_strPage);
	}*/
	var inargs=new Array(m_strUrl, m_strAPO, m_strPage, m_strCurrentPage);

	var strHeight = "230";
	if(g_fIsSP2)
		strHeight = "250";
	var returnval = window.showModalDialog("Print.htm",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:300px;center:yes;resizable:no;help:no;status:no;scroll:no");
	if(returnval != null)
	{
		var strSelect = returnval[0];
		var strStartPageNumber = returnval[1];
		var strPages = returnval[2];
		/*
		if(strStartPageNumber <= 0)
			strStartPageNumber = "1";
		if(strPrintPages <= 0)
			strPrintPages = "1";
		*/
		switch(strSelect)
		{
			case '1':
				strPages = 1;
				break;
			case '2':
				strStartPageNumber = CreateUrl('1');
				strPages = document.PatentInfo.strPage.value;
				break;
			case '3':
				strStartPageNumber = strStartPageNumber;
				break;
		}
//alert(strStartPageNumber);
//alert(strPages);
//alert(document.PatentInfo.strAPO.value);
		window.parent.mainFrame.document.all.PatTifAcTiveX1.CtlPrintPageAndNumSet(strStartPageNumber, strPages, document.PatentInfo.strAPO.value);
	}
}

/**********************************************************/
function Download()
{	
	var m_strUrl = document.PatentInfo.strUrl.value;
	var m_strPage = document.all.lbCountPage.innerText;
	var m_strAPO = document.PatentInfo.strAPO.value;
	var m_strCurrentPage = document.all.lbCurrentPage.innerText;

	var inargs=new Array(m_strUrl, m_strPage, m_strAPO, m_strCurrentPage);

	var strHeight = "230";
	if(g_fIsSP2)
		strHeight = "250";

	var returnval = window.showModalDialog("Download.htm",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:360px;center:yes;resizable:no;help:no;status:no;scroll:no");
	if(returnval != null)
	{
		var strSelect = returnval[0];
		var r_strUrl = returnval[1];
		var r_strPage = returnval[2];
		var r_strSavePath = returnval[3];
		/*
		alert(strSelect);
		alert(r_strUrl);
		alert(r_strPage);
		alert(r_strSavePath);
		*/
		/*
		if(strStartPageNumber <= 0)
			strStartPageNumber = "1";
		if(strPrintPages <= 0)
			strPrintPages = "1";
		*/
		
		document.PatentInfo.strAPO.value = document.PatentInfo.strAPO.value;
		document.PatentInfo.strUrl.value = r_strUrl;
		document.PatentInfo.strPage.value = r_strPage;
		document.PatentInfo.strSavePath.value = r_strSavePath;
//alert(strStartPageNumber);
//alert(strPages);
//alert(document.PatentInfo.strAPO.value);
//window.parent.mainFrame.document.all.PatTifAcTiveX1.CtlPrintPageAndNumSet(strStartPageNumber, strPages, document.PatentInfo.strAPO.value);
		
		var theDate =new Date();
		var random=theDate.getTime();
		
		rwin = window.open("../../../download.do?method=documentDownload",random,"toolbar=no,titlebar=no,location=no,status=no,menubar=no,resizable=no,scrollbars=no,left=0,width=500,height=330");
	}
}

function OnPageMemberkeyDown()
{
	if(event.keyCode == 13)
	{
		MoveTo();
	}
}
function DocumentLoaded()
{
	//document.all.txtCurrentPage.value = "1";
	//alert(parent.window.PatentInfo.strCurPage.value);
	if(parent.window.PatentInfo.strCurPage.value!="null")
	{	
	   document.all.txtCurrentPage.value = parent.window.PatentInfo.strCurPage.value;}
	else if(parent.window.PatentInfo.strCurPage.value=="null")
	{	document.all.txtCurrentPage.value = "1"; }
	
	var maindoc = window.parent.document;
	var cPage = 1;
	maindoc.title=maindoc.PatentInfo.strAPO.value+"-"+maindoc.PatentInfo.strTI.value;
	var bktitle = maindoc.PatentInfo.strTI.value;
	var bkauthor = maindoc.PatentInfo.strAPO.value;
	if(bktitle.length>0)
	{
		if(bkauthor.length>0)
			bktitle = bktitle+" - "+bkauthor;
	}
	document.all.lblbkinfo.title = bktitle;
//	if(bktitle.length>36)
//	{
//		bktitle = bktitle.substring(0,35)+"...";
//	}
//	document.all.lblbkinfo.innerText = bktitle;
	
	document.all.lbCountPage.innerText = window.parent.document.PatentInfo.strPage.value;
	document.all.lbCurrentPage.innerText = document.all.txtCurrentPage.value;

	window.onresize = windowresied;
	windowresied();	
	browserVersion();
}

function windowresied()
{
	if(document.body.clientWidth > 850)
	{
		tblTop.width = "100%";
//		tblBottom.width = "100%";
//		window.parent.frames.fsMain.rows="83,*";
	}
	else
	{
//		tblTop.width = "850";
//		tblBottom.width = "850";
//		window.parent.frames.fsMain.rows="100,*";
	}
}

-->
</script>
</head>

<form name="PatentInfo">
<Script language="JavaScript">
	document.write("<input type=hidden name=strUrl value="+window.parent.document.PatentInfo.strUrl.value+">");
	document.write("<input type=hidden name=strAPO value="+window.parent.document.PatentInfo.strAPO.value+">");
	document.write("<input type=hidden name=strTI value="+window.parent.document.PatentInfo.strTI.value+">");
	document.write("<input type=hidden name=strIPC value="+window.parent.document.PatentInfo.strIPC.value+">");
	document.write("<input type=hidden name=strANN value="+window.parent.document.PatentInfo.strANN.value+">");
	document.write("<input type=hidden name=strPage value="+window.parent.document.PatentInfo.strPage.value+">");
	document.write("<input type=hidden name=strTurnpage value="+window.parent.document.PatentInfo.strTurnpage.value+">");
	document.write("<input type=hidden name=strCurPage value="+window.parent.document.PatentInfo.strCurPage.value+">");
	document.write("<input type=hidden name=strNowPage value="+window.parent.document.PatentInfo.strNowPage.value+">");
	document.write("<input type=hidden name=strSavePath value=>");
</Script>
</form>
<body onload="DocumentLoaded();CheckButtonStatus();" bgcolor="#ECE9D8">

<form name="downloadGB" id="downloadGB" action="<%=basePath%>download.do?method=downloadGB" method="post" target="blank">
<script type="text/javascript">
	document.write("<input type=hidden name='strURL' value='"+window.parent.document.PatentInfo.strUrl.value+"'>"); 
	document.write("<input type=hidden name='turnpage' value='"+window.parent.document.PatentInfo.strTurnpage.value+"'>");
	document.write("<input type=hidden name='tiflength' value='<%=VIEWGBTIFNUM%>'>");	  
</script>			
</form>


	  <table id="tblTop" border="0" cellspacing="0" cellpadding="0" width="100%">
  		<tr>
    		<td nowrap>
				<SELECT NAME="selZoomRate" SIZE=1 onchange="Zoom(this.value);">
					<OPTION value="-1">--缩放--</OPTION>
					<OPTION VALUE="0.1">10%</OPTION>
					<OPTION VALUE="0.2">20%</OPTION>
					<OPTION VALUE="0.3">30%</OPTION>
					<OPTION VALUE="0.4">40%</OPTION>
					<OPTION VALUE="0.5">50%</OPTION>
					<OPTION VALUE="0.6">60%</OPTION>
					<option value="0.7">70%</OPTION>
					<option value="0.8">80%</OPTION>
					<option value="0.9">90%</OPTION>
					<option value="1">100%</OPTION>
				</SELECT>
			</td>
    		<td nowrap width="30" align="center">
			<img src="../../../images/rotaryleft1.gif" onclick="javascript:Rotary();" style="cursor:hand"></td>
    		<td nowrap class="style4"><input type=button value="上一页" onclick="prevpage()" id="btnPrev"><input type=button value="下一页" onclick="nextpage()" id="btnNext">
    		<input name="txtCurrentPage" type=text size=3 onKeyDown="OnPageMemberkeyDown()">
    		<input type=button value="转到" onClick="MoveTo()">
    		&nbsp;公报共<B><label id="lbCountPage" class="style4"></label></B>页，当前为第<B><label id="lbCurrentPage" class="style4"></label></B>页
  		&nbsp;<!-- input type=button value=" 打印 " onclick="Print()" id="btnPrint"-->
  		
  		 <% if(SetupAccess.getProperty(SetupConstant.VIEWSWGBFEIYE)!=null && SetupAccess.getProperty(SetupConstant.VIEWSWGBFEIYE).equals("1")){%>
	       <input type=button value=" 查看扉页 " id="ViewFeiPage" onclick="ViewFeiPage()"  />
	     <%} %>
  		<input type=button value=" 查看公报 " id="ViewGBPage"  style="display:none;" onclick="ViewGBPage()"  />
  		
  		&nbsp;<input type=button value=" 下载 " onclick="$('#downloadGB').submit();return false;" id="btnDownload">&nbsp;<input type=button value=" 刷新 " onclick="Refresh()" id="btnRefresh"></td>
  		<td nowrap align="right">&nbsp;
  		
  		
  		<input type=button value="关闭窗口" onclick="javascript:parent.CloseWin();"><label id="lblbkinfo" class="style4"></label></td>
  		</tr>
   	    </table>

<script type="text/javascript">
CheckButtonStatus();
//SetReadUrl(document.PatentInfo.strUrl.value, document.PatentInfo.strAPO.value);
</script>
</body>

</html>

<input type="hidden" id="btnCheck" onClick="javascript:CheckButtonStatus();">
