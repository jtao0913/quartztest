package com.cnipr.cniprgz.struts.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.jbase.common.util.DateUtil;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.GetSearchFormat;
import com.cnipr.cniprgz.commons.Log74Access;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.dao.DownloadLogDAO;
import com.cnipr.cniprgz.dao.RelevanceQueryDao;
import com.cnipr.cniprgz.entity.AnalyseModulePie;
import com.cnipr.cniprgz.entity.AnalyzeModule;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.CrossLanguage;
import com.cnipr.cniprgz.func.DownloadFunc;
import com.cnipr.cniprgz.func.ExpressionFunc;
import com.cnipr.cniprgz.func.SysUserFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.func.search.SemanticSearch;
import com.cnipr.cniprgz.func.stat.Page;
import com.cnipr.cniprgz.func.stat.StatBean;
import com.cnipr.cniprgz.func.stat.StatFunc;
import com.cnipr.cniprgz.log.Log74Util;
import com.cnipr.cniprgz.log.PlatformLog;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.response.LegalStatusResponse;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import jxl.write.Label;

public class DownLoadAction extends ActionSupport {

	private DownloadFunc downloadFunc;
	public ChannelFunc channelFunc;
	public SearchFunc searchFunc; 
	private SemanticSearch semanticSearchImpl; 
	private RelevanceQueryDao semanticDao;
	public ExpressionFunc expFunc;
	public SysUserFunc sysUserFunc;

	public SysUserFunc getSysUserFunc() {
		return sysUserFunc;
	}

	public void setSysUserFunc(SysUserFunc sysUserFunc) {
		this.sysUserFunc = sysUserFunc;
	}
	// public ActionForward downLoad1(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {
	// String url = request.getParameter("url");
	// String savePath = request.getParameter("savePath");
	// String saveName = request.getParameter("saveName");
	// // downloadFunc = new DownloadFunc();
	// // downloadFunc.setFileName(saveName);
	// // downloadFunc.setFilePath(savePath);
	// // downloadFunc.setUrl(url);
	// // downloadFunc.start();
	// // downloadFunc.g
	// // Runtime.getRuntime().;
	// request.setAttribute("testrequest","测试request");
	// request.getSession().setAttribute("test","测试");
	// FileSplitterFetch fileFetch = downloadFunc.download(url, savePath,
	// saveName);
	// request.getSession().setAttribute("downloadInfo", fileFetch);
	// // downloadFunc.download(url,savePath, saveName);
	//return mapping.findForward("download");
	//}

// 前提：后台认为displayCol值一定正确
	@SuppressWarnings("unchecked")	
	public String downloadAbstract() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String displayCol = request.getParameter("downloadcol"); 
		String downloadType = request.getParameter("downtype");
		String strPatentList = request.getParameter("patentList");
		String isbatchdownload = request.getParameter("isbatchdownload");
		String downloadStart = request.getParameter("downloadStart");
		String downloadAmount = request.getParameter("downloadAmount");
		String onepatent = request.getParameter("onepatent")==null?"0":request.getParameter("onepatent");
		
		String operateAmount = "";
		
		String strWhere = request.getParameter("strWhere");
		if (strWhere == null)
			strWhere = (String) session.getAttribute("strWhere");
		
		String area = request.getParameter("area");
		
		//System.out.println("strPatentList="+strPatentList);
//		List<PatentInfo> patentList = Util.getList4Json(strPatentList,PatentInfo.class);
		
		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		List<PatentInfo> _patentList = new ArrayList<PatentInfo>();
		
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		/**
		 * 记录检索日志
		 */
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
			String userName = "";
			userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			PlatformLog.insertTableLog(userName,  com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), "download");
		}
		String strSources = request.getParameter("strSources");
		
		GregorianCalendar date = new GregorianCalendar();
//		long time1 = date.getTimeInMillis()/1000;
		
		if(onepatent.equals("1")){				
				patentList = (List<PatentInfo>)request.getSession().getAttribute("onePatentInfo");
		}else{			
				_patentList = (List<PatentInfo>)request.getSession().getAttribute("list");
				
				String[] arrPatentAn = strPatentList.split(",");
	//			 for(int i=0;i<arrPatentAn.length;i++){
	//				 PatentInfo _pi = patentList.
	//			 }
				 
				 Iterator<PatentInfo> iter = _patentList.iterator();
				 while(iter.hasNext()&&patentList.size()==0)  
				 {  
					 PatentInfo pi = iter.next();
	
					 for(int i=0;i<arrPatentAn.length;i++){
	//					 System.out.println("pi.getAn()="+pi.getAn());
	//					 System.out.println("arrPatentAn[i]="+arrPatentAn[i]);
						 
						 if(pi.getAn().trim().equals(arrPatentAn[i].trim())){
							 patentList.add(pi);
							 break;
						 }
					 }					 
				     //System.out.println(iter.next());  
				 }
			 }
			 
			 String wap = request.getParameter("wap")==null?"":request.getParameter("wap");
			
		
			if(patentList!=null && patentList.size()>0){
				operateAmount = patentList.size()+"";
				
				downloadFunc.downloadZip(wap, basePath,patentList, displayCol.split(","),
						downloadType, response, area, Integer.valueOf((String) request
								.getSession().getAttribute(Constant.APP_USER_ID)),
						(String) request.getSession().getAttribute(
								Constant.APP_USER_NAME), com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
						(Integer) request.getSession().getAttribute(
								Constant.APP_USER_FEETYPE)); 
			}else{
				//System.out.println(displayCol);
				
			}
		
		
		//记录log74日志文摘下载
		if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
		{ 
			if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
			{
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					Log74Util.log_func("9000", operateUserId+"", ipruser.getIntGroupId()+"", com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(), strSources , operateAmount);
				} catch (IOException e) { 
					e.printStackTrace();
				}
			}
		}
		// String url = request.getParameter("url");
		// String savePath = request.getParameter("savePath");
		// String saveName = request.getParameter("saveName");
		// // downloadFunc = new DownloadFunc();
		// // downloadFunc.setFileName(saveName);
		// // downloadFunc.setFilePath(savePath);
		// // downloadFunc.setUrl(url);
		// // downloadFunc.start();
		// // downloadFunc.g
		// // Runtime.getRuntime().;
		// request.setAttribute("testrequest","测试request");
		// request.getSession().setAttribute("test","测试");
		// FileSplitterFetch fileFetch = downloadFunc.download(url, savePath,
		// saveName);
		// request.getSession().setAttribute("downloadInfo", fileFetch);
		// downloadFunc.download(url,savePath, saveName);

		return null;
	}

	public String createAnalysePNG() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		
		String pngstr = request.getParameter("pngstr");
		
		File targetFile = downloadFunc.createAnalysePNGZip(basePath, pngstr);
		
		jsonresult=targetFile.getName();
		return SUCCESS;
		
	}
	
	public String createAbstractZip111111() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String downloadcol = request.getParameter("downloadcol");
