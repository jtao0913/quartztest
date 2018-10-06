<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<% String path = request.getContextPath(); %>
<style type="text/css">
td {font-size: 14px;}
a {
	font-size: 14px;
	color: #0000FF;
}
</style>
<!--media=print 这个属性可以在打印时有效-->     
<style media=print>     
.Noprint{display:none;}     
.PageNext{page-break-after: always;}     
</style>  
<link rel="stylesheet" href="<%=basePath%>css/lytebox.css"
			type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath%>js/lytebox.js"></script>
<script src="<%=basePath%>jsp/viewPlugin/xml/xml.js"></script>
<script>
function PrintXml() {
	//alert("11111111111");
	document.sOutline.printxml();
}

function showLogin() {

	var objLink = document.createElement('a');
	objLink.setAttribute('href','<%=basePath%>jsp/guestLogin.jsp');
	objLink.setAttribute('rel','lyteframe');
	objLink.setAttribute('rev','width:'+'400'+';height:'+'150'+';')
	objLink.setAttribute('title','Title');
	  
	myLytebox.start(objLink, false, true);
}

function click() {
    if (event.button==2 || event.button == 3) {//2 为只按右键，3为按组合键，即先按左键，再右键，或反过来
        //alert("已经屏蔽了该功能！");
    }
}
document.onmousedown=click;

var windowWidth=screen.width-100;
var windowHight=(parseInt(windowWidth))*10/7;

function dyniframesize(iframename) {
  var pTar = null;
  if (document.getElementById){
    pTar = document.getElementById("sOutline");
  }
  if (pTar && !window.opera){
    //begin resizing iframe
    pTar.style.display="block"
    if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
      //ns6 syntax
	  pTar.height = pTar.contentDocument.body.offsetHeight;
    }
    else if (pTar.Document && pTar.Document.body.scrollHeight){
      //ie5+ syntax
      pTar.height = pTar.Document.body.scrollHeight;
    }
  }
}
</script>

<%
try
{

String pageIndex=(String)request.getAttribute("pageIndex");

String strAN=(String)request.getAttribute("an");

String strChannelIDs=(String)request.getAttribute("channelIDs");
String strPD=(String)request.getAttribute("pd");

String CLM_Page=(String)request.getAttribute("CLM_Page");
String DES_Page=(String)request.getAttribute("DES_Page");
String DRA_Page=(String)request.getAttribute("DRA_Page");

String ft_type=(String)request.getAttribute("ft_type");

String startpage=(String)request.getAttribute("startpage");

%>
<script>
</script>
<body>
<form name="ViewXML" method="post" action="<%=basePath%>xml.do?method=viewXml">
<input type="hidden" name="an" value="<%=strAN%>">
<input type="hidden" name="channelIDs" value="<%=strChannelIDs%>">
<input type="hidden" name="pd" value="<%=strPD%>">
<input type="hidden" name="CLM_Page" value="<%=CLM_Page%>">
<input type="hidden" name="DES_Page" value="<%=DES_Page%>">
<input type="hidden" name="DRA_Page" value="<%=DRA_Page%>">
<input type="hidden" name="ft_type">
<input type="hidden" name="startpage" value="1">
</form>

<table align="center"><tr><td align="center">
<Script language="JavaScript">
//alert(windowWidth);
//alert(windowHight);
<%if(ft_type.equals("3")){%>
	document.write("<div align='right' class='PageNext'><iframe align='right' name='sOutline' id='sOutline' onLoad='javascript:{dyniframesize();}' src='<%=basePath%>xml.do?method=renderXML&an=<%=strAN%>&pn=<%=DRA_Page%>&channelIDs=<%=strChannelIDs%>&pd=<%=strPD%>&ft_type=<%=ft_type%>&startpage=<%=startpage%>&pagenum=1&windowWidth="+windowWidth+"' width="+windowWidth+" height="+windowHight+" frameborder='0' scrolling='no'></iframe></div>");
<%}else{%>
	document.write("<div align='right' class='PageNext'><iframe align='right' name='sOutline' id='sOutline' onLoad='javascript:{dyniframesize();}' src='<%=basePath%>xml.do?method=renderXML&an=<%=strAN%>&channelIDs=<%=strChannelIDs%>&pd=<%=strPD%>&ft_type=<%=ft_type%>&pageIndex=<%=pageIndex%>&CLM_Page=${requestScope.CLM_Page}&DES_Page=${requestScope.DES_Page}&DRA_Page=${requestScope.DRA_Page}&windowWidth="+windowWidth+"' width=830 height=500 frameborder='0' scrolling='no'></iframe></div>");
<%}%>
//document.write("<div align='right'><iframe align='right' id='sOutline' onLoad='javascript:{dyniframesize();}' src='RenderXML.xml' width=830 height=500 frameborder='0' scrolling='no'></iframe></div>");
</Script>
</td>
</tr>
<!--<tr>
<td align="center"><input type="button" value="返&nbsp;&nbsp;回" onclick="javascript:window.parent.close();"></td>
</tr>-->
</table>
</body>
<%
}
catch(Exception exp)
{
	exp.printStackTrace(); 
}
%>
