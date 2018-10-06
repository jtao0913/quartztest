<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%
	String path = request.getContextPath();
	String strAN = request.getParameter("an");
	String strChannelIDs = request.getParameter("strChannelIDs");
	String strPD = request.getParameter("pd");
	String ft_type = request.getParameter("ft_type");
	String operation = request.getParameter("operation");
	String startpage = request.getParameter("int_start");
	String int_end = request.getParameter("int_end");
	String i_CopyXML = "0";
%>
<script>
function printpage()
{
	document.execCommand("print");
	window.close();
}

</script>

<BODY onload="printpage()">
		<iframe align='left' id='sOutline'
			onLoad='javascript:{dyniframesize();}'
			src='<%=basePath%>renderXML.do?method=renderXMLForPrint&an=<%=strAN%>&operation=<%=operation%>&strChannelIDs=<%=strChannelIDs%>&pd=<%=strPD%>&ft_type=<%=ft_type%>&int_start=<%=startpage%>&int_end=<%=int_end%>&i_CopyXML=<%=i_CopyXML%>'
			width='100%' height='100%' frameborder='0' scrolling='yes'></iframe>

</BODY>
