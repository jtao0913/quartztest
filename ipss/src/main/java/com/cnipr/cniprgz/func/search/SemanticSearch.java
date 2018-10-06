package com.cnipr.cniprgz.func.search;

import java.lang.reflect.Proxy;
import java.net.MalformedURLException;
import org.codehaus.xfire.client.Client;
import org.codehaus.xfire.client.XFireProxy;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.codehaus.xfire.transport.http.CommonsHttpMessageSender;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

import com.cnipr.cniprgz.client.CoreBizClient;
//import com.cnipr.corebiz.search.entity.GBIndex;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

/*
public class SemanticSearch {
	static String siteurl = "http://service.cnipr.com/cnipr-corebiz/SearchService.ws";
	ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
//	ICoreBizFacade webserviceClient;	
	
	public static ICoreBizFacade getCoreBizClient(String siteurl) {
		ICoreBizFacade srvc = null;
		Service srvcModel = new ObjectServiceFactory().create(ICoreBizFacade.class);
		
		try {
			srvc = (ICoreBizFacade) new XFireProxyFactory().create(srvcModel,siteurl);
			XFireProxy proxy = (XFireProxy) Proxy.getInvocationHandler(srvc);
			Client client = proxy.getClient();
			client.addOutHandler(new LocalSiteCoreBizClientAuthenticationHandler("cnipr", "cnipr"));
			// 同时启动response和request压缩
            client.setProperty(CommonsHttpMessageSender.GZIP_REQUEST_ENABLED,Boolean.TRUE);
//          忽略超时
//          client.setProperty(CommonsHttpMessageSender.HTTP_TIMEOUT, "0");
		} catch (MalformedURLException e) {}

		return srvc;
	}
		
	public String[] getWordTips(String inputQuerys) {
		String[] wordTips = null;
		try {
			wordTips = webserviceClient.getSemanticResult(inputQuerys);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
		return wordTips;
	}
	
	public OverviewSearchResponse getSemanticResult(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long startIndex, long endIndex,
			String strSection, String strSynonymous, String an, String lastWhere)
			throws Exception {
		
		webserviceClient = getCoreBizClient(siteurl);	
		
		OverviewSearchResponse overViewResp = new OverviewSearchResponse();

		try{
			overViewResp = webserviceClient.getOverViewSemanticResult(strSources,
					strWhere, strSortMethod, strStat, strDefautCols, iOption,
					iHitPointType, bContinue, startIndex, endIndex, strSection,
					strSynonymous, an, lastWhere);

//			webserviceClient.getOverViewSemanticResult("fmzl_ab,fmzl_ft,syxx_ab,syxx_ft,wgzl_ab,fmsq_ab,fmsq_ft", strWhere, "RELEVANCE", "", "主权项, 名称, 摘要", 2, 115, false, 0, 10, null,null,null,null);
//      	overViewResp = webserviceClient.getOverViewSemanticResult("fmzl_ab,fmzl_ft,syxx_ab,syxx_ft,wgzl_ab,fmsq_ab,fmsq_ft", strWhere, "RELEVANCE", "", "主权项, 名称, 摘要", 2, 115, false, 0, 10, null,null,null,null);
			
		}catch(Exception ex){
			ex.printStackTrace();
			throw ex;
		}
		
		return overViewResp;
	}
	
	public OverviewSearchResponse getBatchSemanticResult(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long startIndex, long endIndex,
			String strSection, String strSynonymous, String an, String lastWhere)
			throws Exception {
		OverviewSearchResponse overViewResp = new OverviewSearchResponse();

		overViewResp = webserviceClient.batchDownload(strSources,
				strWhere, strSortMethod, strStat, strDefautCols, iOption,
				iHitPointType, bContinue, startIndex, endIndex, strSection,
				strSynonymous, an, lastWhere);
		return overViewResp;
	}

//com.cnipr.cniprgz.func.search.SemanticSearch.webserviceClient
	public DetailSearchResponse getSemanticResult(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long recordCursor, String strSynonymous,String an)
			throws Exception {
		DetailSearchResponse overViewResp = new DetailSearchResponse();
		overViewResp = webserviceClient.getDetailSemanticResult(strSources,
				strWhere, strSortMethod, strStat, strDefautCols, iOption,
				iHitPointType, bContinue, recordCursor, strSynonymous,an);
		return overViewResp;
	}
	
	public String getSemanticResult(String pn, String tablename, String sAbs, String weiWords, String stopWords, String ic,int absNum,int absPercent)throws Exception{
		return webserviceClient.getSemanticResult(pn, tablename, sAbs, weiWords, stopWords, ic, absNum, absPercent);
	}	
	
	public String getPatentWords(String an,String tableName)throws Exception{
		return webserviceClient.getPatentWords("申请号='"+an+"'", tableName, "", "");
	}
}
*/

