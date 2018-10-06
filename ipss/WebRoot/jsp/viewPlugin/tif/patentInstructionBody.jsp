<%@ page import="java.util.*" errorPage=""%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%
	String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
String strAN=request.getParameter("an");
String strURL=request.getParameter("url");
String strTifPages=request.getParameter("tifpages");
String strChannel=request.getParameter("channel");
String strThirdParty = request.getParameter("ThirdParty");
%>

<frameset rows="2" cols="115,*" framespacing="0" frameborder="no" border="0">
  <% if(SetupAccess.getProperty(SetupConstant.SUOLUEPIC)!=null && SetupAccess.getProperty(SetupConstant.SUOLUEPIC).equals("1")){%>
  	<frame src="<%=basePath%>jsp/viewPlugin/tif/patentInstructionBody_Left.jsp?an=<%=strAN%>&channel=<%=strChannel%>&url=<%=strURL%>&tifpages=<%=strTifPages%>&ThirdParty=<%=strThirdParty%>" scrolling="auto" noresize name="leftFrame">
  <%}else{ %>
  	<frame src="<%=basePath%>jsp/viewPlugin/tif/TIF_Blank.jsp?an=<%=strAN%>&channel=<%=strChannel%>&url=<%=strURL%>&tifpages=<%=strTifPages%>&ThirdParty=<%=strThirdParty%>" scrolling="auto" noresize name="leftFrame">
  <%} %>
  	<frame src="<%=basePath%>jsp/viewPlugin/tif/patentInstructionBody_Right.jsp" noresize name="rightFrame" scrolling="auto">
  </frameset>
<noframes>
<body>

</body>
</noframes>