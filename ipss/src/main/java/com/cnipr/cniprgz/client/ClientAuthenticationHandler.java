package com.cnipr.cniprgz.client;

import org.codehaus.xfire.MessageContext;
import org.codehaus.xfire.handler.AbstractHandler;
import org.jdom.Element;
//import org.jdom.Element;
/**
 * webservice客户端用户名密码验证
 * @author liuqi
 *
 */
public class ClientAuthenticationHandler extends AbstractHandler {
/*     private String username = null;
     private String password = null;

     public ClientAuthenticationHandler() {} 

     public ClientAuthenticationHandler(String username,String password) {
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
*/
//    private String clientcode = null;
    private String macaddr = null;
    private String remoteAddr = null;
    private String websitename = null;

    public ClientAuthenticationHandler() {} 

    public ClientAuthenticationHandler(String websitename,String macaddr,String remoteAddr) {
//        this.clientcode = clientcode;
    	this.websitename = websitename;
        this.macaddr = macaddr;
        this.remoteAddr = remoteAddr;
    } 

    public void setWebsitename(String websitename) {
		this.websitename = websitename;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

/*	public void setClientcode(String clientcode) {
        this.clientcode = clientcode;
    } */

    public void setMacaddr(String macaddr) {
        this.macaddr = macaddr;
    } 

    public void invoke(MessageContext context) throws Exception {
        Element el = new Element("header"); 
        context.getOutMessage().setHeader(el); 
        Element auth = new Element("AuthenticationToken");

//        Element clientcode_el = new Element("Clientcode");
//        clientcode_el.addContent(clientcode);
        Element clientname_el = new Element("ClientName");
        clientname_el.addContent(websitename);
        Element macaddr_el = new Element("Macaddr");
        macaddr_el.addContent(macaddr);
        Element remoteAddr_el = new Element("RemoteAddr");
        remoteAddr_el.addContent(remoteAddr);

        auth.addContent(clientname_el);
        auth.addContent(macaddr_el);
        auth.addContent(remoteAddr_el);
//        getWebsitename()
        
        el.addContent(auth); 
    }
}
