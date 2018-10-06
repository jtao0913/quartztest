package com.cnipr.cniprgz.func.search;

import java.lang.reflect.Proxy;
import java.net.MalformedURLException;

import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.transport.http.CommonsHttpMessageSender;

import com.cnipr.cniprgz.client.ClientAuthenticationHandler;
import com.cnipr.cniprgz.interceptor.GlobalInterceptor;
import com.cnipr.cniprgz.interceptor.LoginInterceptor;
import com.cnipr.corebiz.search.ws.response.AddressSearchResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

public class AddrFunc {

	public static void main(String[] args) {
		String macaddr = GlobalInterceptor.getMacaddr();
		String clientname = GlobalInterceptor.getWebsitename();		
		String remoteAddr = LoginInterceptor.getRemoteAddr();
//		System.out.println(macaddr);
//		System.out.println(clientcode);
//		System.out.println("remoteAddr = "+remoteAddr);
		
		macaddr = "F48E38A1264C";
		clientname = "ipph大数据";
		remoteAddr = "127.0.0.1";		
		
		ICoreBizFacade srvc = null;
		Service srvcModel = new ObjectServiceFactory().create(ICoreBizFacade.class);		
		String url = "http://127.0.0.1:8080/cnipr-corebiz/AddrService.ws"; 
		url = "http://szzl.patsev.com/cnipr-corebiz/AddrService.ws";
		
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
		///////////////////////////////////////////////////////////////////////////////////////////////
		
		ICoreBizFacade client = srvc;
		try {
//			400013重庆市渝中区七星岗业成花园民安园1号14楼
//			611430四川省新津县五津镇岳巷路136号
			AddressSearchResponse addr = client.getAddress("611430四川省新津县五津镇岳巷路136号");
//			AddressSearchResponse addr = client.getAddress("15465798河北省邯郸市丛台区滏002西北大159街99号邮");
			System.out.println(addr.getProvince());
			System.out.println(addr.getCity());
			System.out.println(addr.getDistrict());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}


}
