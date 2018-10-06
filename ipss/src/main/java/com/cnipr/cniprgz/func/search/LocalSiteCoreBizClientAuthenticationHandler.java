package com.cnipr.cniprgz.func.search;

import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.handler.AbstractHandler;
import org.jdom.Element;

/**
 * webservice客户端用户名密码验证
 * 
 * @author liuqi
 * 
 */
public class LocalSiteCoreBizClientAuthenticationHandler extends
		AbstractHandler {

	private String username = null;

	private String password = null;

	public LocalSiteCoreBizClientAuthenticationHandler() {

	}

	public LocalSiteCoreBizClientAuthenticationHandler(String username,
			String password) {

		this.username = username;

		this.password = password;
	}

	public void setUsername(String username) {

		this.username = username;

	}

	public void setPassword(String password) {

		this.password = password;

	}

	public void invoke(MessageContext context) throws Exception {

		Element el = new Element("header");
		context.getOutMessage().setHeader(el);
		Element auth = new Element("AuthenticationToken");
		Element username_el = new Element("Username");
		username_el.addContent(username);
		Element password_el = new Element("Password");
		password_el.addContent(password);
		auth.addContent(username_el);
		auth.addContent(password_el);
		el.addContent(auth);
	}

}