//		System.out.println("downloadcol="+downloadcol);
		
		
		String downloadType = request.getParameter("downtype");
		String strPatentList = request.getParameter("patentList");
		String isbatchdownload = request.getParameter("isbatchdownload");
		String downloadStart = request.getParameter("downloadStart");
		String downloadAmount = request.getParameter("downloadAmount");
		String operateAmount = "";
		
		String strWhere = request.getParameter("strWhere");
		if (strWhere == null)
			strWhere = (String) request.getAttribute("strWhere");
		
		String area = request.getParameter("area");
		String strSources = request.getParameter("strSources");
		strSources = Util.getPatentTable(application,strSources);
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
//		记录log74日志文摘下载
		if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
		{ 
			if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
			{
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					Log74Util.log_func("9000", operateUserId+"", ipruser.getIntGroupId()+"", com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(), strSources , operateAmount);
				} catch (IOException e) { 
					e.printStackTrace();
				}
			}
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		List<PatentInfo> patentList = new ArrayList<PatentInfo>();
		List<PatentInfo> _patentList = new ArrayList<PatentInfo>();
		
		GregorianCalendar date = new GregorianCalendar();
		long time1 = date.getTimeInMillis()/1000;
		if(isbatchdownload!=null && isbatchdownload.equals("1"))//批量下载
		{	
			//System.out.println("isbatchdownload="+isbatchdownload);
			 Long download_start = (long)0;
			 Long download_amount = (long)0;			 
			 if(downloadStart!=null) download_start=Long.parseLong(downloadStart);
			 if(downloadAmount!=null) download_amount = Long.parseLong(downloadAmount);			 
//				 System.out.println("download_start="+download_start);
//				 System.out.println("download_amount="+download_amount);
			 try{
//				 patentList = overviewSearch(request, response, download_start, download_amount).getPatentInfoList();
				 
				 SearchAction searchaction = new SearchAction();
				 HashMap<String,Object> hm_result = searchaction.getPatentInfos(cxt);
				 
				 OverviewSearchResponse overviewResponse =  (OverviewSearchResponse)hm_result.get("overviewResponse");
				 patentList = overviewResponse.getPatentInfoList();
				 
			 }catch(Exception e)
			 {
				 e.printStackTrace();
			 }
		
			 date = new GregorianCalendar();
			long time3 = date.getTimeInMillis()/1000;
			if(isbatchdownload!=null && isbatchdownload.equals("1")) {}
//			System.out.println("批量下载用时,检索=" + (time3-time1)+"秒");
			File targetFile = downloadFunc.createAbstractZip(basePath, patentList, downloadcol.split(","),
						downloadType, response, area, Integer.valueOf((String) request
								.getSession().getAttribute(Constant.APP_USER_ID)),
						(String) request.getSession().getAttribute(
								Constant.APP_USER_NAME), com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
						(Integer) request.getSession().getAttribute(
								Constant.APP_USER_FEETYPE));
				
				
//			long time2 = date.getTimeInMillis()/1000;
//			if(isbatchdownload!=null && isbatchdownload.equals("1")) {
//				System.out.println("批量下载用时,打包=" + (time2-time3)+"秒");
//			}
//			operateAmount = downloadAmount;
				
			jsonresult=targetFile.getName();
			return SUCCESS;
				 
//			downloadFunc.batchdownloadZip(patentList, displayCol.split(","),
//					downloadType, response, area, Integer.valueOf((String) request
//							.getSession().getAttribute(Constant.APP_USER_ID)),
//					(String) request.getSession().getAttribute(
//							Constant.APP_USER_NAME), request.getRemoteAddr(),
//					(Integer) request.getSession().getAttribute(
//							Constant.APP_USER_FEETYPE));
				
//			date = new GregorianCalendar();
			
		}else{
			_patentList = (List<PatentInfo>)request.getSession().getAttribute("list");
			
			String[] arrPatentAn = strPatentList.split(",");
//			 for(int i=0;i<arrPatentAn.length;i++){
//				 PatentInfo _pi = patentList.
//			 }
			 
			 Iterator<PatentInfo> iter = _patentList.iterator();				 
			 while(iter.hasNext())  
			 {  
				 PatentInfo pi = iter.next();

				 for(int i=0;i<arrPatentAn.length;i++){
					 if(pi.getAn().equals(arrPatentAn[i])){
						 patentList.add(pi);
					 }						 
				 }					 
			     //System.out.println(iter.next());  
			 }
			
			//System.out.println(displayCol);
//			downloadFunc.downloadZip(patentList, displayCol.split(","),
//					downloadType, response, area, Integer.valueOf((String) request
//							.getSession().getAttribute(Constant.APP_USER_ID)),
//					(String) request.getSession().getAttribute(
//							Constant.APP_USER_NAME), request.getRemoteAddr(),
//					(Integer) request.getSession().getAttribute(
//							Constant.APP_USER_FEETYPE));

			 File targetFile = downloadFunc.createAbstractZip(basePath,patentList, downloadcol.split(","),
						downloadType, response, area, Integer.valueOf((String) request
								.getSession().getAttribute(Constant.APP_USER_ID)),
						(String) request.getSession().getAttribute(
								Constant.APP_USER_NAME), com.cnipr.cniprgz.commons.Common.getRemoteAddr(request),
						(Integer) request.getSession().getAttribute(
								Constant.APP_USER_FEETYPE));
			 
			 jsonresult=targetFile.getName();
			 return SUCCESS;
			 
		}
