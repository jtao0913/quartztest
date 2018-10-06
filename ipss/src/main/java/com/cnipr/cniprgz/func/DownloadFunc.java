package com.cnipr.cniprgz.func;

//import javax.servlet.http.HttpSession;

//import uk.ltd.getahead.dwr.WebContextFactory;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;

import com.cnipph.util.SaveImage;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.FileUtilsExpand;
import com.cnipr.cniprgz.commons.HttpToolsI;
import com.cnipr.cniprgz.commons.PathUtil;
import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.commons.itext.ConvertIMG2PDF;
import com.cnipr.cniprgz.func.download.HttpGet;
import com.cnipr.cniprgz.func.download.JspFileDownload;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.log.CniprLogger;
import com.cnipr.corebiz.search.entity.LegalStatusInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;

//20160127
//import com.cnipr.net.FileSplitterFetch;
//import com.cnipr.net.SiteFileFetch;
//import com.cnipr.net.SiteInfoBean;

public class DownloadFunc extends AbsCniprFunc {

	private SearchFunc searchFunc;
	private String tempFilePath = PathUtil.getAbsoluteWebPath()+"/temp/";//DataAccess.getProperty("tempFilePath")
	
	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}
	
	// private String url;
	// private String filePath;
	// private String fileName;

	public DownloadFunc() {
//		this.addListener(new CniprListener());
	}
	
