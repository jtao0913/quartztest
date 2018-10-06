package com.cnipr.cniprgz.struts.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.jbase.common.util.security.MD5;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.Log74Access;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class KeySetAction extends ActionSupport {
	
	//public ActionForward execute(ActionMapping mapping, ActionForm form,
	//		HttpServletRequest request, HttpServletResponse response)
	//public String execute() throws Exception{	
	public String getKeySet() throws Exception{
      
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		String pwd1 = request.getParameter("pwd1");
		    
	 
		if (pwd1 != null && pwd1.equals("admin8324?!")) {
			request.setAttribute("islogin", "1");

			String configkey = request.getParameter("configkey");
			String configlife = request.getParameter("configlife");
			if (configkey == null)
				configkey = "";
			if (configlife == null)
				configlife = "";
			String md5key = "";
			if (configkey != null && configkey.equals("") == false) {
				MD5 md5 = new MD5();
				String key = DataAccess.getProperty("key");
				md5key = md5.md5(configkey + key);
				DataAccess.set("configkey", md5key);
			}
			
			if (configlife != null && configlife.equals("") == false) {
				DataAccess.set("configlife", configlife);
			}
			request.setAttribute("pwd1", pwd1);
			request.setAttribute("configkey", configkey);
			request.setAttribute("md5key", md5key);
			request.setAttribute("configlife", configlife);
		}
		
		//return mapping.findForward("keyset");
		return SUCCESS;
	}
	
	public String managesystem() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
//		System.out.println(Log74Access.get("log74.areacode"));
		
		request.setAttribute("log74_areacode", Log74Access.get("log74.areacode"));
		
		return SUCCESS;
	}
	
	public String setProperty(){
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
	
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


		String settype = request.getParameter("settype");
		String name = request.getParameter("name");
		String val = request.getParameter("val");


		if(settype!= null && settype.equals("app"))
		{
			DataAccess.set(name,val);
//			out.print("{jsonMessage:'true'}"); 
			jsonresult = "{jsonMessage:'true'}";
		}
		else if(settype!= null && settype.equals("setup"))
		{
			SetupAccess.set(name,val);
			jsonresult = "{jsonMessage:'true'}";
		}
		else
		if(settype!= null && settype.equals("log74"))
		{
//			System.out.println(name);
			Log74Access.set(name,val);
			jsonresult = "{jsonMessage:'true'}";
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
}