//		if(patentList!=null && patentList.size()>0)
//			operateAmount = patentList.size()+"";
//		}
		
//		String tifInfos = "";
//		
//		
//		if (tifInfos != null && !"".equals(tifInfos)) {
//			File targetFile = downloadFunc.createTiffZip(basePath, tifInfos);
////			return new ResultStatus("", "100000", "fileName=" + targetFile.getName());
//			
//			jsonresult=targetFile.getName();
//			return SUCCESS;
//		} else {
////			return new ResultStatus("下载失败！", "999999", "");
//			return ERROR;
//		}
	}
	
	public String createAnalyseTableZip() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		
		String[][] arr = null;
		
		String dimension = request.getParameter("dimension");
		if(dimension!=null&&dimension.equals("x")) {
//			TreeMap<String,Integer>
			String jsonresult = request.getParameter("jsonresult");			
			jsonresult = jsonresult.replace("&quot;", "");	
			System.out.println(jsonresult);
			
			Gson gson = new Gson();
			AnalyseModulePie amp = gson.fromJson(jsonresult,AnalyseModulePie.class);
			
			
//			AnalyseModulePie amp = new AnalyseModulePie();
//			amp = (AnalyseModulePie)request.getAttribute("am");
			
			arr = new String[amp.getResults().size()][2];
			
			ArrayList<Map.Entry<String,Integer>> list_data_single = new ArrayList<Map.Entry<String,Integer>>(amp.getResults().entrySet());
	        Collections.sort(list_data_single, new Comparator<Map.Entry<String, Integer>>() {
	            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
	                return (o2.getValue().intValue() - o1.getValue().intValue());
	            }
	        });
	        
	        int i = 0;
	        for (Map.Entry<String, Integer> mapping : list_data_single) {
//	            System.out.println(mapping.getKey() + ":" + mapping.getValue());
	        	arr[i][0] = mapping.getKey();
	            arr[i][1] = mapping.getValue()+"";
	            i++;
	        }			
			
/*			int i = 0;
	        Iterator titer=amp.getResults().entrySet().iterator();  
	        while(titer.hasNext()){  
	            Map.Entry entry=(Map.Entry )titer.next();  
	            String key=entry.getKey().toString();  
	            String value=entry.getValue().toString();  
//	            System.out.println(keyt+"*"+valuet);
	            arr[i][0] = key;
	            arr[i][1] = value;
	            i++;
	        }
*/			
		}else if(dimension!=null&&(dimension.equals("xy")||dimension.equals("xx"))) {
			
//			AnalyzeModule am = new AnalyzeModule();
//			am = (AnalyzeModule)request.getAttribute("am");		
//			am.getArrSeries();
			
			String jsonresult = request.getParameter("jsonresult");
			
//			System.out.println(jsonresult);
//			&quot;MITSUBISHI ELECTRIC CORP&quot;,
			jsonresult = jsonresult.replace("&quot;", "");
			
//			jsonresult = jsonresult.replace(" ", "");
//			System.out.println(jsonresult);
//			
//			System.out.println( jsonresult.trim());
//			System.out.println( jsonresult.trim().indexOf("legend:[")+9);
//			System.out.println( jsonresult.trim().indexOf("],xAxisData:["));
			
//			String _legend = jsonresult.trim().substring(jsonresult.trim().indexOf("legend:[")+9, jsonresult.trim().indexOf("],xAxisData:["));
//			String _xAxisData = jsonresult.trim().substring(jsonresult.trim().indexOf("xAxisData:[")+12, jsonresult.trim().indexOf("],arrSeries:["));
			
//			String _legend ="";
//			String _xAxisData ="";
			
			Gson gson = new Gson();
			AnalyzeModule am = gson.fromJson(jsonresult,AnalyzeModule.class);
			
//			String[] legend = am.getLegend();
//			String[] xAxisData = am.getxAxisData();
			
			String[] legend = am.getLegend();		
			String[] xAxisData =  am.getxAxisData();
			
			int[][] arrSeries  = am.getArrSeries();			
			
			arr = new String[legend.length+1][xAxisData.length+1];
			
			for(int i=0;i<arr.length;i++) {
				if(i==0)
				{
					for(int j=0;j<xAxisData.length;j++) {
						arr[0][j+1]=xAxisData[j].trim();
					}
				}else {
					for(int j=0;j<arr[i].length;j++) {
						
						if(j==0) {
							arr[i][j]=legend[i-1].trim();
						}else {
							arr[i][j]=arrSeries[i-1][j-1]+"";
						}						
					}					
				}
			}
			
			
		}
		
		File targetFile = downloadFunc.createAnalyseTableZip(basePath, arr);

		jsonresult=targetFile.getName();
		
		return SUCCESS;
	}

	public String createPDFZip() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
