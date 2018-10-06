package com.cnipr.cniprgz.authority.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class SessionListener implements HttpSessionBindingListener, Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 886713027632748474L;
	
	private String userName;
	
	public SessionListener(){}
	
	public SessionListener(String userName){
		this.userName = userName;
	}


	@SuppressWarnings("unchecked") 
	 
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		// 把用户名放入在线列表
		List<String> userList = (List<String>) application.getAttribute("onlineUserList");
		// 第一次使用前，需要初始化
		if (userList == null){
			userList = new ArrayList<String>();
		}
		userList.add(this.userName);
		application.setAttribute("onlineUserList", userList);
	}

	@SuppressWarnings("unchecked")
	 
	public void valueUnbound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		
		List<String> userList = (List<String>) application.getAttribute("onlineUserList");
		if(userList!=null){
			userList.remove(this.userName);
		}
		application.setAttribute("onlineUserList", userList);
		
	}
	
	
	@SuppressWarnings("unchecked")
	public static int getOnlineCount(String userName,HttpSession session){
		ServletContext application = session.getServletContext();
		List<String> userList = (List<String>) application.getAttribute("onlineUserList");
		if(userList!=null && userList.size()>0){
			int cnt = 0;
			for(String user:userList){
				if(user.equals(userName)){
					cnt++;
				}
			}
			return cnt;
		}else{
			return 0;
		}
	}
}
