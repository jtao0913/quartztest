<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<% String path = request.getContextPath(); %>
<html>
<title>请输入验证码</title>
<head>

<script>
var returnVerifyValue="";

function ListHTML(verifynumber){
var xmlHttp = GetXmlHttp();

var url = "<%=basePath%>jsp/viewPlugin/xml/verifySubmit.jsp?verifynumber="+verifynumber+"&"+rand(9999);
//alert(url);
//url=encodeURI(url);
var strRet = "0";

xmlHttp.open("GET",url,false);
 
xmlHttp.onreadystatechange = function Listoption()
{
  if(xmlHttp.readyState == 4)
  {
   if(xmlHttp.status == 200) 
   {
		strRet = xmlHttp.responseText;
		var reg=new RegExp("\r\n","g");
		strRet = strRet.replace(reg,'');
		
		if(strRet=="Wrong"){
			alert("您输入的验证码不正确，请重新输入");
		}
		if(strRet=="Right"){
			var DownloadArgs = new Array(strRet);
			window.returnValue = DownloadArgs;
			window.close();
		}
		//document.write(strRet);
   }else{
		document.body.innerText=xmlHttp.status;
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
		//alert("支持XMLHTTP功能");
        return XmlHttp;
    }
}

rnd.today=new Date(); 
rnd.seed=rnd.today.getTime(); 

function rnd() { 
 rnd.seed = (rnd.seed*9301+49297) % 233280; 
　return rnd.seed/(233280.0); 
}; 

function rand(number) { 
　return Math.ceil(rnd()*number); 
}; 


function OnSetDownloadOption()
{
	var userVerifyNumber=document.all.verifynumber.value;
	//alert(userVerifyNumber);
	ListHTML(userVerifyNumber);
	//alert(returnVerifyValue);
}

function changeImg()
{
	var img = document.getElementById("verifyImg");
	img.src = img.src+'?';
	document.all.verifynumber.focus();
}

function verifyNumberChange(obj){
	if(obj.length==4){
		ListHTML(obj);
	}else if(obj.length>4){
		alert("请输入四位验证码");
		document.all.verifynumber.value=document.all.verifynumber.value.substring(0,4);
	}	
}
</script>
</head>

<body>
<table width="252" border="0" align="center" cellpadding="3" cellspacing="3">
  <tr>
    <td>
	<!--<div id="div"></div><input type="text" name="verifynumber" onPropertyChange="div.innerHTML=this.value;">-->
	<input type="text" name="verifynumber" onPropertyChange="javascript:verifyNumberChange(this.value)">
	&nbsp;<a onClick="javascript:changeImg()"><img id="verifyImg" src="<%=basePath%>jsp/viewPlugin/xml/verifyImage.jsp" alt="验证码" title="看不清楚？换一张" border="0"></a></td>
  </tr>
  <tr>
    <td>
<input id="btnok" type="submit" value=" 确 定 " onclick="return verifyNumberChange(document.all.verifynumber.value)">&nbsp;&nbsp;&nbsp;
<input id="btncancel" type="button" value=" 取 消 " onclick="window.close();">
	</td>
  </tr>
</table>
</body>
</html>