//		String tifInfos = "BOOKS/FM/2015/20150520/201510102912.4,9,CN201510102912.4,BOOKS/XK/1988/19880120/87207506,5,CN87207506,BOOKS/XK/1988/19880127/87206642,6,CN87206642";
		
		String tifInfos = request.getParameter("tifInfos");
		String pictype = request.getParameter("pictype");
		
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		if (tifInfos != null && !"".equals(tifInfos)) {
			
//			System.out.println("basePath="+basePath);
//			System.out.println("tifInfos="+tifInfos);
//			System.out.println("pictype="+pictype);
			
			File targetFile = downloadFunc.createPDFZip(basePath, tifInfos, pictype);
//			return new ResultStatus("", "100000", "fileName=" + targetFile.getName());
			
			jsonresult=targetFile.getName();
			return SUCCESS;
		} else {
//			return new ResultStatus("下载失败！", "999999", "");
			return ERROR;
		}
	}
	
	public String createPNGZip() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
//		String tifInfos = "BOOKS/FM/2015/20150520/201510102912.4,9,CN201510102912.4,BOOKS/XK/1988/19880120/87207506,5,CN87207506,BOOKS/XK/1988/19880127/87206642,6,CN87206642";
		
		String tifInfos = request.getParameter("tifInfos");
		
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		if (tifInfos != null && !"".equals(tifInfos)) {
			File targetFile = downloadFunc.createPNGZip(basePath, tifInfos);
//			return new ResultStatus("", "100000", "fileName=" + targetFile.getName());
			
			jsonresult=targetFile.getName();
			return SUCCESS;
		} else {
//			return new ResultStatus("下载失败！", "999999", "");
			return ERROR;
		}
	}
	
	public String createTIFFZip() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
//		String tifInfos = "BOOKS/FM/2015/20150520/201510102912.4,9,CN201510102912.4,BOOKS/XK/1988/19880120/87207506,5,CN87207506,BOOKS/XK/1988/19880127/87206642,6,CN87206642";
		
		String tifInfos = request.getParameter("tifInfos");
		
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		if (tifInfos != null && !"".equals(tifInfos)) {
			File targetFile = downloadFunc.createTiffZip(basePath, tifInfos);
//			return new ResultStatus("", "100000", "fileName=" + targetFile.getName());
			
			jsonresult=targetFile.getName();
			return SUCCESS;
		} else {
//			return new ResultStatus("下载失败！", "999999", "");
			return ERROR;
		}
	}	
	
	private InputStream fileInputStream;	  
	public InputStream getFileInputStream() {	 
		return fileInputStream;	   
	}	
	private String fileName;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}	
	public String getDownloadFileName() {
	    String downFileName = fileName;
	    try {
	        downFileName = new String(downFileName.getBytes(), "ISO8859-1");
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    return downFileName;
	}
	
	public String downloadZipfile() throws Exception {
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
//		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
//		HttpSession session = request.getSession();
		
//		String filename = request.getParameter("filename");
		
//		fileInputStream = new FileInputStream(new File("C:\\downloadfile.txt"));
		String basePath = request.getSession().getServletContext().getRealPath("tempfile");
		fileInputStream = new FileInputStream(new File(basePath +"\\"+fileName));

	    return SUCCESS;	  
	}
	
	//下载文件的接口
//	@RequestMapping(value = "downloadFile", method = RequestMethod.GET)
//	public void downloadFile(HttpServletRequest request,
//			HttpServletResponse response,
//			@RequestParam(value = "fileName", required = true) String fileName) throws UnsupportedEncodingException {
	
	public String downloadFile11(){		
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String fileName = request.getParameter("fileName");
		
		response.setContentType("text/html;charset=UTF-8");
		fileName = fileName.trim();
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		String xmlPathDir = request.getSession().getServletContext()
				.getRealPath("tempfile");
		String filePath = xmlPathDir + File.separator + fileName;
		File downloadFile = new File(filePath);
		long fileLength = downloadFile.length();
		response.setHeader("Content-disposition", "attachment;filename="
				+ fileName);
		response.setHeader("Content-Length", String.valueOf(fileLength));
		response.setContentType("application/octet-stream");
		try {
			bis = new BufferedInputStream(new FileInputStream(downloadFile));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[1024];
			while (-1 != bis.read(buff)) {
				bos.write(buff);
			}
			bos.flush();
			response.flushBuffer();
			
			return SUCCESS;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return ERROR;
		} catch (IOException e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (bis != null) {
					bis.close();
				}
				if (bos != null) {
					bos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

	public String formatTifName(String a ,int length)
	{
		String result = "";
		for(int i=0;i<length-a.length();i++)
		{
			result = "0"+result;
		}
		return result+a;
	}
	
	
//	public ActionForward documentDownload(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {	
	
	@SuppressWarnings("unchecked")
	public String documentDownload_() throws Exception{	
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String strAn = request.getParameter("strAn");
		if (strAn == null || strAn.equals("")) {
			strAn = "0";
		}

		String[] anArray = strAn.split(",");

		boolean isDeducte = false;

		int[] account = Util.getBelongAccount(request);
		
	    String operateAmount  = "";
		if(anArray!=null)
			operateAmount = anArray.length+"";
		
		//////////////////////////////////////////////////////////////////
		int x=(int)(Math.random()*10000000);	
		
		String path = request.getSession().getServletContext().getRealPath("/tempfile");
	    String fileName = x +".xlsx";
	    String filePath = path + "\\" + fileName;
	    downloadFunc.downLoadFile(filePath, response, fileName, "xls");
		 
		/**
		 * 记录检索日志
		 */
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
			String userName = "";
			userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			PlatformLog.insertTableLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), "download_doc");
		}
		//记录log74日志全文下载
		if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
		{ 
			if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
			{	
				String strSources = request.getParameter("strSources");
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					Log74Util.log_func("9100", operateUserId+"", ipruser.getIntGroupId()+"", com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(), strSources , operateAmount);
				} catch (IOException e) { 
					e.printStackTrace();
				}
			}
		}

		downloadFunc.downloadDocument(account[0], anArray.length, request
				.getRemoteAddr(), isDeducte);

//		return mapping.findForward("documentDownload");
		return Action.SUCCESS;
	}
	
