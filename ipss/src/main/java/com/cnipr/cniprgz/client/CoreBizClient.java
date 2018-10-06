package com.cnipr.cniprgz.client;

import java.lang.reflect.Proxy;
import java.net.MalformedURLException;

import javax.naming.NamingException;

import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.transport.http.CommonsHttpMessageSender;

import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.interceptor.GlobalInterceptor;
import com.cnipr.cniprgz.interceptor.LoginInterceptor;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

import net.jbase.common.util.security.MD5;

public class CoreBizClient {
	/**
	 * 获取webservice客户端
	 * @return
	 * @throws NamingException
	 */
	public static ICoreBizFacade getCoreBizClient(int isFR) {

//		GlobalInterceptor gi = new GlobalInterceptor();
		String macaddr = GlobalInterceptor.getMacaddr();
		String clientname = GlobalInterceptor.getWebsitename();
//		String clientcode = GlobalInterceptor.getClientcode();		
		String remoteAddr = LoginInterceptor.getRemoteAddr();
		
//		macaddr = "F48E38A1264C";
//		clientname = "PatViewer专利搜索引擎";
//		remoteAddr = "10.33.4.21";
		
//		System.out.println("macaddr="+macaddr);
//		System.out.println("clientname="+clientname);
//		System.out.println("remoteAddr = "+remoteAddr);
		
		ICoreBizFacade srvc = null;

		Service srvcModel = new ObjectServiceFactory().create(ICoreBizFacade.class);
		
		String url = DataAccess.getProperty("SearchServerUrl"); 
		if(isFR==1)
			url = DataAccess.getProperty("SearchServerUrl_fr");
		if(isFR==2)
			url = DataAccess.getProperty("SearchServerUrl_xml");
		if(isFR==3)
			url = DataAccess.getProperty("SearchServerUrl_gb");
		if(isFR==5)
			url = DataAccess.getProperty("SearchServerUrl_wap");
		if(isFR==6)
			url = DataAccess.getProperty("TranslateServerUrl");
		
		try {
			srvc = (ICoreBizFacade) new XFireProxyFactory().create(srvcModel, url);
			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(srvc);
			Client client = proxy.getClient();
			
//			client.addOutHandler(new ClientAuthenticationHandler(DataAccess.getProperty("WSUser"), DataAccess.getProperty("WSPwd")));
			client.addOutHandler(new ClientAuthenticationHandler(clientname,macaddr,remoteAddr));
//			同时启动response和request压缩
            client.setProperty(CommonsHttpMessageSender.GZIP_REQUEST_ENABLED, Boolean.TRUE);
//            忽略超时
//            client.setProperty(CommonsHttpMessageSender.HTTP_TIMEOUT, "0");
		} catch (MalformedURLException e) {}

		return srvc;
	}

	public static void main(String[] args) {
/*		ICoreBizFacade searchFunc = CoreBizClient.getCoreBizClient(0);
		OverviewSearchResponse response;
		try {
			response = searchFunc.executeOutlineSearch("fmzl_ft,syxx_ft", "名称,摘要,主权项+=材料", 
					"", "", "", 2, 115, false, 0, 10, "", "");
			if (response != null && response.getPatentInfoList() != null) {
				for (PatentInfo pat : response.getPatentInfoList()) {
					System.out.println(pat.getTi());
				}
			}
			System.out.println(response.getUnfilterTotalCount());
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		String sss = MD5.md5("海军医学院");
		System.out.println(sss);
		
	}
}
