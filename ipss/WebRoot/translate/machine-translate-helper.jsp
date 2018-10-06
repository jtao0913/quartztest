<%@ page contentType="text/html;charset=UTF-8" errorPage="/error.jsp"%>

<html>
<head>
<title>翻译助手</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
BODY {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
 
  scrollbar-face-color: #B2D6FE; 
  scrollbar-shadow-color: #E9F4F5; 
  scrollbar-highlight-color: #E8F0F2; 
  scrollbar-3dlight-color: #E0E6F6; 
  scrollbar-darkshadow-color: #58B1D8; 
  scrollbar-track-color: #E9F4F5; 
  scrollbar-arrow-color: #007DB7; 
} 

.input_font {
	font-size: 12px;
	color: #666666;
	font-family: "Arial", "Helvetica", "sans-serif";
	border: 1px solid #99CCCC;
	padding-top: 2px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	text-decoration: none;
}
.input_font2 {color:#333}
.readonly {
	padding:2px 8px 0pt 3px;
	height:135px;
	border:1px solid #999;
	background-color:#DDD;
	color:#666;
}
.input01 {
	font-size: 12px;
	color: #666666;
	font-family: "Arial", "Helvetica", "sans-serif";
	border: 1px solid #99CCCC;
	padding-top: 2px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	text-decoration: none;
}
.input02 {
	font-size: 12px;
	color: #666666;
	font-family: "Arial", "Helvetica", "sans-serif";
	border: 1px solid #99CCCC;
	padding-top: 2px;
	font-style: normal;
	line-height: normal;
	font-weight: normal;
	text-decoration: none;
	background-color:#DDD;
}
-->
</style></head>
<script src="../jquery/jquery.min.js" type="text/javascript"></script>
<script>
String.prototype.trim = function() { return this.replace(/(^\s*)|(\s*$)/g, ""); }
function FormSubmit(){
	var contents = document.all.phrase_1.value;
	var translib = document.all.translib.value;

	contents = contents.trim();
	if(contents == ""){
		alert("请输入要翻译的内容");
		return;
	}
	
	var contentArray = contents.split("");
	content = "";
	for (var i = 0 ; i < contentArray.length ; i++){
		content += "A" + contentArray[i].charCodeAt();
	}
	
	document.all.phrase_2.value = ""; 
	//alert(contents+".............."+translib);
/*
	var contentArray = contents.split("");
	
	var content = "";
	for (var i = 0 ; i < contentArray.length ; i++){
		content += "A" + contentArray[i].charCodeAt();
	}
	
	alert(content);
		String contents = "";
		if (content != null && !content.equals("")){
			String[] chars = content.split("A");
			for(int i=0; i<chars.length; i++){ 
				if (!chars[i].equals(""))
					contents += (char)Integer.parseInt(chars[i]);
	        } 
		}
*/
  $.ajax({
		type: "POST",
		url: "machine-translate-helper-result.jsp",
		data: "content=" + content + "&translib=" + translib,
		//async: false,
		success: function(msg){
			msg = msg.trim();
			//alert(msg);
			document.all.phrase_2.value=msg;
		}
   }); 
	//return false;
}
</script>
<body bgcolor="E2F0FE">
<table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr><td>
<table width="409" cellspacing="0" cellpadding="3" align="center">
<form>
  <tr>
    <td align="center">
<textarea id="phrase_1" name="phrase_1" cols="110" rows="10" class="input01"></textarea>
	</td>
  </tr>
  <tr><td class="gray">
  语言
      <select name="select">
        <option value="" selected>英文--&gt;中文</option>
      </select>
      词典库

<select name="translib">
<option value="hgsw" selected>化工库+生物库	</option>
<option value="hgyj">化工库+冶金库</option>
<option value="jthk">交通库+航空库</option>
<option value="jx">机械库</option>
<option value="jxag">机械库+农业库</option>
<option value="jxdz">机械库+地质库</option>
<option value="jxfz">机械库+纺织库</option>
<option value="jxjz">机械库+建筑库</option>
<option value="jxny">机械库+能源库</option>
<option value="jxyx">机械库+医学库</option>
<option value="txjs">通信库+计算机库</option>
</select>
</td>
  </tr>
  <tr>
    <td align="center">
	<textarea id="phrase_2" name="phrase_2" cols="110" rows="10" class="input02" readonly></textarea>
	</td>
  </tr>
  <tr>
<td align="center">

<table border="0" cellpadding="0" cellspacing="0" width="80%">
<tr>
<td align="center"><input type="button" value="" onClick="FormSubmit()" style="border:0;background:url(machine-translate-helper-action.jpg);width:109;height:28;cursor:hand"></td>
<td align="center"><input type="reset" value="" style="border:0;background:url(machine-translate-helper-clear.jpg);width:80;height:28;cursor:hand"></td>
<td align="center"><input type="button" value="" style="border:0;background:url(machine-translate-helper-close.jpg);width:80;height:28;cursor:hand" onclick="javascript:window.close()"></td>
</tr>
</table>

</td>
</tr>
</form>
</table>
</td></tr></table>
</body>
</html>
<script language="JavaScript" type="text/javascript">
var s_phrase_1 = "在此处键入或粘贴要翻译的文本。选择翻译语言，然后单击“翻译”。";
var s_phrase_2 = "译文是由无人工介入的自动机器翻译软件完成，仅供参考，旨在帮助您理解翻译文本要点，无法与专业人员的翻译相提并论。服务提供方不对机器翻译结果的质量承担任何责任。";

document.getElementById("phrase_1").value = s_phrase_1;
document.getElementById("phrase_2").value = s_phrase_2; 

function addListener(element,e,fn){ 
	if(element.addEventListener){ 
		element.addEventListener(e,fn,false); 
	} else { 
		element.attachEvent("on" + e,fn); 
	} 
} 

var phrase_1 = document.getElementById("phrase_1"); 
addListener(phrase_1,"click",function(){ 
	if(phrase_1.value == s_phrase_1){
		phrase_1.value = "";
		//phrase_1.className="input_font2";
	}
})

var phrase_2 = document.getElementById("phrase_2"); 
addListener(phrase_2,"click",function(){ 
	if(phrase_2.value == s_phrase_2){
		phrase_2.value = ""; 
	}
}) 
/*
addListener(phpzixue,"blur",function(){ 
	phpzixue.value = "php自学网"; 
})
*/ 
</script>
