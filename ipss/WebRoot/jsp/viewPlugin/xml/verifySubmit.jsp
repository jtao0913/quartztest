<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>

<%
	
	String verifynumber=request.getParameter("verifynumber");
	//out.println(verifynumber+"<br>");
	if(verifynumber==null){
		verifynumber="";
	}
	
	String sRand=(String)session.getAttribute("rand");
	//out.println(sRand);
	if(sRand==null){
		sRand="";
	}

	if(!verifynumber.equals("")  && verifynumber.equalsIgnoreCase(sRand)){
		out.println("Right");
	}else{
		out.println("Wrong");
	}

%>