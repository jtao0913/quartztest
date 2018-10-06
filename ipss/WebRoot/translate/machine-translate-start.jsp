<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cnipr.cniprgz.dao.TranslateDAO" %>

<% session.removeAttribute("task"); %> 
<%String path = request.getContextPath(); %>

<body>
<%
try{
//String contents = (String)request.getSession().getAttribute("contents");
String content = request.getParameter("content");
String showType = request.getParameter("showType");
String contents = "";

if (content != null && !content.equals("")){
	String[] chars = content.split("A");
	for(int i=0; i<chars.length; i++){ 
		if (!chars[i].equals(""))
		{
			contents += (char)Integer.parseInt(chars[i]);
		}
	}
}

//System.out.println("machine-translate-start.jsp...........>>"+contents);

String strContentNum = request.getParameter("contentnum");

int contentNum = 1;
if(strContentNum==null || strContentNum.equals("")){
	contentNum=(contents.split("!!!")).length;
}else{
	contentNum = Integer.parseInt(strContentNum);
}

//System.out.println("contentNum = "+contentNum);
//int contentNum = Integer.parseInt(request.getParameter("contentNum"));
%>
<script>
String.prototype.trim = function() 
{ 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 

function ListHTMLstoptran(){
//alert("stop.......");
	var xmlHttp = GetXmlHttp();
	var url = "stop.jsp?" + rand(9999);

	xmlHttp.open("GET",url,false);
 
 xmlHttp.onreadystatechange = function Listoption()
 {
  if(xmlHttp.readyState == 4)
  {
   if(xmlHttp.status == 200) 
   {}
  }
 }
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
	xmlHttp.send();
}

var isComplete = false;
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
var xmlHttp = GetXmlHttp();
var url = "machine-translate-status.jsp?" + rand(9999);

var strRet = "0";
var translatedNow = 0;

xmlHttp.open("GET",url,false);
 
 xmlHttp.onreadystatechange = function Listoption()
 {
  if(xmlHttp.readyState == 4)
  {
   if(xmlHttp.status == 200) 
   {
	strRet = xmlHttp.responseText;
	strRet = strRet.trim();
//alert(".....>>"+strRet+"<<......");
//alert("<%=contentNum%>");
		if(strRet==""){
			translatedNow = 0;
		}else{
			var arrArgs = strRet.split("!!!");
			translatedNow = arrArgs.length;
		}

//alert("translatedNow = "+translatedNow);
//alert("contentNum = "+"<%=contentNum%>");

   	setProcessPercent('<%=contentNum%>',translatedNow);
   }
  }
 }
xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
xmlHttp.send();

	if(translatedNow != <%=contentNum%>)
	{
		setTimeout(ListHTML,500);
	}
	else
	{
//alert("...>>"+strRet);
		var arrArgs = strRet.split("!!!");
		for(var i=0;i<arrArgs.length;i++){
//alert(arrArgs[i]);

			var arrItem = arrArgs[i].split("===");
			
			var div_patent_name_en;
			if('<%=showType%>'=="detail"){
				div_patent_name_en = window.parent.document.getElementById("td_"+arrItem[0]);
			}else{
				div_patent_name_en = window.parent.sOutline.document.getElementById("td_"+arrItem[0]);
			}
			
//alert("patent_name_en_"+arrItem[1]);

			if(div_patent_name_en != null){
				//div_patent_name_en.innerHTML = arrItem[1];
				
				if('<%=showType%>'=="detail"){
					div_patent_name_en.innerHTML += "<br><br>"+arrItem[1];
				}else{
					div_patent_name_en.innerHTML = arrItem[1];
				}
				
				/*var translate = window.parent.document.getElementById("translate");


				translate.innerHTML="机器翻译";
				if('<%=showType%>'=="detail"){
//					translate.innerHTML="[ 自动翻译 ]";
					translate.innerHTML="";
				}else{
					translate.innerHTML="自动翻译";
					//translate.innerHTML="<img src='../images/button_autotrans_un.gif' border='0'>";
				}*/
			}
		}

		//alert(translate.innerHTML);
		
		setTimeout(selfClose,500);
		//window.open("CN_index.jsp","","");
	}
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

function setProcessPercent(total,current)
{
	var per = Math.round(current/total*100);
	if(per==0 || per=="0"){per=1;}
	//document.all.processtab.width = per*3;
	document.all.status.innerText = per + "%";	
}

function selfClose()
{
	parent.tb_remove();
	//window.parent.closeWindow();
}
</Script>

<%
Hashtable<String, String> translateLib = (Hashtable<String, String>)application.getAttribute("translateLib");
if(translateLib==null){

	translateLib = com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
}else{
	application.setAttribute("translateLib",translateLib);
}

//Hashtable translateLib = wasConfig.getTranslateLib();

String s_translateLib = "";

Set entry = translateLib.entrySet();
Iterator it = entry.iterator();
Map.Entry me = null;
while (it.hasNext()) {
	me = (Map.Entry) it.next();
	
	//out.println("hashtable values  = " + me.getKey()+":"+me.getValue() + "<br>");
	s_translateLib += me.getKey()+","+me.getValue() + ";";
	/*
	if (arrContentItem[1].indexOf(me.getKey() + "") > -1) {
		strTranslateLib = me.getValue() + "";
		break;
	}
	*/
}
%>

<jsp:useBean id="task" scope="session" class="com.translate.TranslateThread">
<jsp:setProperty name="task" property="contents" value="<%=contents%>"/>
<jsp:setProperty name="task" property="stranslateLib" value="<%=s_translateLib%>"/>
</jsp:useBean>

<% new Thread(task).start(); %> 
<!--jsp:forward page="status.jsp"/-->
<p>
<table height="12" width="3" border="0" cellpadding="0" cellspacing="0" background="../zljs/images/process.gif" id="processtab" style="visibility:hidden"><tr><td></td></tr></table>
<img src="<%=path%>/images/speed.gif"><br>
<font face="Arial"><span id="status">0</span></font>

<script>
//alert("<%=contents%>");
ListHTML();
</script>
    
</p>
</body>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>