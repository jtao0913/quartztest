<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>

<%@ include file="../../../jsp/zljs/include-head-base.jsp"%>

<%
	try {
		String strAN = request.getParameter("an");
		//System.out.println("00--"+strAN);

		String strChannelIDs = request.getParameter("channelIDs");
		//String strChannelIDs = "fmzl_ft,fmzl_ab,syxx_ft,syxx_ab";
		String strPD = request.getParameter("pd");
		String CLM_Page = request.getParameter("CLM_Page");
		String DES_Page = request.getParameter("DES_Page");
		String DRA_Page = request.getParameter("DRA_Page");
		String ft_type = request.getParameter("ft_type");
		if (ft_type == null) {
			ft_type = "1";
		}
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null) {
			pageIndex = "0";
		}
%>
<html>
	<head>
		<title></title>
	</head>

 	<frameset rows="2" cols="*" framespacing="0" frameborder="no"
		border="0">
		<frame
			src="<%=basePath%>xml.do?method=viewXml&an=<%=strAN%>&channelIDs=<%=strChannelIDs%>&pd=<%=strPD%>&CLM_Page=<%=CLM_Page%>&DES_Page=<%=DES_Page%>&DRA_Page=<%=DRA_Page%>&ft_type=<%=ft_type%>&pageIndex=<%=pageIndex%>"
			name="rightFrame" id="right" scrolling="auto">
	</frameset> 
	<noframes>
	 	<body width="100%" height="100%">

		</body>
	</noframes>
</html>
<%
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>