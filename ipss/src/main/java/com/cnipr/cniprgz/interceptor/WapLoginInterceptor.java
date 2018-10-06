package com.cnipr.cniprgz.interceptor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.dao.MenuDAO;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class WapLoginInterceptor extends AbstractInterceptor {

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
    	ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		try{
			String remoteAddr = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
			/************************************************************************************************/
//			同一IP访问频率高，就封。之所以写在这里是因为如果限制了此IP，就写入配置文件中，就不走下面的步骤了
			String IPLIMIT = (String)application.get("IPLIMIT");//全部有效菜单
			if(IPLIMIT==null){			
				IPLIMIT = SetupAccess.getProperty(SetupConstant.IPLIMIT);
				application.put("IPLIMIT",IPLIMIT);
			}
			String ipsegment = (String)application.get("ipsegment");//全部被记录在配置文件中的受限IP
			if(ipsegment==null){			
				ipsegment = SetupAccess.getProperty("ipsegment");
				application.put("ipsegment",ipsegment);
			}			
			/************************************************************************************************/
//			IP在允许范围
			
			if(IPLIMIT.equals("1"))
			{		
//				boolean flag = IPCheckUtils.checkIPAddress(username, remoteAddr);			
//				boolean flag = true;
//				String ipsegment = SetupAccess.getProperty("ipsegment");
				if(ipsegment!=null&&!ipsegment.trim().equals("")){
					String[] arrIP = ipsegment.split(",");
					
					for(int i=0;i<arrIP.length;i++){
						if(arrIP[i].endsWith(remoteAddr)){
//							jsonresult = "error##您的IP不在允许范围内，不能登录系统";
							return Action.LOGIN;
						}
					}
				}
			}
			/************************************************************************************************/
//			需要在配置文件中增加一个配置项，作为开关，这个过程还是比较耗时的
			/************************************************************************************************/
			
			session.setAttribute(Constant.APP_USER_NAME, "guest");
			session.setAttribute("userid", "3");
			/*
			String username = session.getAttribute(Constant.APP_USER_NAME) == null ? "" : (String) session.getAttribute(Constant.APP_USER_NAME);
//			System.out.println("LoginInterceptor username=" + username);
			
			if(username.equals("")){
				return Action.LOGIN;
			}else{
				//////////////////////////////////////////////////////////////////						
//				System.out.println(request.getRequestURI());
				String actionURI = request.getRequestURI().replace(request.getContextPath()+"/", "");
				
				List<MenuInfo> almenu = (List<MenuInfo>)application.get("almenu");//全部有效菜单
				if(almenu==null){			
					almenu = MenuDAO.getAllMenuInfo();
					application.put("almenu",almenu);
				}
				
				String usermenu = ","+(String)session.getAttribute("userMenu");
				
				Iterator<MenuInfo> it = almenu.iterator();
		        while(it.hasNext()){
		            MenuInfo menuinfo = (MenuInfo)it.next();
		            
		            String menuURI = menuinfo.getChrMenuURL()==null?"":menuinfo.getChrMenuURL();
		            
//		            System.out.println(menuURI);
		            
		            if(menuURI.indexOf(actionURI)==0){
		            	int menuID = menuinfo.getIntMenuID();
		            	if(usermenu.indexOf(","+menuID+",")>-1){
		            		return invocation.invoke();//此用户的菜单在全部有效菜单中
		            	}else{
		            		return Action.LOGIN;//此菜单在全部有效菜单中，但没有在用户菜单内
		            	}
		            }
		        }
	        //////////////////////////////////////////////////////////////////
			
		        return invocation.invoke();//此菜单不在全部有效菜单中，比如提交后的submit.do
			}
			*/
			return invocation.invoke();
		}catch(Exception ex){
			ex.printStackTrace();
			return invocation.invoke();
		}
		
		/*
        String user = (String) session.get(Constants.USER_SESSION);  
  
        //如果没有登陆，或者登陆所有的用户名不是yuewei，都返回重新登陆
        if (user != null && user.equals("yuewei")) {  
//            System.out.println("test");  
            return invocation.invoke();  
        }  
  
//      ctx.put("tip", "你还没有登录");
        return Action.LOGIN;  
		*/
    }
  
}  