/* public DownloadFunc(String url, String filePath,
	  String fileName) {
	  this.url = url;
	   this.filePath = filePath;
	  this.fileName = fileName;
    }
*/
	public File createPDFZip(String basePath,String tifInfos,String pictype){
		String downloadServer = null;
		String suffix = "";
		
/*		if(pictype.equals("1")){
			downloadServer = DataAccess.get("PNGServerURL");
			suffix = ".png";
		}else if(pictype.equals("0")){
			downloadServer = DataAccess.get("PicServerURL");
			suffix = ".tif";
		}*/
		
		downloadServer = DataAccess.get("PicServerURL");
		suffix = ".tif";
		
		String tempName = UUID.randomUUID().toString();//临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFileName =basePath+File.separator + tempName;
		File outFile = new File(temFileName);//这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		int requestCount = 0;
		String[] tifInfo = tifInfos.split(";");
		List<String> fileList = new ArrayList<String>();
		for (String info : tifInfo) {
			if (!"".equals(info.trim())) {
				requestCount++;
				String[] t = info.split(",", -1);
				if (t[1]!=null && !"".equals(t[1]) && Integer.valueOf(t[1]) > 0) {
					requestCount++;
					String secondlevpath = temFileName + File.separator + t[2] + File.separator;
					fileList.add(secondlevpath);
					File secondlevdir = new File(secondlevpath);
					if (!secondlevdir.exists()) {
						secondlevdir.mkdirs();
					}
//					String picType = ".png";//图片格式默认是PNG
//					if (t[0].substring(6, 8).equalsIgnoreCase("WG")) {
//						picType = ".jpg";//外观专利图片格式是JPG
//					}
					
					
//					long startTime = new Date().getTime();
//					System.out.println("下载TIFF图当前的时间"+startTime);
					for (int i = 1; i <= Integer.valueOf(t[1]); i++) {
//						String serverUrl = downloadServer + t[0] + File.separator + Util.formatDecimal("000000", i)+ picType;
						String serverUrl = t[0];
						if(serverUrl.toUpperCase().indexOf("WG")>-1){
							suffix = ".jpg";
						}
						String fileSavePath = secondlevpath+ Util.formatDecimal("000000", i)+ suffix;
						
						if(pictype.equals("1")){//png
							new HttpToolsI().downloadPNGToFile(downloadServer, serverUrl, fileSavePath ,i);
						}else if(pictype.equals("0")){//tif
							new HttpToolsI().downloadTiffJpgToFile(downloadServer + "/" + serverUrl  + "/" + String.format("%06d", i)+ suffix, fileSavePath);
						}
//						new HttpToolsI().downloadPNGToFile(downloadServer, serverUrl, fileSavePath ,i);
					}
//					System.out.println("下载TIFF图总共需要的时间"+(new Date().getTime()-startTime));
					
					///////////////////////////////////////////////////////////////////////////////////////
//					TIF合成PDF
					File tiffolder = new File(secondlevpath);
					
					FileFilter filtertif = new FileFilter() {
						@Override
						public boolean accept(File pathname) {
							return pathname.getName().toLowerCase().endsWith(".tif");
						}
					};
					
					FileFilter filterjpg = new FileFilter() {
						@Override
						public boolean accept(File pathname) {
							return pathname.getName().toLowerCase().endsWith(".jpg");
						}
					};
					
					FileFilter filterpng = new FileFilter() {
						@Override
						public boolean accept(File pathname) {
							return pathname.getName().toLowerCase().endsWith(".png");
						}
					};
					
					FileFilter filterpdf = new FileFilter() {
						@Override
						public boolean accept(File pathname) {
							return pathname.getName().toLowerCase().endsWith(".pdf");
						}
					};
					
					if(pictype.equals("1")){//png
						File[] tifs = (tiffolder).listFiles(filterpng);
						for(int n=0;n<tifs.length;n++){
							ConvertIMG2PDF.PNG2PDF(tifs[n].getAbsolutePath(), tifs[n].getAbsolutePath().replace(".PNG", ".png").replace(".png", ".pdf"));							
						}
					}else if(pictype.equals("0")){//tif
						File[] tifs = (tiffolder).listFiles(filtertif);
						if(tifs!=null&&tifs.length>0){
							for(int n=0;n<tifs.length;n++){
								ConvertIMG2PDF.TIF2PDF(tifs[n].getAbsolutePath(), tifs[n].getAbsolutePath().replace(".TIF", ".tif").replace(".tif", ".pdf"));							
							}
						}
						
						tifs  = (tiffolder).listFiles(filterjpg);
						if(tifs!=null&&tifs.length>0){
							for(int n=0;n<tifs.length;n++){
								ConvertIMG2PDF.JPG2PDF(tifs[n].getAbsolutePath(), tifs[n].getAbsolutePath().replace(".JPG", ".jpg").replace(".jpg", ".pdf"));							
							}
						}
					}					
					
//					File[] tifs = (tiffolder).listFiles(filtertif);
//					for(int n=0;n<tifs.length;n++){
////						String imgeFilename = tifs[n].getAbsolutePath();
//						if(pictype.equals("1")){//png
//							ConvertIMG2PDF.PNG2PDF(tifs[n].getAbsolutePath().replace(".TIF", ".tif").replace(".tif", ".png"), tifs[n].getAbsolutePath().replace(".TIF", ".tif").replace(".tif", ".pdf"));
//						}else if(pictype.equals("0")){//tif
//							ConvertIMG2PDF.TIF2PDF(tifs[n].getAbsolutePath(), tifs[n].getAbsolutePath().replace(".TIF", ".tif").replace(".tif", ".pdf"));
//						}
//					}
					
					File[] pdfs = (tiffolder).listFiles(filterpdf);
					
//					System.out.println(tiffolder.getAbsolutePath()+"\\"+t[2]+".pdf");
					
					ConvertIMG2PDF.mergePdfFiles(pdfs, new File(tiffolder.getAbsolutePath()+"\\"+t[2]+".pdf"));
					
					/*
					for(int n=0;n<pdfs.length;n++){
				        File file = new File(pdfs[n].getAbsolutePath());
				        if (!file.exists()) {
//				            System.out.println("删除文件失败:" + fileName + "不存在！");
//				            return false;
				        } else {
				            if (file.isFile()
//				            		&&file.getName().indexOf(t[2])==-1
				            		){
				                file.delete();
				            }
				        }
					}
					
					File[] pngs = (tiffolder).listFiles(filterpng);
					for(int n=0;n<pngs.length;n++){
				        File file = new File(pngs[n].getAbsolutePath());
				        if (!file.exists()) {
//				            System.out.println("删除文件失败:" + fileName + "不存在！");
//				            return false;
				        } else {
				            if (file.isFile()
//				            		&&file.getName().indexOf(t[2])==-1
				            		){
				                file.delete();
				            }
				        }
					}
					
					File[] tifs = (tiffolder).listFiles(filtertif);
					for(int n=0;n<tifs.length;n++){
				        File file = new File(tifs[n].getAbsolutePath());
				        if (!file.exists()) {
//				            System.out.println("删除文件失败:" + fileName + "不存在！");
//				            return false;
				        } else {
				            if (file.isFile()
//				            		&&file.getName().indexOf(t[2])==-1
				            		){
//				                file.delete();
				                
				                boolean result=false;
				                result=file.delete();
				                
				                int delCount=0;
				                while(!result && delCount++ <10)   
				                {  
//				                	System.gc() 
				                	try{
				                		Thread.sleep(1000);
				                	}catch(Exception ex){}
				                	
				                	result = file.delete();
				                }  
				            }
				        }
					}
					*/
					
					File pdffile = new File(tiffolder.getAbsolutePath()+"\\"+t[2]+".pdf");
					
					File pdffolder = new File(temFileName+"1");
					if(!pdffolder.exists()){
						pdffolder.mkdirs();
					}
					
					pdffile.renameTo(new File(pdffolder.getAbsolutePath()+"\\"+t[2]+".pdf"));
					///////////////////////////////////////////////////////////////////////////////////////
				}
			}
		}
		
		try {
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip						
			

			
			
			
			FileUtilsExpand.zip(temFileName+"1", temFileName+"1"+"z.zip");
			FileUtilsExpand.forceDeleteOnExit(outFile);
			
			FileUtilsExpand.forceDeleteOnExit(new File(temFileName+"1"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"1"+"z.zip");
	}
	
	public File createPNGZip(String basePath,String tifInfos){
		String downloadServer = null;
		downloadServer = DataAccess.get("PNGServerURL");
		String tempName = UUID.randomUUID().toString();//临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFileName =basePath+File.separator + tempName;
		File outFile = new File(temFileName);//这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		int requestCount = 0;
		String[] tifInfo = tifInfos.split(";");
		List<String> fileList = new ArrayList<String>();
		for (String info : tifInfo) {
			if (!"".equals(info.trim())) {
				requestCount++;
				String[] t = info.split(",", -1);
				if (t[1]!=null && !"".equals(t[1]) && Integer.valueOf(t[1]) > 0) {
					requestCount++;
					String secondlevpath = temFileName + File.separator + t[2] + File.separator;
					fileList.add(secondlevpath);
					File secondlevdir = new File(secondlevpath);
					if (!secondlevdir.exists()) {
						secondlevdir.mkdirs();
					}
					String picType = ".png";// 图片格式默认是PNG
					if (t[0].substring(6, 8).equalsIgnoreCase("WG")) {
						picType = ".jpg";// 外观专利图片格式是JPG
					}
					long startTime = new Date().getTime();
//					System.out.println("下载TIFF图当前的时间"+startTime);
					for (int i = 1; i <= Integer.valueOf(t[1]); i++) {
//						String serverUrl = downloadServer + t[0] + File.separator + Util.formatDecimal("000000", i)+ picType;
						String serverUrl = t[0];
						String fileSavePath = secondlevpath+ Util.formatDecimal("000000", i)+ picType;
						new HttpToolsI().downloadPNGToFile(downloadServer, serverUrl, fileSavePath ,i);
					}
//					System.out.println("下载TIFF图总共需要的时间"+(new Date().getTime()-startTime));
				}
			}
		}
		
		try {
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip
			FileUtilsExpand.zip(temFileName, temFileName+"z.zip");
			FileUtilsExpand.forceDeleteOnExit(outFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"z.zip");
	}
	
	public File createTiffZip(String basePath,String tifInfos){
//		String downloadServer = APIUtils.getProperty("tiffDownload",true);//tiffDownload=http://pic.cnipr.com:8080/
		String downloadServer = DataAccess.get("PicServerURL");
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFileName =basePath+File.separator + tempName;
		File outFile = new File(temFileName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		int requestCount = 0;
		String[] tifInfo = tifInfos.split(";");
		List<String> fileList = new ArrayList<String>();
		for (String info : tifInfo) {
			if (!"".equals(info.trim())) {
				requestCount++;
				String[] t = info.split(",", -1);
				if (t[1]!=null && !"".equals(t[1]) && Integer.valueOf(t[1]) > 0) {
					requestCount++;
					String secondlevpath = temFileName +File.separator+ t[2] + File.separator;
					fileList.add(secondlevpath);
					File secondlevdir = new File(secondlevpath);
					if (!secondlevdir.exists()) {
						secondlevdir.mkdirs();
					}
					String picType = ".tif";// 图片格式默认是TIF
					if (t[0].substring(6, 8).equalsIgnoreCase("WG")) {
						picType = ".jpg";// 外观专利图片格式是JPG
					}
					long startTime = new Date().getTime();
//					System.out.println("下载TIFF图当前的时间"+startTime);
					for (int i = 1; i <= Integer.valueOf(t[1]); i++) {
						String serverUrl = downloadServer+ t[0] + File.separator + Util.formatDecimal("000000", i)+ picType;
						String fileSavePath = secondlevpath+ Util.formatDecimal("000000", i)+ picType;
						new HttpToolsI().downloadTiffJpgToFile(serverUrl, fileSavePath);
					}
//					System.out.println("下载TIFF图总共需要的时间"+(new Date().getTime()-startTime));
				}
			}
		}
		
		try {
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip
			FileUtilsExpand.zip(temFileName, temFileName+"z.zip");
			FileUtilsExpand.forceDeleteOnExit(outFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"z.zip");
	}
	
 //	public void downloadDocument() {
////		this.fireEvent(new CniprEvent(this, true, false, patentList,
////				userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
////				0, userIp, feeType));
//	}

	/**
	 * 功能：打包下载代码化数据 过程：从TRS服务器获取相应的代码化数据并做处理，如果代码化中包含
	 * 图片信息要将图片下载到本地服务器,将代码化数据生成文件连同dtd、xsl及图片文件一起打包返回
	 * 客户端，删除所有产生的中间文件。
	 */
	@SuppressWarnings("unchecked")
	public void downloadXML(String wap, String strSources, String strWhere,
			String an, String pd, HttpServletResponse response, int userId,
			String userIp, int feeType) throws UnsupportedEncodingException {
		// src_is = new StringBufferInputStream(new String(searchFunc
		// .getXmlDocument(strSources, strWhere, column), "iso_8859_1"));
		HttpGet httpGetInstance = new HttpGet();

		List getXmlContantList = searchFunc.getAllXmlContant(wap, "", strSources, an,
				pd, httpGetInstance);

		String srcString = (String) getXmlContantList.get(0);

		httpGetInstance = (HttpGet) getXmlContantList.get(1); 
		
		
		String dtdFilePath = PathUtil.getAbsoluteWebPath()+"/dtd";
		String xslFilePath = PathUtil.getAbsoluteWebPath()+"/xsl";
		
		String picTempPath = tempFilePath + UUID.randomUUID().toString() + "/"; 
		
		if (httpGetInstance.getVFileList().size() > 0) {
			File pictempdir = new File(picTempPath);
			if (!pictempdir.exists()) {
				pictempdir.mkdirs();
			}
			
			httpGetInstance.setRootPath(picTempPath);
			httpGetInstance.downLoadByList();
		}

		String desPath = tempFilePath + UUID.randomUUID().toString() + ".xml";
		if (createTempFile(srcString, desPath)) {
			ArrayList<String> fileNames = new ArrayList<String>();
			
			
			fileNames.add(desPath);
			for (String filePath : httpGetInstance.getVFileList()) {  
				File picFile = new File(picTempPath + filePath);
				if (picFile.exists()) {
					fileNames.add(picTempPath + filePath);
				}
			}
		
			
			fileNames.add(dtdFilePath);
			fileNames.add(xslFilePath );
			
			 
			 
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定为zip压缩的根目录名称
			jfd.setRootPath(an + "/");
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
			// 删除下载的图形文件
			Util.delFolder(picTempPath);
			 
			// 触发监听事件
		//	this.fireEvent(new CniprEvent(this, true, true, userId, "", Constant.AUTH_FUNC_XML_DOWNLOAD, 1,
			//		userIp, 1));
//			this.fireEvent(new CniprEvent(this, true, false, intUserId, "", Constant.AUTH_FUNC_FAVORITE_ADD, patentInfoList.size(),
//					strUserIp, 0));
//			PatentInfo patent = new PatentInfo();
//			patent.setAn(an);
//			patent.setSectionName(strSources);
//			List<PatentInfo> patentList = new ArrayList<PatentInfo>();
//			patentList.add(patent);
//			this.fireEvent(new CniprEvent(this, true, false, patentList, userId,
//					userName, Constant.AUTH_FUNC_XML_DOWNLOAD, Integer
//							.parseInt(strStartPage), Integer
//							.parseInt(strEndPage), userIp, feeType));
		}

	}
	
	/**
	 * 批量下载代码化
	 */
	@SuppressWarnings("unchecked")
	public void batchDownloadXML(String wap, JSONArray patentArray,String column,String ft_type,
			HttpServletResponse response, int accountId,
			String userIp, int feeType) throws Exception{
		
		try{
		
		ArrayList<String> fileNames = new ArrayList<String>();
		
	 	String dtdFilePath = PathUtil.getAbsoluteWebPath()+"/dtd";
		String xslFilePath = PathUtil.getAbsoluteWebPath()+"/xsl";
		
		fileNames.add(dtdFilePath);
		fileNames.add(xslFilePath);
		
		String picTempPath =tempFilePath
				+ UUID.randomUUID().toString() + "/";
		
		int downloadCount = 0;
		
		for(int i=0;i<patentArray.size();i++){
			JSONObject obj = patentArray.getJSONObject(i);
			String an = obj.getString("an");
			String pd = obj.getString("pd");
			String channel = obj.getString("sectionName");
			String page = "";
			
			if("1".equals(ft_type)){
				page = Integer.toString(searchFunc.getXmlTotalPage(wap,channel, an, "1"));
			}else if("2".equals(ft_type)){
				page = Integer.toString(searchFunc.getXmlTotalPage(wap,channel, an, "2"));
			}else if("3".equals(ft_type)){
				page = Integer.toString(searchFunc.getXmlTotalPage(wap,channel, an, "3"));
			}
			if(page!=null && !"".equals(page) && !"null".equals(page) && Integer.parseInt(page)>0){
				
				HttpGet httpGetInstance = new HttpGet();
				List getXmlContantList = searchFunc.getAllXmlContant(wap, "", channel, an,
						pd, httpGetInstance);
				
				String srcString = (String) getXmlContantList.get(0);

				httpGetInstance = (HttpGet) getXmlContantList.get(1);
				
				if (httpGetInstance.getVFileList().size() > 0) {
					File pictempdir = new File(picTempPath);
					if (!pictempdir.exists()) {
						pictempdir.mkdirs();
					}
		
					httpGetInstance.setRootPath(picTempPath);
					httpGetInstance.downLoadByList();
				}
		
				String desPath = tempFilePath
						+ an + ".xml";
				if (createTempFile(srcString, desPath)) {
					fileNames.add(desPath);
					downloadCount++;
					for (String filePath : httpGetInstance.getVFileList()) {
						File picFile = new File(picTempPath + filePath);
						if (picFile.exists()) {
							fileNames.add(picTempPath + filePath);
						}
					}
				}
			}
		}
		// 实例初始化
		JspFileDownload jfd = new JspFileDownload();
		// 设定为zip压缩的根目录名称
		//jfd.setRootPath(an + "/");
		jfd.setRootPath(UUID.randomUUID().toString() + "/");
		// 设定response对象。
		jfd.setResponse(response);
		// 设定下载模式 1 多文件压缩成ZIP文件下载。
		jfd.setDownType(1);
		// 设定显示的文件名
		jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
		// 设定要下载的文件的路径（数组，绝对路径）
		jfd.setZipFileNames(fileNames);
		// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
		jfd.setZipDelFlag(true);
		// 设定zip文件暂时保存的路径 （是文件夹）
		jfd.setZipFilePath(tempFilePath);
		// 主处理函数 注意返回值
		jfd.process();
		// 删除下载的图形文件
		Util.delFolder(picTempPath);
		// 触发监听事件
	//	this.fireEvent(new CniprEvent(this, true, true, accountId, "", Constant.AUTH_FUNC_XML_BATCHDOWNLOAD, downloadCount,
	//			userIp, feeType));
		/*PatentInfo patent = new PatentInfo();
					patent.setAn(an);
					patent.setSectionName(channel);
					List<PatentInfo> patentLists = new ArrayList<PatentInfo>();
					patentLists.add(patent);
					this.fireEvent(new CniprEvent(this, true, false, patentList, userId,
							userName, Constant.AUTH_FUNC_XML_DOWNLOAD, 1, Integer
									.parseInt(page), userIp, feeType));*/
		}catch(Exception ex){
			throw ex;
		}
	}
		
	/**
	 * 功能：批量法律状态下载 过程：从TRS服务器获取相应的文摘，根据文件类型生成相应中间文件，
	 * 返回客户端，删除所有产生的中间文件。
	 */
	public void batchdownloadGBZip(List<String> urls, 
			  HttpServletResponse response) {
		String savePath =tempFilePath + UUID.randomUUID().toString()+"/" ;
		ArrayList files = null;
		if(urls!=null)
		{
			files = new ArrayList();
			for(int i=0;i<urls.size();i++){
				String url = urls.get(i);
				String savefilepath = SaveImage.getImageFromURL(url,savePath);
				files.add(savefilepath);
			}
		}
		

		try {
			ArrayList<String> fileNames = files;
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			// String[] s =
			// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
	//		this.fireEvent(new CniprEvent(this, true, false, userId, "", Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, patentList.size(),
	//				userIp, feeType));
//			// 触发监听事件
//			this.fireEvent(new CniprEvent(this, true, false, patentList,
//					userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
//					0, userIp, feeType));
		 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	/**
	 * 功能：批量法律状态下载 过程：从TRS服务器获取相应的文摘，根据文件类型生成相应中间文件，
	 * 返回客户端，删除所有产生的中间文件。
	 */
	public void batchdownloadLasStatusZip(List<LegalStatusInfo> legalStatusInfoList, 
			  HttpServletResponse response) {
		StringBuffer anBuf = new StringBuffer();
		StringBuffer dbBuf = new StringBuffer();

		/*for (PatentInfo patent : patentList) {
			anBuf.append(patent.getAn() + ",");
			dbBuf.append(patent.getSectionName() + ",");
		}
		String strWhere = anBuf.substring(0, anBuf.length() - 1);
		String strSources = dbBuf.substring(0, dbBuf.length() - 1);*/

		/*boolean isGetPages = false;
		if (area.equals("0")) {
			isGetPages = true;
		}*/

		try {
			//patentList = searchFunc.executeSearch(strSources, "申请号=(" + strWhere + ")", false, isGetPages);
		} catch (Exception e1) {
			CniprLogger.LogError("DownloadFunc -> downloadZip error: "
					+ e1.getMessage());
		}

		try {
			ArrayList<String> fileNames = createLawStatusTempFile(legalStatusInfoList);
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			// String[] s =
			// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
	//		this.fireEvent(new CniprEvent(this, true, false, userId, "", Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, patentList.size(),
	//				userIp, feeType));
//			// 触发监听事件
//			this.fireEvent(new CniprEvent(this, true, false, patentList,
//					userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
//					0, userIp, feeType));
		} catch (RowsExceededException e) {
			e.printStackTrace();
		} catch (WriteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public File createAnalysePNGZip(String basePath, String dataUrl){
//		StringBuffer anBuf = new StringBuffer();
//		StringBuffer dbBuf = new StringBuffer();
		
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFolderName =basePath+File.separator + tempName;
		File outFile = new File(temFolderName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		
		try{
			ArrayList<String> fileNames = createPNGTempFile(dataUrl,temFolderName);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
//			FileUtilsExpand.zip(temFolderName+"\\"+tempName+".xls", temFolderName+"z.zip");
			
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip
//			FileUtilsExpand.zip(temFileName, temFileName+"z.zip");
			
			FileUtilsExpand.zip(temFolderName, temFolderName+"z.zip");
			
			FileUtilsExpand.forceDeleteOnExit(outFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"z.zip");		
	}	
		
	/**
	 * 功能：批量文摘下载 过程：从TRS服务器获取相应的文摘，根据文件类型生成相应中间文件，
	 * 返回客户端，删除所有产生的中间文件。
	 */
	public File createAbstractZip(String basePath, List<PatentInfo> patentList, String[] titles,
			String fileType, HttpServletResponse response, String area,
			int userId, String userName, String userIp, int feeType) {
//		StringBuffer anBuf = new StringBuffer();
//		StringBuffer dbBuf = new StringBuffer();
		
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFolderName =basePath+File.separator + tempName;
		File outFile = new File(temFolderName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		
		try{
			ArrayList<String> fileNames = createTempFile(patentList, titles, fileType,temFolderName);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
//			FileUtilsExpand.zip(temFolderName+"\\"+tempName+".xls", temFolderName+"z.zip");
			
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip
//			FileUtilsExpand.zip(temFileName, temFileName+"z.zip");
			
			FileUtilsExpand.zip(temFolderName, temFolderName+"z.zip");
			
			FileUtilsExpand.forceDeleteOnExit(outFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"z.zip");		
	}
	
	public File createAnalyseTableZip(String basePath, String[][] arr) {
//		StringBuffer anBuf = new StringBuffer();
//		StringBuffer dbBuf = new StringBuffer();
		
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFolderName =basePath+File.separator + tempName;
		File outFile = new File(temFolderName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		
		try{
			ArrayList<String> fileNames = createAnalyseTempFile(arr,temFolderName);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
//			FileUtilsExpand.zip(temFolderName+"\\"+tempName+".xls", temFolderName+"z.zip");
			
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168b
//			E:\develop\Tomcat\workspace\.metadata\.me_tcat\webapps\ipss\tempfile\4b662437-8659-4395-b1c7-2a540ba2168bz.zip
//			FileUtilsExpand.zip(temFileName, temFileName+"z.zip");
			
			FileUtilsExpand.zip(temFolderName, temFolderName+"z.zip");
			
			FileUtilsExpand.forceDeleteOnExit(outFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new File(tempName+"z.zip");		
	}
	
	//String basePath = request.getSession().getServletContext().getRealPath("tempfile");
	public void batchdownloadZip(String basePath,List<PatentInfo> patentList, String[] titles,
			String fileType, HttpServletResponse response, String area,
			int userId, String userName, String userIp, int feeType) {
		StringBuffer anBuf = new StringBuffer();
		StringBuffer dbBuf = new StringBuffer();

		/*for (PatentInfo patent : patentList) {
			anBuf.append(patent.getAn() + ",");
			dbBuf.append(patent.getSectionName() + ",");
		}
		String strWhere = anBuf.substring(0, anBuf.length() - 1);
		String strSources = dbBuf.substring(0, dbBuf.length() - 1);*/
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFolderName =basePath+File.separator + tempName;
		File outFile = new File(temFolderName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		
		boolean isGetPages = false;
		if (area.equals("0")) {
			isGetPages = true;
		}
		
		try {
			//patentList = searchFunc.executeSearch(strSources, "申请号=(" + strWhere + ")", false, isGetPages);
		} catch (Exception e1) {
			CniprLogger.LogError("DownloadFunc -> downloadZip error: " + e1.getMessage());
		}

		try {
			//fileNames = E:/develop/Tomcat/workspace/.metadata/.me_tcat/webapps/ipss//temp/1431b046-ff29-42c0-96c3-8f4e53f31b77.xls
			ArrayList<String> fileNames = createTempFile(patentList, titles,fileType,temFolderName);
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			// String[] s =
			// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
	//		this.fireEvent(new CniprEvent(this, true, false, userId, "", Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, patentList.size(),
	//				userIp, feeType));
//			// 触发监听事件
//			this.fireEvent(new CniprEvent(this, true, false, patentList,
//					userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
//					0, userIp, feeType));
		} catch (RowsExceededException e) {
			e.printStackTrace();
		} catch (WriteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	/**
	 * 功能：文摘下载 过程：从TRS服务器获取相应的文摘，根据文件类型生成相应中间文件，
	 * 返回客户端，删除所有产生的中间文件。
	 */
	public void downloadZip(String wap,String basePath,List<PatentInfo> patentList, String[] titles,
			String fileType, HttpServletResponse response, String area,
			int userId, String userName, String userIp, int feeType) {
		StringBuffer anBuf = new StringBuffer();
		StringBuffer dbBuf = new StringBuffer();

		for (PatentInfo patent : patentList) {
			anBuf.append("(申请号="+patent.getAn() + " and 公开（公告）日="+patent.getPd()+") or ");
			dbBuf.append(patent.getSectionName() + ",");			 
		}
		String strWhere = anBuf.substring(0, anBuf.length() - 3);
		String strSources = dbBuf.substring(0, dbBuf.length() - 1);

		boolean isGetPages = false;
		if (area.equals("0")) {
			isGetPages = true;
		}
		
		String tempName = UUID.randomUUID().toString();    //临时文件夹的名字
		File tempFile = new File(basePath);
		if(!tempFile.exists()){
			tempFile.mkdirs();
		}
		
		String temFolderName =basePath+File.separator + tempName;
		File outFile = new File(temFolderName);  			   //这里临时产生一个 文件夹
		if (!outFile.exists()) {
			outFile.mkdirs();
		}
		

		//System.out.println("strWhere="+strWhere);
/*		try {
			OverviewSearchResponse overviewResponse = searchFunc.overviewSearch(wap, strSources,
					  strWhere  , "RELEVANCE", "", "",
					2, 115, false,
					0, 5000, "", "");
			if(overviewResponse!=null)
			patentList = overviewResponse.getPatentInfoList();
			patentList = searchFunc.executeSearch(strSources, "申请号=("
			+ strWhere + ")", false, isGetPages);  
		} catch (Exception e1) {
			CniprLogger.LogError("DownloadFunc -> downloadZip error: "
					+ e1.getMessage());
		}*/

		try {
			ArrayList<String> fileNames = createTempFile(patentList, titles,
					fileType,temFolderName);
			// 实例初始化
			JspFileDownload jfd = new JspFileDownload();
			// 设定response对象。
			jfd.setResponse(response);
			// 设定下载模式 1 多文件压缩成ZIP文件下载。
			jfd.setDownType(1);
			// 设定显示的文件名
			jfd.setDisFileName(UUID.randomUUID().toString() + ".zip");
			// 设定要下载的文件的路径（数组，绝对路径）
			// String[] s =
			// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
			jfd.setZipFileNames(fileNames);
			// 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
			jfd.setZipDelFlag(true);
			// 设定zip文件暂时保存的路径 （是文件夹）
			jfd.setZipFilePath(tempFilePath);
			// 主处理函数 注意返回值
			jfd.process();
	//		this.fireEvent(new CniprEvent(this, true, false, userId, "", Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, patentList.size(),
	//				userIp, feeType));
//			// 触发监听事件
//			this.fireEvent(new CniprEvent(this, true, false, patentList,
//					userId, userName, Constant.AUTH_FUNC_ABSTRACT_DOWNLOAD, 0,
//					0, userIp, feeType));
		} catch (RowsExceededException e) {
			e.printStackTrace();
		} catch (WriteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	base64字符串转化成图片
	private static String GenerateImage(String temFolderName,String imgStr) { // 对字节数组字符串进行Base64解码并生成图片		
		String pngName = temFolderName + "\\" + UUID.randomUUID().toString() + ".png";		
//		String imgFilePath = "c://222.png";// 新生成的图片
//		if (imgStr == null) // 图像数据为空
//			return false;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			// Base64解码
			byte[] b = decoder.decodeBuffer(imgStr.replace("data:image/png;base64,", ""));
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// 调整异常数据
					b[i] += 256;
				}
			}
			// 生成png图片
			
			OutputStream out = new FileOutputStream(pngName);
			out.write(b);
			out.flush();
			out.close();
		} catch (Exception e) {
		}
		
		return pngName;
	}

	private ArrayList<String> createPNGTempFile(String dataUrl, String temFolderName) throws RowsExceededException,
			WriteException, IOException {
		ArrayList<String> fileNames = new ArrayList<String>();

//		if (fileType.equals("0")) {
//			fileNames.add(createXls(patentList, titles, temFolderName));
//		} else if (fileType.equals("1")) {
//			fileNames.add(createTxt(patentList, titles, temFolderName));
//		}
		
		fileNames.add(GenerateImage(temFolderName, dataUrl));
		
		return fileNames;
	}
	/**
	 * 功能：文摘下载中间文件生成
	 */
	private ArrayList<String> createTempFile(List<PatentInfo> patentList,
			String[] titles, String fileType, String temFolderName) throws RowsExceededException,
			WriteException, IOException {
		ArrayList<String> fileNames = new ArrayList<String>();

		if (fileType.equals("0")) {
			fileNames.add(createXls(patentList, titles, temFolderName));
		} else if (fileType.equals("1")) {
			fileNames.add(createTxt(patentList, titles, temFolderName));
		}
		
		return fileNames;
	}
	
	private ArrayList<String> createAnalyseTempFile(String[][] arr, String temFolderName) throws RowsExceededException,
			WriteException, IOException {
		ArrayList<String> fileNames = new ArrayList<String>();

/*		if (fileType.equals("0")) {
			fileNames.add(createAnalyseXls(arr, temFolderName));
		} else if (fileType.equals("1")) {
			fileNames.add(createTxt(patentList, titles, temFolderName));
		}
*/		
		fileNames.add(createAnalyseXls(arr, temFolderName));

		return fileNames;
	}

	/**
	 * 功能：法律状态下载中间文件生成
	 */
	private ArrayList<String> createLawStatusTempFile(List<LegalStatusInfo> legalStatusInfoList) throws RowsExceededException,
			WriteException, IOException {
			ArrayList<String> fileNames = new ArrayList<String>(); 
			fileNames.add(createLawStatusXls(legalStatusInfoList)); 
		return fileNames;
	}
	
	/**
	 * 功能：文摘下载中间文件（xsl）生成
	 */
	private String createXls(List<PatentInfo> patentList, String[] titles,String temFolderName)
			throws IOException, RowsExceededException, WriteException {
		
//		tempFilePath = "G:/movie/";
//		String xlsName = tempFilePath + UUID.randomUUID().toString() + ".xls";
		String xlsName = temFolderName + "\\" + UUID.randomUUID().toString() + ".xls";
		
		try{
			WritableWorkbook book = Workbook.createWorkbook(new File(xlsName));
			int row = 0;
			// 写工作表名字
			WritableSheet sheet = book.createSheet("著录项", 0);
			// 增加工作表表头
			for (int column = 0; column < titles.length; column++) {
				sheet.addCell(new Label(column, row, titles[column]));
			}
	
			for (PatentInfo info : patentList) {
				row++;
				int col = 0;
				for (String title : titles) {
//					System.out.println(title);
					String content = info.getInfoByName(title)==null?"":info.getInfoByName(title);
					
					book.getSheet(0).addCell(
							new Label(col++, row, content.replace("<font style='color:red'>", "").replace("</font>", "")));
				}
			}
			if (book != null) {
				try {
					book.write();
					book.close();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (WriteException e) {
					e.printStackTrace();
				}
			}
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return xlsName;
	}

	private String createAnalyseXls(String[][] arr,String temFolderName)
			throws IOException, RowsExceededException, WriteException {
		
//		tempFilePath = "G:/movie/";
//		String xlsName = tempFilePath + UUID.randomUUID().toString() + ".xls";
		String xlsName = temFolderName + "\\" + UUID.randomUUID().toString() + ".xls";
		
		try{			
			WritableWorkbook book = Workbook.createWorkbook(new File(xlsName));
			int row = 0;
			// 写工作表名字
			WritableSheet sheet = book.createSheet("著录项", 0);
//			增加工作表表头
/*			for (int column = 0; column < titles.length; column++) {
				sheet.addCell(new Label(column, row, titles[column]));
			}
	
			for (PatentInfo info : patentList) {
				row++;
				int col = 0;
				for (String title : titles) {
					book.getSheet(0).addCell(
							new Label(col++, row, info.getInfoByName(title).replace("<font style='color:red'>", "").replace("</font>", "")));
				}
			}*/
			
			for(int i=0;i<arr.length;i++) {				
				int col = 0;
				for(int j=0;j<arr[i].length;j++) {
					book.getSheet(0).addCell(
							new Label(col++, row, arr[i][j]));
				}
				row++;
			}
			
			if (book != null) {
				try {
					book.write();
					book.close();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (WriteException e) {
					e.printStackTrace();
				}
			}
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return xlsName;
	}
	
	/**
	 * 功能： 法律状态下载中间文件（xsl）生成
	 */
	private String createLawStatusXls(List<LegalStatusInfo> legalStatusInfoList)
			throws IOException, RowsExceededException, WriteException {
		
		String xlsName =tempFilePath
				+ UUID.randomUUID().toString() + ".xls";
		WritableWorkbook book = Workbook.createWorkbook(new File(xlsName));
		int row = 0;
		// 写工作表名字
		WritableSheet sheet = book.createSheet("法律状态项", 0);
		// 增加工作表表头
		//for (int column = 0; column < titles.length; column++) {
			sheet.addCell(new Label(0, row, "申请号"));
			sheet.addCell(new Label(1, row, "法律状态公告日"));
			sheet.addCell(new Label(2, row, "法律状态"));
			sheet.addCell(new Label(3, row, "法律状态信息"));
		//}

		 for (LegalStatusInfo info : legalStatusInfoList) {
			row++;
			int col = 0; 
				book.getSheet(0).addCell(new Label(0, row, info.getStrAn() ));
				book.getSheet(0).addCell(new Label(1, row, info.getStrLegalStatusDay() ));
				book.getSheet(0).addCell(new Label(2, row, info.getStrLegalStatus() ));
				book.getSheet(0).addCell(new Label(3, row, info.getStrStatusInfo() ));
		 	 
		} 
		if (book != null) {
			try {
				book.write();
				book.close();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (WriteException e) {
				e.printStackTrace();
			}
		}
		return xlsName;
	}
	
	/**
	 * 功能：文摘下载中间文件（txt）生成
	 */
	private String createTxt(List<PatentInfo> patentList, String[] titles,String temFolderName) {
		String txtName = tempFilePath
				+ UUID.randomUUID().toString() + ".txt";
		StringBuffer sb = new StringBuffer();
		if(patentList!=null)
		for (PatentInfo info : patentList) {
			sb.append("<REC>\r\n");
			for (String title : titles) {
				String biaoti = "";
				if(info.getInfoByName(title)!=null)
					biaoti = info.getInfoByName(title).replaceAll("<br>", "\n");
				sb.append("<" + title + ">="
						+ biaoti
						+ "\r\n");
			}
			sb.append("\r\n");
		}

		try {
			File tempTxt = new File(txtName);
			DataOutputStream outs = new DataOutputStream(new FileOutputStream(
					tempTxt));
			outs.write(sb.toString().getBytes("GBK"));
			// outs.write(bb);
			outs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return txtName;
	}

	/**
	 * 功能：代码化下载中间文件生成
	 */
	public boolean createTempFile(String xmlContent, String des) {
		File desFile;
		desFile = new File(des);
		FileOutputStream fos = null;

		try {
			desFile.createNewFile();
			fos = new FileOutputStream(desFile);
			fos.write(xmlContent.getBytes("UTF-8"));
			// int bytesRead;
			// byte[] buf = new byte[4 * 1024]; // 4K buffer
			// while ((bytesRead = fis.read(buf)) != -1) {
			// fos.write(buf, 0, bytesRead);
			// }
			fos.flush();
			fos.close();
		} catch (IOException e) {
			System.out.println(e);
			return false;
		}
		return true;
	}
	
	
	
	public boolean downLoadFile(String filePath,
		    HttpServletResponse response, String fileName, String fileType)
		    throws Exception {
		    File file = new File(filePath);//根据文件路径获得File文件
		    //设置文件类型(这样设置就不止是下Excel文件了，一举多得)
		    if("pdf".equals(fileType)){
		       response.setContentType("application/pdf;charset=GBK");
		    }else if("xls".equals(fileType)){
		       response.setContentType("application/msexcel;charset=GBK");
		    }else if("doc".equals(fileType)){
		       response.setContentType("application/msword;charset=GBK");
		    }
		    //文件名
//		    response.setHeader("Content-Disposition", "attachment;filename=""+
//		          new String(fileName.getBytes(), "ISO8859-1")+ """);
		    
		    response.setHeader("Content-Disposition","attachment; filename="+fileName+";");
		    
		    response.setContentLength((int) file.length());
		    byte[] buffer = new byte[4096];// 缓冲区
		    BufferedOutputStream output = null;
		    BufferedInputStream input = null;
		    try {
		        output = new BufferedOutputStream(response.getOutputStream());
		        input = new BufferedInputStream(new FileInputStream(file));
		        int n = -1;
		        //遍历，开始下载
		        while ((n = input.read(buffer, 0, 4096)) > -1) {
		            output.write(buffer, 0, n);
		        }
		        output.flush();   //不可少
		        response.flushBuffer();//不可少
		    } catch (Exception e) {
		        //异常自己捕捉       
		    } finally {
		        //关闭流，不可少
		        if (input != null)
		            input.close();
		        if (output != null)
		           output.close();
		    }
		    return false;
		}
	
	/**
	 * 
	 */
	public void downloadDocument(int intUserId, int downloadCount, String strUserIp, boolean isDeducte) {
		 
//		String funcName = Constant.AUTH_FUNC_DOC_DOWNLOAD;
//		if (isDeducte) {
//			funcName = Constant.AUTH_FUNC_DOC_BATCHDOWNLOAD;
//		}
//		this.fireEvent(new CniprEvent(this, true, false, intUserId, "", Constant.AUTH_FUNC_DOC_DOWNLOAD, downloadCount,
//				strUserIp, 0));
	}
	// public void downloadUserStatisticXsl(String[][] arrStatistic, String[]
	// titles,
	// String fileType, HttpServletResponse response, boolean isGetPages) {
	// StringBuffer anBuf = new StringBuffer();
	// StringBuffer dbBuf = new StringBuffer();
	//		
	// try {
	// ArrayList<String> fileNames = createTempFile(patentList, titles,
	// fileType);
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
	// //
	// {"D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\111.txt","D:\\tools\\develop\\Tomcat6\\webapps\\cniprGZnew\\temp\\222.txt"};
	// jfd.setZipFileNames(fileNames);
	// // 设定服务器端生成的zip文件是否保留。 true 删除 false 保留，默认为false
	// jfd.setZipDelFlag(true);
	// // 设定zip文件暂时保存的路径 （是文件夹）
	// jfd.setZipFilePath(DataAccess.getProperty("tempFilePath"));
	// // 主处理函数 注意返回值
	// jfd.process();
	// } catch (RowsExceededException e) {
	// e.printStackTrace();
	// } catch (WriteException e) {
	// e.printStackTrace();
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }

	// public void run() {
	// this.download(url, filePath, fileName);
	// }
	//	
	// public FileSplitterFetch getDownloadInfo()
	// {
	// HttpSession req = WebContextFactory.get().getSession();
	//        
	// System.out.println(WebContextFactory.get().getHttpServletRequest().getAttribute("testrequest"));
	//
	// if (req.getAttribute("downloadInfo") != null)
	// return (FileSplitterFetch) req.getAttribute("downloadInfo");
	// else
	// return new FileSplitterFetch();
	// }

	// public String getFileName() {
	// return fileName;
	// }
	//
	// public void setFileName(String fileName) {
	// this.fileName = fileName;
	// }
	//
	// public String getFilePath() {
	// return filePath;
	// }
	//
	// public void setFilePath(String filePath) {
	// this.filePath = filePath;
	// }
	//
	// public String getUrl() {
	// return url;
	// }
	//
	// public void setUrl(String url) {
	// this.url = url;
	// }
}
