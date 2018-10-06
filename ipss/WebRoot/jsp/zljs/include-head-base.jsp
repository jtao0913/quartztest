<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.println("basePath="+basePath);

java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("[/]{2,}");  
java.util.regex.Matcher matcher = pattern.matcher(basePath);
int _slash = 0;
while (matcher.find())  
{
	String suffix_slashs = matcher.group();
	if(_slash > 0 ){        		
		if(basePath.endsWith(suffix_slashs)){
	  		basePath = basePath.substring(0, basePath.length()-suffix_slashs.length())+"/";
	  		break;
		}
	}
	_slash++;
}

String website_title = (application.getAttribute("website_title")==null||application.getAttribute("website_title").equals(""))?"综合信息服务平台":(String)application.getAttribute("website_title");

//String areacode = com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode");
String areacode = "";
//041 内蒙古
if(application.getAttribute("areacode")==null)
{
	areacode = com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode");
	application.setAttribute("areacode",areacode);
}else{
	areacode = (String)application.getAttribute("areacode");
}
//System.out.println("areacode = " + areacode);
%>
<%
String _51laStat = com.cnipr.cniprgz.commons.DataAccess.getProperty("51laStat");
_51laStat = (_51laStat==null||_51laStat.equals(""))?"1":_51laStat;
if(_51laStat.equals("1"))
{
%>
<div style="display:none;"><script language="javascript" type="text/javascript" src="//js.users.51.la/19141689.js"></script></div>
<%}%>
