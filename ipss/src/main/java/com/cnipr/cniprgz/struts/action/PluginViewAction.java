package com.cnipr.cniprgz.struts.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.HttpToolsI;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.commons.fenye.Page;
import com.cnipr.cniprgz.func.ImageConvert;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.log.PlatformLog;
import com.cnipr.util.Endecrypt;
import com.cnipr.util.localMAC;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class PluginViewAction extends ActionSupport {	
	public SearchFunc searchFunc;

	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}
	
//	public String showPDF() throws Exception{
//		return INPUT;
//	}
	
	public String showPIC() throws Exception{
		String ret = "SUCCESS";
		String showPIC = DataAccess.get("showPIC")==null?"1":DataAccess.get("showPIC");
		if(showPIC.equals("0")){
			showTIF();			
			ret = SUCCESS;
		}else if(showPIC.equals("1")){
			showPNG();
			ret = SUCCESS;
		}
//		else if(showPIC.equals("2")){
//			showPDF();
//			ret = INPUT;
//		}
		
		return ret;
	}
	
	public String showPNG() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		
		//http://png.cnipr.com:8080/imgpub/showpage.do?path=HoNIB48KtbBE6sxTixMz9G57fmXoyZ29rLzmZs9%2BxnQrrrmnB80sb%2BzvDW0Yeyada0EMVnGHYa9i8cXuNWjdiSmbN4t%2FzwyQZgla8E%2BnYLcXjDwekcw%2FdENb5oaAnrLj&pageno=6
		String mac = localMAC.getLocalMac();
		//	/2016/20160629/201510676030.9
		
		String strUrl = request.getParameter("strUrl");
		String _strCurPage = request.getParameter("strCurPage")==null?"1":request.getParameter("strCurPage");
		String strCurPage = com.cnipr.cniprgz.commons.Util.getTifName(Integer.parseInt(_strCurPage));
		
//		String _strUrl = DataAccess.getProperty("PicServerURL") + strUrl + "/" + strCurPage;
		
		Endecrypt crypt = new Endecrypt();
//		F48E38A1264C@/SD/2016/20160210/201310406669.6
		String oldString = mac + "@" + strUrl;
		
		
		String SPKEY = "cniprPNG";
//		System.out.println("1、分配的SPKEY为:  " + SPKEY);
//		System.out.println("2、的内容为:  " + oldString);
		String reValue = crypt.get3DESEncrypt(oldString, SPKEY);
		
		request.setAttribute("pi", reValue);		
		
		request.setAttribute("strUrl", strUrl);		
//		标题
		request.setAttribute("ti", request.getParameter("ti"));
//		IPC
		request.setAttribute("strIPC", request.getParameter("strIPC"));
//		申请号
		request.setAttribute("an", request.getParameter("strAn"));
//		申请人
		request.setAttribute("strANN", request.getParameter("strANN"));
//		总页数
		request.setAttribute("pages", request.getParameter("totalPages"));
