package com.cnipr.cniprgz.interceptor;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.dao.MenuDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.func.AreacodeFunc;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.util.Endecrypt;
import com.cnipr.util.localMAC;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class GlobalInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = -1876790686598304099L;

	public ChannelFunc channelFunc;
	
	public void setChannelFunc(ChannelFunc channelFunc) {
		this.channelFunc = channelFunc;
	}
	public ChannelFunc getChannelFunc() {
		return channelFunc;
	}
	
	private AreacodeFunc areacodeFunc;	
	public AreacodeFunc getAreacodeFunc() {
		return areacodeFunc;
	}
	public void setAreacodeFunc(AreacodeFunc areacodeFunc) {
		this.areacodeFunc = areacodeFunc;
	}
	
	private static String macaddr;

	private static String clientcode;
	
	private static String websitename;
	
	public static String getWebsitename() {
		return websitename;
	}
	public static String getMacaddr() {
		return macaddr;
	}
	public static String getClientcode() {
		return clientcode;
	}
	
	
	@Override
    public String intercept(ActionInvocation invocation) throws Exception {
    	ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		/**************************************************************************************************/
		if(application.get("channelInfoList_cn")==null) {
			List<ChannelInfo> _channelInfoList_cn = channelFunc.getChannels("cn");
			application.put("channelInfoList_cn",_channelInfoList_cn);
		}
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
		
		if(application.get("channelInfoList_fr")==null) {
			List<ChannelInfo> _channelInfoList_fr = channelFunc.getChannels("fr");
			application.put("channelInfoList_fr",_channelInfoList_fr);
		}
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		
		if(application.get("channelInfoList_sx")==null) {
			List<ChannelInfo> _channelInfoList_sx = channelFunc.getChannels("sx");
			application.put("channelInfoList_sx",_channelInfoList_sx);
		}
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");
		
		if(application.get("ShowVerifyCode")==null) {
			String ShowVerifyCode = DataAccess.getProperty("ShowVerifyCode");
			application.put("ShowVerifyCode",ShowVerifyCode);
		}
		
		if(application.get("ShowBase64")==null) {
			String ShowBase64 = DataAccess.getProperty("ShowBase64");
			application.put("ShowBase64",ShowBase64);
		}
		
		/*
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");//全部FR
		if(channelInfoList_fr==null){
			channelInfoList_fr = channelFunc.getChannels("fr");
			application.put("channelInfoList_fr",channelInfoList_fr);
		}
		
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");//全部FR
		if(channelInfoList_sx==null||channelInfoList_sx.size()==0){
			channelInfoList_sx = channelFunc.getChannels("sx");
			application.put("channelInfoList_sx",channelInfoList_sx);
		}
		*/
//		channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");//全部FR
		
/*		HashMap<String,String> hm_areacode = (HashMap<String,String>)application.get("hm_areacode");
		if(hm_areacode==null){
			hm_areacode = areacodeFunc.getAllAreacode();
			application.put("hm_areacode", hm_areacode);
		}*/
		if(application.get("hm_areacode")==null) {
			application.put("hm_areacode", areacodeFunc.getAllAreacode());
		}
		HashMap<String,String> hm_areacode = (HashMap<String,String>)application.get("hm_areacode");
		
		if(application.get("areacode")==null) {
			String _areacode = com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode");
			if(_areacode==null||_areacode.trim().equals("")){
				_areacode = "000";
			}
			application.put("areacode", _areacode);
		}
		String areacode = (String)application.get("areacode");
//		System.out.println("areacode="+areacode);
		
		String translate = (String)application.get("translate");
		if(translate==null||translate.trim().equals("")){
			translate = SetupAccess.get("translate")==null?"0":SetupAccess.get("translate");
			application.put("translate", translate);
		}
		
/*		String website_title = hm_areacode.get(areacode);
		website_title = website_title==null||website_title.equals("")?"综合信息服务平台":website_title;
		application.put("website_title", website_title);
*/
		if(application.get("website_title")==null) {
			String _website_title = hm_areacode.get(areacode);
			_website_title = _website_title==null||_website_title.equals("")?"PatViewer专利搜索引擎":_website_title;
			application.put("website_title", _website_title);
		}
		String website_title = (String)application.get("website_title");
//		System.out.println("website_title="+website_title);
		/*
		if(application.get("macaddr")==null) {
			String _macaddr = localMAC.getLocalMac();
			application.put("macaddr", _macaddr);
		}
		String macaddr = (String)application.get("macaddr");
		
		if(application.get("clientcode")==null) {
			Endecrypt crypt = new Endecrypt();
			String SPKEY = macaddr;
			String _clientcode = crypt.get3DESEncrypt(website_title, SPKEY);
			
			application.put("clientcode", _clientcode);
		}
		String clientcode = (String)application.get("clientcode");
		*/
		
		
		if(websitename==null) {
			websitename = (String)application.get("website_title");
		}
		
		if(macaddr==null) {
			macaddr = localMAC.getLocalMac();
		}
		
		if(clientcode==null) {
			Endecrypt crypt = new Endecrypt();
			String SPKEY = macaddr;
			clientcode = crypt.get3DESEncrypt(website_title, SPKEY);
		}
		
		HashMap<String,String> patenttype = new HashMap<String,String>();
		patenttype.put("fmzl", "fm");
		patenttype.put("fmzl_ft", "fm");
		patenttype.put("syxx", "xx");
		patenttype.put("syxx_ft", "xx");
		patenttype.put("wgzl", "wg");
		patenttype.put("wgzl_ab", "wg");
		patenttype.put("fmsq", "sq");
		patenttype.put("fmsq_ft", "sq");
		application.put("patenttype", patenttype);
			
		/**************************************************************************************************/
		try{
			List<MenuInfo> almenu = (List<MenuInfo>)application.get("almenu");//全部有效菜单
			if(almenu==null){
				almenu = MenuDAO.getAllMenuInfo();
				application.put("almenu",almenu);
			}
			
			String s_allmenu = (String)application.get("s_allmenu");//全部有效菜单
			if(s_allmenu==null){
				s_allmenu = "";
				Iterator<MenuInfo> iter = almenu.iterator();
				while(iter.hasNext())
				{
					s_allmenu += ((MenuInfo)iter.next()).getIntMenuID()+",";
//					System.out.println(iter.next());
				}
//				if(s_allmenu.endsWith(",")){
//					s_allmenu = s_allmenu.substring(0, s_allmenu.length()-1);
//				}
				application.put("s_allmenu",s_allmenu);
			}
			
		    return invocation.invoke();//此菜单不在全部有效菜单中，比如提交后的submit.do
			
		}catch(Exception ex){
			ex.printStackTrace();
			return invocation.invoke();
		}
    }  
}  
