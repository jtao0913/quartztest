package com.cnipr.cniprgz.struts.action;

import java.lang.reflect.Proxy;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;

import com.cnipr.cniprgz.client.CoreBizClient;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;
import com.cnipr.translate.service.ITranslateService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.translate.ClientAuthenticationHandler;

public class TranslateAction extends ActionSupport{

	private static final long serialVersionUID = 7964761938249061129L;
	
	public String mutitranslate1(){
		jsonresult = "";
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String strTranslateLib = "jx";
		Object _translateLib = application.get("translateLib");		
		Hashtable<String, String> translateLib = null;		
		if(_translateLib==null) {
			translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
			application.put("translateLib", translateLib);
		}else{
			translateLib = (Hashtable<String, String>)application.get("translateLib");
		}
		
		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
//		ArrayList<String> alPic = new ArrayList<String>();
//		ArrayList<String> alTi = new ArrayList<String>();
//		ArrayList<String> alAb = new ArrayList<String>();
		
		String ans = request.getParameter("ans");
		String[] arrAn = ans.split(",");
		
		String no = "";
		List<PatentInfo> patentlist = (List<PatentInfo>)request.getSession().getAttribute("list");		
		Iterator<PatentInfo> iter = patentlist.iterator();
		while(iter.hasNext())
		{
			PatentInfo pi = iter.next();
			if((":"+ans+",").indexOf(pi.getAn())>-1){
//				alPic.add(pi.getPic());
//				alTi.add(pi.getTi());
//				alAb.add(pi.getAb());
				
				for(int n=0;n<arrAn.length;n++) {
					if(arrAn[n].indexOf(pi.getAn())>-1)
					{
						no = arrAn[n].substring(0, arrAn[n].indexOf(":"));
						no = no.replace("ti_", "");
					}
				}

				try {
					Set entry = translateLib.entrySet();
					Iterator it = entry.iterator();
					Map.Entry me = null;
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						
						//out.println("hashtable values  = " + me.getKey()+":"+me.getValue() + "<br>");
//						s_translateLib += me.getKey()+","+me1.getValue() + ";";
						/*
						if (arrContentItem[1].indexOf(me.getKey() + "") > -1) {
							strTranslateLib = me.getValue() + "";
							break;
						}
						*/
						if(pi.getSic().startsWith((String)me.getKey())) {
							strTranslateLib = me.getValue() + "";
							break;
						}
					}
					
					/////////////////////////////////////////////////////////////
					
					Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
					ITranslateService service = (ITranslateService) new XFireProxyFactory().create(serviceModel,
							"http://" + TranslateServer + "/TranslateService/services/TranslateService");

					XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
					Client client = proxy.getClient();
					client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
					short iLanguage = 1;
					
					char[] chars = (no+"\r\n"+pi.getTi()+"\r\n"+pi.getAb()).toCharArray();
					String source = "";
					for (int j = 0; j < chars.length; j++) {
						source += "%" + (int) chars[j];
					}
					source = source.toLowerCase();			
					String _ti = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);
					
					if(jsonresult!=null&&!jsonresult.equals("")) {
						jsonresult += "===";
					}
					jsonresult += _ti;
					
				}catch(Exception ex) {
					ex.printStackTrace();
				}
				
			}
		}
		
		jsonresult = jsonresult.trim();
				
		return SUCCESS;
	}

	public String mutitranslate(){
		jsonresult = "";
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String strTranslateLib = "jx";
		Object _translateLib = application.get("translateLib");		
		Hashtable<String, String> translateLib = null;		
		if(_translateLib==null) {
			translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
			application.put("translateLib", translateLib);
		}else{
			translateLib = (Hashtable<String, String>)application.get("translateLib");
		}
		
		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
		String ans = request.getParameter("ans");
		String[] arrAn = ans.split(",");
		
		String no = "";
		List<PatentInfo> patentlist = (List<PatentInfo>)request.getSession().getAttribute("list");		
		Iterator<PatentInfo> iter = patentlist.iterator();
		while(iter.hasNext())
		{
			PatentInfo pi = iter.next();
			if((":"+ans+",").indexOf(pi.getAn())>-1){
				for(int n=0;n<arrAn.length;n++) {
					if(arrAn[n].indexOf(pi.getAn())>-1)
					{
						no = arrAn[n].substring(0, arrAn[n].indexOf(":"));
						no = no.replace("ti_", "");
					}
				}

				try {
					Set entry = translateLib.entrySet();
					Iterator it = entry.iterator();
					Map.Entry me = null;
					while (it.hasNext()) {
						me = (Map.Entry) it.next();
						
						if(pi.getSic().startsWith((String)me.getKey())) {
							strTranslateLib = me.getValue() + "";
							break;
						}
					}
					////////////////////////////////////////////////////////////////////////
					ICoreBizFacade client = CoreBizClient.getCoreBizClient(6);
//					<font style="color: red;">computer</font>
					String ti = pi.getTi().replace("<font style='color:red'>", "").replace("<font style=\"color: red;\">", "").replace("<font style=\"color:red\">", "").replace("</font>", "");
					String ab = pi.getAb().replace("<font style='color:red'>", "").replace("<font style=\"color: red;\">", "").replace("<font style=\"color:red\">", "").replace("</font>", "");
					
//					System.out.println(no+"\r\n"+ti+"\r\n"+ab);					
					
					String _ti  = client.translate(no+"\r\n"+ti+"\r\n"+ab, strTranslateLib);
//					1.\n
					if(_ti.startsWith(no+".\\n")) {
						_ti = _ti.replace(no+".\\n", no+"\\n");
					}
					
					if(jsonresult!=null&&!jsonresult.equals("")) {
						jsonresult += "===";
					}
					jsonresult += _ti;
					
				}catch(Exception ex) {
					ex.printStackTrace();
				}				
			}
		}
		
		jsonresult = jsonresult.trim();
				
		return SUCCESS;
	}
	
	public String translate1(){
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String ipc = request.getParameter("ipc");//<font style="color: red;">system</font>
//		String ti = request.getParameter("ti").replace("<font style=\"color: red;\">", "</font>");
//		String ab = request.getParameter("ab").replace("<font style=\"color: red;\">", "</font>");
		
		String ti = request.getParameter("ti").replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");
		String ab = request.getParameter("ab").replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");
		
		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
		try {
			String strTranslateLib = "jx";
			Object _translateLib = application.get("translateLib");		
			Hashtable<String, String> translateLib = null;
			if(_translateLib==null) {
				translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
				application.put("translateLib", translateLib);
			}else{
				translateLib = (Hashtable<String, String>)application.get("translateLib");
			}
			
			Set entry = translateLib.entrySet();
			Iterator it = entry.iterator();
			Map.Entry me = null;
			while (it.hasNext()) {
				me = (Map.Entry) it.next();
				if(ipc.startsWith((String)me.getKey())) {
					strTranslateLib = me.getValue() + "";
					break;
				}
			}

			/////////////////////////////////////////////////////////////
			
			Service serviceModel = new ObjectServiceFactory().create(ITranslateService.class);
			ITranslateService service = (ITranslateService) new XFireProxyFactory().create(serviceModel,
					"http://" + TranslateServer + "/TranslateService/services/TranslateService");

			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(service);
			Client client = proxy.getClient();
			client.addOutHandler(new ClientAuthenticationHandler("webtranslate", "webtranslate"));
			short iLanguage = 1;
			
/*			char[] chars = ti.toCharArray();
			String source = "";
			for (int j = 0; j < chars.length; j++) {
				source += "%" + (int) chars[j];
			}
			source = source.toLowerCase();			
			String _ti = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);
			
			chars = ab.toCharArray();
			source = "";
			for (int j = 0; j < chars.length; j++) {
				source += "%" + (int) chars[j];
			}
			source = source.toLowerCase();			
			String _ab = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);
			
			jsonresult = _ti+"###"+_ab;*/
			
			char[] chars = (ti+"\r\n"+ab).toCharArray();
			String source = "";
			for (int j = 0; j < chars.length; j++) {
				source += "%" + (int) chars[j];
			}
			source = source.toLowerCase();			
			String _ti = service.mtTranslate(iLanguage, strTranslateLib, strTranslateLib, source);
			jsonresult = _ti;
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		
//		request.setAttribute("jsonresult", jsonresult);

//		return ERROR;
		return SUCCESS;
	}
	
	public String translate2(){
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
    	String clientcode = (String)application.get("clientcode");
		String macaddr = (String)application.get("macaddr");
		String clientcode_key = clientcode + "," + macaddr;
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String ipc = request.getParameter("ipc");//<font style="color: red;">system</font>
//		String ti = request.getParameter("ti").replace("<font style=\"color: red;\">", "</font>");
//		String ab = request.getParameter("ab").replace("<font style=\"color: red;\">", "</font>");
		
		String ti = request.getParameter("ti").replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");
		String ab = request.getParameter("ab").replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");
		
		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
		try {
			String strTranslateLib = "jx";
			Object _translateLib = application.get("translateLib");		
			Hashtable<String, String> translateLib = null;
			if(_translateLib==null) {
				translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
				application.put("translateLib", translateLib);
			}else{
				translateLib = (Hashtable<String, String>)application.get("translateLib");
			}
			
			Set entry = translateLib.entrySet();
			Iterator it = entry.iterator();
			Map.Entry me = null;
			while (it.hasNext()) {
				me = (Map.Entry) it.next();
				if(ipc.startsWith((String)me.getKey())) {
					strTranslateLib = me.getValue() + "";
					break;
				}
			}

			ICoreBizFacade client = CoreBizClient.getCoreBizClient(6);
			jsonresult = client.translate(ti+"\r\n"+ab, strTranslateLib);			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String translate(){
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();

		String clientcode = (String)application.get("clientcode");
		String macaddr = (String)application.get("macaddr");
		String clientcode_key = clientcode + "," + macaddr;
		
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		PatentInfo patentInfo = (PatentInfo)session.getAttribute("patentInfo");
		
		String ipc = patentInfo.getPic();//request.getParameter("ipc");//<font style="color: red;">system</font>
//		String ti = request.getParameter("ti").replace("<font style=\"color: red;\">", "</font>");
//		String ab = request.getParameter("ab").replace("<font style=\"color: red;\">", "</font>");
		
//		String ti = patentInfo.getTi().replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");
//		String ab = patentInfo.getAb().replace("&lt;font style=&quot;color: red;&quot;&gt;", "").replace("&lt;/font&gt;", "");

//		<font style="color: red;">computer</font>
//		<font style='color:red'>
		String ti = patentInfo.getTi().replace("<font style='color:red'>", "").replace("<font style=\"color: red;\">", "").replace("<font style=\"color:red\">", "").replace("</font>", "");
		String ab = patentInfo.getAb().replace("<font style='color:red'>", "").replace("<font style=\"color: red;\">", "").replace("<font style=\"color:red\">", "").replace("</font>", "");
		
//		String TranslateServer = DataAccess.getProperty("TranslateServer");
		
		try {
			String strTranslateLib = "jx";
			Object _translateLib = application.get("translateLib");		
			Hashtable<String, String> translateLib = null;
			if(_translateLib==null) {
				translateLib =com.cnipr.cniprgz.dao.TranslateDAO.buildTranslateParam();
				application.put("translateLib", translateLib);
			}else{
				translateLib = (Hashtable<String, String>)application.get("translateLib");
			}
			
			Set entry = translateLib.entrySet();
			Iterator it = entry.iterator();
			Map.Entry me = null;
			while (it.hasNext()) {
				me = (Map.Entry) it.next();
				if(ipc.startsWith((String)me.getKey())) {
					strTranslateLib = me.getValue() + "";
					break;
				}
			}

			ICoreBizFacade client = CoreBizClient.getCoreBizClient(6);
			jsonresult = client.translate(ti+"\r\n"+ab, strTranslateLib);			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return SUCCESS;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	public static void main(String[] args) {
		
	}
	
}