//		当前页
		request.setAttribute("strCurPage", _strCurPage);
		
		return SUCCESS;
	}
	
	public String showTIF() throws Exception{
    	ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
//		wap=1&curpage="+strCurPage+"&strCurPage="+strCurPage+"&method=viewDocument&strUrl="+strUrl+"&totalPages="+totalPages

/*
		String wap = request.getParameter("wap");
		System.out.println("wap----" + wap);
		
		String curpage = request.getParameter("curpage");
		System.out.println("curpage----" + curpage);
		
		String strCurPage1 = request.getParameter("strCurPage");
		System.out.println("strCurPage----" + strCurPage1);
		
		String method = request.getParameter("method");
		System.out.println("method----" + method);
		
		String strUrl1 = request.getParameter("strUrl");
		System.out.println("strUrl----" + strUrl1);
		
		String totalPages = request.getParameter("totalPages");
		System.out.println("totalPages----" + totalPages);
		*/
		
		String strUrl = request.getParameter("strUrl");
		String _strCurPage = request.getParameter("strCurPage")==null?"1":request.getParameter("strCurPage");
		String strCurPage = com.cnipr.cniprgz.commons.Util.getTifName(Integer.parseInt(_strCurPage));
		
		String _strUrl = DataAccess.getProperty("PicServerURL") + strUrl + "/" + strCurPage;
		
//		System.out.println("111----" + request.getSession().getServletContext().getRealPath("pngtempfiles"));
//		System.out.println("222----" + strUrl);
		
		
//		下载到本地pngtempfiles
		java.io.File fileName = new java.io.File(request.getSession().getServletContext().getRealPath("pngtempfiles")+ "\\" + strUrl.toUpperCase().replace("/", "\\"));
		if(!fileName.exists())    
		{
			fileName.mkdirs();
		}
		String pngtempfiles = fileName.getAbsolutePath() + "\\" + strCurPage;
		
		java.io.File pngtempfile = new java.io.File(pngtempfiles);
		if(!pngtempfile.exists())
		{
			new HttpToolsI().downloadTiffJpgToFile(_strUrl, pngtempfiles);				
//			转化成PNG格式，并生成路径赋值到strUrl
			ImageConvert.readTiff(pngtempfiles);
		}
		
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
		String pngPath = basePath + "pngtempfiles/" + strUrl.toUpperCase() + "/" + strCurPage.toLowerCase().replaceAll(".tif", ".png");
		
//		System.out.println("tifDistributePath=" + strUrl);
//		System.out.println("ti=" + request.getParameter("ti"));
//		System.out.println("strIPC=" + request.getParameter("strIPC"));
//		System.out.println("an=" + request.getParameter("strAn"));
//		System.out.println("strANN=" + request.getParameter("strANN"));
//		System.out.println("pages=" + request.getParameter("totalPages"));
		
//		路径, 如：http://search.cnipr.com:8080/BOOKS/XX/2010/20100929/201020103546.7/000001.tif
		request.setAttribute("strUrl", strUrl);
		
		request.setAttribute("pngDistributePath", pngPath);
//		标题
		request.setAttribute("ti", request.getParameter("ti"));
//		IPC
		request.setAttribute("strIPC", request.getParameter("strIPC"));
//		申请号
		request.setAttribute("an", request.getParameter("strAn"));
//		申请人
		request.setAttribute("strANN", request.getParameter("strANN"));
//		总页数
		request.setAttribute("pages", request.getParameter("totalPages"));
//		当前页
		request.setAttribute("strCurPage", _strCurPage);
		
		
		/**
		 * 记录检索日志
		 */
		String dbName = request.getParameter("dbName");
		if(dbName!=null){
			dbName = dbName.toLowerCase();
			if(dbName.indexOf("fmzl")>-1){
				dbName = "FMZL";
			}else if(dbName.indexOf("fmsq")>-1){
				dbName = "FMSQ";
			}else if(dbName.indexOf("syxx")>-1){
				dbName = "SYXX";
			}else if(dbName.indexOf("wgzl")>-1){
				dbName = "WGZL";
			}
		}else{
			dbName = "";
		}
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
			String userName = "";
			userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			PlatformLog.insertViewDocLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr( request), dbName);
		}
		
//		return mapping.findForward("instructionPage");
		return SUCCESS;
	}
	
//	public ActionForward viewSWGB(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {
//		
//		String an = request.getParameter("an"); 
//		String lawpd = request.getParameter("lawpd"); 
//		
//		try {
//			GBSWIndex gbswindex = searchFunc.getGBScWIndex(an, lawpd);
//			request.setAttribute("gbswindex", gbswindex); 
//			 
//			
//		} catch (Exception e) { 
//			e.printStackTrace();
//		}
// 	
//		// 路径, 如：http://search.cnipr.com:8080/BOOKS/XX/2010/20100929/201020103546.7/000001.tif
//		//request.setAttribute("tifDistributePath", strUrl);
//		// 标题
//		/*request.setAttribute("ti", request.getParameter("ti"));
//		// IPC
//		request.setAttribute("strIPC", request.getParameter("strIPC"));
//		// 申请号
//		request.setAttribute("an", request.getParameter("strAn"));
//		// 申请人
//		request.setAttribute("strANN", request.getParameter("strANN"));
//		// 总页数
//		request.setAttribute("pages", request.getParameter("totalPages")); */		
//		return mapping.findForward("viewSWGB");
//	}
	
