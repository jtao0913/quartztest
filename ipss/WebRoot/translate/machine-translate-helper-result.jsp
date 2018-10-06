<%@ page contentType="text/html;charset=UTF-8" errorPage="/error.jsp"%>

<%@ page import="java.lang.reflect.Proxy"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Set"%>

<%@ page import="org.codehaus.xfire.client.Client"%>
<%@ page import="org.codehaus.xfire.client.XFireProxy"%>
<%@ page import="org.codehaus.xfire.client.XFireProxyFactory"%>
<%@ page import="org.codehaus.xfire.service.Service"%>
<%@ page import="org.codehaus.xfire.service.binding.ObjectServiceFactory"%>

<%@ page import="com.cnipr.translate.service.ITranslateService"%>
<%@ page import="com.translate.ClientAuthenticationHandler"%>

<%
String strSource = request.getParameter("content");
String strTranslateLib = request.getParameter("translib");
String contents = "";

if (strSource != null && !strSource.equals("")){
	String[] chars = strSource.split("A");
	for(int i=0; i<chars.length; i++){ 
		if (!chars[i].equals(""))
		{
			contents += (char)Integer.parseInt(chars[i]);
		}
	}
}
//strSource = "vehicle";
//strTranslateLib = "jthk";

//System.out.println(strSource+"...................................."+strTranslateLib);

String strRet = "";
String source = "";

		ResourceBundle rb;
		rb = ResourceBundle.getBundle("com.trs.was.resource.wasconfig");
		String TranslateServer = rb.getString("TranslateServer");

		try {
			Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
			ITranslateService service = (ITranslateService) new XFireProxyFactory()
					.create(serviceModel, "http://" + TranslateServer + "/TranslateService/services/TranslateService");

			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
			Client client = proxy.getClient();
			client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
			short iLanguage = 1;
			//--------------------------------------------------
			char[] chars = contents.toCharArray();
			 for (int j=0;j<chars.length;j++){
				 source += "%" + (int)chars[j];
			 }
//System.out.println("source = "+source);
			//--------------------------------------------------
			strRet = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);		
			
//System.out.println("strRet = "+strRet);

			out.write(strRet);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
%>