public class SemanticSearch {

	

	public String[] getWordTips(String inputQuerys) {
		String[] wordTips = null;
		try {
			ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
			wordTips = webserviceClient.getSemanticResult(inputQuerys);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			return null;
		}
		return wordTips;
	}
	
	
//	public OverviewSearchResponse getSemanticResult(String strSources,
//			String strWhere, String strSortMethod, String strStat,
//			String strDefautCols, int iOption, int iHitPointType,
//			boolean bContinue, long startIndex, long endIndex,
//			String strSection, String strSynonymous, String an, String lastWhere)
//			throws Exception {
//		OverviewSearchResponse overViewResp = new OverviewSearchResponse();
//
//		overViewResp = webserviceClient.getOverViewSemanticResult(strSources,
//				strWhere, strSortMethod, strStat, strDefautCols, iOption,
//				iHitPointType, bContinue, startIndex, endIndex, strSection,
//				strSynonymous, an, lastWhere);
//		return overViewResp;
//	}
	
	public OverviewSearchResponse getSemanticResult(String wap,String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long startIndex, long endIndex,
			String strSection, String strSynonymous, String an, String lastWhere)
			throws Exception {
		OverviewSearchResponse overViewResp = new OverviewSearchResponse();

		int isFR = 0;
		if(strSources.indexOf("patent")>-1){
			isFR = 1;
		}
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(isFR);
		
		overViewResp = webserviceClient.getOverViewSemanticResult(strSources,
				strWhere, strSortMethod, strStat, strDefautCols, iOption,
				iHitPointType, bContinue, startIndex, endIndex, strSection,
				strSynonymous, an, lastWhere);
		return overViewResp;
	}

	
/*	public OverviewSearchResponse getBatchSemanticResult(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long startIndex, long endIndex,
			String strSection, String strSynonymous, String an, String lastWhere)
			throws Exception {
		OverviewSearchResponse overViewResp = new OverviewSearchResponse();

		overViewResp = webserviceClient.batchDownload(strSources,
				strWhere, strSortMethod, strStat, strDefautCols, iOption,
				iHitPointType, bContinue, startIndex, endIndex, strSection,
				strSynonymous, an, lastWhere);
		return overViewResp;
	}*/	
	
	public DetailSearchResponse getSemanticResult(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long recordCursor, String strSynonymous,String an)
			throws Exception {
		DetailSearchResponse overViewResp = new DetailSearchResponse();
		
		ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
		overViewResp = webserviceClient.getDetailSemanticResult(strSources,
				strWhere, strSortMethod, strStat, strDefautCols, iOption,
				iHitPointType, bContinue, recordCursor, strSynonymous,an);
		return overViewResp;
	}
	public String getSemanticResult(String pn, String tablename, String sAbs, String weiWords, String stopWords, String ic,int absNum,int absPercent)throws Exception{
		ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
		return webserviceClient.getSemanticResult(pn, tablename, sAbs, weiWords, stopWords, ic, absNum, absPercent);
	}
	
	public String getPatentWords(String an,String tableName)throws Exception{
		ICoreBizFacade webserviceClient = CoreBizClient.getCoreBizClient(0);
		return webserviceClient.getPatentWords("申请号='"+an+"'", tableName, "", "");
	}

}