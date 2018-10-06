<%@ page language="java" pageEncoding="UTF-8"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<script type="text/javascript" src="<%=basePath%>common/com_2/js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>industryIPCtree/zTreeStyle3.5/jquery.ztree.all-3.5.js"></script>

<link href="<%=basePath%>common/com_2/css/bootstrap.min.css" rel="stylesheet"/>
<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet"/>
<link href="<%=basePath%>common/tu/css/fancybox.css" rel="stylesheet" />
<link href="<%=basePath%>industryIPCtree/zTreeStyle3.5/zTreeStyle.css" rel="stylesheet">

<!-- WPA Button Begin 
<script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODE3ODI4MV8zOTkyNDNfNDAwMTg4MDg2MF8"></script>
 WPA Button End -->

<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/com_2/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>common/mask/mask.js"></script>
<SCRIPT type=text/javascript src="<%=basePath%>common/mask/lhgdialog.min.js?skin=chrome"></SCRIPT>


<STYLE type="text/css" media="all">
@import "<%=basePath%>jsp/window/thickbox.css";
</STYLE>

<SCRIPT type="text/javascript" src="<%=basePath%>jsp/window/thickbox-compressed.js"></SCRIPT>

<script src="<%=basePath%>common/tu/js/jquery.fancybox.pack.js"></script>
<script type="text/javascript">
	$(".fancybox").fancybox();
</script>

<script type="text/javascript">
function showexp(exp){
	var html1 =
		"<div style='max-width:800px;line-height:22px;word-break:break-all;word-wrap:break-word;'>"
		+ exp
		+ "</div>"
	$.dialog({
		title:'提示',
		max:false,
		min:false,
		lock: true,
		content: html1
	});
}
</script>

<script type="text/javascript">    
$(document).ready(function(){
    var bro=$.browser;
    var binfo="";
    if(bro.msie) {
        binfo="Microsoft Internet Explorer "+bro.version;
//		alert(bro.version);
		version = bro.version.substring(0,2);
//		alert(version);
		if(version=="6."||version=="7."){
			alert("目前您正在使用ie低版本浏览器，请升级浏览器到8以上版本");
		}
    }
    if(bro.mozilla) {binfo="Mozilla Firefox "+bro.version;}
    if(bro.safari) {binfo="Apple Safari "+bro.version;}
    if(bro.opera) {binfo="Opera "+bro.version;}
    if(bro.chrome) {binfo="chrome "+bro.version;}
//  alert(binfo);
});
</script>