//	@SuppressWarnings("unchecked")
//	public ActionForward documentDownload(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {
		
	public String documentDownload() throws Exception{	
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
		String strAn = request.getParameter("strAn");
		if (strAn == null || strAn.equals("")) {
			strAn = "0";
		}

		String[] anArray = strAn.split(",");

		boolean isDeducte = false;

		int[] account = Util.getBelongAccount(request);
		
	    String operateAmount  = "";
		if(anArray!=null)
			operateAmount = anArray.length+"";
//		 System.out.println();
		/**
		 * 记录检索日志
		 */
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
			String userName = "";
			userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			PlatformLog.insertTableLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), "download_doc");
		}
		//记录log74日志全文下载
		if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
		{ 
			if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
			{	
				String strSources = request.getParameter("strSources");
				String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
				IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
				try {
					Log74Util.log_func("9100", operateUserId+"", ipruser.getIntGroupId()+"", com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), DateUtil.getCurrentTimeStr(), strSources , operateAmount);
				} catch (IOException e) { 
					e.printStackTrace();
				}
			}
		}
		
		String username=(String)session.getAttribute(Constant.APP_USER_NAME);
		String userid=(String)session.getAttribute(Constant.APP_USER_ID);
		Long ctime=System.currentTimeMillis();
		Date d1=new Date(ctime);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time=sdf.format(d1);
		DownloadLogDAO dldao=new DownloadLogDAO();
		dldao.addDownloadLog(username, userid, time, "3","cn",operateAmount);//1为下载
		
		downloadFunc.downloadDocument(account[0], anArray.length, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), isDeducte);

//		return mapping.findForward("documentDownload");
		return Action.SUCCESS;
	}

	/*
	public ActionForward doDownloadXML(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		String channel = request.getParameter("channelIDs");
		String an = request.getParameter("an");
		String pd = request.getParameter("pd");
		// 数据权限验证
		// AbsDataAuthority dataAuthority = new DownloadScopeAuthProxy(
		// request, response);
		// if (!dataAuthority.hasDataAuthority(roleId.toString(),
		// Constant.AUTH_FUNC_DOC_BATCHDOWNLOAD, ((List<Map>) request
		// .getSession().getAttribute("userAuthorityList"))
		// .get(1), anArray.length)) {
		// return null;
		// }
		int[] account = Util.getBelongAccount(request);
		// 验证点卡数是否足够
		// AbsDataAuthority dataAuthority = new DownloadScopeAuthProxy(
		// request, response);
		// if (!dataAuthority.hasFeeAuthority(account[0], 1)) {
		// return null;
		// }

		String strWhere = "";
		String strANShort = an;
		if (strANShort.indexOf(".") > -1) {
			strANShort = strANShort.substring(0, strANShort.indexOf("."));
		}
		if (an.equals(strANShort)) {
			strWhere = "申请号=" + an;
		} else {
			strWhere = "申请号=(" + an + " or " + strANShort + ")";
		}

		
//		记录检索日志
		 
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
		String userName = "";
		userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
		PlatformLog.insertTableLog(userName, request.getRemoteAddr(), "download_xml");
		}
		
		try {
			downloadFunc.downloadXML(channel, strWhere, an, pd,
					response, account[0], request.getRemoteAddr(), 1);
			
			//记录log74日志xml下载
			if(Log74Access.getProperty(Log74Util.getLOG_OPEN())!=null && Log74Access.getProperty(Log74Util.getLOG_OPEN()).equals("1"))
			{ 
				if(request.getSession().getAttribute(Constant.APP_USER_ID)!=null)
				{	
					String strSources = request.getParameter("strSources");
					String operateUserId = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
					IprUser ipruser = sysUserFunc.getUserInfo(Integer.parseInt(operateUserId));
					try {
						Log74Util.log_func("9200", operateUserId+"", ipruser.getIntGroupId()+"", request.getRemoteAddr(), DateUtil.getCurrentTimeStr(), channel , "1");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return null;
	}
	*/

	// public ActionForward downLoad2(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {
	// // 实例初始化
	// JspFileDownload jfd = new JspFileDownload();
	// // 设定response对象。
	// jfd.setResponse(response);
	// // 设定下载模式 1 多文件压缩成ZIP文件下载。
	// jfd.setDownType(1);
	// // 设定显示的文件名
	// jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
	// // 设定要下载的文件的路径（数组，绝对路径）
	// // String[] s =
	// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
	// ArrayList<String> fileNames = new ArrayList<String>();
	// fileNames.add("D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt");
	// jfd.setZipFileNames(fileNames);
	// // 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
	// jfd.setZipDelFlag(true);
	// // 设定zip文件暂时保存的路径 （是文件夹）
	// jfd.setZipFilePath(DataAccess.getProperty("tempFilePath"));
	// // 主处理函数 注意返回值
	// jfd.process();
	//		
	// return null;
	// }

	// public ActionForward downloadUserStatisticXsl(ActionMapping mapping,
	// ActionForm form,
	// HttpServletRequest request, HttpServletResponse response) {
	// String operation = request.getParameter("operation");
	// String userName = request.getParameter("userName");
	// String time_from = request.getParameter("time_from");
	// String time_to = request.getParameter("time_to");
	// String
	// selectScope=request.getParameter("selectScope")==null?"all":request.getParameter("selectScope");
	// int
	// paixu=request.getParameter("paixu")==null?0:Integer.parseInt(request.getParameter("paixu"));
	//
	// StatsManageDAO statsManage = new StatsManageDAO();
	// String[][] arrStatistic = null;
	// String[] arrColumnTitle = null;
	// arrStatistic =
	// statsManage.getUserStatistic(time_from,time_to,userName,selectScope,paixu,10,1,1,true);
	//		
	// arrColumnTitle = new String[5];
	// arrColumnTitle[0] = "";
	// arrColumnTitle[1] = "中国专利原文打印";
	// arrColumnTitle[2] = "中国专利原文下载";
	// arrColumnTitle[3] = "国外专利文摘打印";
	// arrColumnTitle[4] = "国外专利文摘下载";
	// downloadFunc.downloadUserStatisticXsl(arrStatistic, arrColumnTitle,
	// downloadType, response, isGetPages);
	// return null;
	// }

	/**
	 * 批量下载代码化
	 */
	/*
	@SuppressWarnings("unchecked")
	public ActionForward doBatchDownloadXML(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {

		String patentList = request.getParameter("patentList");

		JSONArray patentJsonarray = JSONArray.fromObject(patentList);
		int[] account = Util.getBelongAccount(request);
		// 验证点卡数是否足够
		int accountId = account[0];

		String ft_type = request.getParameter("ft_type");

		String column = "";
		if (ft_type.equals("1")) {
			column = "权利要求书";
		} else if (ft_type.equals("2")) {
			column = "说明书";
		} else if (ft_type.equals("3")) {
			column = "说明书附图";
		}

		try {
			downloadFunc.batchDownloadXML(patentJsonarray, column, ft_type,
					response, accountId, request.getRemoteAddr(), 1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
//		记录检索日志
		 
		String userName = "";
		if(patentJsonarray!=null && patentJsonarray.size()>0)
		for(int i=0;i<patentJsonarray.size();i++)
		{
			if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
			{
				userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertTableLog(userName, request.getRemoteAddr(), "download_xml");
			}
			}
		return null;
	}
*/
	
