<%@ page contentType="text/html; charset=gb2312" errorPage="/error.jsp"%>

<HEAD>
<TITLE>专利信息服务平台-打印</TITLE>

<script>
var m_strSavePath = "";
var m_strFTType = "";
var m_strFTType1 = "权利要求书";
var m_strFTType2 = "说明书";
var m_strFTType3 = "说明书附图";

var m_strPage;

var m_startpage=1;
var m_endpage=1;

var rwin;

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
	
function PrepareArgs(strSelect, txtBeginPageNumber, txtEndPageNumber)
{
	if(strSelect=='3')
	{
		if(txtBeginPageNumber.replace(/(^\s*)|(\s*$)/g, "")=='')
		{
			alert("指定起始页不能为空，请重新输入");
			return false; 
		}
		if(txtEndPageNumber.replace(/(^\s*)|(\s*$)/g, "")=='')
		{
			alert("指定终止页不能为空，请重新输入");
			return false; 
		}
	
		if(!isInteger(txtBeginPageNumber))
		{
			alert("指定起始页必须是整数！");
			return false;
		}	
		if(!isInteger(txtEndPageNumber))
		{
			alert("指定终止页必须是整数！");
			return false;
		}		
		
		if(parseInt(txtBeginPageNumber) < 1 || parseInt(txtBeginPageNumber) > parseInt(m_strPage))
		{
			alert('请重新输入起始页码');
			document.all.txtBeginPage.focus();
			return false;
		}
		if(parseInt(txtEndPageNumber) < parseInt(txtBeginPageNumber) || parseInt(txtEndPageNumber) > parseInt(m_strPage))
		{
			alert('请重新输入终止页码');
			document.all.txtEndPage.focus();
			return false;	
		}
		m_strPage = parseInt(txtEndPageNumber) - parseInt(txtBeginPageNumber) + 1;
	}
}

function AutoChecked()
{
	if(document.all.rdSelect[1].checked)
		return;
	else
		document.all.rdSelect[1].checked = true;
}

function OnSetDownloadOption()
{
	var pgs=m_strPage;
	var strSelect;
	var txtBeginPageNumber;
	var txtEndPageNumber;
	var strSavePath;
	
	for(var i=0;i<document.all.rdSelect.length;i++)
	{
		if(document.all.rdSelect[i].checked)
			strSelect = document.all.rdSelect[i].value;
	}
	txtBeginPageNumber = document.all.txtBeginPage.value;
	txtEndPageNumber = document.all.txtEndPage.value;
	
	var checkvalue = PrepareArgs(strSelect, txtBeginPageNumber, txtEndPageNumber);
	//alert(checkvalue);
	if(checkvalue==false){
		return false;	
	}

	if((strSelect==3 || strSelect=="3") && (txtBeginPageNumber=="1" && txtEndPageNumber==pgs)){
		strSelect="1";
	}
//strSavePath = document.all.txtSavePath.value;
//生成一个随机数的窗口名称

	var theDate =new Date();
	var random=theDate.getTime();

	if(document.all.xmlType[0].checked){m_strFTType="1";}
	if(document.all.xmlType[1].checked){m_strFTType="2";}
	if(document.all.xmlType[2].checked){m_strFTType="3";}		

	var DownloadArgs = new Array(m_strFTType, strSelect, txtBeginPageNumber, txtEndPageNumber);
	window.returnValue = DownloadArgs;
	window.close();
}