//	public ActionForward showXML(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {
	
	public String showXML() throws Exception{		
    	ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpSession session = request.getSession();
		
//		当前页下标
		String pageIndex = request.getParameter("pageIndex");
		if (pageIndex == null || pageIndex.equals("")) {
			pageIndex = "0";
		}
		
		String strUrl = request.getParameter("strUrl");
		strUrl = DataAccess.getProperty("PicServerURL") + strUrl + "/000001.tif";
		
		String strTI = request.getParameter("strTI");
		 
		strTI = strTI.replace("<","﹤");
		strTI = strTI.replace(">","﹥");
		
		String wap = request.getParameter("wap")==null?"":request.getParameter("wap");
		
//		System.out.println("strUrl=" + strUrl);
//		System.out.println("strTI=" + request.getParameter("strTI"));
//		System.out.println("channel=" + request.getParameter("channel"));
//		System.out.println("an=" + request.getParameter("an"));
//		System.out.println("pd=" + request.getParameter("pd"));
//		System.out.println("CLM_Page=" + request.getParameter("CLM_Page"));
//		System.out.println("DES_Page=" + request.getParameter("DES_Page"));
//		System.out.println("DRA_Page=" + request.getParameter("DRA_Page"));
//		System.out.println("strPage=" + request.getParameter("strPage"));
//		System.out.println("srcWhere=" + request.getParameter("srcWhere"));
//		System.out.println("======================================================");

		request.setAttribute("strUrl", strUrl);
		request.setAttribute("strTI", strTI);
		request.setAttribute("channel", request.getParameter("channel"));
		request.setAttribute("an", request.getParameter("an"));
		request.setAttribute("pd", request.getParameter("pd"));
				
		int CLM_Page = searchFunc.getXmlTotalPage(wap,request.getParameter("channel"), request.getParameter("an"), "1");
		int DES_Page = searchFunc.getXmlTotalPage(wap,request.getParameter("channel"), request.getParameter("an"), "2");
//		DES_Page = 136;
		int DRA_Page = searchFunc.getXmlTotalPage(wap,request.getParameter("channel"), request.getParameter("an"), "3");
		Page nav = new Page();
		int pageNum = 10;
		
		pageNum = Constant.XmlPageNUM;
		
//		System.out.println("\n\n############:" + pageNum);
		nav.setPageCount(Integer.toString((int) java.lang.Math.ceil((CLM_Page + DES_Page - 1) / pageNum) + 1));
		nav.setPageIndex((Integer.parseInt(pageIndex) + Integer.valueOf(1).toString()));
		nav.setParams("");
		nav.setNavigationUrl(request.getContextPath());
		request.setAttribute("nav", nav);
		request.setAttribute("pageIndex", pageIndex);
		request.setAttribute("CLM_Page", CLM_Page);
		request.setAttribute("DES_Page", DES_Page);
		request.setAttribute("DRA_Page", DRA_Page);
		request.setAttribute("strPage", request.getParameter("strPage"));
		request.getSession().setAttribute("srcWhere", request.getParameter("srcWhere"));
		
		/**
		 * 记录检索日志
		 */
		if(SetupAccess.getProperty(SetupConstant.DATABASELOG)!=null && SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1"))
		{
			String userName = "";
			userName = (String)request.getSession().getAttribute(Constant.APP_USER_NAME);
			PlatformLog.insertTableLog(userName, com.cnipr.cniprgz.commons.Common.getRemoteAddr(request), "view_xml");
		}
//		return mapping.findForward("xmlPage");
		return SUCCESS;
	}
}