//	public ActionForward statTableDownload(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response){
		
	public String statTableDownload() throws Exception{
//		ActionContext cxt = ActionContext.getContext();
//		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();	
				
		
		StatFunc statFunc = new StatFunc();
		//统计类型，登录，检索，查看，浏览，打印，下载等
		String statType = request.getParameter("t");
		int userid = Integer.parseInt(request.getParameter("userid")==null?"0":request.getParameter("userid"));
		String userName = request.getParameter("userName");
		if(StringUtils.isBlank(statType)){
			statType = "1";
		}
		String strCurrentPage = request.getParameter("currentPage");
		if(StringUtils.isBlank(strCurrentPage)){
			strCurrentPage = "1";
		}
		int currentPage = Integer.parseInt(strCurrentPage);
		//根据类型来取得统计列表
		List<StatBean> list = null;
		String[] titles = null;
		String n = request.getParameter("n");
		int cnt = StringUtils.isNotBlank(n) ? Integer.parseInt(n) : 12;
		//用户登录总体统计
		if(StringUtils.isNotBlank(userName)){
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)){
				try {
					list = statFunc.statDetail(userid, startTime,endTime);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
				list = statFunc.statDetail(userid, cnt);
			}
			titles = new String[]{"时间段","会话","查询","查看文摘","中国专利说明书浏览量","发明授权说明书浏览量","实用新型说明书浏览量","外观设计说明书浏览量","国外文摘浏览量","说明书下载","说明书打印"};
		}else{
			Page<StatBean> page = statFunc.loginGroupList(currentPage);
			if(page!=null){
				list = page.getResultList();
				titles = new String[]{"用户名","访问次数"};
			}			
		}
		statFunc.downloadZip(list, titles, response);
		return null;		
	}
	
	/**
	 * 批量下载文摘，得到检索结果
	 * @throws Exception 
	 * */
	public OverviewSearchResponse overviewSearch_111(HttpServletRequest request, HttpServletResponse response ,Long downloadStart,Long downloadAmount) throws Exception {
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
		try{
		// 当前页下标
		/*String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "1";
		}*/

		// 搜索的数据库范围（eg：fmzl_ab，syxx_ab）
		String strSources = "";
		// 地区（中外）
		String area = request.getParameter("area");
		if (area == null || area.equals("0"))
			area = "cn";

/*
		List<ChannelInfo> channelList = null;
		String[] channelArray = null;

		// 获取查询频道信息（频道ID）
		String[] dbArray = request.getParameterValues("strdb");
		if (dbArray == null) {
			dbArray = (String[]) request.getAttribute("strdb");
		}
		String tempChannel = "";
		if (dbArray != null) {
			for (String strChannel : dbArray) {
				tempChannel += strChannel + ",";
			}
			// IPC
			if (request.getParameter("strChannel") != null
					&& !request.getParameter("strChannel").equals("")) {
				tempChannel = request.getParameter("strChannel");
			}

			if (!tempChannel.equals("")) {
				channelArray = tempChannel.split(",");
			}
		}
		String strChannels = "";//strSources

		
		if (channelArray != null) {
			for (int i = 0; i < channelArray.length; i++) {
				strChannels += channelArray[i] + ",";
			}
			strChannels = strChannels.substring(0, strChannels.length() - 1);
		} else {
			strChannels = request.getParameter("strChannels");

			// IPC
			if (request.getParameter("strChannel") != null
					&& !request.getParameter("strChannel").equals("")) {
				strChannels = request.getParameter("strChannel");
			} else if (request.getParameter("strSources") != null) {
				strSources = request.getParameter("strSources") + ",";
			}

			channelArray = strChannels.split(",");
		}
*/
		String trsLastWhere = request.getParameter("trsLastWhere");
		
		strSources = request.getParameter("strSources");
		strSources = Util.getPatentTable(application,strSources);
		// 数据权限验证
		/**
		 * AbsDataAuthority dataAuthority = new SearchScopeAuthProxy(request,
		 * response); if (!dataAuthority.hasDataAuthority(((Integer)
		 * request.getSession()
		 * .getAttribute(Constant.APP_USER_ROLE)).toString(),
		 * Constant.AUTH_FUNC_OVERVIEW_SEARCH, strChannels, Integer
		 * .parseInt(pageIndex))) { return null; }
		 **/
/*
		// 通过ID，获取数据库的具体信息
		channelList = channelFunc.getInfoMapByChannel(channelArray);

		if (channelList != null && channelList.size() > 0) {
			strSources = "";
		}
		// TRS表名 （egg：发明专利，实用新型，外观设计） 保存表达式时用到
		String strTRSTableName = "";

		for (ChannelInfo info : channelList) {
			strSources += info.getChrTRSTable() + ",";
			strTRSTableName += info.getChrChannelName() + ",";
		}

		if (strSources != null && !strSources.equals(""))
			strSources = strSources.substring(0, strSources.length() - 1);

		if (strTRSTableName != null && !strTRSTableName.equals(""))
			strTRSTableName = strTRSTableName.substring(0, strTRSTableName
					.length() - 1);
		// System.out.println("strSources=" + strSources);
*/
		// 搜索条件
		String strWhere = request.getParameter("strWhere");
		if (strWhere == null)
			strWhere = (String) request.getAttribute("strWhere");
		//System.out.println("搜索条件进行处理前："+strWhere);
		// 对搜索条件进行处理
/*		if (!strWhere.equalsIgnoreCase(trsLastWhere)) {
			strWhere = GetSearchFormat.preprocess(strWhere);
		}*/

		//System.out.println("搜索条件进行处理后："+strWhere);
		// 排序
		String strSortMethod = request.getParameter("strSortMethod");
		/**
		 * RELEVANCE排序方式只支持 RELEVANCE
		 */
		if (strSortMethod == null || strSortMethod.equals("")
				|| strSortMethod.equals("+RELEVANCE")
				|| strSortMethod.equals("-RELEVANCE"))
			strSortMethod = "RELEVANCE";
		String strDefautCols = request.getParameter("strDefautCols");
		if (strDefautCols == null)
			strDefautCols = "主权项, 名称, 摘要";
		String strStat = request.getParameter("strStat");
		if (strStat == null)
			strStat = "";
		// 按词或按字搜索
		String option = request.getParameter("iOption");
		int iOption = (option != null && !option.trim().equals("")) ? Integer
				.parseInt(option) : 2;

		String iHitPointType = request.getParameter("iHitPointType");
		if (iHitPointType == null||iHitPointType.equals("")) {
			iHitPointType = "115";
		}
		// 二次检索

		String secondSearchFlag = request.getParameter("bContinue");

		boolean bContinue = secondSearchFlag == null
				|| secondSearchFlag.equals("")
				|| secondSearchFlag.equals("false") ? false : true;

		StringBuffer params = new StringBuffer();
		// params.append("strSources=").append(strSources).append("&")
		// .append("strSortMethod=").append(strSortMethod).append("&")
		// .append("strDefautCols=").append(strDefautCols.replace(" ",
		// "%20")).append("&")
		// .append("iOption=").append(iOption).append("&")
		// .append("iHitPointType=").append(iHitPointType).append("&")
		// .append("bContinue=").append(bContinue);

		// System.out.println("当前所在页数pageIndex= " + pageIndex);
		// 同义词检索
		String strSynonymous = request.getParameter("synonymous");
		if (strSynonymous == null) {
			strSynonymous = "";
		} else {
			strSynonymous = "SYNONYM_UTF8";
		}
		
		
		long startIndex = downloadStart-1;
		//Constant.PAGERECORD;
		//本次显示 最后一条记录下标
		long endIndex = downloadStart + downloadAmount - 1;
		
		// 概览页查询单个频道专利信息
		String filterChannel = request.getParameter("filterChannel");
		request.setAttribute("filterChannel", filterChannel);
		// 检索
		OverviewSearchResponse overviewResponse = null;

		String appNo = request.getParameter("appNum") == null ? "" : request
				.getParameter("appNum");
		String simFlag = request.getParameter("simFlag");
		String an = "";
		try {
			/**
			 * 是否进行了相似检索
			 */
			String pdLimit = request.getParameter("dateLimit") == null
					|| request.getParameter("dateLimit").equals("") ? "1999"
					: request.getParameter("dateLimit");
			String appDate = request.getParameter("apdRange");

			if (simFlag != null && !simFlag.trim().equals("")) {
				String dateCond = appDate.equals("0") ? "" : appDate
						.equals("1") ? " 申请日=(1900.01.01 to " + pdLimit
						+ ") not (申请日=" + pdLimit + ")"
						: appDate.equals("2") ? "申请日=" + pdLimit
								+ " to 2099.12.31" : "";
				strWhere = dateCond;
				an = "申请号=" + appNo;
//				strSources = "fmzl_ab,fmzl_ft,syxx_ab,syxx_ft";
				strSources = Util.getPatentTableByArea(application, area);
				bContinue = false;
				request.setAttribute("trsLastWhere", "");
				request.setAttribute("apdRange", appDate);
			}

			/**
			 * 是否进行了跨语言检索
			 */
			String crossLanguage = request.getParameter("crossLanguage");
			if (crossLanguage != null && crossLanguage.equals("ON")) {
				strWhere = CrossLanguage.getCrossLanguageExp(strWhere);
			}

			/**
			 * 非中国专利检索调用普通检索
			 */
//			if (!area.equals("cn")) {
//				bContinue = false; 
//				
//				overviewResponse =  searchFunc.overviewSearch(strSources,
//						strWhere, strSortMethod, strStat, strDefautCols,
//						iOption, Integer.parseInt(iHitPointType), false,
//						startIndex, endIndex, filterChannel, strSynonymous);
//				
//				/*overviewResponse =   searchFunc.batchDownload(strSources,
//						strWhere, strSortMethod, strStat, strDefautCols,
//						iOption, Integer.parseInt(iHitPointType), false,
//						startIndex, endIndex, filterChannel, strSynonymous);*/
//				 
//			}
//			/**
//			 * 智能检索semanticSearchImpl
//			 */
//			else {
//				overviewResponse = semanticSearchImpl.getBatchSemanticResult(
//						strSources, strWhere, strSortMethod, strStat,
//						strDefautCols, iOption,
//						Integer.parseInt(iHitPointType), bContinue, startIndex,
//						endIndex, filterChannel, strSynonymous, an,
//						trsLastWhere);
//				
//				/*overviewResponse =   searchFunc.batchDownload(strSources,
//						strWhere, strSortMethod, strStat, strDefautCols,
//						iOption, Integer.parseInt(iHitPointType), false,
//						startIndex, endIndex, filterChannel, strSynonymous);*/				 
//			}
			
			bContinue = false; 
			
			String wap = request.getParameter("wap")==null?"":request.getParameter("wap");
			
			overviewResponse =  searchFunc.overviewSearch(wap, strSources,
					strWhere, strSortMethod, strStat, strDefautCols,
					iOption, Integer.parseInt(iHitPointType), false,
					startIndex, endIndex, filterChannel, strSynonymous);
			
			/**
			 * 概览检索记录检索日志
			 */
			if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
			{
//				int userid = 0;
//				userid = (Integer)request.getSession().getAttribute(Constant.APP_USER_ID);
				
				int userid = 0;
				userid = Integer.parseInt((String)request.getSession().getAttribute(Constant.APP_USER_ID));
				
				String userName = "";
				userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
				PlatformLog.insertSearchLog(userid,userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), area);
			}
			// ISearchFunc client = CoreBizClient.getCoreBizClient((String)
			// request
			// .getSession().getAttribute(Constant.APP_USER_NAME));
			// overviewResponse = client.executeSearch(strSources, strWhere,
			// strSortMethod, strStat, strDefautCols, iOption,
			// Integer.parseInt(iHitPointType), false, startIndex,
			// endIndex, filterChannel);

		} catch (Exception e) {
			request.setAttribute("search_error", "概览检索出错," + e.getMessage());
			e.printStackTrace();
			return null;
		}
//		if (overviewResponse != null) {
//			/**
//			 * 如果执行了二次检索则执行trsLastWhere
//			 */
//
//			trsLastWhere = overviewResponse.getTrsLastWhere();
//			if (bContinue) {
//				strWhere = trsLastWhere;
//			}
//			request.setAttribute("trsLastWhere", trsLastWhere);
//
//			// 界面jstl进行迭代
//			request.getSession().setAttribute("list",
//					overviewResponse.getPatentInfoList());
//			//Page nav = new Page();
//			long totalRecord = overviewResponse.getRecordCount();
//			// 设置总页数
//			String count = Integer.toString((int) java.lang.Math
//					.ceil((totalRecord - 1) / Constant.PAGERECORD) + 1);
//			// 是否保存检索表达式
//			String savesearch = request.getParameter("savesearchword");
//			if (savesearch != null && savesearch.equals("ON")) {
//				String userID = (String) request.getSession().getAttribute(
//						Constant.APP_USER_ID);
//				String userIP = request.getRemoteAddr();
//				int intCountry = (area != null && area.equalsIgnoreCase("fr")) ? 1
//						: 0;
//				
//				String commonExp = ParseSemanticExp.getSemanticExp(strWhere)[2];
//				String relation = ParseSemanticExp.getSemanticExp(strWhere)[0];
//				String semantic = overviewResponse.getPatentWords();
//				if (semantic != null && !semantic.equals("")) {
//					semantic = "ss=" + Array2StringUtil.parseArray(semantic);
//					strWhere = commonExp + relation + semantic;
//				}
//
//				expFunc.saveExpression(userIP, Integer.parseInt(userID),
//						strWhere, strTRSTableName, null, totalRecord, request
//								.getParameter("synonymous"), intCountry);
//			}

//			nav.setPageCount(count);
//			nav.setPageIndex(pageIndex);
//			nav.setParams(params.toString());
//			nav.setNavigationUrl(request.getContextPath());
			

//			} else {
//				return overviewResponse;
//			}
			
			return overviewResponse;
		}catch(Exception e){e.printStackTrace();throw e;}

	}
	
	
	public void setDownloadFunc(DownloadFunc downloadFunc) {
		this.downloadFunc = downloadFunc;
	}

	public ChannelFunc getChannelFunc() {
		return channelFunc;
	}

	public void setChannelFunc(ChannelFunc channelFunc) {
		this.channelFunc = channelFunc;
	}

	public DownloadFunc getDownloadFunc() {
		return downloadFunc;
	}

	public SearchFunc getSearchFunc() {
		return searchFunc;
	}

	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}

	public SemanticSearch getSemanticSearchImpl() {
		return semanticSearchImpl;
	}

	public void setSemanticSearchImpl(SemanticSearch semanticSearchImpl) {
		this.semanticSearchImpl = semanticSearchImpl;
	}

	public RelevanceQueryDao getSemanticDao() {
		return semanticDao;
	}

	public void setSemanticDao(RelevanceQueryDao semanticDao) {
		this.semanticDao = semanticDao;
	}

	public ExpressionFunc getExpFunc() {
		return expFunc;
	}

	public void setExpFunc(ExpressionFunc expFunc) {
		this.expFunc = expFunc;
	}
}