var CLM_Page=0;
var DES_Page=0;
var DRA_Page=0;
function OnPageLoad()
{
	var enterval = window.dialogArguments;
	m_strFTType = enterval[0];
	
	CLM_Page=enterval[1];
	DES_Page=enterval[2];
	DRA_Page=enterval[3];
	
	if(m_strFTType==1 || m_strFTType=="1"){
		m_strFTType=m_strFTType1;
		m_strPage=CLM_Page;
		document.all.xmlType.x1.checked=true;
	}
	if(m_strFTType==2 || m_strFTType=="2"){
		m_strFTType=m_strFTType2;
		m_strPage=DES_Page;
		document.all.xmlType.x2.checked=true;
	}
	if(m_strFTType==3 || m_strFTType=="3"){
		if(DRA_Page==0 || DRA_Page=="0"){document.all.xmlType[2].disabled=true;}
		m_strFTType=m_strFTType3;
		m_strPage=DRA_Page;
		document.all.xmlType.x3.checked=true;
	}
	//document.all.f1.innerHTML="<font size='3'><B>"+m_strFTType+"</B></font>";
	document.all.f2.innerHTML=m_strFTType;
	//m_strPage = enterval[1];
	//alert(m_strPage);
	document.all.txtEndPage.value = m_strPage;
}

function switchFT_Type(ft_type){
	if(ft_type==1 || ft_type=="1"){
		//document.all.f1.innerHTML="<font size='3'><B>权利要求书</B></font>";
		m_strPage=CLM_Page;
		document.all.f2.innerHTML="权利要求书";
		document.all.txtEndPage.value = CLM_Page;
	}
	if(ft_type==2 || ft_type=="2"){
		//document.all.f1.innerHTML="<font size='3'><B>说明书</B></font>";
		m_strPage=DES_Page;
		document.all.f2.innerHTML="说明书";
		document.all.txtEndPage.value = DES_Page;
	}
	if(ft_type==3 || ft_type=="3"){
		//document.all.f1.innerHTML="<font size='3'><B>说明书附图</B></font>";
		m_strPage=DRA_Page;
		document.all.f2.innerHTML="说明书附图";
		document.all.txtEndPage.value = DRA_Page;
	}
}
</script>
<style type="text/css">
body, a, table, div, span, td, th, input, select{font:9pt;font-family: "宋体", Verdana, Arial, Helvetica, sans-serif;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>
<BODY bgcolor="#ECE9D8" Onload="OnPageLoad()">

<center><font size="3"><B><span id="f1"></span>打印设置</B></font></center><br>

  <table width="335" border="0" align="center">
    <tr><td>
	<input type="radio" name="xmlType" value="1" checked id="x1" onClick="switchFT_Type(1)"><label for="x1">&nbsp;打印权利要求书</label>
	<input type="radio" name="xmlType" value="2" id="x2" onClick="switchFT_Type(2)"><label for="x2">&nbsp;打印说明书</label>
	<input type="radio" name="xmlType" value="3" id="x3" onClick="switchFT_Type(3)"><label for="x3">&nbsp;打印说明书附图</label>
	</td></tr>
    <tr>
      <td>
      <fieldset>
      <legend>设置打印选项</legend>
  <table width="335" border="0" align="center">
    <tr height="28">
      <td colspan="2" style="cursor:hand"><input type="radio" name="rdSelect" value="1" checked id="c1"><label for="c1">&nbsp;打印整件<span id="f2"></span></label></td>
    </tr>
    <!--<tr height="28">
      <td colspan="2" style="cursor:hand"><input type="radio" name="rdSelect" value="2" id="c2"><label for="c2">&nbsp;打印当前页</label></td>
    </tr>-->
    <tr height="28">
      <td style="cursor:hand"><input type="radio" name="rdSelect" value="3" id="c3"><label for="c3">&nbsp;打印指定页</label></td>
      <td>从&nbsp;<input type=text name="txtBeginPage" size=4 border=1 onFocus="AutoChecked();" value="1">&nbsp;到&nbsp;
        <input type="text" name="txtEndPage" size=4 border=1 onFocus="AutoChecked();" value=""></td>
    </tr>
  </table>
  </fieldset>
  </td>
  </tr>
        <tr>
        <td align="center">
        <input id="btnok" type=submit value=" 确 定 " onclick="return OnSetDownloadOption()" style="width:78px">
		  <input id="btncancel" type=button value=" 取 消 " onclick="window.close();" style="width:78px">
        </td>
        </tr>
  </table>


</BODY>
