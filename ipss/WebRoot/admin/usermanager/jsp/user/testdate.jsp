<%
String strExpTime="";
	java.util.Date dExp = new java.util.Date();
	dExp.setYear(dExp.getYear() + 1);

//	strExpTime = "Sat Oct 20 11:07:08 CST 2007";
	java.text.DateFormat df = java.text.DateFormat.getDateInstance();
	out.print("strExpTime="+dExp);
	strExpTime = df.format(dExp);
	out.print("\r\nstrExpTime1="+strExpTime);
%>