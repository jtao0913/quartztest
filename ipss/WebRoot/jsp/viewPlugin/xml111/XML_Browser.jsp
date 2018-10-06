<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	String path = request.getContextPath();
	try {
		//String strTI = request.getParameter("strTI");

		//String strAN=request.getParameter("an");
		//System.out.println("00--"+strAN);

		//String strChannelIDs=request.getParameter("channelIDs");
		//String strPD=request.getParameter("pd");
		//String CLM_Page=request.getParameter("CLM_Page");
		//String DES_Page=request.getParameter("DES_Page");
		//String DRA_Page=request.getParameter("DRA_Page");
		String ft_type = (String)request.getAttribute("ft_type");
		//String strPage=request.getParameter("strPage");
		//String strUrl=request.getParameter("strUrl");

		if (ft_type == null) {
			ft_type = "1";
		}
		
		String title = request.getParameter("strTI");;
		//title = new String(title.getBytes("iso-8859-1"),"utf-8");
		if(title==null){title="";}
		title = title.replace("<font color=red>","");
		title = title.replace("</font>","");
%>
<html>
	<head>
		<title>${requestScope.an}-<%=title%></title>
	</head>
	  <frameset name="fsMain" rows="30,*" cols="*" framespacing="0" frameborder="no" border="0">
  	<frame src="jsp/viewPlugin/xml/XML_Browser_Head.jsp?an=${requestScope.an}&channelIDs=${requestScope.channel}&pd=${requestScope.pd}&pageCount=${requestScope.nav.pageCount}&pageIndex=${requestScope.nav.pageIndex}&CLM_Page=${requestScope.CLM_Page}&DES_Page=${requestScope.DES_Page}&DRA_Page=${requestScope.DRA_Page}&ft_type=<%=ft_type%>" name="headFrame" scrolling="NO" id="left">
  	<frameset name="mainFrame" rows="*" cols="100,*" framespacing="0" frameborder="no" border="0">
  	<frame src="jsp/viewPlugin/xml/XML_Blank.jsp" name="liftFrame" id="left" >
  	<frame src="<%=basePath%>xml.do?method=renderXML&an=${requestScope.an}&channelIDs=${requestScope.channel}&pd=${requestScope.pd}&ft_type=<%=ft_type%>&pageIndex=${requestScope.pageIndex}&CLM_Page=${requestScope.CLM_Page}&DES_Page=${requestScope.DES_Page}&DRA_Page=${requestScope.DRA_Page}" name="rightFrame" id="right" >
  	</frameset>
</frameset>
<noframes>
	<body>
	</body></noframes>
</html>
<%
	} catch (Exception ex) {
		ex.printStackTrace();
	}
%>