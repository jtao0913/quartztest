package com.cnipr.cniprgz.func.search;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.cnipr.cniprgz.client.CoreBizClient;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.func.AbsCniprFunc;
import com.cnipr.cniprgz.func.download.HttpGet;
import com.cnipr.cniprgz.func.xml.NoOpEntityResolver;
import com.cnipr.cniprgz.func.xml.XMLContentProcess;
import com.cnipr.cniprgz.struts.action.SearchAction;
import com.cnipr.corebiz.search.entity.DataScopeInfo;
//import com.cnipr.corebiz.search.entity.GBIndex;
//import com.cnipr.corebiz.search.entity.GBSWIndex;
import com.cnipr.corebiz.search.entity.LegalStatusInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.cnipr.corebiz.search.ws.response.LegalStatusResponse;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.cnipr.corebiz.search.ws.response.ParticipleSearchResponse;
import com.cnipr.corebiz.search.ws.response.SynonymSearchResponse;
import com.cnipr.corebiz.search.ws.service.ICoreBizFacade;

public class SearchFunc extends AbsCniprFunc {

	String strGif_Tif = "GIF|gif|tif|TIF";
	/*
	public GBIndex getGBIndex(String an, String pd) throws Exception {
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(3);
		try {
			return client.getGBIndex(an, pd);

		} catch (Exception e) {
			throw e;
		}
	}
	
	public GBSWIndex getGBSWIndex(String an, String pd) throws Exception {
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(3);
		try {
			return client.getGBSWIndex(an, pd);
		} catch (Exception e) {
			throw e;
		}
	}
*/
	public void writeXML(String xml_path, String an,String type, String xmlcontent){
		try {
//			D:\ben\morningreport
		     File file = new File(xml_path + "\\" + type + "_" + an + ".xml");
		     if(!file.exists()) {
			     FileOutputStream fos = new FileOutputStream(file);
			     OutputStreamWriter osw = new OutputStreamWriter(fos,"UTF-8");
			     BufferedWriter bw = new BufferedWriter(osw);
			     
			     bw.write(xmlcontent);
	//		     bw.newLine();
			     
			     bw.flush();
			     bw.close();
			     osw.close();
			     fos.close();
		     }
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
	
	public List<DataScopeInfo> dataScopeSearch() throws Exception {
		List<DataScopeInfo> dataScope = null;
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(1);
		try {
			dataScope = client.getDataScope();
		} catch (Exception e) {
			dataScope = null;
			throw e;
		}
		return dataScope;
	}
	
	@SuppressWarnings("unchecked")
	public String replaceInnerPICXML111111111111(String tmpString,String patent_type, String strAN, String strPD) {

		String strANShort = strAN;
		if (Integer.parseInt(strPD.substring(0, 4)) < 1989) {
			if (strAN.indexOf(".") > -1) {
				strANShort = strAN.substring(0, strAN.indexOf("."));
			}
		}
		strANShort = strANShort.toUpperCase().replace("CN", "");

//		String strRenderInnerXMLPath = rootPath + "/xml/RenderInnerXML";
//		System.out.println("patent_type----:"+patent_type);
/*		if(patent_type!=null&&"sq".equalsIgnoreCase(patent_type)){
			ICoreBizFacade client = CoreBizClient.getCoreBizClient(2);
			DetailSearchResponse detailResponse=null;
			try {
				detailResponse = client.executeDetailSearch("fmsq_ft","an="+strAN,"","","",2,115,false,0,"");
			} catch (Exception e) {
				e.printStackTrace();
			}
			strPD=detailResponse.getPatentInfo().getPd().replace(".", "");
 			//System.out.println(detailResponse.getPatentInfo().getSqTifPath());
//			System.out.println(strPD);
		}else{
			ICoreBizFacade client = CoreBizClient.getCoreBizClient(2);
			DetailSearchResponse detailResponse=null;
			try {
				detailResponse = client.executeDetailSearch("fmzl_ft,syxx_ft","an="+strAN,"","","",2,115,false,0,"");
			} catch (Exception e) {
				e.printStackTrace();
			}
			strPD=detailResponse.getPatentInfo().getPd().replace(".", "");
		}*/
		
//		String strInnerXMLPath = patent_type + "\\" + strPD + "\\" + strANShort;

		Pattern pattern = Pattern.compile("file=\"[^\u4e00-\u9fa5]+." + strGif_Tif + "\"");
		Matcher matcher = pattern.matcher(tmpString);

		List strList = new ArrayList();
		if (matcher.find()) {
			/*******************************************************************************/
			pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif + ")\")+");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				String strImgName = matcher.group().substring(
						"file=\"".length(), matcher.group().lastIndexOf("\""));
				String picURL = patent_type + "/"
						+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
						+ strImgName;
				if(SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE)!=null && SetupAccess.getProperty(SetupConstant.XMLFUTUTYPE).equals("gif") )					
				{		
					picURL = picURL.replace("TIF", "gif");
					picURL = picURL.replace("tif", "gif");
					strImgName = strImgName.replace("TIF", "gif").replace("tif", "gif");
				}
//				System.out.println("strImgName----:"+picURL);
/*				if (httpGetInstance != null) {
					// 这里如果是与IIS数据同机房的一定要用内网地址，否则下不了数据
					httpGetInstance.addItem(DataAccess.getProperty("XMLIntranetServerURL") + patent_type + "/"
							+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
							+ strImgName, strImgName);
				}
*/				
				String result = "file=\"" + picURL + "\"";
//				 System.out.println("result---::"+result);
				strList.add(tmpString.substring(end, matcher.start()));
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			tmpString = tmpString + old.substring(end);

		}
		/** *************************************************************************** */
		strList = new ArrayList();
/*
		pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(.xml|XML)\")+");
		matcher = pattern.matcher(tmpString);

		int end = 0;
		while (matcher.find()) {
			String xml = matcher.group().substring("file=\"".length(),
					matcher.group().lastIndexOf("\""));
			String result = "file=\"" + strRenderInnerXMLPath + "?path="
					+ strInnerXMLPath + "&amp;xml=" + xml + "\"";
			// System.out.println(result);
			strList.add(tmpString.substring(end, matcher.start()));
			strList.add(result);
			end = matcher.end();
		}
		String old = tmpString;
		tmpString = "";
		for (int i = 0; i < strList.size(); i++) {
			tmpString += (String) strList.get(i);
		}
		tmpString = tmpString + old.substring(end);
*/
		return tmpString;
	}
	

	
	public OverviewSearchResponse overviewSearch(String wap,String strSources,
			String strWhere, String strSortMethod, String hangye_analyse_id,
			String strDefautCols, int xAxisSize, int yAxisSize,
			boolean b_reverse, long startIndex, long endIndex,
			String filterChannel, String SearchType) throws Exception {
		OverviewSearchResponse overviewResponse = null;
		
		strWhere = strWhere.replace("快速检索=","申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
		strWhere = strWhere.replace("语义检索=","主权项语义,摘要语义+=");
		
//		"主权项语义,摘要语义+=", "语义检索="
		
//		strSynonymous = "SYNONYM_UTF8";
		
		int isFR = 0;
		if(strSources.indexOf("patent")>-1){
			isFR = 1;
		}
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
//		if(isFR==1)
//			url = DataAccess.getProperty("SearchServerUrl_fr");
//		if(isFR==2)
//			url = DataAccess.getProperty("SearchServerUrl_xml");
//		if(isFR==3)
//			url = DataAccess.getProperty("SearchServerUrl_gb");
		long begin;
		long end;
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
		try {
/*			Date now1 = new Date();
		    SimpleDateFormat ft = new SimpleDateFormat ("yyyy.MM.dd hh:mm:ss");
		    System.out.println("开始时间: " + ft.format(now1));
*/			
			overviewResponse = client.executeOutlineSearch(strSources,
					strWhere, strSortMethod, hangye_analyse_id, strDefautCols, xAxisSize,
					yAxisSize, b_reverse, startIndex, endIndex,
					filterChannel, SearchType+"");
/*			
			Date now2 = new Date( );
		    System.out.println("结束时间: " + ft.format(now2)+"......"+overviewResponse.getPatentInfoList().size()+"条");
*/		
//			end = System.currentTimeMillis();
//			System.out.println("end......"+end);			
//			System.out.println(begin+"......"+overviewResponse.getPatentInfoList().size()+"条......"+ end + "........."+countTime(begin,end));
			
		} catch (Exception e) {
			overviewResponse = null;
			throw e;
		}
		return overviewResponse;
	}
	
	public String replaceInnerPICXML(String chrFigureVirtualPath ,String patent_type,String tmpString, String strAN, String strPD) {
		tmpString = tmpString.trim();
		
		String xml_type = "";
		if(tmpString.indexOf("<description>")>-1) {
			xml_type = "ft";
		}else if(tmpString.indexOf("<claims>")>-1) {
			xml_type = "clm";
		}else if(tmpString.indexOf("<drawings>")>-1) {
			xml_type = "dra";
		}
		
		
		String strGif_Tif = "GIF|TIF|gif|tif";
		String strANShort = strAN;
		if (Integer.parseInt(strPD.substring(0, 4)) < 1989) {
			if (strAN.indexOf(".") > -1) {
				strANShort = strAN.substring(0, strAN.indexOf("."));
			}
		}
		strANShort = strANShort.toUpperCase().replace("CN", "");

		int figure_num = 0;
		
//		String strRenderInnerXMLPath = rootPath + "/xml/RenderInnerXML";
		String strInnerXMLPath = patent_type + "\\" + strPD.substring(0, 10) + "\\" + strANShort;

		Pattern pattern = Pattern.compile("file=\"[^\u4e00-\u9fa5]+." + strGif_Tif + "\"");
		Matcher matcher = pattern.matcher(tmpString);
		
		List<String> strList = new ArrayList<String>();
		if (matcher.find()){
			/******************************************************************************/
			pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif + ")\")+");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				String strImgName = matcher.group().substring(
						"file=\"".length(), matcher.group().lastIndexOf("\""));
				String picURL = chrFigureVirtualPath + patent_type + "/"
						+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
						+ strImgName;
				picURL = picURL.replace("TIF", "gif");
				picURL = picURL.replace("tif", "gif");
				strImgName = strImgName.replace("TIF", "gif").replace("tif", "gif");
//				if (httpGetInstance != null) {
//					// 这里如果是与IIS数据同机房的一定要用内网地址，否则下不了数据
//					httpGetInstance.addItem(DataAccess.getProperty("XMLIntranetServerURL") + patent_type + "/"
//							+ strPD.substring(0, 10).replaceAll("\\.", "") + "/" + strANShort + "/"
//							+ strImgName, strImgName);
//				}
//				System.out.println(strImgName);
//				说明书附图路径错误
//				String result = "file=\"" + strImgName.replace("TIF", "gif").replace("tif", "gif") + "\"";//错误的代码，不知原因
				String result = "file=\"" +picURL+ "\"";
//				 System.out.println(result);
				
				String prestr = tmpString.substring(end, matcher.start());
				
/*				Pattern _pattern = Pattern.compile("figure-labels=\"图[0-9]+\"");
				Matcher _matcher = _pattern.matcher(prestr);
				String _ImgName = "";
				if (_matcher.find()) {
					_ImgName = _matcher.group();
					_ImgName = _ImgName.replace("figure-labels=", "").replace("\"", "");
				}
*/
				if(xml_type.equals("dra")) {
					prestr = prestr.substring(0, prestr.indexOf("<img")) 
						+ "<a class=\"fancybox\" href=\""+picURL+"\" rel=\"group\">" 
						+ prestr.substring(prestr.indexOf("<img"));
					
					if(prestr.indexOf("</figure>")>-1) {
						figure_num++;
						prestr = prestr.replace("</figure>", "</figure><div style=\"text-align:center\">图"+figure_num+"</div>");
					}
				}
/*				if(xml_type.equals("dra")&&prestr.indexOf("</figure>")>-1) {
					figure_num++;
					prestr = prestr.replace("</figure>", "</figure>"+"图"+figure_num);
				}*/
				
				strList.add(prestr);
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			
			String remaining = old.substring(end);
//			xml_type = "dra";
			if(xml_type.equals("dra")&&remaining.indexOf("</figure>")>-1) {
				figure_num++;
				remaining = remaining.replace("</figure>", "</figure><div style=\"text-align:center\">图"+figure_num+"</div>");
			}
			tmpString = tmpString + remaining;
		}
		if(xml_type.equals("dra")) {
			tmpString = tmpString.replace("</figure>", "</a></figure>");
		}
		/*****************************************************/
/*		if(tmpString.indexOf("</figure>")>-1) {
			String[] arr = tmpString.split("</figure>");
			tmpString = "";
			for(int i=0;i<arr.length-1;i++) {
				tmpString+=arr[i] + "图"+ (i+1) + "</figure>";
			}
			tmpString+=arr[arr.length-1];
		}*/
		
//		System.out.println(tmpString);
		/******************************************************************************/
//		wi="281" he="66"
//		pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif + ")\")+");
		
		pattern = Pattern.compile("[wi]{2}[=]{1}[\"]{1}[0-9]+[\"]{1}");
		matcher = pattern.matcher(tmpString);
		
		strList = new ArrayList();
		if (matcher.find()) {
			pattern = Pattern.compile("[wi]{2}[=]{1}[\"]{1}[0-9]+[\"]{1}");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				int imgwidth = 0;
				String strImgWidth = matcher.group().substring(
						"wi=\"".length(), matcher.group().lastIndexOf("\""));				
				if(strImgWidth==null||strImgWidth.equals("")) {
					strImgWidth="100";
				}
				
				if((Integer.parseInt(strImgWidth))>390) {
					imgwidth = 390;
				}else {
					imgwidth = Integer.parseInt(strImgWidth);
				}
				
//				String result = "width=\"" +(new Float((Integer.parseInt(strImgWidth))*0.8)).intValue()+ "\"";
				String result = "width=\"" +imgwidth+ "\"";
//				 System.out.println(result);
				strList.add(tmpString.substring(end, matcher.start()));
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			tmpString = tmpString + old.substring(end);
		}
		/******************************************************************************/
//		wi="281" he="66"
		pattern = Pattern.compile("[he]{2}[=]{1}[\"]{1}[0-9]+[\"]{1}");
		matcher = pattern.matcher(tmpString);
		
		strList = new ArrayList();
		if (matcher.find()) {
			pattern = Pattern.compile("[he]{2}[=]{1}[\"]{1}[0-9]+[\"]{1}");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				String strImgName = matcher.group().substring(
						"he=\"".length(), matcher.group().lastIndexOf("\""));
//				String result = "height=\"" +(new Float((Integer.parseInt(strImgName))*0.8)).intValue()+ "\"";
				String result = "";
//				 System.out.println(result);
				strList.add(tmpString.substring(end, matcher.start()));
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			tmpString = tmpString + old.substring(end);
		}
		/** *************************************************************************** */
		/*
		pattern = Pattern.compile("src=\"[^\u4e00-\u9fa5]+." + strGif_Tif + "\"");
		matcher = pattern.matcher(tmpString);
		
		strList = new ArrayList();
		if (matcher.find()) {
			pattern = Pattern.compile("(src=\"[^\u4e00-\u9fa5]+?(."
					+ strGif_Tif + ")\")+");
			matcher = pattern.matcher(tmpString);
			int end = 0;
			while (matcher.find()) {
				String strImgName = matcher.group().substring(
						"src=\"".length(), matcher.group().lastIndexOf("\""));
				String picURL = chrFigureVirtualPath + patent_type + "/"
						+ strPD.replaceAll("\\.", "") + "/" + strANShort + "/"
						+ strImgName;
				picURL = picURL.replace("TIF", "gif");
				picURL = picURL.replace("tif", "gif");
				strImgName = strImgName.replace("TIF", "gif").replace("tif", "gif");
//				if (httpGetInstance != null) {
//					// 这里如果是与IIS数据同机房的一定要用内网地址，否则下不了数据
//					httpGetInstance.addItem(DataAccess.getProperty("XMLIntranetServerURL") + patent_type + "/"
//							+ strPD.substring(0, 10).replaceAll("\\.", "") + "/" + strANShort + "/"
//							+ strImgName, strImgName);
//				}
//				System.out.println(strImgName);
				//说明书附图路径错误
//				String result = "file=\"" + strImgName.replace("TIF", "gif").replace("tif", "gif") + "\"";//错误的代码，不知原因
				String result = "src=\"" +picURL+ "\"";
//				 System.out.println(result);
				strList.add(tmpString.substring(end, matcher.start()));
				strList.add(result);
				end = matcher.end();
			}
			String old = tmpString;
			tmpString = "";
			for (int i = 0; i < strList.size(); i++) {
				tmpString += (String) strList.get(i);
			}
			tmpString = tmpString + old.substring(end);
		}
		*/
//		System.out.println(tmpString);
		/** *************************************************************************** */
		strList = new ArrayList();
		
		pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(.xml|XML)\")+");
		matcher = pattern.matcher(tmpString);
		
		int end = 0;
		while (matcher.find()) {
			String xml = matcher.group().substring("file=\"".length(),
					matcher.group().lastIndexOf("\""));
//			String result = "file=\"" + strRenderInnerXMLPath + "?path="
//					+ strInnerXMLPath + "&amp;xml=" + xml + "\"";
//			System.out.println("0000000");
//			 System.out.println(result);
			strList.add(tmpString.substring(end, matcher.start()));
//			strList.add(result);
			end = matcher.end();
		}
		String old = tmpString;
		tmpString = "";
		for (int i = 0; i < strList.size(); i++) {
			tmpString += (String) strList.get(i);
		}
		tmpString = tmpString + old.substring(end);

		return tmpString;
	}
/*
	public OverviewSearchResponse batchDownload(String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long startIndex, long endIndex,
			String filterChannel, String strSynonymous) throws Exception {
		OverviewSearchResponse overviewResponse = null;

		int isFR = 0;
		if(strSources.indexOf("patent")>-1){
			isFR = 1;
		}
		
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
		try {
			overviewResponse = client.batchDownload(strSources, strWhere,
					strSortMethod, strStat, strDefautCols, iOption,
					iHitPointType, false, startIndex, endIndex, filterChannel,
					strSynonymous, "", "");

		} catch (Exception e) {
			overviewResponse = null;
			throw e;
		}
		return overviewResponse;
	}
*/
	public DetailSearchResponse detailSearch(String wap,String strSources,
			String strWhere, String strSortMethod, String strStat,
			String strDefautCols, int iOption, int iHitPointType,
			boolean bContinue, long recordCursor, String strSynonymous)
			throws Exception {
		
		strWhere = strWhere.replace("快速检索=","申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=");
		strWhere = strWhere.replace("语义检索=","主权项语义,摘要语义+=");
		
		int isFR = 0;
		if(strSources.indexOf("patent")>-1){
			isFR = 1;
		}
		
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
		DetailSearchResponse detailResponse = null;
		try {
			detailResponse = client.executeDetailSearch(strSources, strWhere,
					strSortMethod, strStat, strDefautCols, iOption,
					iHitPointType, false, recordCursor, "2");
			//			response.setPatentInfoList(patentInfoList);

		} catch (Exception e) {
//			System.out.println("***********************************************");
//			System.out.println(strWhere);
			detailResponse = null;
			throw e;
		}
		
		return detailResponse;
	}

	public List<PatentInfo> executeSearch(String wap, String strSources, String strWhere,
			boolean bContinue, boolean isGetPags) throws Exception {
		List<PatentInfo> patentInfoList = null;

		int isFR = 0;
		if(strSources.indexOf("patent")>-1){
			isFR = 1;
		}
		
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		try {
			patentInfoList = CoreBizClient.getCoreBizClient(isFR).executeSearch(
					strSources, strWhere, bContinue, isGetPags);
		} catch (Exception e) {
			patentInfoList = null;
			throw e;
		}
		
		return patentInfoList;
	}
/*
	public List<LegalStatusInfo> _lastestlegalStatusSearch(String strWhere,int size)
		throws Exception {
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(0);
		List<LegalStatusInfo> legalStatusInfoList = null;
		try {
			legalStatusInfoList = client.getLegalStatus(strWhere);
			
			Iterator<LegalStatusInfo> iter = legalStatusInfoList.iterator();
			while(iter.hasNext())
			{
				LegalStatusInfo legalstatusinfo = iter.next();
//				System.out.println(legalstatusinfo.getStrAn()+"----"+legalstatusinfo.getStrLegalStatusDay()+"----"+legalstatusinfo.getStrLegalStatus()+"----"+legalstatusinfo.getStrStatusInfo());
			}
//			System.out.println("------------------------------------------------------------------");
			
			legalStatusInfoList = client.getLegalStat(strWhere,0,size).getLegalStatusInfoList();
			
			iter = legalStatusInfoList.iterator();
			while(iter.hasNext())
			{
				LegalStatusInfo legalstatusinfo = iter.next();
				System.out.println(legalstatusinfo.getStrAn()+"----"+legalstatusinfo.getStrLegalStatusDay()+"----"+legalstatusinfo.getStrLegalStatus()+"----"+legalstatusinfo.getStrStatusInfo());
			}
			
		} catch (Exception e) {
			legalStatusInfoList = null;
			throw e;
		}
		return legalStatusInfoList;
	}
*/
	public List<LegalStatusInfo> legalStatusSearch(String wap, String strWhere)
			throws Exception {		
//		System.out.println(strWhere);
		
		int isFR = 0;
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
//		ICoreBizFacade client = CoreBizClient.getCoreBizClient(0);
		List<LegalStatusInfo> legalStatusInfoList = null;
		try {
			legalStatusInfoList = client.getLegalStatus(strWhere);
			
//			Iterator<LegalStatusInfo> iter = legalStatusInfoList.iterator();
//			while(iter.hasNext())
//			{
//				LegalStatusInfo legalstatusinfo = iter.next();
//				System.out.println(legalstatusinfo.getStrAn()+"----"+legalstatusinfo.getStrLegalStatusDay()+"----"+legalstatusinfo.getStrLegalStatus()+"----"+legalstatusinfo.getStrStatusInfo());
//			}
//			System.out.println("------------------------------------------------------------------");
//			
//			legalStatusInfoList = client.getLegalStat(strWhere,0,10).getLegalStatusInfoList();
//			
//			iter = legalStatusInfoList.iterator();
//			while(iter.hasNext())
//			{
//				LegalStatusInfo legalstatusinfo = iter.next();
//				System.out.println(legalstatusinfo.getStrAn()+"----"+legalstatusinfo.getStrLegalStatusDay()+"----"+legalstatusinfo.getStrLegalStatus()+"----"+legalstatusinfo.getStrStatusInfo());
//			}
			
		} catch (Exception e) {
			legalStatusInfoList = null;
			throw e;
		}
		return legalStatusInfoList;
	}

	public LegalStatusResponse legalStatusSearch(String wap, String strWhere, long startIndex, long endIndex) throws Exception {
		int isFR = 0;
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
		LegalStatusResponse response = null;
		try {
			response = client.getLegalStat(strWhere, startIndex, endIndex);
		} catch (Exception e) {
			response = null;
			throw e;
		}
		return response;
	}

	public byte[] getXmlDocument(String wap, String strSources, String strWhere,
			String column) throws Exception {
		
		int isFR = 0;
		if(wap!=null&&!wap.equals("")){
			isFR = 5;
		}
		
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(isFR);
		byte[] xmlByte = null;
		try {
			/*
			 * System.out.println(strSources); System.out.println(strWhere);
			 * System.out.println(column);
			 */
			xmlByte = client.getXmlDocument(strSources, strWhere, column);
		} catch (Exception e) {
			xmlByte = null;
			throw e;
		}
		return xmlByte;
	}

	public int getXmlTotalPage(String wap, String strSources, String an, String ft_type) throws Exception {
		int totalPage = 0;

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

		String column = "";
		String prefix = "";
		if (ft_type.equals("1")) {
			column = "权利要求书";
			prefix = "<claim ";
		} else if (ft_type.equals("2")) {
			column = "说明书";
			prefix = "<p ";
		} else if (ft_type.equals("3")) {
			column = "说明书附图";
			prefix = "<figure ";
		}

		String xmlContant = "";
		BufferedReader reader = null;

		InputStream src_is = null;
		try {
			src_is = new ByteArrayInputStream(getXmlDocument(wap,strSources,strWhere, column));
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			while (xmlContant != null) {
				xmlContant = xmlContant.trim();
				
//				System.out.println(xmlContant);
				
				if (xmlContant.indexOf(prefix) > -1) {
//					totalPage++;
					
//					System.out.println(totalPage);
//					System.out.println(xmlContant.indexOf(prefix));
//					System.out.println(xmlContant.substring(xmlContant.indexOf(prefix),xmlContant.indexOf(prefix)+1));
					
				    int offset = 0;
				    while((offset = xmlContant.indexOf(prefix, offset)) != -1){
				            offset = offset + prefix.length();
				            totalPage++;
				    }
				}
				
//				int cnt = 0;				
				xmlContant = reader.readLine();
			}
		} catch (UnsupportedEncodingException ex) {
//			e.printStackTrace();
			throw ex;
		} catch (IOException ex) {
//			e.printStackTrace();
			throw ex;
		} catch (Exception ex) {
//			e.printStackTrace();
			if(ex.getMessage()!=null&&ex.getMessage().equals("ErrorMessage:null")){
				totalPage = 0;
			}else{
			
			throw ex;
			}
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return totalPage;
	}

	// 需要重构
	// strCurrentPage当前页数（每页为原先文档的pageNum页），下标从0开始
	@SuppressWarnings( { "unchecked" })
	public List getXmlContant(String wap, String rootPath, String strSources, String an,
			String pd, String ft_type, String strCurrentPage, int clmPage,
			int desPage, int draPage, HttpGet httpGetInstance, int pageNum) {
		// strCurrentPage = "2";
		int intCurrentPage = (strCurrentPage != null && !strCurrentPage
				.equals("")) ? Integer.parseInt(strCurrentPage) : 0;
		// int CLM_Page = 15;
		// int DES_Page = 47;
		// int DRA_Page = 42;

		int int_start = intCurrentPage * pageNum + 1;
		int int_end = int_start + pageNum;
		int totalClmDes = clmPage + desPage;
		if (int_end > totalClmDes) {
			int_end = totalClmDes + 1;
		}
		List resultList = new ArrayList();
		if (ft_type.equals("1")) {

			if (int_end < clmPage) {
				if (int_end == int_start) {
					int_end++;
				}
				resultList = getXmlContant(wap, rootPath, strSources, an, pd,
						"<claims>", int_start, int_end, httpGetInstance);
			} else if (int_end == clmPage) {
				resultList = getXmlContantByType(wap, rootPath, strSources, an, pd,
						httpGetInstance, "claims");
			} else if (int_start > clmPage) {
				resultList = getXmlContant( wap, rootPath, strSources, an, pd,
						"<description>", int_start - clmPage,
						int_end - clmPage, httpGetInstance);
			} else if (int_start <= clmPage && int_end > clmPage) {
				resultList = getClaimsAndDescription( wap, rootPath, strSources, an,
						pd, int_start, int_end - clmPage, clmPage,
						httpGetInstance);
			}
		} else {
			resultList = getXmlContantByType( wap, rootPath, strSources, an, pd,
					httpGetInstance, "drawings");
		}

		return resultList;
	}

	private List getClaimsAndDescription(String wap, String rootPath, String strSources,
			String an, String pd, int startPage, int endPage, int clmPage,
			HttpGet httpGetInstance) {

		List resultList = new ArrayList();

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

		String xmlContant = "";
		String strTemp = "";
		String clmTemp = "";
		String desTemp = "";
		BufferedReader reader = null;

		InputStream src_is = null;
		try {
			byte[] xmlByteArray = getXmlDocument(wap,strSources, strWhere, "权利要求书");
			// System.out.println("xmlByteArray[0]="+ xmlByteArray[0]+";
			// xmlByteArray[1]="+xmlByteArray[1]);
			int i = 0;
			while (xmlByteArray[i] < 0) {
				i++;
			}
			byte[] paaseXmlByteArray = new byte[xmlByteArray.length - i];
			System.arraycopy(xmlByteArray, i, paaseXmlByteArray, 0,
					paaseXmlByteArray.length);
			src_is = new ByteArrayInputStream(paaseXmlByteArray);
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			clmTemp = clmXmlParse(reader, startPage, clmPage);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		clmTemp = "<claims>" + clmTemp + "</claims>/n";
		try {
			byte[] xmlByteArray = getXmlDocument(wap,strSources, strWhere, "说明书");
			// System.out.println("xmlByteArray[0]="+ xmlByteArray[0]+";
			// xmlByteArray[1]="+xmlByteArray[1]);
			int i = 0;
			while (xmlByteArray[i] < 0) {
				i++;
			}
			byte[] paaseXmlByteArray = new byte[xmlByteArray.length - i];
			System.arraycopy(xmlByteArray, i, paaseXmlByteArray, 0,
					paaseXmlByteArray.length);

			src_is = new ByteArrayInputStream(paaseXmlByteArray);
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			desTemp = desXmlParse(reader, 1, endPage - 1);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		desTemp = "<description>" + desTemp + "</description>";
		strTemp = clmTemp + desTemp;
		XMLContentProcess processXml = new XMLContentProcess(strSources, 0);
		strTemp = processXml.setPrePostfix(strTemp, "", "");

		try {
			// xmlContant = processXml.convert(rootPath, an, pd, strTemp, 0);
			xmlContant = processXml.replaceInnerPICXML(rootPath, strTemp, an,
					pd);
			// xmlContant =
			// "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM
			// \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet
			// type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser
			// SegmentMark=\"paragraph\" NewLineMark=\"br\"
			// HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document
			// lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\"
			// country=\"CN\"><claims><claim><claim-text><!-- SIPO <DP n=\"10\">
			// -->成移动以吸纳所述管中的热膨胀和收缩。</claim-text></claim><claim id=\"cl0072\"
			// num=\"0072\"><claim-text>72.根据权利要求68所述的太阳辐射吸收器，还包括流动控制元件，该流动控制元件插入在至少一个所述吸收器管中或布置在该至少一个吸收器管上。</claim-text></claim><claim
			// id=\"cl0073\"
			// num=\"0073\"><claim-text>73.一种用于太阳能收集器系统中的太阳辐射吸收器，所述太阳辐射吸收器包括：</claim-text><claim-text>多个吸收器管；以及</claim-text><claim-text>流动控制元件，该流动控制元件作用在至少一个吸收器管上，以保持所述吸收器管之间的相对恒定的流体流动。</claim-text></claim><claim
			// id=\"cl0074\"
			// num=\"0074\"><claim-text>74.根据权利要求73的太阳辐射吸收器，其特征在于，所述流动控制元件导致所述至少一个吸收器管中的约30％至约70％的压降。</claim-text></claim><claim
			// id=\"cl0075\"
			// num=\"0075\"><claim-text>75.一种用于太阳能收集器系统中的太阳辐射吸收器，所述太阳辐射吸收器包括多个吸收器管，其中：</claim-text><claim-text>所述多个吸收器管包括用于向所述吸收器供应热交换流体的一个或多个进口管以及用于从所述吸收器释放热交换流体的一个或多个出口管；以及</claim-text><claim-text>所述多个吸收器管构造成使得所述一个或多个出口管相对于所述一个或多个进口管定位成更靠近所述吸收器的内部。</claim-text></claim><claim
			// id=\"cl0076\"
			// num=\"0076\"><claim-text>76.一种太阳能收集器系统，包括：</claim-text><claim-text>高位的接收器，所述接收器包括：</claim-text><claim-text>细长的接收器沟槽，该接收器沟槽包括第一和第二侧壁以及孔口，所述第一和第二侧壁以及所述孔口分别沿着所述接收器沟槽的长度延伸；以及</claim-text><claim-text>太阳辐射吸收器，该太阳辐射吸收器包括多个间隔开的平行的吸收器管，所述吸收器管在所述第一和第二侧壁之间以及在所述孔口上方沿长度方向设置在所述接收器沟槽中；以及</claim-text><claim-text>第一和第二反射器场，该第一和第二反射器场相对于所述接收器的中心定位在相对侧上，其中：</claim-text><claim-text>每个反射器场包括设置在大体沿平行于所述接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器；</claim-text><claim-text>每个所述反射器包括反射面，所述反射面构造成引导入射的太阳辐射通过所述孔口以至少部分地入射在所述多个吸收器管上；</claim-text><claim-text>所述反射器被驱动以至少部分地跟踪太阳的白昼运动；以及</claim-text><claim-text>所述间隔开的平行的吸收器管中的相邻的吸收器管之间的间隔被选择成减少被反射的太阳辐射经过所述吸收器管的泄漏。</claim-text></claim><claim
			// id=\"cl0077\"
			// num=\"0077\"><claim-text>77.根据权利要求76的太阳能收集器系统，其特征在于，使用从所述反射器中的至少一个的内缘延伸的一组切线来确定所述间隔开的平行的吸收器管中的相邻的吸收器管之间的间隔。</claim-text></claim><claim
			// id=\"cl0078\"
			// num=\"0078\"><claim-text>78.一种设定太阳能收集器系统的高位的接收器中的间隔开的平行的吸收器管中的相邻的吸收器管之间的间隔的方法，所述方法包括：</claim-text><claim-text>将所述吸收器管沿长度方向且并排地设置在一水平面上，该水平面相对于所述太阳能收集器系统中的反射器升高；以及</claim-text><claim-text>将每个吸收器管的外周缘与从所述反射器的内缘延伸的切线对齐，以将所述吸收器管<!--
			// SIPO <DP n=\"11\"> -->在所述水平面上间隔开。</claim-text></claim><claim
			// id=\"cl0079\"
			// num=\"0079\"><claim-text>79.一种用于太阳能收集器系统的接收器，所述接收器包括：</claim-text><claim-text>细长的接收器沟槽，该接收器沟槽包括第一和第二侧壁以及孔口，所述第一和第二侧壁以及所述孔口分别沿着所述接收器沟槽的长度延伸；</claim-text><claim-text>太阳辐射吸收器，该太阳辐射吸收器定位在形成在所述第一和第二侧壁之间以及在所述孔口上方的空腔中；以及</claim-text><claim-text>框架，该框架用于支承所述太阳辐射吸收器和所述接收器沟槽，</claim-text><claim-text>其中，所述框架与联接在所述太阳辐射吸收器上的安装结构之间的接合部和所述框架与所述接收器沟槽之间的接合部的至少其中之一构造成阻止所述空腔与所述框架之间的导热。</claim-text></claim><claim
			// id=\"cl0080\"
			// num=\"0080\"><claim-text>80.根据权利要求79的接收器，包括隔热构件，该隔热构件位于所述框架与所述安装结构之间的接合部中和/或位于所述框架与所述接收器沟槽之间的接合部中。</claim-text></claim><claim
			// id=\"cl0081\"
			// num=\"0081\"><claim-text>81.一种用于太阳能收集器系统的接收器，所述接收器包括太阳辐射吸收器，所述太阳辐射吸收器包括多个沿长度方向设置在所述接收器中的平行的吸收器管，其中所述多个平行的吸收器管由横跨所述接收器延伸的一组同轴的辊子支承。</claim-text></claim><claim
			// id=\"cl0082\"
			// num=\"0082\"><claim-text>82.根据权利要求81的接收器，其特征在于，所述一组同轴的辊子包括用于每个吸收器管的单独的辊子。</claim-text></claim><claim
			// id=\"cl0083\"
			// num=\"0083\"><claim-text>83.一种用于太阳能收集器系统的驱动系统，所述驱动系统包括：</claim-text><claim-text>构造成驱动齿轮的双向马达；</claim-text><claim-text>反射器支承件，该反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，所述反射器支承件构造成旋转所述反射器元件以至少部分地跟踪太阳的白昼运动，所述反射器元件构造成将入射的太阳辐射引导至高位的接收器；以及</claim-text><claim-text>链条，该链条与所述齿轮啮合；其中所述链条构造成卷绕在所述反射器支承件的外周面周围，并与附装在所述反射器支承件的所述外周面上的接合构件连续接合，使得所述马达经由所述链条驱动所述反射器支承件。</claim-text></claim><claim
			// id=\"cl0084\"
			// num=\"0084\"><claim-text>84.根据权利要求83的驱动系统，其特征在于，所述链条形成连续的环，所述接合构件包括带齿的齿轮状结构。</claim-text></claim><claim
			// id=\"cl0085\"
			// num=\"0085\"><claim-text>85.根据权利要求83的驱动系统，其特征在于：</claim-text><claim-text>所述接合构件包括第一和第二附接点；</claim-text><claim-text>所述链条包括第一和第二链条端部；以及</claim-text><claim-text>所述第一链条端部构造成与所述第一附接点接合，所述第二链条端部构造成与所述第二附接点接合，使得沿第一方向施加在所述链条上的拉力能够沿顺时针方向和逆时针方向中的一个旋转所述反射器支承件，沿第二方向施加在所述链条上的拉力能够沿顺时针方向和逆时针方向中的另一个旋转所述反射器支承件。</claim-text></claim><claim
			// id=\"cl0086\"
			// num=\"0086\"><claim-text>86.一种用于太阳能收集器系统的驱动系统，所述驱动系统包括：</claim-text><claim-text>构造成驱动齿轮的马达；</claim-text><claim-text>反射器支承件，该反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，所述反射器支承件构造成旋转所述反射器元件以至少部分地跟踪太阳的白昼运动，所述反射器元件构造成将入射的太阳辐射引导至高位的接收器；</claim-text><!--
			// SIPO <DP n=\"12\">
			// --><claim-text>链条，该链条与所述齿轮啮合，并卷绕在所述反射器支承件的外周面周围且联接在该外周面上，使得当所述齿轮被所述马达驱动时，在所述链条上施加拉力以旋转所述反射器支承件；</claim-text><claim-text>安装在基座上的轮，该轮构造成接触所述反射器支承件的所述外周面并在所述反射器支承件旋转时旋转；以及</claim-text><claim-text>侧向稳定构件，该侧向稳定构件构造成减小所述轮与所述反射器支承件的所述外周面之间的侧向移动的量。</claim-text></claim><claim
			// id=\"cl0087\"
			// num=\"0087\"><claim-text>87.一种用于太阳能收集器系统的驱动系统，所述驱动系统包括：</claim-text><claim-text>构造成旋转反射器支承件的马达，所述反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，以至少部分地跟踪太阳的白昼运动和将入射的太阳辐射引导至接收器；以及</claim-text><claim-text>位置传感器，该位置传感器构造成在至少约0.2度内感测所述反射器支承件的旋转位置。</claim-text></claim><claim
			// id=\"cl0088\"
			// num=\"0088\"><claim-text>88.根据权利要求87的驱动系统，还包括控制器，所述控制器构造成向所述位置传感器提供输入和/或从所述位置传感器接收输出。</claim-text></claim><claim
			// id=\"cl0089\"
			// num=\"0089\"><claim-text>89.根据权利要求87的驱动系统，包括闭环控制构造，其中所述控制器构造成从所述位置传感器接收输入以确定所述反射器支承件的旋转位置，以及向所述马达提供输出指令以将所述反射器支承件旋转至希望的旋转位置。</claim-text></claim><claim
			// id=\"cl0090\"
			// num=\"0090\"><claim-text>90.根据权利要求87的驱动系统，其特征在于，所述位置传感器构造成在所述反射器支承件旋转时感测所述反射器支承件的旋转位置。</claim-text></claim><claim
			// id=\"cl0091\"
			// num=\"0091\"><claim-text>91.根据权利要求87的驱动系统，还包括一个或多个限位传感器，其中每个限位传感器构造成检测所述反射器支承件是否已旋转至预定的极限位置。</claim-text></claim><claim
			// id=\"cl0092\"
			// num=\"0092\"><claim-text>92.根据权利要求91的驱动系统，包括两个限位传感器，其中所述两个限位传感器定位在所述反射器支承件的周边或周边附近，并相对于彼此以约270°定向。</claim-text></claim><claim
			// id=\"cl0093\"
			// num=\"0093\"><claim-text>93.根据权利要求91的驱动系统，其?卣髟谟冢鲆桓龌蚨喔鱿尬淮衅髦械闹辽僖桓龉乖斐捎米饔糜谒鑫恢么衅鞯幕嘉恢谩</claim-text></claim><claim
			// id=\"cl0094\"
			// num=\"0094\"><claim-text>94.根据权利要求87的驱动系统，其特征在于，所述位置传感器包括至少两个元件，使用所述至少两个元件之间的对比测量来确定所述反射器支承件的旋转位置。</claim-text></claim><claim
			// id=\"cl0095\"
			// num=\"0095\"><claim-text>95.一种太阳能收集器系统，所述系统包括：</claim-text><claim-text>反射器支承件，该反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，所述反射器支承件构造成旋转所述一个或多个反射器元件以至少部分地跟踪太阳的白昼运动，所述一个或多个反射器元件构造成将入射的太阳辐射引导至高位的接收器；</claim-text><claim-text>构造成旋转所述反射器支承件的马达；以及</claim-text><claim-text>位置传感器，该位置传感器构造成在至少约0.2度内感测所述反射器支承件的旋转位置。</claim-text></claim><claim
			// id=\"cl0096\"
			// num=\"0096\"><claim-text>96.根据权利要求95的太阳能收集器系统，包括控制器，所述控制器构造成从所述位置传感器接收输入和/或向所述位置传感器提供输出。</claim-text></claim><claim
			// id=\"cl0097\"
			// num=\"0097\"><claim-text>97.根据权利要求95的太阳能收集器系统，还包括闭环控制构造，其中所述控制器构造成从所述位置传感器接收输入以确定所述反射器支承件的旋转位置，以及向所述马达提<!--
			// SIPO <DP n=\"13\">
			// -->供输出指令以将所述反射器支承件旋转至希望的旋转位置。</claim-text></claim><claim
			// id=\"cl0098\"
			// num=\"0098\"><claim-text>98.一种用于太阳能收集器系统的驱动装置，所述驱动装置包括第一马达，该第一马达构造成旋转包括一个或多个反射器支承件的第一组，所述第一组中的每个反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，其中所述第一马达构造成联接在变频驱动装置上，以控制分配给由所述第一马达旋转的所述第一反射器支承件的旋转位置解析度。</claim-text></claim><claim
			// id=\"cl0099\"
			// num=\"0099\"><claim-text>99.根据权利要求98的驱动装置，其特征在于，所述变频驱动装置向所述马达提供具有约1Hz至约6Hz的频率的AC功率。</claim-text></claim><claim
			// id=\"cl0100\"
			// num=\"0100\"><claim-text>100.根据权利要求98的驱动装置，其特征在于，所述变频驱动装置包括控制器，所述控制器构造成可远程编程。</claim-text></claim><claim
			// id=\"cl0101\"
			// num=\"0101\"><claim-text>101.根据权利要求98的驱动装置，其特征在于，所述第一马达构造成在直接驱动操作与通过所述变频驱动装置操作之间切换。</claim-text></claim><claim
			// id=\"cl0102\"
			// num=\"0102\"><claim-text>102.根据权利要求98的驱动装置，包括第二马达，该第二马达构造成旋转包括一个或多个反射器支承件的第二组，所述第二组中的每个反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件，其中所述第二马达构造成联接在所述变频驱动装置上，以控制分配给由所述第二马达旋转的第二组反射器支承件的旋转位置解析度。</claim-text></claim><claim
			// id=\"cl0103\"
			// num=\"0103\"><claim-text>103.根据权利要求102的驱动装置，其特征在于，所述第一和第二马达构造成按顺序操作，以按顺序旋转所述第一和第二组反射器支承件。</claim-text></claim><claim
			// id=\"cl0104\"
			// num=\"0104\"><claim-text>104.根据权利要求102的驱动装置，其特征在于，所述第一和第二马达构造成同时操作，使得所述第一和第二组反射器支承件能够被同时旋转。</claim-text></claim><claim
			// id=\"cl0105\"
			// num=\"0105\"><claim-text>105.根据权利要求102的驱动装置，其特征在于，所述第一和第二马达分别构造成在通过所述变频驱动装置操作与以直接驱动操作之间切换。</claim-text></claim><claim
			// id=\"cl0106\"
			// num=\"0106\"><claim-text>106.根据权利要求105的驱动装置，其特征在于，所述第一和第二马达构造成彼此独立地在通过所述变频驱动装置操作与以直接驱动操作之间切换。</claim-text></claim><claim
			// id=\"cl0107\"
			// num=\"0107\"><claim-text>107.一种用于太阳能收集器系统的驱动系统，所述驱动系统包括：</claim-text><claim-text>一个或多个变频驱动装置，每个变频驱动装置联接在一组马达上，所述组中的每个马达构造成驱动一个或多个反射器支承件，每个反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件；以及</claim-text><claim-text>一个或多个开关，其中每个开关构造成绕开所述一个或多个变频驱动装置中的至少一个，使得与在所述一个或多个变频驱动装置中的所述至少一个联接的所述一组马达以直接驱动进行操作。</claim-text></claim><claim
			// id=\"cl0108\"
			// num=\"0108\"><claim-text>108.根据权利要求107的驱动系统，其特征在于，所述一个或多个变频驱动装置的单个变频驱动装置联接在包括十个或更多个马达的组上。</claim-text></claim><claim
			// id=\"cl0109\"
			// num=\"0109\"><claim-text>109.根据权利要求107的驱动系统，其特征在于，所述一个或多个开关的单个开关构造成绕开所述一个或多个变频驱动装置的多于一个变频驱动装置。</claim-text></claim><claim
			// id=\"cl0110\"
			// num=\"0110\"><claim-text>110.一种太阳能收集器系统，包括：</claim-text><claim-text>高位的接收器，该接收器包括太阳辐射吸收器；</claim-text><claim-text>第一和第二反射器场，该第一和第二反射器场相对于所述接收器的中心定位在相对侧上；</claim-text><!--
			// SIPO <DP n=\"14\">
			// --><claim-text>其中：</claim-text><claim-text>每个反射器场包括设置在大体沿平行于所述接收器的长度的方向延伸的一个或多个平行的反射器排中的反射器；</claim-text><claim-text>每个所述反射器包括反射面，所述反射面构造成将入射的太阳辐射引导至所述接收器中的所述太阳辐射吸收器；</claim-text><claim-text>每个反射器排的至少一部分构造成由马达驱动；以及</claim-text><claim-text>每个马达构造成连接在变频驱动装置上。</claim-text></claim><claim
			// id=\"cl0111\"
			// num=\"0111\"><claim-text>111.根据权利要求110的太阳能收集器系统，其特征在于，单个变频驱动装置连接在十个或更多个马达上。</claim-text></claim><claim
			// id=\"cl0112\"
			// num=\"0112\"><claim-text>112.根据权利要求110的太阳能收集器系统，还包括构造成绕开连接在马达上的所述变频驱动装置的开关。</claim-text></claim><claim
			// id=\"cl0113\"
			// num=\"0113\"><claim-text>113.根据权利要求110的太阳能收集器系统，其特征在于，所述变频驱动装置构造成在约1Hz至约6Hz下向每个马达供应AC功率。</claim-text></claim><claim
			// id=\"cl0114\"
			// num=\"0114\"><claim-text>114.根据权利要求101的驱动装置，包括第一和第二转速设定，其中通过经所述变频驱动装置操作所述第一马达实现所述第一转速设定，通过以直接驱动操作所述第一马达实现所述第二转速设定。</claim-text></claim><claim
			// id=\"cl0115\"
			// num=\"0115\"><claim-text>115.根据权利要求114的驱动装置，包括第三转速设定，其中通过在标称AC功率频率的谐波下经变频驱动装置操作所述第一马达实现所述第三转速设定。</claim-text></claim><claim
			// id=\"cl0116\"
			// num=\"0116\"><claim-text>116.一种用于太阳能收集器系统的驱动系统，所述驱动系统包括：</claim-text><claim-text>两个或多个反射器支承件，每个反射器支承件包括框架，所述框架构造成支承并旋转连接在其上的一个或多个反射器元件，其中：</claim-text><claim-text>至少一个反射器支承件框架包括箍状框架；以及</claim-text><claim-text>至少一个反射器支承件框架包括被基本限制在一平面的一侧的框架，所述平面大体由联接在该框架上的所述一个或多个反射器元件的反射面限定。</claim-text></claim><claim
			// id=\"cl0117\"
			// num=\"0117\"><claim-text>117.根据权利要求116的驱动系统，包括主反射器支承件，该主反射器支承件构造成使得主反射器支承件框架的旋转驱动联接在其上的一个或多个从反射器支承件框架的旋转。</claim-text></claim><claim
			// id=\"cl0118\"
			// num=\"0118\"><claim-text>118.根据权利要求116的驱动系统，其特征在于，至少一个反射器支承件包括：</claim-text><claim-text>基座；</claim-text><claim-text>框架，该框架基本被限制在大体由联接在该框架上的一个或多个反射器元件的反射面限定的平面的一侧；以及</claim-text><claim-text>毂，该毂构造成支承所述框架，并旋转地联接在所述基座上。</claim-text></claim><claim
			// id=\"cl0119\"
			// num=\"0119\"><claim-text>119.根据权利要求117的驱动系统，其特征在于，所述主反射器支承件构造成驱动联接在其上的三个或更多个从反射器支承件框架的旋转。</claim-text></claim><claim
			// id=\"cl0120\"
			// num=\"0120\"><claim-text>120.根据权利要求116的驱动系统，构造成用于线性菲涅尔反射器阵列中。</claim-text></claim><!--
			// SIPO <DP n=\"15\"> --></claims><description><invention-title
			// id=\"tilte1\">线性菲涅尔太阳能阵列及其部件</invention-title><p id=\"p0001\"
			// num=\"0001\">相关申请的交叉引用</p><p id=\"p0002\"
			// num=\"0002\">本申请要求2007年8月27日提交的题为“线性菲涅尔太阳能阵列(Linear?Fresnel?Solar?Arrays)”的美国专利申请No.61/007,926的权益，通过引用将其全文结合于本文中。本申请还要求题为“线性菲涅尔太阳能阵列及其部件(Linear?Fresnel?Solar?Arrays?and?Components?Therefor)”的美国专利申请No.12/012,920(代理机构卷号No.62715-20013.00)、题为“线性菲涅尔太阳能阵列及其接收器(Linear?Fresnel?Solar?Arrays?andReceivers?Therefor)”的美国专利申请No.12/012,829(代理机构卷号No.62715-20015.00)以及题为“线性菲涅尔太阳能阵列及其驱动装置(Linear?Fresnel?Solar?Arrays?and?Drives?Therefor)”的美国专利申请No.12/012,821(代理机构卷号No.62715-20016.00)的权益，各申请均在2008年2月5日提交，且通过引用将各申请全文结合于本文中。</p><technical-field
			// id=\"technical-field001\"><p id=\"p0003\" num=\"0003\">技术领域</p><p
			// id=\"p0004\"
			// num=\"0004\">本申请涉及太阳能收集器系统，更具体地涉?跋咝苑颇瓷淦魈裟苷罅?太阳能模块。本文描述的是可结合太阳能收集器系统使用的反射器、太阳辐射吸收器、接收器、驱动装置、支承结构、稳定元件及相关方法。</p></technical-field><background-art
			// id=\"background-art001\"><p id=\"p0005\" num=\"0005\">背景技术</p><p
			// id=\"p0006\"
			// num=\"0006\">称为“线性菲涅尔反射器(LFR)系统”的类型的太阳能收集器系统是相对众所周知的。LFR阵列包括排列在平行相邻的排中的线性反射器场。反射器可被驱动以跟踪太阳的运动。在这些系统中，反射器被定向成向高位的远程接收器反射入射的太阳辐射，该接收器能够吸收所反射的太阳辐射。接收器通常平行于反射器排延伸，以接收所反射的辐射用于进行能量交换。接收器通常(但不必)定位在两个相邻的反射器场之间。例如，在一些系统中，n个间隔开的接收器可被从第(n+1)个或可选择地第(n-1)个反射器场反射的辐射辐照。在一些变型中，单个接收器可被从两个相邻的反射器场反射的辐射辐照。</p><p
			// id=\"p0007\"
			// num=\"0007\">为了跟踪太阳的运动，可将单独的反射器安装在能够倾斜或枢转的支承件上。2004年7月1日提交的国际专利公开号为WO05/003647和2005年2月17日提交的国际专利公开号为WO05/0078360的专利文献中描述了合适的支承件的示例，通过引用将各专利文献全文结合于本文中。</p><p
			// id=\"p0008\"
			// num=\"0008\">在大多数LFR系统中，接收器和反射器排定位成沿南-北方向线性延伸，反射器对称地布置在接收器周围。在这些系统中，反射器可被枢转地安装和驱动通过接近90度的角度，以在连续的白昼周期期间跟踪太阳的大致东-西向运动。已经提出一些系统，其中反射器排定位成沿东-西方向线性延伸。参看例如Di?Canio等人的最终报告1977-79DOE/ET/20426-1以及2007年8月27日提交的题为“具有东-西向延伸的线性反射器的能量收集系统(Energy?Collection?System?Having?East-West?Extending?LinearReflectors)”的国际专利申请PCT/AU2007/001232，通过引用将各文献全文结合于本文中。</p><!--
			// SIPO <DP n=\"1\"> --><p id=\"p0009\"
			// num=\"0009\">太阳能收集器系统通常可在一定范围内铺展，并且定位在远程环境中。另外，太阳能收集器系统必须在苛刻的室外环境中持续使用多年，而对操作、维护和维修的要求较低。希望获得对用于操作、维护和/或维修的人员、时间和/或设备的要求降低的改进的系统。进一步地，希望太阳能收集器系统容易运输至远程场地并在那里组装。因此，需要改进的太阳能收集系统和改进的用于太阳能收集器系统的部件。此类部件可包括反射器、接收器、驱动装置、驱动系统和/或支承结构。改进的部件可导致用于太阳能收集器系统如LFR阵列的提高的收集效率和提高的整体性能。改进的部件还可降低操作、维护和/或维修要求、提高在苛刻的室外环境中的寿命、提高轻便性、降低组装要求并减少制造时间和/或成本。</p></background-art><disclosure
			// id=\"disclosure001\"><p id=\"p0010\" num=\"0010\">发明内容</p><p
			// id=\"p0011\"
			// num=\"0011\">本文描述了太阳能收集器系统、用于太阳能收集器系统的部件和用于安装太阳能收集器系统的方法。用于太阳能收集器系统的部件包括但不限于太阳辐射吸收器、接收器、驱动装置和驱动系统、反射器以及各种支承结构。太阳能收集系统、太阳辐射吸收器、接收器、驱动装置、驱动系统、反射器、支承结构和/或方法例如可用于LFR太阳能阵列中。本文所述的部件和方法可在太阳能收集器系统中以任何结合一起使用，或它们可单独用于不同的太阳能收集器系统中。</p><p
			// id=\"p0012\"
			// num=\"0012\">描述了用于太阳能收集器系统中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射引导至高位的接收器中的太阳辐射吸收器。反射器的反射面可构造成提供线聚焦，例如，反射器可为柱面镜。这些反射器可具有大于反射器的反射面与接收器中的太阳辐射吸收器之间的距离的焦距。反射器可构造成被驱动以至少部分跟随太阳的白昼运动。一些反射器的变型可具有比其反射面与该反射器被导向的太阳辐射吸收器之间的距离大至少约1％至约15％(例如，约2％、5％或10％)的焦距。</p><p
			// id=\"p0013\"
			// num=\"0013\">在此还描述了包括此类反射器的太阳能收集器系统。该太阳能收集器系统包括高位的接收器，该高位的接收器包括太阳辐射吸收器。第一和第二反射器场相对于接收器的中心定位在相对侧上。各反射器场包括设置在大致沿平行于接收器的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成引导入射的太阳辐射以在接收器中的太阳辐射吸收器处形成线聚焦。反射器构造成被驱动以至少部分跟踪太阳的白昼运动。来自第一和/或第二反射器场的至少一个反射器具有大于其反射面与接收器中的太阳辐射吸收器之间的距离的焦距，例如，比其反射面与太阳辐射吸收器之间的距离大约1％至约15％，或约2％、约5％或约10％。例如，一些系统可包括一个或多个平行的反射器排，该反射器排包括外排，定位在外排中的反射器可具有大于其反射面与太阳辐射吸收器之间的距离的焦距。</p><p
			// id=\"p0014\"
			// num=\"0014\">提供了太阳能收集器系统的其它变型。这些系统包括高位的接收器，该高位的接收器包括太阳辐射吸收器。第一和第二反射器场相对于接收器的中心定位在相对侧上。各反射器场包括设置在大致平行于接收器的长度延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射引导至接收器中的太阳辐射吸收器和至少部分跟踪太阳的白昼运动。反射器可设置成使得各反射器的焦距与反射器与接收器之间的距离大致相关联。</p><p
			// id=\"p0015\" num=\"0015\">提供了用于稳定太阳能收集器系统中的竖直支承结构的不对称拉线组。这些不对<!--
			// SIPO <DP n=\"2\">
			// -->称拉线组包括第一和第二拉线。各第一和第二拉线具有远端和近端。第一拉线的远端构造成在第一联接点联接在太阳能收集器系统的锚固在地面上的竖直支承结构的远端上。第一拉线的近端构造成在第一锚固点锚固在地面和/或锚固结构上。第一拉线当其在第一联接点联接在竖直支承结构上并在第一锚固点锚固时在第一联接点与第一锚固点之间具有第一共振频率。第二拉线的远端构造成在第二联接点联接在竖直支承结构的远端上。第二拉线的近端构造成在第二锚固点锚固在地面上和/或锚固结构上。第二拉线当其在第二联接点联接在竖直支承结构上并在第二锚固点锚固时在第二联接点与第二锚固点之间具有第二共振频率。在这些拉线组中，第一共振频率与第二共振频率不相同。</p><p
			// id=\"p0016\"
			// num=\"0016\">不对称拉线组中的拉线可以以任何合适的方式变化使得它们的共振频率不同。例如，在一些变型中，第一拉线在第一联接点与第一锚固点之间的长度可不同于第二拉线在第二联接点与第二锚固点之间的长度，以致第一共振频率与第二共振频率不同。在特定变型中，第一拉线在第一联接点与第一锚固点之间的宽度可不同于第二拉线在第二联接点与第二锚固点之间的宽度。</p><p
			// id=\"p0017\"
			// num=\"0017\">不对称拉线组的一些变型可包括多于两个拉线，例如，三个或更多个拉线。在此类组中，第三拉线的远端构造成在第三联接点联接在锚固在地面上的竖直支承结构的远端上。第三拉线的近端构造成在第三锚固点锚固在地面和/或锚固结构上。第三拉线当在第三联接点联接在竖直支承结构上并在第三锚固点锚固时在第三联接点与第三锚固点之间具有第三共振频率。第三共振频率不同于第一和第二共振频率中至少一个。</p><p
			// id=\"p0018\"
			// num=\"0018\">提供了包括不对称拉线的太阳能收集器系统。这些系统包括沿纵向延伸的高位的接收器和构造成支承高位的接收器的竖直支承结构。系统还包括第一和第二拉线。第一拉线在第一联接点联接在竖直支承结构上并从竖直支承结构侧向延伸至第一锚固点。第一拉线在第一联接点与第一锚固点之间具有第一共振频率。第一锚固点可在地面上，或在锚固结构上。第二拉线在第二联接点联接在竖直支承结构上并从竖直支承结构侧向延伸至第二锚固点。第二锚固点可在地面上，或在锚固结构上。第二拉线在第二联接点与第二锚固点之间具有第二共振频率。在这些系统中，第一共振频率不同于第二共振频率。例如，第一和第二共振频率可相差至少约20％、至少约30％、至少约40％或至少约50％。</p><p
			// id=\"p0019\"
			// num=\"0019\">还描述了包括纵向拉线的太阳能收集器系统。这些系统包括高位的接收器，该高位的接收器包括太阳辐射吸收器。多个竖直支承结构沿着高位的接收器的长度分布并构造成支承高位的接收器。系统各自包括纵向拉线布置。在纵向拉线布置中，各纵向拉线在两个相邻的竖直支承结构之间延伸。纵向拉线布置构造成稳定太阳能收集器系统并吸纳高位的接收器的一个或多个部件的纵向热膨胀。</p><p
			// id=\"p0020\"
			// num=\"0020\">这些系统可包括任何合适的纵向拉线布置以提供系统稳定性，同时吸纳接收器中的热膨胀。例如，在系统的一些变型中，纵向拉线布置可包括随着与高位的接收器的纵向中心相距的距离的增加而减小的纵向拉线密度。在特定变型中，纵向拉线布置可包括第一组大体平行的单个纵向拉线。第一组中的各单个纵向拉线大体沿多个竖直支承结构中的两个相邻的竖直支承结构之间的第一对角方向延伸。系统中的拉线布置的变型还可包括第二组大体平行的纵向拉线。第二组中的各单个纵向拉线大体沿相邻的竖直支承结构之间的第二对角方向延伸。在这些变型中，第一和第二组纵向拉线可相对于接收器的纵向中心定位在相对侧上。</p><!--
			// SIPO <DP n=\"3\"> --><p id=\"p0021\"
			// num=\"0021\">提供了用于安装线性菲涅尔太阳能反射器系统的方法。这些方法包括将多个反射器设置成排并提供接收器本体。接收器本体包括接收器沟槽，该接收器沟槽包括第一和第二侧壁以及孔口，它们各自沿着接收器沟槽的长度延伸。将多个太阳辐射吸收器管沿长度方向设置在接收器沟槽中。沿横向于接收器沟槽的长度的方向将窗插入接收器沟槽中。将窗固定在孔口上方，使得窗与接收器沟槽的第一和第二侧壁中的每一个都形成一接合部，以形成容纳太阳辐射管的空腔。将接收器本体定向成使得接收器沟槽的长度大体平行于反射器排。这些方法包括将包含接收器沟槽、太阳辐射吸收器管和窗的接收器本体升高至位于多个反射器上方的安装后的竖直接收器位置。对准多个反射器，使得当接收器本体处于安装后的竖直接收器位置时，各反射器引导入射的太阳辐射透过窗至少部分入射在一个或多个太阳能吸收器管上。在这些方法的一些变型中，可在将接收器本体升高至安装后的竖直接收器位置之前使用紧固件将窗固定在接收器沟槽上。</p><p
			// id=\"p0022\"
			// num=\"0022\">在这些方法的特定变型中，将接收器本体升高至安装后的竖直接收器位置可包括：将带接合部的竖直支承结构的近端锚固在地面上；使竖直支承结构的远端朝地面成角度；以及将接收器本体固定在带接合部的竖直支承结构的远端上。可向带接合部的竖直支承结构的远端施加侧向力以升高接收器本体。当接收器本体处于安装后的竖直接收器位置时，可锁定带接合部的竖直支承结构的一个或多个接合部。例如，在这些方法的一些变型中，可通过绳索向带接合部的竖直支承结构的远端施加侧向力。在这些方法中，绳索可穿引通过一个或多个滑轮，以控制向带接合部的竖直支承结构的远端施加侧向力。在这些方法的其它变型中，将接收器本体升高至安装后的竖直接收器位置可包括：将竖直支承结构的至少一个支柱锚固在地面上；使用联接在竖直支承结构上的提升装置(即，提升结构)升高接收器本体；以及将升高的接收器联接在竖直支承结构上。</p><p
			// id=\"p0023\"
			// num=\"0023\">提供了用于太阳能收集器系统中的竖直支承结构。竖直支承结构的特定变型分别包括构造成锚固在地面上的近端，以及构造成联接在太阳能收集器系统中的高位的接收器上的远端。支承结构包括第一接合部，其构造成允许支承结构的远端朝地面成角度，以在地面或地面附近将接收器联接在其上，同时将支承结构的近端锚固在地面上。第一接合部还构造成允许通过向支承结构的远端施加侧向力来升高支承结构的远端，使得联接在其上的接收器可升高至竖直安装后的接收器位置。在竖直支承结构的一些变型中，第一接合部可构造成要被锁定在锁定构造中，以将升高的接收器保持在竖直安装后的接收器位置。</p><p
			// id=\"p0024\"
			// num=\"0024\">一些竖直支承结构可包括相对于第一接合部定位在远侧的第二接合部。在竖直支承结构的这些变型中，第二接合部可独立于第一接合部弯曲。与第一接合部相比，第二接合部构造成允许竖直支承结构的远端更朝地面成角度，同时支承结构的近端朝地面成角度。第二接合部还构造成允许通过向支承结构的远端施加侧向力来升高支承结构的远端，使得联接在其上的接收器可被升高至竖直安装后的接收器位置。在这些支承结构的一些变型中，第二接合部可构造成要被锁定在锁定构造中，以将升高的接收器保持在竖直安装后的接收器位置。</p><p
			// id=\"p0025\"
			// num=\"0025\">一些竖直支承结构可还包括联接在支承结构的远端上的绳索。在这些变型中，绳索可构造成向支承结构的远端施加侧向拉力以升高联接在其上的接收器。这些包括绳索的竖直支承结构的特定变型还包括一个或多个滑轮。在这些变型中，绳索构造成穿引通过该一个或多个滑轮，以在向竖直支承结构的远端施加侧向拉力时引导绳索的位置。</p><!--
			// SIPO <DP n=\"4\"> --><p id=\"p0026\"
			// num=\"0026\">在此描述了用于太阳能收集器系统中的竖直支承结构的另外其它变型。这些结构包括构造成锚固在地面上的至少一个支柱，以及联接在竖直支承结构上的提升装置(即，提升结构)。提升装置构造成提升接收器。竖直支承结构包括构造成将接收器支承在高位的安装后的位置的至少一个安装构件。在一些情形中，安装构件可包括至少一个搁架。这些竖直支承结构的一些变型可包括分别构造成联接在地面上的两个支柱。这些支柱可朝彼此成角度并在竖直支承结构的顶点或顶点附近互相连接。在竖直支承结构的一些实施方式中，提升装置可安装在竖直支承结构的辅助部分上。该辅助部分可构造成在接收器安装好后被移去。</p><p
			// id=\"p0027\"
			// num=\"0027\">在此描述了制造用于支承线性菲涅尔太阳能反射器系统中的反射器元件的托架的方法。这些方法包括提供第一和第二平台，其中各平台包括第一端和相对的第二端。设置第一反射器支承件，其包括附接在第一反射器支承件上的一个或多个附接凸片。在这些方法中，将第一反射器支承件固定在第一平台的第二端上。还使用该一个或多个附接凸片将第一反射器支承件暂时或以可移去的方式联接在第二平台的第一端上，使得第一和第二平台分别从第一反射器支承件的相对侧延伸。这些方法包括使用该一个或多个附接凸片将第二平台与第一平台对齐。在一些变型中，例如可在约5mm内将第二平台与第一平台对齐。这些方法的一些变型包括在将第一平台与第二平台对齐后将第二平台的第一端固定在第一反射器支承件上。</p><p
			// id=\"p0028\"
			// num=\"0028\">这些方法的一些变型还包括提供第二和第三反射器支承件。在这些变型中，将第二反射器支承件联接在第一平台的第一端上，使得第一平台被支承在第一和第二反射器支承件之间，以及将第三反射器支承件联接在第二平台的第二端上，使得第二平台被支承在第一和第三反射器支承件之间。</p><p
			// id=\"p0029\"
			// num=\"0029\">在此提供了用于支承线性菲涅尔太阳能反射器系统中的反射器元件的托架。这些托架各自包括第一和第二平台，各平台包括第一和第二端。托架包括第一反射器支承件和附接在第一反射器支承件上的至少一个附接凸片。第一平台的第二端固定在第一反射器支承件上。使用该至少一个附接凸片将第二平台的第一端以可移去的方式附接在第一反射器支承件上，使得第一和第二平台从第一反射器支承件的相对侧延伸。该至少一个附接凸片构造成允许第二平台相对于第一平台对齐，并允许在对齐的位置将第二平台固定在第一反射器支承件的第二侧上。例如，附接凸片可构造成允许第二平台的旋转和/或平移，以将第二平台与第一平台对齐。在一些托架中，附接凸片可包括构造成用于接纳联接在第二平台上的螺栓的螺孔。一些托架还包括第二和第三反射器支承件，其中第二反射器支承件联接在第一平台的第一端上，使得第一平台被支承在第一和第二反射器支承件之间，第三反射器支承件联接在第二平台的第二端上，使得第二平台被支承在第一和第三反射器支承件之间。</p><p
			// id=\"p0030\"
			// num=\"0030\">在此还提供了用于将高位的接收器安装在太阳能收集器系统中的方法。这些方法包括将包含提升装置的竖直支承结构锚固在地面上，以及使用提升装置提升接收器。在接收器被提升后，将接收器联接在竖直支承结构上，以将接收器安装在太阳能收集器系统中。这些方法中的一些可包括将一排竖直支承结构锚固在地面上，其中竖直支承结构中的至少一个包括提升装置。该排中多于一个竖直支承结构、例如该排竖直支承结构中的端部的竖直支承结构可包括提升装置。在这些方法中，可将细长接收器沿着该排竖直支承结构定位<!--
			// SIPO <DP n=\"5\">
			// -->在地面上或地面附近并使用提升装置提升。在已提升接收器后，将接收器联接在竖直支承结构上以将接收器安装在太阳能收集器系统中。在这些方法的一些变型中，可在已安装好接收器后从竖直支承结构移去一个或多个提升装置。</p><p
			// id=\"p0031\"
			// num=\"0031\">在此提供了用于太阳能收集器系统的接收器。这些接收器各自包括接收器沟槽，该接收器沟槽包括第一和第二侧壁。孔口布置在第一和第二侧壁之间。第一和第二侧壁及孔口各自沿着接收器沟槽的长度延伸。太阳辐射吸收器定位在接收器沟槽中。窗布置在孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的纵向空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。接收器包括一个或多个窗支承构件。该一个或多个窗支承构件可沿着接收器沟槽的第一侧壁和/或第二侧壁布置。该一个或多个窗支承构件可构造成允许沿横向于接收器沟槽的长度的方向将窗安装在接收器中，以及当窗被安装在接收器中时支承窗。</p><p
			// id=\"p0032\"
			// num=\"0032\">这些接收器的一些变型可包括沿着第一侧壁布置的第一窗支承构件和沿着第二侧壁布置的第二窗支承构件。例如，第一窗支承构件可沿着第一侧壁布置并且可包括横档和台阶。在特定变型中，第二窗支承构件可沿着第二侧壁布置并且可包括槽隙。第二窗支承构件中的槽隙可包括上、下槽隙表面以及槽隙侧壁。上、下槽隙表面可间隔开足以容纳窗的厚度的量。当安装在接收器的这些变型中时，窗可定位在横档上和下槽隙表面上以及在台阶与槽隙侧壁之间，其中窗的纵向边缘定位在上、下槽隙表面之间的槽隙中。这些接收器的变型可包括一个或多个凸片，以将窗固定在接收器上。</p><p
			// id=\"p0033\"
			// num=\"0033\">在此还描述了包括此类接收器的太阳能收集器系统。这些系统包括高位的接收器。高位的接收器包括接收器沟槽，该接收器沟槽又包括第一和第二侧壁以及布置在第一和第二侧壁之间的孔口。第一和第二侧壁及孔口各自沿着接收器沟槽的长度延伸。太阳辐射吸收器定位在接收器沟槽中。窗布置在孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的纵向空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。该接收器可包括一个或多个沿着接收器沟槽的第一侧壁和/或第二侧壁布置的窗支承构件。该一个或多个窗支承构件可构造成允许沿横向于接收器沟槽的长度的方向将窗插入接收器中，以及当窗被安装在接收器中时支承窗。系统还包括相对于高位的接收器的中心定位在相对侧上的第一和第二反射器场。各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射透过窗引导至接收器中的太阳辐射吸收器。系统中的反射器被驱动以至少部分跟踪太阳的白昼运动。</p><p
			// id=\"p0034\"
			// num=\"0034\">描述了接收器的其它变型。这些接收器包括接收器沟槽，该接收器沟槽包括沿着其长度延伸的孔口。太阳辐射吸收器定位在接收器沟槽中。窗布置在接收器沟槽的孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。在这些接收器中，窗和接收器沟槽中的至少一个可构造成吸纳沿着孔口的长度的热膨胀和收缩。例如，窗可包括沿着孔口的长度分布以吸纳纵向热膨胀和收缩的两个或多个重叠的窗区段。</p><p
			// id=\"p0035\"
			// num=\"0035\">在此还公开了包括此类接收器的太阳能收集器系统。这些系统包括高位的接收器以及相对于接收器的中心定位在相对侧上的第一和第二反射器场。高位的接收器包括接收器沟槽，该接收器沟槽包括沿着其长度延伸的孔口。太阳辐射吸收器定位在接收器沟槽中。<!--
			// SIPO <DP n=\"6\">
			// -->窗布置在孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。窗和接收器沟槽中的至少一个可构造成吸纳沿着孔口的长度的热膨胀。例如，在一些系统中，窗可包括沿着孔口的长度分布的两个或多个重叠的窗区段。系统中的各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射透过窗引导至接收器中的太阳辐射吸收器。系统中的反射器被驱动以至少部分跟踪太阳的白昼运动。</p><p
			// id=\"p0036\"
			// num=\"0036\">在此描述了用于太阳能收集器系统的接收器的另外的变型。这些接收器的变型分别包括接收器沟槽，该接收器沟槽又包括沿着接收器沟槽的长度延伸的孔口。太阳辐射吸收器定位在接收器沟槽中。窗布置在孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。窗与接收器沟槽形成一接合部。在这些接收器中，阻止了外部空气经窗与接收器(沟槽)之间的接合部进入空腔中。</p><p
			// id=\"p0037\"
			// num=\"0037\">可采取任何合适的方式阻止外部空气经窗与接收器(沟槽)之间的接合部进入空腔中。例如，这些接收器的一些变型可包括密封件，该密封件定位在接收器沟槽与窗之间的接合部中以阻止外部空气进入空腔中。可选择地或另外，可使正压的已过滤的气体或空气(例如，已过滤的空气或干燥的氮气)流入空腔中以阻止外部空气进入空腔中。这些接收器的特定变型可包括定位在接收器沟槽上方的顶蓬，以在顶蓬与接收器沟槽之间形成空间。顶蓬与接收器沟槽之间的空间与容纳太阳辐射吸收器的空腔流体连通。可将隔热材料布置在顶蓬与接收器沟槽之间的空间中。外部空气经顶蓬与接收器沟槽之间的空间中的至少一部分隔热材料流入空腔中的流速大于外部空气经窗与接收器沟槽之间的接合部流入空腔中的流速。在这些接收器的一些变型中，隔热材料可用作过滤器以过滤掉外部空气中存在的颗粒物、湿气和/或其它污染物。</p><p
			// id=\"p0038\"
			// num=\"0038\">描述了包括此类接收器的太阳能收集器系统。这些系统分别包括高位的接收器和相对于接收器的中心定位在相对侧上的第一和第二反射器场。高位的接收器包括沿着接收器沟槽的长度延伸的孔口。太阳辐射吸收器定位在接收器沟槽中。窗布置在孔口中，使得窗和接收器沟槽共同形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。窗和接收器沟槽形成一接合部。在这些系统中可阻止外部空气经接收器沟槽与窗之间的接合部进入空腔中。系统中的各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射透过窗引导至太阳辐射吸收器。系统中的反射器被驱动以至少部分跟踪太阳的白昼运动。</p><p
			// id=\"p0039\"
			// num=\"0039\">在此类系统的一些变型中，接收器可还包括定位在接收器沟槽上方的顶蓬，以在顶蓬与接收器沟槽之间形成空间。这样形成的空间与容纳太阳辐射吸收器的空腔流体连通。可将隔热材料布置在该空间中。外部空气经至少一部分隔热材料流入空腔中的流速可大于外部空气经窗与接收器沟槽之间的接合部流入空腔中的流速。</p><p
			// id=\"p0040\"
			// num=\"0040\">在此描述了接收器的其它变型。接收器的这些变型包括接收器沟槽，该接收器沟槽包括沿着接收器沟槽的长度延伸的孔口。顶蓬定位在接收器沟槽上方并沿着接收器沟槽的长度延伸。顶蓬可具有形成平滑曲线的横截面并且包括面向接收器沟槽的凹面。太阳辐<!--
			// SIPO <DP n=\"7\">
			// -->射吸收器定位在接收器沟槽中。可将窗布置在孔口中，使得窗和接收器沟槽形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。窗和接收器沟槽可形成一接合部。顶蓬可构造成使环境碎屑与窗脱开。顶蓬可构造成以任何合适的方式使环境碎屑与窗脱开。例如，在一些变型中，顶蓬可在接收器沟槽与窗之间的接合部的下方延伸。</p><p
			// id=\"p0041\"
			// num=\"0041\">描述了包括此类接收器的系统。这些系统分别包括高位的接收器和相对于接收器的中心定位在相对侧上的第一和第二反射器场。各高位的接收器包括接收器沟槽，该接收器沟槽包括沿着其长度延伸的孔口。顶蓬可定位在接收器沟槽上方并且沿着接收器沟槽的长度延伸。顶蓬可具有形成平滑曲线的横截面并且包括面向接收器沟槽的凹面。太阳辐射吸收器定位在接收器沟槽中。可将窗布置在孔口中，使得窗和接收器沟槽形成容纳太阳辐射吸收器的空腔，并使得入射在太阳辐射吸收器上的太阳辐射透过窗传输。窗和接收器沟槽可形成一接合部。顶蓬可构造成使环境碎屑与窗脱开。例如，在一些系统中，接收器沟槽上方的顶蓬可在窗与接收器沟槽之间的接合部的下方延伸。系统中的各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射透过窗引导至太阳辐射吸收器。系统中的反射器被驱动以至少部分跟踪太阳的白昼运动。</p><p
			// id=\"p0042\"
			// num=\"0042\">在此描述了接收器的另外其它变型。这些接收器的变型分别包括太阳辐射吸收器。太阳辐射吸收器包括分别沿着接收器的长度延伸的多个平行的吸收器管。接收器还可包括多个间隔件。各间隔件可定位在平行的吸收器管中的两个相邻的吸收器管之间。各间隔件所提供的横向间隔足以吸纳平行的吸收器管中的两个相邻的吸收器管的热膨胀和/或移动。例如，在一些变型中，定位在位于接收器沟槽的横向中心附近的平行吸收器管中的两个相邻的吸收器管之间的其中一个间隔件可大于定位在位于接收器的纵向外边缘附近的平行吸收器管中的两个相邻的吸收器管之间的另一间隔件。</p><p
			// id=\"p0043\"
			// num=\"0043\">描述了包括此类接收器的太阳能收集器系统。这些系统分别包括高位的接收器和相对于接收器的中心定位在相对侧上的第一和第二反射器场。各接收器包括细长接收器沟槽，该接收器沟槽包括第一和第二侧壁及孔口。第一和第二侧壁及孔口分别沿着接收器沟槽的长度延伸。各接收器还包括太阳辐射吸收器，该太阳辐射吸收器包括多个平行的吸收器管，该吸收器管在第一和第二侧壁之间以及在孔口上方沿长度方向设置在接收器沟槽中。各接收器中可包括多个间隔件。各间隔件可定位在平行的吸收器管中的两个相邻的吸收器管之间。各间隔件所提供的横向间隔可足以吸纳平行的吸收器管中的两个相邻的吸收器管的热膨胀和/或移动。系统中的各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。系统中的反射器各自包括反射面，该反射面构造成引导入射的太阳辐射通过孔口以至少部分入射在多个吸收器管上。反射器被驱动以至少部分跟踪太阳的白昼运动。</p><p
			// id=\"p0044\"
			// num=\"0044\">描述了接收器的另外的变型。接收器的这些变型分别包括太阳辐射吸收器，该太阳辐射吸收器包括沿长度方向设置在接收器中的多个平行的吸收器管。接收器还包括一个或多个横跨接收器延伸的辊子。该一个或多个辊子中的至少一个可支承多个吸收器管。在这些变型中，该一个或多个辊子中的至少一个可包括布置在中空筒内的中心轴，该中空筒包括两个筒端部。中空筒可在各筒端部处通过联接在中心轴上的轴衬进行支承。在这些接<!--
			// SIPO <DP n=\"8\"> -->收器的一些变型中，中心轴的直径最多是中空筒的直径的约一半，或约四分之一。</p><p
			// id=\"p0045\"
			// num=\"0045\">描述了包括此类接收器的太阳能收集器系统。各系统包括高位的接收器和相对于接收器的中心定位在相对侧上的第一和第二反射器场。系统中的各接收器包括细长的接收器沟槽，该接收器沟槽包括第一和第二侧壁及孔口。第一和第二侧壁及孔口各自沿着接收器沟槽的长度延伸。接收器还各自包括太阳辐射吸收器，该太阳辐射吸收器包括多个平行的吸收器管，该吸收器管在第一和第二侧壁之间以及在孔口上方沿长度方向设置在接收器沟槽中。该多个平行的吸收器管可由横跨接收器沟槽定位的一个或多个辊子支承。该一个或多个辊子中的至少一个可包括布置在中空筒内的中心轴，该中空筒包括两个筒端部。中空筒可在两个筒端部中的每一个筒端部处通过联接在中心轴上的轴衬进行支承。系统中的各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成引导入射的太阳辐射通过孔口以至少部分入射在多个吸收器管上。反射器被驱动以至少部分跟踪太阳的白昼运动。在这些系统的特定变型中，中心轴的直径可最多是中空筒的直径的约一半，或约四分之一。</p><p
			// id=\"p0046\"
			// num=\"0046\">在此描述了接收器的更多变型。这些接收器包括太阳辐射吸收器，其包括沿长度方向设置在接收器中的多个平行的吸收器管。在这些变型中，多个吸收器管可由横跨接收器延伸的一组同轴辊子支承。例如，在一些变型中，该组同轴辊子可包括用于各吸收器管的单独的辊子。</p><p
			// id=\"p0047\"
			// num=\"0047\">在此描述了用于太阳能收集器系统中的太阳辐射吸收器。这些吸收器包括多个吸收器管。各吸收器管可经由管结构联接在总集管(headermanifold)上。总集管和/或将各吸收器管联接在总集管上的管结构中的至少一个管结构可构造成吸纳吸收器管的有差别的热膨胀。例如，总集管的至少一部分可构造成移动以吸纳管中的热膨胀和收缩。在这些吸收器的一些变型中，总集管可包括输入/输出集管，且输入/输出集管可包括能够独立于输出区段移动的进口区段。在这些吸收器的特定变型中，将各吸收器管连接在总集管上的管结构中的至少一个管结构可包括两个或多个不共面的弯头。一些变型可包括插入至少一个吸收器管中或布置在该至少一个吸收器管上的流动控制元件。</p><p
			// id=\"p0048\"
			// num=\"0048\">提供了用于太阳能收集器系统中的太阳辐射吸收器的其它变型。这些吸收器可包括多个吸收器管和作用在至少一个吸收器管上以保持吸收器管之间的相对恒定的流体流动的流动控制元件。例如，在一些变型中，流动控制元件可导致该至少一个吸收器管中的约30％至约70％的压降，例如约40％至约50％的压降。</p><p
			// id=\"p0049\"
			// num=\"0049\">提供了用于太阳能收集器系统中的吸收器的再其它变型。这些吸收器包括多个吸收器管，该吸收器管又包括用于向吸收器供应热交换流体的一个或多个进口管以及用于从吸收器释放热交换流体的一个或多个出口管。在这些吸收器中，多个吸收器管可构造成使得该一个或多个出口管定位成相对于该一个或多个出口管更靠近吸收器的内部。</p><p
			// id=\"p0050\"
			// num=\"0050\">在此提供了太阳能收集器系统的其它变型。这些系统分别包括高位的接收器，该接收器包括细长的接收器沟槽，该接收器沟槽包括分别沿着接收器沟槽的长度延伸的第一和第二侧壁及孔口。系统还包括太阳辐射吸收器，该太阳辐射吸收器包括多个间隔开的平行的吸收器管，其在第一和第二侧壁之间以及在孔口上方沿长度方向设置在接收器沟槽中。系统包括相对于接收器的中心定位在相对侧上的第一和第二反射器场。各反射器场包括设置在大体沿平行于接收器沟槽的长度的方向延伸的一个或多个平行的反射器排中的<!--
			// SIPO <DP n=\"9\">
			// -->反射器。反射器各自包括反射面，该反射面构造成引导入射的太阳辐射通过孔口以至少部分入射在多个吸收器管上。反射器被驱动以至少部分跟踪太阳的白昼运动。在这些系统中，可选择间隔开的平行吸收器管中的相邻吸收器管之间的间隔，以减少反射的太阳辐射经过吸收器管的泄漏。例如，可利用从反射器中至少一个的内缘延伸的一组切线确定间隔开的平行吸收器管中的相邻吸收器管之间的间隔。</p><p
			// id=\"p0051\"
			// num=\"0051\">提供了用于设定太阳能收集器系统的接收器中的间隔开的平行吸收器管中的相邻吸收器管之间的间隔的方法。这些方法包括将吸收器管沿长度方向且并排地设置在一相对于太阳能收集器系统中的反射器升高的水平面上。可通过将各吸收器管的外周缘与从反射器的内缘延伸的切线对齐来使吸收器管在该水平面上间隔开。</p><p
			// id=\"p0052\"
			// num=\"0052\">提供了用于太阳能收集器系统的接收器的另外的变型。接收器的这些变型分别包括细长的接收器沟槽，该接收器沟槽包括第一和第二侧壁及孔口。第一和第二侧壁及孔口分别沿着接收器沟槽的长度延伸。接收器包括太阳辐射吸收器，其定位在形成在第一和第二侧壁之间以及孔口上方的空腔中。接收器可包括用于支承太阳辐射吸收器的框架和接收器沟槽。在接收器的这些变型中，框架与联接在太阳辐射吸收器上的安装结构之间的接合部和框架与接收器沟槽之间的接合部的至少其中之一可构造成阻止空腔与框架之间的导热。例如，在一些变型中，接收器可包括隔热构件，其定位在框架与安装结构之间的接合部中和/或框架与接收器沟槽之间的接合部中。</p><p
			// id=\"p0053\"
			// num=\"0053\">在此描述了用于太阳能收集器系统的驱动系统。一些驱动系统包括两个或多个反射器支承件，其中各反射器支承件包括框架，该框架构造成支承并旋转联接在其上的一个或多个反射器元件。在这些系统中，至少一个反射器支承件框架可包括箍状框架，至少一个反射器支承件框架可包括基本上被限制在大致由联接在其上的一个或多个反射器元件的反射面限定的平面的一侧的框架。例如，一些驱动系统可包括与一个或多个从反射器支承件相联的主反射器支承件，使得主反射器支承件框架的旋转驱动联接在其上的一个或多个从反射器支承件框架中的相应旋转。主反射器支承件例如可构造成驱动联接在其上的三个或更多个从反射器支承件框架。在一些变型中，主反射器支承件框架可包括箍状框架。一些驱动系统中的至少一个反射器支承件可包括基座、框架、以及构造成支承该框架的毂(hub)，其中该毂旋转地联接在基座上，该框架基本上被限制在大体由联接在其上的一个或多个反射器元件的反射面限定的平面的一侧。</p><p
			// id=\"p0054\"
			// num=\"0054\">在此描述了用于太阳能收集器系统的驱动系统的另外的变型。这些系统包括构造成驱动齿轮的双向马达，以及构造成支承并旋转联接在其上的一个或多个反射器元件的反射器支承件。该反射器支承件构造成旋转反射器元件以至少部分跟踪太阳的白昼运动，反射器元件构造成将入射的太阳辐射引导至高位的接收器。在这些系统中，链条可与齿轮啮合。该链条可构造成卷绕在反射器支承件的外周面周围，并使链条与附装在反射器支承件的外周面上的接合构件连续接合，使得马达经由链条驱动反射器支承件。</p><p
			// id=\"p0055\"
			// num=\"0055\">在这些驱动系统的一些变型中，链条可形成连续的环，接合构件可包括带齿的齿轮状(gear-like)结构。在其它变型中，接合构件可包括第一和第二附接点，链条可包括第一和第二链条端部。在这些变型中，第一链条端部可构造成与第一附接点接合，而第二链条端部可构造成与第二附接点接合。沿第一方向施加在链条上的拉力可沿顺时针方向和逆时针方向中的一个旋转反射器支承件，而沿第二方向施加在链条上的拉力可沿顺时针方向和<!--
			// SIPO <DP n=\"10\"> -->逆时针方向中的另一个旋转反射器支承件。</p><p id=\"p0056\"
			// num=\"0056\">提供了用于太阳能收集器系统的其它驱动系统。这些系统包括构造成驱动齿轮的马达。系统还包括构造成支承并旋转联接在其上的一个或多个反射器元件的反射器支承件。反射器支承件构造成旋转反射器元件以至少部分跟踪太阳的白昼运动。反射器元件构造成将入射的太阳辐射引导至高位的接收器。链条可与齿轮啮合并卷绕在反射器支承件的外周面周围且联接在该外周面上，使得当齿轮被马达驱动时，拉力被施加在链条上以旋转反射器支承件。在这些系统中，链条可穿接在枢转臂周围。枢转臂可构造成调节链条中的拉力。例如，枢转臂可包括高度调节以调节链条拉力。</p><p
			// id=\"p0057\"
			// num=\"0057\">描述了用于太阳能收集器系统的驱动系统的另外其它变型。这些系统包括构造成驱动齿轮的马达。系统还包括构造成支承并旋转联接在其上的一个或多个反射器元件的反射器支承件。该反射器支承件构造成旋转反射器元件以至少部分跟踪太阳的白昼运动，反射器元件构造成将入射的太阳辐射引导至高位的接收器。链条可与齿轮啮合并卷绕在反射器支承件的外周面周围且联接在该外周面上，使得当齿轮被马达驱动时，在链条上施加拉力以旋转反射器支承件。可在基座上安装有一轮，该轮构造成接触反射器支承件的外周面并在反射器支承件旋转时旋转。系统还可包括侧向稳定构件，其构造成减少轮与反射器支承件的外周面之间的侧向移动的量。</p><p
			// id=\"p0058\"
			// num=\"0058\">在此描述了用于包括旋转位置传感器的太阳能收集器系统的驱动系统。这些驱动系统分别包括构造成旋转反射器支承件的马达，其中反射器支承件构造成支承并旋转联接在其上的一个或多个反射器元件以至少部分跟踪太阳的白昼运动，并将入射的太阳辐射引导至接收器。驱动系统还可包括位置传感器，其构造成在至少约0.2度、至少约0.1度、至少约0.05度、至少约0.02度或至少约0.01度内感测反射器支承件的旋转位置。这些驱动系统中可使用任何合适的位置传感器。例如，在一些驱动系统中，位置传感器可被安装在反射器支承件上并包括至少两个元件。该两个元件可为任何合适的元件，例如电容元件或加速度计(accelerometer)。位置传感器中的该至少两个元件之间的对比测量可用来确定反射器支承件的旋转位置。在一些变型中，该至少两个元件之间的对比测量可用来确定反射器支承件的绝对倾斜度。一些驱动系统可包括构造成在反射器支承件旋转的同时感测反射器支承件的旋转位置的位置传感器。</p><p
			// id=\"p0059\"
			// num=\"0059\">这些驱动系统的一些变型可包括控制器，该控制器构造成向位置传感器提供输入和/或从位置传感器接收输出。这些驱动系统的特定变型可包括闭环控制构造，其中控制器构造成从位置传感器接收输入以确定反射器支承件的旋转位置，以及向马达提供输出指令以将反射器支承件旋转至希望的旋转位置。驱动系统可包括一个或多个限位传感器，其中各限位传感器可构造成检测反射器支承件是否已旋转到预定的极限位置。例如，一些驱动系统可包括两个限位传感器，其定位在反射器支承件的周边上或周边附近，并且相对于彼此以约270°定向。在包括一个或多个限位传感器的驱动系统的变型中，该一个或多个限位传感器中的至少一个可构造成用作用于位置传感器的基准位置。</p><p
			// id=\"p0060\"
			// num=\"0060\">提供了可包括上述旋转位置传感器的太阳能收集器系统。这些系统包括构造成支承并旋转联接在其上的一个或多个反射器元件的反射器支承件。该反射器支承件构造成旋转该一个或多个反射器元件以至少部分跟踪太阳的白昼运动，该一个或多个反射器元件构造成将入射的太阳辐射引导至高位的接收器。系统包括构造成旋转反射器支承件的马达，<!--
			// SIPO <DP n=\"11\">
			// -->以及位置传感器，该位置传感器构造成在至少约0.2度、至少约0.1度、至少约0.05度、至少约0.02度或至少约0.01度内感测反射器支承件的旋转位置。这些系统可包括控制器，其构造成从位置传感器接收输入和/或向位置传感器提供输出。系统的一些变型可还包括闭环控制构造，其中控制器构造成从位置传感器接收输入以确定反射器支承件的旋转位置，以及向马达提供输出指令以将反射器支承件旋转至希望的旋转位置。</p><p
			// id=\"p0061\"
			// num=\"0061\">提供了用于太阳能收集器系统的驱动装置。这些驱动装置包括第一马达，其构造成旋转包括一个或多个反射器支承件的第一组(反射器支承件)。第一组中的各反射器支承件可构造成支承并旋转联接在其上的一个或多个反射器元件。第一马达可构造成联接在变频驱动装置上，以控制分配给由第一马达旋转的第一组反射器支承件的旋转位置解析度(resolution)。例如，在一些变型中，变频驱动装置可向第一马达提供具有为1Hz至约6Hz或约1Hz至约5Hz(例如，约2Hz或约3Hz)的频率的AC功率(AC?Power)。变频驱动装置可包括构造成可远程编程的控制器。在驱动装置的特定变型中，第一马达可构造成在以直接驱动操作与通过变频驱动装置操作之间切换。</p><p
			// id=\"p0062\"
			// num=\"0062\">驱动装置的一些变型可包括第二马达，其构造成旋转包括一个或多个反射器支承件的第二组(反射器支承件)。第二组中的各反射器支承件可构造成支承并旋转联接在其上的一个或多个反射器元件。第二马达也可构造成联接在变频驱动装置上，以控制分配给由第二马达旋转的第二组反射器支承件的旋转位置解析度。在这些变型中，第一和第??达可构造成按顺序操作以按顺序旋转第一和第二组反射器支承件。在其它变型中，第一和第二马达可构造成同时操作，使得第一和第二组反射器支承件可同时旋转。第一和第二马达分别可构造成在通过变频驱动装置操作与以直接驱动操作之间切换。第一和第二马达可构造成彼此独立地在通过变频驱动装置操作与以直接驱动操作之间切换</p><p
			// id=\"p0063\"
			// num=\"0063\">描述了更多用于太阳能收集器系统的驱动系统。这些驱动系统可包括一个或多个变频驱动装置。各变频驱动装置可联接在一组马达上，其中该组中的各马达构造成驱动一个或多个反射器支承件。反射器支承件各自构造成支承并旋转联接在其上的一个或多个反射器元件。驱动系统可包括一个或多个开关，其中各开关构造成绕开一个或多个变频驱动装置中的至少一个，使得联接在该一个或多个变频驱动装置中的该至少一个上的该组马达以直接驱动操作。在这些驱动系统的一些变型中，单个变频驱动装置可联接在包括十个或更多个马达的一组上。单个开关可构造成绕开多于一个变频驱动装置。</p><p
			// id=\"p0064\"
			// num=\"0064\">驱动装置的一些变型可具有多个一个转速设定。例如，一些驱动装置可具有用于旋转位置精度较高的反射器支承件的较慢的移动的第一慢转速设定，以及对应于允许反射器支承件较快地旋转的马达速度的第二转速设定。一些变型可包括对应于反射器支承件的极快旋转(例如，所希望的反射器支承件的最快旋转)的第三转速设定。可通过向驱动装置中的马达提供具有不同频率范围的AC功率来实现不同的转速设定。例如，可通过经在约1Hz至约6Hz或约1Hz至约5Hz(例如，约2Hz或3Hz)下操作的变频驱动装置向马达供应AC功率来实现第一转速设定。可通过在约50Hz或约60Hz下以直接驱动操作马达——例如，通过绕开连接在马达上的变频驱动装置——来实现第二转速设定。如果存在，第三转速设定可通过在标称AC功率的谐波下经变频驱动装置例如在约100Hz或约120Hz下向马达供应AC功率来实现。</p><p
			// id=\"p0065\" num=\"0065\">提供了太阳能收集器系统。这些系统分别包括高位的接收器和相对于接收器的中<!--
			// SIPO <DP n=\"12\">
			// -->心定位在相对侧上的第一和第二反射器场，该接收器包括太阳辐射吸收器。各反射器场包括设置在大体沿平行于接收器的长度的方向延伸的一个或多个平行的反射器排中的反射器。反射器各自包括反射面，该反射面构造成将入射的太阳辐射引导至接收器中的太阳辐射吸收器。各反射器排的至少一部分构造成由马达驱动，各马达可构造成连接在变频驱动装置上。在这些系统的一些变型中，单个变频驱动装置可连接在十个或更多个马达上。一些系统可还包括构造成绕开连接在马达上的变频驱动装置的开关。变频驱动装置可向连接在其上的马达提供具有任何合适的频率的AC功率，例如，频率为约1Hz至约6Hz或约1Hz至约5Hz。太阳能收集器系统的一些变型可具有如上所述的包括多于一个转速设定的驱动装置。</p></disclosure><description-of-drawings
			// id=\"description-of-drawings001\"><p id=\"p0066\"
			// num=\"0066\">附图说明</p><p id=\"p0067\"
			// num=\"0067\">图1A-1C示出了包括两个反射器场的太阳能收集器系统的示例，所述反射器场将入射的太阳辐射引导至高位的接收器。图1A示出了该系统的横向、端部上的视图，而图1B-1C示出了该系统的纵向侧视图。</p><p
			// id=\"p0068\" num=\"0068\">图2A示出了包括两个高位的接收器的太阳能收集器系统的示例。</p><p
			// id=\"p0069\"
			// num=\"0069\">图2B-2D示出了可用于太阳能收集器系统中的反射器支承件的各种示例，且图2E示出了用于太阳能阵列中的驱动系统的示例，所述太阳能阵列包括反射器支承件类型的组合。</p><p
			// id=\"p0070\"
			// num=\"0070\">图3示出了具有在接收器处聚焦反射的太阳辐射的反射面的反射器元件的示例。</p><p
			// id=\"p0071\"
			// num=\"0071\">图4示出了具有在接收器处聚焦反射的太阳辐射的反射面的反射器元件的另一示例。</p><p
			// id=\"p0072\" num=\"0072\">图5提供了包括不对称侧向拉线的太阳能收集器系统的示例。</p><p
			// id=\"p0073\" num=\"0073\">图6显示了包括不对称侧向拉线的太阳能收集器系统的另一示例。</p><p
			// id=\"p0074\" num=\"0074\">图7示出了具有不对称侧向拉线的太阳能收集器系统的另一变型。</p><p
			// id=\"p0075\" num=\"0075\">图8显示了具有纵向拉线布置的太阳能收集器系统的变型。</p><p
			// id=\"p0076\" num=\"0076\">图9显示了具有纵向拉线布置的太阳能收集器系统的另一变型。</p><p
			// id=\"p0077\" num=\"0077\">图10A-10C示出了接收器的示例。</p><p id=\"p0078\"
			// num=\"0078\">图11A-11E示出了构造成允许窗横向插入的接收器的示例。图11A、11C和11D示出了接收器的截面图，图11B提供了接收器的透视图，以及图11E提供了接收器的底部平面图。</p><p
			// id=\"p0079\"
			// num=\"0079\">图12A-12C示出了包括窗的接收器的变型，所述窗具有重叠的窗区段。图12B-12C显示了沿着线I-I’的截面图。</p><p
			// id=\"p0080\" num=\"0080\">图13显示了构造成吸纳纵向热膨胀和收缩的接收器的变型。</p><p
			// id=\"p0081\"
			// num=\"0081\">图14A-14F显示了接收器的变型，其中禁止外部空气经窗附近的路径进入容纳太阳辐射吸收器的空腔中。</p><p
			// id=\"p0082\"
			// num=\"0082\">图15显示了包括顶蓬的接收器的变型，所述顶蓬构造成使环境碎屑与接收器中的窗脱离。</p><p
			// id=\"p0083\"
			// num=\"0083\">图16A-16B示出了包括太阳辐射吸收管的接收器的示例，其中间隔件定位在相邻的管之间。图16B是圆形区域A的放大图。</p><!--
			// SIPO <DP n=\"13\"> --><p id=\"p0084\"
			// num=\"0084\">图17A-17B示出了用于确定太阳辐射吸收器管之间的间隔的方法的示例。</p><p
			// id=\"p0085\"
			// num=\"0085\">图18A-18C显示了接收器的示例，其中容纳太阳辐射吸收器的空腔与接收器的结构元件之间的导热路径的数量和/或质量已下降。</p><p
			// id=\"p0086\"
			// num=\"0086\">图19A-19D示出了其中携带热交换流体的管由一个或多个辊子支承的接收器的变型。</p><p
			// id=\"p0087\"
			// num=\"0087\">图20A-20F显示了用于包括多个太阳能吸收器管的接收器的吸收器的示例，所述多个太阳能吸收器管连接在总集管上。</p><p
			// id=\"p0088\" num=\"0088\">图20G-20I显示了可供太阳能吸收器管使用的流动控制元件的示例。</p><p
			// id=\"p0089\"
			// num=\"0089\">图21A-21C示出了热交换流体通过多个太阳能吸收器管的流动模式的各种构造。</p><p
			// id=\"p0090\"
			// num=\"0090\">图22示出了带接合部的竖直支承结构的变型，以及使用带接合部的竖直支承件来升高用于太阳能收集器系统的接收器或接收器的一部分的方法。</p><p
			// id=\"p0091\" num=\"0091\">图23A-23B示出了带接合部的竖直支承结构的另一变型。</p><p
			// id=\"p0092\"
			// num=\"0092\">图24A-24D显示了允许用于支承太阳能收集器系统中的反射器元件的两个或多个平台的相对对齐的托架的示例。</p><p
			// id=\"p0093\"
			// num=\"0093\">25A-25B示出了用于太阳能收集器系统的驱动系统的示例，其中驱动系统包括链条，该链条与支承并定位一个或多个反射器元件的反射器支承件上的带齿的齿轮状啮合部件连续地啮合。图25B是圆形区域B的放大图。</p><p
			// id=\"p0094\"
			// num=\"0094\">图26A-26B示出了用于太阳能收集器系统的驱动系统的另一示例。图26B是圆形区域C的放大图。</p><p
			// id=\"p0095\"
			// num=\"0095\">图27显示了用于太阳能收集器系统的驱动系统的变型，其中驱动系统包括枢转臂，该枢转臂可调节驱动反射器支承件中的运动的链条中的张力，所述反射器支承件支承一个或多个反射器元件。</p><p
			// id=\"p0096\"
			// num=\"0096\">图28A-28B示出了用于太阳能收集器系统的驱动系统的实施方式，其中驱动系统包括侧向稳定构件，以减少旋转一个或多个反射器元件的反射器支承件所进行的侧向移动。图28B是圆形区域D的放大图。</p><p
			// id=\"p0097\"
			// num=\"0097\">图29示出了用于太阳能收集器系统的驱动系统的示例，该驱动系统包括变频驱动装置。</p><p
			// id=\"p0098\"
			// num=\"0098\">图30示出了包括多个反射器排和多个马达的太阳能收集器系统的实施方式。</p><p
			// id=\"p0099\"
			// num=\"0099\">图31A-31C示出了用于太阳能收集器系统中的竖直支承结构的各种实施方式。</p></description-of-drawings><mode-for-invention
			// id=\"mode-for-invention001\"><p id=\"p0100\"
			// num=\"0100\">具体实施方式</p><p id=\"p0101\"
			// num=\"0101\">以下详细描述应当参照附图阅读，其中在全部不同的图中相同的参考标号表示相同/相似的元件。不一定按比例绘制的附图示出了可选的实施例且并非意图限制本发明的范围。详细描述以举例而非以限制的方式说明了本发明的原理。本说明书将使本领域技术人员能够制造和利用本发明，并且描述了包括目前认为是执行本发明的最佳模式在内的本发明的若干实施方式、示例、改造、变型、备选方案和用途。</p><p
			// id=\"p0102\"
			// num=\"0102\">说明书全文和所附权利要求中术语“太阳能收集器系统”、“太阳收集器系统”和“太阳能阵列”可互换地使用。另外，除非另外指出，“阵列”指太阳能阵列，且“吸收器”指太阳辐射吸收器。单数形式“一”、“一个”和“该”包括多个指称对象，除非上下文清楚地另外<!--
			// SIPO <DP n=\"14\">
			// -->指出。同样，术语“平行”意在意指“基本上平行”并且包含与平行几何形状略微偏离，而不要求例如平行反射器排或文中所述的任何其它平行设置精确地平行。用语“大体沿南-北方向”或如文中所用意在表示在+/-45°的容差内垂直于地球的旋转轴线的方向。例如，在提及大体沿南-北方向延伸的反射器排时，意思是该反射器排在约+/-45°的容差内平行于地球的旋转轴线定位。</p><p
			// id=\"p0103\"
			// num=\"0103\">本文公开了太阳能收集器系统、用于太阳能收集器系统的部件及相关方法的示例和变型。太阳能收集器系统可以是LFR太阳能阵列。部件可包括用于将入射的太阳辐射引导至接收器的反射器、用于接收并至少部分地吸收太阳辐射的接收器、太阳辐射吸收器、用于定位反射器的驱动装置和驱动系统、用于高位的接收器的支承结构、用于反射器元件的支承结构或托架、以及用于稳定或固定太阳能阵列的任何部分的另外的稳定元件，诸如拉线。在此所述的部件可以任何组合方式用于太阳能收集器系统中。此外，本文所述的太阳能收集器系统中可使用本文公开的、本领域普通技术人员已知的或以后开发的任何合适的接收器、太阳辐射吸收器、反射器、驱动装置、驱动系统、支承结构、稳定元件或方法。本文公开的接收器、太阳辐射吸收器、反射器、驱动装置、驱动系统、相关支承结构和稳定元件以及方法可用于本领域普通技术人员已知或以后开发的其它太阳能收集器系统(例如，LFR太阳能阵列)中。</p><p
			// id=\"p0104\"
			// num=\"0104\">下面是对太阳能收集器系统的总体描述，该太阳能收集器系统可与用于下述太阳能收集器系统的部件中的任何一个或以任何组合方式结合地使用。此详细描述与本文公开的特定部件和方法如反射器、接收器、吸收器、驱动装置、驱动系统、支承结构、稳定元件及相关方法相结合，包括了太阳能收集器系统的另外的示例。</p><p
			// id=\"p0105\"
			// num=\"0105\">参照图1A-1C，示出了LFR阵列的示例。本例的提出大致包含设置成东-西或西-北定向的系统或阵列。LFR阵列7包括高位的接收器5，其定位在两个反射器场10和16上方但在水平方向上定位在它们之间。箭头21代表太阳在阵列7上方的白昼东-西向路径。对于南-北定向的阵列而言，方向A将代表东方而方向B将代表西方。反射器场10包括设置在M个平行并排反射器排12R1-12RM中的反射器12。反射器场16包括设置在N个平行并排反射器排14R1-14RN中的反射器14。如图1B所示，单个反射器排可包括一个或多个反射器，例如2至6个。在包括多个反射器的给定反射器排内，多个反射器可大体沿着共同的平面延伸，例如，反射器排14R1中的反射器14可大体沿着共同的平面18延伸。射线13代表从太阳入射在反射器12和14上的太阳辐射的路径。射线13’代表从反射器12和14反射至高位的接收器5的太阳辐射的路径。在典型的LFR阵列中，反射器可以是在接收器处形成线聚焦的弯曲镜。</p><p
			// id=\"p0106\"
			// num=\"0106\">现参照图1C，示出了入射射线13与垂直于反射器(例如，反射器12)的入射反射面20的轴线Z之间的入射角θ。反射器具有宽度D。由于射线13以非直角θ入射在表面20上，所以反射器的有效收集宽度d由d＝Dcos(θ)得出。因此，反射器的有效收集面积随着入射角增大而减小。另外，反射损失可随着入射角增大而增加，并且诸如是像散的光学像差可随着入射角增大而增加。光学像差可减少聚焦由反射器反射至接收器的太阳辐射的能力，从而使入射在接收器上的辐射的聚焦模糊并降低了收集效率。</p><p
			// id=\"p0107\"
			// num=\"0107\">对于具有多个反射器场的系统而言，反射器场可关于接收器对称或不对称。例如可确定反射器场的组成和/或设置以增加地面地面面积使用率和/或系统收集效率。再次<!--
			// SIPO <DP n=\"15\">
			// -->参照图1A，两个反射器场10和16可关于高位的接收器5对称或不对称。在本例中，接收器5具有对称平面19。代表平面19的相对侧上的反射器排数的M和N可相同或不同。在设计成东-西定向的阵列的变型中，M和N可不同。接收器的极侧(例如，对于在北半球中使用的系统而言为北极)上的反射器场可具有比接收器的赤道侧上的反射器场多的接收器。2007年8月27日提交的美国专利申请11/895,869和2007年8月27日提交的国际专利申请PCT/AU2007/001232中描述了东-西向阵列的示例，前文已通过引用将各者全文结合于本文中。可选择地，接收器的中心的相对侧上的反射器排数(例如，图1A中M和N)可相同。例如，在将太阳辐射反射至共同的接收器的两个反射器场中，设计成南-北定向的阵列可在反射器数量方面对称。</p><p
			// id=\"p0108\"
			// num=\"0108\">对于给定的反射器场而言，相邻的反射器排可间隔开恒定的排间隔或可变的排间隔。例如，比相邻的第二反射器排中的反射器的倾斜程小的第一反射器排中的反射器可被组装成较靠近相邻的第二排中的反射器而不会造成遮挡。再次参照图1A，反射器场10中的相邻反射器排x和x+1之间的间隔为15Rx，x+1，其中1≤x≤M。反射器场12中的相邻的反射器排之间的间隔为17Ry，y+1，其中1≤y≤N。因而，反射器排间间隔15Rx，x+1可恒定，或15Rx，x+1可随着x变化而变化，并且反射器排间间隔17Ry，y+1可恒定，或17Ry，y+1可随着y变化而变化。</p><p
			// id=\"p0109\"
			// num=\"0109\">在阵列的特定变型中，相邻的反射器排之间的间隔可大体随着反射器排与接收器之间的距离变化。也就是说，更靠近接收器的反射器排可比更远离接收器的反射器排相隔更近。例如，如图1A所示，对于反射器场10而言，最靠近接收器5的前两排反射器15R1，2之间的间隔可小于距接收器5最远的两排接收器之间的间隔15RM-1，M。类似地，对于反射器场16而言，最靠近接收器5的前两排反射器17R1，2之间的间隔可小于距接收器5最远的两排接收器之间的间隔17RN-1，N。此类反射器排间隔的变化可适合于南-北定向的阵列。在阵列的特定变型中，反射器排之间的排间间隔可随反射器场而变化。此类构造可适合东-西定向的阵列。例如，赤道场中的反射器排可比极场中的反射器排相隔更近，因为赤道场中的反射器排中的反射器相对于相邻排中的反射器的倾斜度更小。</p><p
			// id=\"p0110\"
			// num=\"0110\">可变排间隔的使用可允许更靠近地组装反射器排，从而提高地面面积的利用率和/或减少相邻的反射器造成的反射器的遮挡。在一些系统中，反射器面积与地面面积的比率可大于约70％，或大于约75％，或大于约80％。可使用反射器排之间的恒定间隔和可变间隔的结合。例如，第一组反射器排——例如最靠近接收器的反射器排——可间隔开第一恒定的较窄间隔。第二组反射器排——例如距接收器最远的反射器排——可间隔开第二恒定的较宽间隔。另外，在单个系统中可在不同的反射器场之间使用不同的间隔方案。例如，一个反射器场可具有恒定的反射器排间隔，而一个反射器场可具有可变的反射器排间隔。对于包括约2.3米宽的反射器排的南-北定向阵列而言——该反射器排将太阳辐射引导至定位在反射器上方约15米处的、约0.6米宽的吸收器——中心到中心的反射器排间间距的范围可从约2.6米至接近3米(例如，约2.9米)。</p><p
			// id=\"p0111\"
			// num=\"0111\">应当注意的是，与在东-西方向上接近约180°相比，白昼太阳在南-北方向上移动通过小于约90°的角度。因此，对于东-西定向的阵列而言，反射器场中的各反射器仅需枢转移动小于约45°以在每个白昼周期期间跟随太阳。结果，极反射器场中的反射器的入射角通常小于赤道反射器场中的反射器的入射角。因此，极反射器场中的反射器与定位成<!--
			// SIPO <DP n=\"16\">
			// -->与接收器相距相同距离的赤道反射器场中的对应的反射器相比可具有更大的有效收集面积并在接收器处产生改善的聚焦。由于极反射器的提高的效率，可通过与赤道反射器场相比增加极反射器场中的相对反射器面积——例如，通过增加极场中反射器的数量——来提高太阳能阵列的整体收集效率。</p><p
			// id=\"p0112\"
			// num=\"0112\">太阳能收集器系统可包括多个高位的接收器，以及构造成将入射光引导至高位的接收器的多个反射器场。现参照图2A，太阳能阵列201包括四个反射器场210、212、214和216。反射器排211包括多个反射器211a。一反射器排中的反射器211a可被以同线方式联接在一起。例如，反射器211a可在接合部区域223经由共同的反射器支承件222(例如，箍)联接在一起。支承件222可构造成旋转地驱动联接在其上的一个或多个反射器以至少部分地跟踪太阳的白昼运动。单排或单排的一段中的反射器可由驱动装置如联接在主反射器支承件224上的马达(未示出)驱动，该主反射器支承件可定位在要被驱动的该排或排段内，以减少在反射器排的与主反射器支承件相距最远的部分处的扭转效应。包括2、4、6个或任何适当数量的反射器的排段可由联接在主反射器支承件上的驱动装置驱动。反射器排或排段可被单独驱动，或反射器排或排段可被分组(例如，分区域地)共同驱动。单个驱动装置可旋转多于一个的反射器排或排段，或多个驱动装置可同步或协同地同时旋转多于一个的反射器排或排段。</p><p
			// id=\"p0113\"
			// num=\"0113\">用于阵列中的驱动系统可包括构造成支承并旋转一个或多个反射器元件的任何合适的反射器支承件。一般而言，反射器支承件包括构造成支承一个或多个反射器元件的框架部分、基座和联动装置(linkage)，该联动装置将框架部分旋转地联接在基座上，使得框架部分可通过联动装置旋转以定位该一个或多个反射器元件。反射器支承件可被选择成减少支承件在任何反射器元件——例如，由该反射器支承件支承的一个或多个反射器元件和/或由相邻或附近的反射器支承件支承的一个或多个反射器元件——上的遮挡量。例如，驱动系统中的反射器支承件可构造成使得反射器支承件的框架部分基本上被限制在大体由被该框架支承的一个或多个反射器元件的反射面限定的平面区域的一侧，例如使得该框架在操作期间基本上处于该反射面下方。反射器支承件还可构造成具有强度和/或稳定性，例如抗扭强度和/或稳定性，使得当该反射器支承件旋转时由该反射器支承件支承的一个或多个反射器元件基本上不会扭曲或变形。</p><p
			// id=\"p0114\"
			// num=\"0114\">如上所述，驱动系统中的反射器支承件可构造成主反射器支承件或从反射器支承件，或可在主反射器支承件与从反射器支承件之间转换。主反射器支承件可联接在驱动装置(例如，包括马达的驱动装置)上。从反射器支承件可未直接联接在驱动装置上，而是联接在主反射器支承件(或联接在主支承件上的另一从支承件)上，使得主反射器支承件的旋转驱动从反射器支承件中的协同旋转。这样，可使用单个驱动装置来旋转反射器排或反射器排段。主反射器和驱动装置可构造成驱动任何合适数量的从反射器支承件，例如，一、二、三、四、五、六、七、八、九、十或十一个，或甚至更多。</p><p
			// id=\"p0115\"
			// num=\"0115\">图2B-2D示出了可在用于太阳能收集器阵列如线性菲涅尔反射器阵列的驱动系统中使用的反射器支承件的一些变型。支承件的这些变型均可构造成主反射器支承件或从反射器支承件。首先参照图2B所示的变型，反射器支承件260包括箍状框架261，其构造成支承一个或多个反射器元件(未示出)。框架261可以选择性地包括一个或多个横向构件262。如果存在，横向构件262可增加框架的抗扭强度。在一些变型中，反射器元件(未示<!--
			// SIPO <DP n=\"17\">
			// -->出)可联接在横向构件262上。在图2B所示的特殊变型中，反射器支承件260可包括基座263和将框架261旋转地联接在基座上的联动装置。在该特殊示例中，联动装置包括一个或多个旋转元件264(例如，轮)。如果反射器支承件260构造成主反射器支承件，则反射器支承件可联接有驱动装置(例如，马达)265。可采用任何合适的方式将驱动装置联接在支承件上，例如，使用一个或多个齿轮、带、驱?刺酢⑹嘧鄣取Ｈ绻瓷淦髦С屑?60构造成从支承件，则驱动装置265可未直接联接在反射器支承件260上，而是反射器支承件260可联接在另一反射器支承件上并由其驱动(例如，通过在反射器支承件之间延伸的一个或多个纵向构件(未示出))。下面提供关于结合有此类箍状反射器支承件的驱动系统的另外的细节。</p><p
			// id=\"p0116\"
			// num=\"0116\">本文所述的驱动系统和阵列中可使用反射器支承件的其它变型。现参照图2C，反射器支承件270包括基座271和框架272。基座272例如可包括一个或多个支柱或支座。一个或多个反射器元件276可由框架272支承。框架272可经由联动装置旋转地联接在基座271上。在本例中，联动装置包括毂273，该毂包括构造成绕轴274旋转的一个或多个轴承，其中毂273构造成支承件框架272。在一些变型中，轴274可包括两个丁字轴(stubaxle)。在本变型中，框架272基本上被限制在大体由一个或多个反射器元件276的反射面277限定的平面278的一侧。因而，框架272在操作期间可基本上处于反射面277下方，并因此可减少反射器支承件270在阵列中的任何反射器元件上的遮挡。应当指出的是，反射面277可以是弯曲的(凹入)，使得平面278可仅大体或大致由反射面277限定。如果反射器支承件270构造成为主支承件，则在轴274和/或毂273上可联接驱动装置(未示出)，以使框架272绕轴274旋转。可使用任何合适的驱动装置来使框架272绕轴274旋转。例如，可使用联接在马达上的齿轮、带、驱动链条、枢转臂等的任何结合。如果支承件270构造成为从支承件，则其可联接在另一反射器支承件上并由其驱动(例如，通过在反射器支承件之间延伸的一个或多个纵向构件(未示出))。</p><p
			// id=\"p0117\"
			// num=\"0117\">还可使用反射器支承件的其它变型。参照图2D，反射器支承件280可包括框架281，该框架包括箍的一部分。虽然图2D所示的变型将框架281显示为箍的大致180°弧，但其它变型也是可能的，其中使用具有围绕箍延伸大于或小于约180°弧的不同框架。框架281可任选地包括一个或多个辐条287，该辐条可向反射器支承件提供扭转稳定性。框架281可包括横向构件282，该横向构件例如可联接在一个或多个反射器元件289上。与图2B所示的变型相似，反射器支承件280可包括一个或多个旋转元件284(例如，轮)，该旋转元件可被安装在基座283上。在本变型中，框架281被限制在大体由该一个或多个反射器元件289的反射面288限定的平面290的一侧。因此，反射器支承件与图2D所示的那些相似可减少反射器元件在太阳能阵列中的遮挡。与反射器支承件260和270的情况一样，反射器支承件280可构造成由马达285驱动的主支承件，或可构造成为联接在另一反射器支承件上并由其驱动(例如，经由在反射器支承件之间延伸的一个或多个纵向构件(未示出))的从支承件。</p><p
			// id=\"p0118\"
			// num=\"0118\">在阵列内或在阵列中的反射器排内可使用反射器支承件和反射器支承件类型的任何结合。可选择反射器支承件的结合以提供沿着一排的增加的扭转稳定性、减少的遮挡、安装的容易性、制造的容易性和/或成本。在阵列的一些变型中，诸如图2A所示的阵列201，大部分反射器支承件可包括箍状框架。在图2E中，示出了用于阵列中(例如，阵列中的反<!--
			// SIPO <DP n=\"18\">
			// -->射器排的一部分中)的驱动系统291，其中主反射器支承件292包括箍状框架293并由驱动装置294驱动。从反射器支承件295又经由纵向延伸的构件(未示出)沿长度方向联接在一起，使得反射元件296在相邻的反射器支承件之间延伸。主支承件292的旋转然后驱动该排或排段中所有反射器元件296的旋转。在图2D所示的驱动系统变型中，从支承件295被选择成与图2C所示的那些相似，这可减少包括驱动系统291的阵列所受到的整体遮挡。一排或排段内可使用反射器支承件的其它结合，例如，在一个排段的一端或两端的从支承件可包括箍状框架。</p><p
			// id=\"p0119\"
			// num=\"0119\">如以上指出的，一些阵列可包括多于一个接收器。图2中的阵列201包括两个接收器205和215。接收器205被升高至反射器场210和212上方并在水平方向上定位在它们之间，接收器215被升高至反射器场214和216上方并在水平方向上定位在它们之间。反射器场210和212中的反射器构造成将入射的太阳辐射引导至接收器205，而反射器场214和216中的反射器构造成将入射的太阳辐射引导至接收器215。接收器可具有大体水平定向的孔口(例如，用于接收器205的孔口250)，经该孔口引导太阳辐射入射在接收器中的太阳能吸收器(未示出)上。在一些变型中，基本上对太阳辐射透明的窗可覆盖接收器孔口的至少一部分(例如，窗240被布置在接收器205的孔口250中)。接收器可包括接合在一起的多个接收器结构(例如，205a和215a)以形成细长接收器。接收器205和215通过竖直支承结构(例如，撑杆)218并通过拉线210稳定。拉线可被锚固在地面上，或它们可被锚固在另一结构上。</p><p
			// id=\"p0120\"
			// num=\"0120\">LFR阵列可占约5×103m2至约25×106m2的地面面积。例如，阵列可包括单个接收器以及设置在该接收器的相对侧上的两个反射器场而占约8.5×103m2的地面面积。其它阵列可包括多个接收器和多个反射器场而占更大的地面面积，例如，约5×106m2至约25×106m2。例如，图1A-1C和图2A所示的阵列可包括具有多个接收器和多个反射器场的更大的LFR阵列的一部分。在更大的阵列中，多个接收器和对应的反射器场可相邻且彼此平行地设置，与图2A中的接收器205和215及反射器场210、212、214和216一样。在系统的其它变型中，多个接收器和反射器场可以交替的构造设置。</p><p
			// id=\"p0121\"
			// num=\"0121\">用于太阳能收集器系统中的反射器可以是在此所述、本领域普通技术人员公知或以后开发的任何合适的反射器。国际专利申请PCT/AU2004/000883和PCT/AU2004/000884中公开了合适的反射器的非限制性示例，通过引用将各申请全文结合于本文中。</p><p
			// id=\"p0122\"
			// num=\"0122\">如图3和图4所示，合适的反射器可具有例如圆弧或抛物线截面，以在目标距离聚焦所反射的辐射。典型地，所聚焦的图像可为线聚焦。反射器的焦距可为从约10米至约25米。对于具有圆弧截面的反射器而言，这些焦距分别对应于约20米至约50米的曲率半径。反射器的一些变型可具有大致等于从反射器的反射面至接收器的距离的焦距。反射器的其它变型可具有长于从反射器的反射面至接收器的距离的焦距。</p><p
			// id=\"p0123\"
			// num=\"0123\">现参照图3，太阳能阵列301包括反射器311，该反射器构造成将入射的太阳辐射引导至包括太阳辐射吸收器(未示出)的高位的接收器305。反射器311可以是反射器场的部分，该反射器场包括将入射光引导至接收器305的平行反射器排，其中这些反射器排被驱动以至少部分地跟踪太阳的白昼运动。反射器311的反射面307反射以角度δ入射的光束313，使得所反射的光束313’在接收器305(例如，在接收器305中的太阳辐射吸收器)处形成聚焦图像325。在一些变型中，反射器311可构造成提供线聚焦，例如，反射器<!--
			// SIPO <DP n=\"19\">
			// -->311可为柱面镜。作为参考，虚线318示出了以垂直角度入射在反射面307上并被反射以在与反射面307相距距离320处形成聚焦图像310的光束的路径。距离320对应于反射器311的焦距。然而，对于以非垂直角度δ入射在反射面307上的光束313而言，从第一反射器边缘315和第二反射器边缘316反射的光射线313’可在与焦距320不对应的距离322(例如，在小于焦距320的距离)处形成它们最清晰的聚焦图像325。因而，对于接近垂直入射的光线反射器可具有大致等于反射面与接收器之间的距离的焦距，而对于与远非垂直入射的光线反射器可具有长于它们的反射面与接收器之间的距离的焦距。可通过利用后一种反射器至少部分地补偿由于光线的非垂直入射而引起的像散效应来实现增加的整体系统收集效率。</p><p
			// id=\"p0124\"
			// num=\"0124\">随着反射器与其对应的接收器之间的距离的增加，所需反射器的焦距也可增加。相应地，在接收器处的聚焦图像的尺寸也可增加。如果聚焦图像大于接收器，或越过接收器泄漏，则接收器的收集效率会降低。与接收器相距最远定位的反射器最接近阵列的周边。因此，接收器的表面上的入射角对于定位在周边的反射器而言增加，这可引起在接收器处的损失增加，例如，反射损失或由于如上所述的像散反射的不良聚焦而引起的损失。</p><p
			// id=\"p0125\"
			// num=\"0125\">现参照图4，太阳能阵列401包括反射器411，该反射器构造成将入射的太阳辐射413引导至包括太阳辐射吸收器(未示出)的接收器405。与图3中的反射器311相似，反射器411可以是反射器场的一部分。反射器411的反射面407反射以角度<img
			// id=\"ifd0001\"
			// file=\"http://search.cnipr.com:8080/XmlData/fm/20100915/200880112767.6/GPA00001109369200331.gif\"
			// wi=\"13\" he=\"16\" img-content=\"drawing\" img-format=\"tif\"
			// orientation=\"portrait\"
			// inline=\"yes\"/>入射的光束413，使得所反射的光束413’在接收器405(例如，在接收器405中的太阳辐射吸收器)处形成聚焦图像425。在一些变型中，反射器411可构造成提供线聚焦，例如，反射器411可为柱面镜。作为参考，虚线415示出了以垂直角度入射在反射面407上并被反射以在与反射面307相距距离420处形成聚焦图像410的光束的路径。距离420对应于反射器411的焦距。在本例中，入射光束413以较大的非垂直角度<img
			// id=\"ifd0002\"
			// file=\"http://search.cnipr.com:8080/XmlData/fm/20100915/200880112767.6/GPA00001109369200332.gif\"
			// wi=\"13\" he=\"16\" img-content=\"drawing\" img-format=\"tif\"
			// orientation=\"portrait\"
			// inline=\"yes\"/>到达反射面407。从第一反射器边缘415和第二反射器边缘416反射的光射线413’可在小于焦距420的距离422处形成它们最清晰的聚焦图像425。为了补偿这种像散效果，反射器的焦距可被选择成长于反射器的反射面与接收器(例如，接收器中的吸收器)之间的距离。例如，可使用具有比它们的反射面与接收器之间的距离长约1％至约15％(例如，约1％，约2％，约5％，约10％，或约15％)的焦距的反射器。</p><p
			// id=\"p0126\"
			// num=\"0126\">在一些阵列中，与接收器相距较远定位的周边反射器可具有长于它们与接收器相距的距离的焦距。阵列的一些变型可包括一系列平行反射器排，它们分别将入射光引导至高位的接收器。相应反射器排中的反射器的焦距可连续变化，使得与接收器的横向中心相距最远的那些反射器(的焦距)最长。此类连续变化可包括反射器焦距随着与接收器的横向中心相距的距离的增加而单调地增加，或(包括)增加的反射器焦距与增加的接收器-反射器距离之间的任何总体趋势或总体相关性。在一些阵列中，仅最外面的反射器排可包括具有长于它们相应的反射面-太阳能吸收器距离的焦距的反射器。例如，对于具有被导向至单个接收器的两个反射器场的阵列而言，仅最靠周边的两排或四排可具有长于它们相应的反射面-太阳能吸收器距离的焦距。采用具有长于它们与接收器的距离的焦距的一个或多个反射器的太阳能收集器系统可具有增加了约1％、约2％、约3％、约4％、约5％、约6％或甚至更多(例如，约10％)的整体收集效率，诸如年度光收集效率。</p><p
			// id=\"p0127\"
			// num=\"0127\">反射器可具有任何合适的尺寸。当然，反射器本质上可以是整体式的，并且包括单<!-- SIPO <DP
			// n=\"20\">
			// --></p></mode-for-invention></description></application-body></cn-patent-document>";
			if (httpGetInstance != null) { // 下载
				httpGetInstance = processXml.getHttpGetInstance();
			}
		} catch (Exception e) {
			xmlContant = "";
			e.printStackTrace();
		}

		resultList.add(xmlContant);
		resultList.add(httpGetInstance);

		return resultList;
	}

	public String clmXmlParse(BufferedReader bufferXml, int start, int end) {
		String xmlStr = "";

		try {
			// File f = new File("this.xml");
			SAXReader reader = new SAXReader(false);
			reader.setEntityResolver(new NoOpEntityResolver());
			Document doc = reader.read(bufferXml);
			Element root = doc.getRootElement();
			Element foo;
			Element elements = root.element("application-body").element(
					"claims");
			int index = 0;
			for (Iterator<?> i = elements.elementIterator("claim"); i.hasNext();) {
				foo = (Element) i.next();
				index++;
				if (index >= start && index <= end) {
					xmlStr += foo.asXML();
					if (index == end) {
						break;
					}
				}
			}
			// System.out.println(xmlStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xmlStr;
	}

	public String desXmlParse(BufferedReader bufferXml, int start, int end) {
		String xmlStr = "";

		try {
			// File f = new File("this.xml");
			SAXReader reader = new SAXReader();
			reader.setEntityResolver(new NoOpEntityResolver());
			Document doc = reader.read(bufferXml);
			Element root = doc.getRootElement();
			Element foo;
			Element elements = root.element("application-body").element(
					"description");

			Date startt = new Date();

			int index = 0;
			for (Iterator<?> i = elements.elementIterator(); i.hasNext();) {
				foo = (Element) i.next();
				if (foo.getName().equals("p")) {
					index++;
					if (index >= start && index <= end) {
						xmlStr += foo.asXML();
						if (index == end) {
							Date middle = new Date();
							System.out.println("searchTime:"
									+ (middle.getTime() - startt.getTime())
									+ "ms");
							return xmlStr;
						}
					}
				}
				Element elementP;
				for (Iterator<?> j = foo.elementIterator("p"); j.hasNext();) {
					elementP = (Element) j.next();
					index++;
					// System.out.println(index);
					if (index >= start && index <= end) {
						xmlStr += elementP.asXML();
						if (index == end) {
							Date middle = new Date();
							System.out.println("searchTime:"
									+ (middle.getTime() - startt.getTime())
									+ "ms");
							return xmlStr;
						}
					}
				}
			}
			Date middle = new Date();
			System.out.println("searchTime:"
					+ (middle.getTime() - startt.getTime()) + "ms");
			// for (Iterator<?> i = elements.elementIterator("claim");
			// i.hasNext();) {
			// foo = (Element) i.next();
			// index++;
			// if (index >= start && index <= end) {
			// xmlStr += foo.asXML();
			// if (index == end) {
			// break;
			// }
			// }
			// }
			// System.out.println(xmlStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return xmlStr;
	}

	@SuppressWarnings("unused")
	private List getXmlContant(String wap,String rootPath, String strSources, String an,
			String pd, String ft_type, int startPage, int endPage,
			HttpGet httpGetInstance) {
		List resultList = new ArrayList();

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

		String column = "";
		if (ft_type.equals("<claims>")) {
			column = "权利要求书";
		} else if (ft_type.equals("<description>")) {
			column = "说明书";
		} else {
			column = "说明书附图";
		}

		String xmlContant = "";
		// String s = null;
		String strTemp = "";
		BufferedReader reader = null;
		BufferedReader bufferXml = null;
		InputStream src_is = null;
		try {
			byte[] xmlByteArray = getXmlDocument(wap,strSources, strWhere, column);
			// System.out.println("xmlByteArray[0]="+ xmlByteArray[0]+";
			// xmlByteArray[1]="+xmlByteArray[1]);
			int i = 0;
			while (xmlByteArray[i] < 0) {
				i++;
			}
			byte[] paaseXmlByteArray = new byte[xmlByteArray.length - i];
			System.arraycopy(xmlByteArray, i, paaseXmlByteArray, 0,
					paaseXmlByteArray.length);
			src_is = new ByteArrayInputStream(paaseXmlByteArray);
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));

			// while ((s = reader.readLine()) != null) { // while loop begins
			// here
			// xmlContant += s;
			// System.out.println(xmlContant);
			// } // end

			// xmlContant = reader.readLine();
			// while (reader.readLine() != null) {
			// xmlContant += reader.readLine();
			// }
			// System.out.println(xmlContant);
			// bufferXml = new BufferedReader(new CharArrayReader(xmlContant
			// .toCharArray()));
			if (ft_type.equals("<claims>")) {
				strTemp = clmXmlParse(reader, startPage, endPage - 1);
			} else if (ft_type.equals("<description>")) {
				strTemp = desXmlParse(reader, startPage, endPage - 1);
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
				if (bufferXml != null) {
					bufferXml.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		// System.out.println(strTemp);
		XMLContentProcess processXml = new XMLContentProcess(strSources, 0);
		strTemp = processXml.setPrePostfix(strTemp, ft_type, ft_type.replace(
				"<", "</"));

		try {

			// xmlContant = processXml.convert(rootPath, an, pd, strTemp, 0);
			xmlContant = processXml.replaceInnerPICXML(rootPath, strTemp, an,
					pd);

			if (httpGetInstance != null) { // 下载
				httpGetInstance = processXml.getHttpGetInstance();
			}
		} catch (Exception e) {
			xmlContant = "";
			e.printStackTrace();
		}
		resultList.add(xmlContant);
		resultList.add(httpGetInstance);

		return resultList;
	}

	@SuppressWarnings("unused")
	public List getAllXmlContant(String wap, String rootPath, String strSources, String an,
			String pd, HttpGet httpGetInstance) {
		List resultList = new ArrayList();

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

		String xmlContant = "";
		String strTemp = "";
		BufferedReader reader = null;

		InputStream src_is = null;
		try {
			src_is = new ByteArrayInputStream(getXmlDocument(wap, strSources,
					strWhere, "权利要求书"));
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			boolean b_begin = false;
			// if (int_start == 1) {
			// b_begin = true;
			// }
			while (xmlContant != null) {
				xmlContant = xmlContant.trim();
				String prefix = "";
				prefix = "<claims>";
				if (xmlContant.indexOf(prefix) > -1) {
					b_begin = true;
					xmlContant = xmlContant.substring(xmlContant
							.indexOf(prefix));
					// xmlContant = xmlContant.replace(prefix, "");
					// strTemp+=xmlContant;
				}
				// int sum = int_end - 1;
				prefix = "</claims>";
				if (xmlContant.indexOf(prefix) > -1) {
					strTemp += xmlContant.substring(0, xmlContant
							.indexOf(prefix));
					break;
				}
				if (b_begin) {
					strTemp += xmlContant;
				}

				xmlContant = reader.readLine();
				// tmpString = br.readLine();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		strTemp += "</claims>";

		try {
			src_is = new ByteArrayInputStream(getXmlDocument(wap,strSources,
					strWhere, "说明书"));
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			boolean b_begin = false;
			// if (int_start == 1) {
			// b_begin = true;
			// }
			while (xmlContant != null) {
				xmlContant = xmlContant.trim();
				String prefix = "<description>";
				if (xmlContant.indexOf(prefix) > -1) {
					b_begin = true;
					xmlContant = xmlContant.substring(xmlContant
							.indexOf(prefix));
					// xmlContant = xmlContant.replace(prefix, "");
					// strTemp+=xmlContant;
				}
				// int sum = int_end - 1;
				prefix = "</description>";
				if (xmlContant.indexOf(prefix) > -1) {
					strTemp += xmlContant.substring(0, xmlContant
							.indexOf(prefix));
					break;
				}
				if (b_begin) {
					strTemp += xmlContant;
				}

				xmlContant = reader.readLine();
				// tmpString = br.readLine();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		strTemp += "</description>";
		try {
			src_is = new ByteArrayInputStream(getXmlDocument(wap,strSources,
					strWhere, "说明书附图"));
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			boolean b_begin = false;
			// if (int_start == 1) {
			// b_begin = true;
			// }
			while (xmlContant != null) {
				xmlContant = xmlContant.trim();
				String prefix = "<drawings>";
				if (xmlContant.indexOf(prefix) > -1) {
					b_begin = true;
					xmlContant = xmlContant.substring(xmlContant
							.indexOf(prefix));
					// xmlContant = xmlContant.replace(prefix, "");
					// strTemp+=xmlContant;
				}
				// int sum = int_end - 1;
				prefix = "</drawings>";
				if (xmlContant.indexOf(prefix) > -1) {
					strTemp += xmlContant.substring(0, xmlContant
							.indexOf(prefix));
					break;
				}
				if (b_begin) {
					strTemp += xmlContant;
				}

				xmlContant = reader.readLine();
				// tmpString = br.readLine();
			}
			strTemp += "</drawings>";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		XMLContentProcess processXml = new XMLContentProcess(strSources, 0);
		processXml.setPrePostfix("", "");

		try {
			xmlContant = processXml.convert(rootPath, an, pd, strTemp, 0);
			if (httpGetInstance != null) { // 下载
				httpGetInstance = processXml.getHttpGetInstance();
			}
		} catch (Exception e) {
			xmlContant = "";
			e.printStackTrace();
		}

		resultList.add(xmlContant);
		resultList.add(httpGetInstance);

		return resultList;
	}

	public List getXmlContantByType(String wap, String rootPath, String strSources,
			String an, String pd, HttpGet httpGetInstance, String xmlType) {
		List resultList = new ArrayList();

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

		String searchSource = "";
		if (xmlType.equals("drawings")) {
			searchSource = "说明书附图";
		} else if (xmlType.equals("claims")) {
			searchSource = "权利要求书";
		} else {
			searchSource = "说明书";
		}

		String xmlContant = "";
		String strTemp = "";
		BufferedReader reader = null;

		InputStream src_is = null;
		try {
			src_is = new ByteArrayInputStream(getXmlDocument(wap, strSources,
					strWhere, searchSource));
			reader = new BufferedReader(new InputStreamReader(src_is, "UTF-8"));
			xmlContant = reader.readLine();
			boolean b_begin = false;
			// if (int_start == 1) {
			// b_begin = true;
			// }
			while (xmlContant != null) {
				xmlContant = xmlContant.trim();
				String prefix = "<" + xmlType + ">";
				if (xmlContant.indexOf(prefix) > -1) {
					b_begin = true;
					xmlContant = xmlContant.substring(xmlContant
							.indexOf(prefix));
					// xmlContant = xmlContant.replace(prefix, "");
					// strTemp+=xmlContant;
				}
				// int sum = int_end - 1;
				prefix = "</" + xmlType + ">";
				if (xmlContant.indexOf(prefix) > -1) {
					strTemp += xmlContant.substring(0, xmlContant
							.indexOf(prefix));
					break;
				}
				if (b_begin) {
					strTemp += xmlContant;
				}

				xmlContant = reader.readLine();
				// tmpString = br.readLine();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
				if (src_is != null)
					src_is.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		strTemp += "</" + xmlType + ">";

		XMLContentProcess processXml = new XMLContentProcess(strSources, 0);
		processXml.setPrePostfix("", "");

		try {
			xmlContant = processXml.convert(rootPath, an, pd, strTemp, 0);
			if (httpGetInstance != null) { // 下载
				httpGetInstance = processXml.getHttpGetInstance();
			}
		} catch (Exception e) {
			xmlContant = "";
			e.printStackTrace();
		}

		resultList.add(xmlContant);
		resultList.add(httpGetInstance);

		return resultList;
	}

	// 同义词检索
	public SynonymSearchResponse synonymSearch(String strSources,
			String strWhere) throws Exception {
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(0);
		SynonymSearchResponse response = null;
		try {
			response = client.synonymSearch(strSources, strWhere);
		} catch (Exception e) {
			response = null;
			throw e;
		}
		return response;
	}

	// 分词检索
	public ParticipleSearchResponse participleSearch(String strSources,
			String strOwner, String strWhere) throws Exception {
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(0);
		ParticipleSearchResponse response = null;
		try {
			response = client.participleSearch(strSources, strOwner, strWhere);
		} catch (Exception e) {
			response = null;
			throw e;
		}
		return response;
	}
	
	public static int testTIF(String TIFUrl) throws Exception {
		int responseCode = 200;		
//		String siteurl = "http://search.cnipr.com";		
//		siteurl = "http://10.33.4.3/BOOKS/FM/2000/20000105/98102643.5/000001.TIF";
////////////////////////////////////////  访问网站首页  ////////////////////////////////////
		String pic = "000001.TIF";
		
		String showPIC = DataAccess.get("showPIC")==null?"0":DataAccess.get("showPIC");
		if(showPIC.equals("0")){
			pic = "000001.TIF";
		}else if(showPIC.equals("1")){
			pic = "000001.PNG";
		}		
		
        URL url = null;
        URLConnection URLconnection = null;
        HttpURLConnection httpConnection = null;
        
        try
        {
            url = new URL(DataAccess.getProperty("PicServerURL") + "/" +TIFUrl + "/" + pic);
            URLconnection = url.openConnection();
            URLconnection.setConnectTimeout(10000);
            URLconnection.setReadTimeout(10000);
            URLconnection.setAllowUserInteraction(false);         
            URLconnection.setDoOutput(true);
            
            httpConnection = (HttpURLConnection)URLconnection;
            responseCode = httpConnection.getResponseCode();
        }
        catch (Exception e)
        {
        	responseCode = 404;
        }
        finally
        {
            try
            {
            	httpConnection.disconnect();
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
        
        return responseCode;
	}

//	gd_zbzz_1_2_2,2014,2018,1-1#标签3
	private static String getLabelName(String labelID) {
		String labelname = "";
		
		String[] arr = labelID.split("-");
		labelname = "标签"+(arr.length+1);
		
		return labelname;
	}
	
	public static void main1(String[] args) {
		
		String labelname = getLabelName("1");
		System.out.println(labelname);
		
		labelname = getLabelName("1-1");
		System.out.println(labelname);
		
		labelname = getLabelName("1-1-1");		
		System.out.println(labelname);
		
		labelname = getLabelName("1-1-1-1");		
		System.out.println(labelname);
		
/*		String str = "<?xml version=\"1.0\"?><!DOCTYPE cn-patent-document SYSTEM \"dtd/cn-patent-document-06-10-27.dtd\"><?xml-stylesheet type=\"text/xsl\" href=\"xsl/XSL0117new.xsl\"?><?trs-parser SegmentMark=\"paragraph\" NewLineMark=\"br\" HitShowMark=\"TRSHL\" FilterCData=\"yes\"?><cn-patent-document lang=\"ZH\" country=\"CN\"><application-body lang=\"CN\" country=\"CN\"><claims><claim id=\"cl0001\" num=\"0001\"><claim-text>1.一种触摸屏贴片机，包括机架、行走传动机构、贴片工作台、驱动机构和上腔，所述行走传动机构固定于机架上，所述贴片工作台设于行走传动机构上方，驱动机构设于贴片工作台的一侧，驱动机构连接有转轴，上腔通过转轴与驱动机构可翻转地连接，并设于贴片工作台的一侧；所述上腔的水平高度高于贴片工作台的水平高度，其特征在于：机架的上方还设有若干个上腔缓冲机构，各个上腔缓冲机构分别对应转轴两侧设置，其高度高于贴片工作台的高度；所述行走传动机构的两端设有若干个工作台缓冲机构，并均固定于机架上；上腔和贴片工作台均为腔体结构，其外侧均分别连接有与其连通的正压气管；所述上腔和贴片工作台的上表面均设有若干个真空吸孔；所述机架内设有控制箱，控制箱分别连接正压气管和驱动机构。</claim-text></claim><claim id=\"cl0002\" num=\"0002\"><claim-text>2.根据权利要求1所述的触摸屏贴片机，其特征在于：所述上腔缓冲机构通过固定块固定于机架上；所述上腔缓冲机构的上方对应设有上腔升降感应阀，上腔升降感应阀与驱动机构连接。</claim-text></claim><claim id=\"cl0003\" num=\"0003\"><claim-text>3.根据权利要求1所述的触摸屏贴片机，其特征在于：所述上腔缓冲机构为一上腔缓冲头，所述上腔缓冲头下端连接有弹簧，弹簧固定于固定块上；</claim-text><claim-text>所述工作台缓冲机构包括缓冲头、固定架和弹簧，所述缓冲头与弹簧连接，弹簧与固定架连接，固定架固定于机架上。</claim-text></claim><claim id=\"cl0004\" num=\"0004\"><claim-text>4.根据权利要求3所述的触摸屏贴片机，其特征在于：所述上腔缓冲机构的上腔缓冲头和工作台缓冲机构的缓冲头均为带硅胶头。</claim-text></claim><claim id=\"cl0005\" num=\"0005\"><claim-text>5.根据权利要求1所述的触摸屏贴片机，其特征在于：所述贴片工作台和行走传动机构之间还设有固定机构，所述固定机构包括位置调节块和传动底板，所述传动底板设于行走传动机构，并与行走传动机构连接；所述位置调节块设于传动底板的上方和贴片工作台的下方，且分别与传动底板和贴片工作台连接。</claim-text></claim><claim id=\"cl0006\" num=\"0006\"><claim-text>6.根据权利要求5所述的触摸屏贴片机，其特征在于：所述位置调节块的四个侧边上分别设有微调组件。</claim-text></claim><claim id=\"cl0007\" num=\"0007\"><claim-text>7.根据权利要求5所述的触摸屏贴片机，其特征在于：所述行走传动机构为滑轨组件，并与传动底板滑动连接。</claim-text></claim><claim id=\"cl0008\" num=\"0008\"><claim-text>8.根据权利要求1所述的触摸屏贴片机，其特征在于：所述上腔缓冲机构的个数至少为两个，分别设于转轴的左右两边；所述工作台缓冲机构的个数至少为两个，分别设于行走传动机构的两端。</claim-text></claim><claim id=\"cl0009\" num=\"0009\"><claim-text>9.根据权利要求1所述的触摸屏贴片机，其特征在于：所述驱动机构包括气缸和气缸座，气缸座固定于机架上，气缸固定于气缸座上；所述转轴与气缸座连接，并通过气缸座支撑在机架上方。</claim-text></claim><claim id=\"cl0010\" num=\"0010\"><claim-text>10.根据权利要求1所述的触摸屏贴片机，其特征在于：所述贴片工作台的边缘上连接有靠位块；所述上腔的边缘设有橡胶滚筒。</claim-text></claim><!-- SIPO <DP n=\"1\"> --></claims><description><invention-title id=\"tilte1\">一种触摸屏贴片机</invention-title><technical-field id=\"technical-field001\"><p id=\"p0001\" num=\"0001\">技术领域</p><p id=\"p0002\" num=\"0002\">本实用新型涉及触摸屏贴片加工技术领域，特别涉及一种触摸屏贴片机。</p></technical-field><background-art id=\"background-art001\"><p id=\"p0003\" num=\"0003\">背景技术</p><p id=\"p0004\" num=\"0004\">在触摸屏等产品的加工过程中，一般需将触摸屏面板和触摸屏线路(薄膜材料)贴合在一起，而目前现有的贴片机结构一般采用双面胶粘住材料进行贴合加工，且没有设有吸风装置及缓冲装置。这种结构的缺点在于：(1)靠双面胶粘住材料进行贴合，贴合出来的材料会有错位现象，准确度达不到要求；(2)没有吸风装置及缓冲装置，在贴合过程中会产生很大的振动，精度容易受影响，产品质量和精度都不高；(3)这种结构在加工过程中容易受外力左右移动跑位，影响加工。</p></background-art><disclosure id=\"disclosure001\"><p id=\"p0005\" num=\"0005\">实用新型内容</p><p id=\"p0006\" num=\"0006\">本实用新型的目的在于克服现有技术的缺点与不足，提供一种结构简单、合理，既能吸覆材料又无振动的触摸屏贴片机。</p><p id=\"p0007\" num=\"0007\">本实用新型的目的通过下述技术方案实现：一种触摸屏贴片机，包括机架、行走传动机构、贴片工作台、驱动机构和上腔，所述行走传动机构固定于机架上，所述贴片工作台设于行走传动机构上方，驱动机构设于贴片工作台的一侧，驱动机构连接有转轴，上腔通过转轴与驱动机构可翻转地连接，并设于在贴片工作台的一侧；所述上腔的水平高度高于贴片工作台的水平高度，机架的上方还设有若干个上腔缓冲机构，各个上腔缓冲机构分别对应转轴两侧设置，其高度高于贴片工作台的高度；所述行走传动机构的两端设有若干个工作台缓冲机构，并均固定于机架上；上腔和贴片工作台均为腔体结构，其外侧均分别连接有与其连通的正压气管；所述上腔和贴片工作台的上表面均设有若干个真空吸孔；所述机架内设有控制箱，控制箱分别连接正压气管和驱动机构。</p><p id=\"p0008\" num=\"0008\">所述上腔缓冲机构通过固定块固定于机架上；所述上腔缓冲机构的上方对应设有上腔升降感应阀，上腔升降感应阀与驱动机构连接。</p><p id=\"p0009\" num=\"0009\">所述上腔缓冲机构为一上腔缓冲头，所述上腔缓冲头下端连接有弹簧，弹簧固定于固定块上；</p><p id=\"p0010\" num=\"0010\">所述工作台缓冲机构包括缓冲头、固定架和弹簧，所述缓冲头与弹簧连接，弹簧与固定架连接，固定架固定于机架上。</p><p id=\"p0011\" num=\"0011\">所述上腔缓冲机构的上腔缓冲头和工作台缓冲机构的缓冲头均优选为带硅胶头。</p><p id=\"p0012\" num=\"0012\">所述贴片工作台和行走传动机构之间还设有固定机构，所述固定机构包括位置调节块和传动底板，所述传动底板设于行走传动机构，并与行走传动机构连接；所述位置调节块设于传动底板的上方和贴片工作台的下方，且分别与传动底板和贴片工作台连接。</p><p id=\"p0013\" num=\"0013\">所述位置调节块的四个侧边上分别设有微调组件。</p><p id=\"p0014\" num=\"0014\">所述行走传动机构为滑轨组件，并与传动底板滑动连接。</p><p id=\"p0015\" num=\"0015\">所述上腔缓冲机构的个数至少为两个，分别设于转轴的左右两边；所述工作台缓<!-- SIPO <DP n=\"1\"> -->冲机构的个数至少为两个，分别设于行走传动机构的两端。</p><p id=\"p0016\" num=\"0016\">所述驱动机构包括气缸和气缸座，气缸座固定于机架上，气缸固定于气缸座上；所述转轴与气缸座连接，并通过气缸座支撑在机架上方。</p><p id=\"p0017\" num=\"0017\">所述贴片工作台的边缘上连接有靠位块；所述上腔的边缘设有橡胶滚筒。</p><p id=\"p0018\" num=\"0018\">本实用新型的作用过程：开始时，上腔处于转轴的右边，设有真空吸孔的一面朝上，将触摸屏面板放置于上腔上；将触摸屏线路放置于贴片工作台上，并由靠位块进行L型靠位；通过控制箱控制，分别开启连通贴片工作台和上腔的正压吸管，上腔上的真空吸孔吸住触摸屏面板，贴片工作台上的真空吸孔吸住触摸屏线路；通过控制箱启动气缸，气缸通过转轴将上腔逆时针翻转，即向贴片工作台翻转；传动底板在行走传动机构上往右行走，同时将贴片工作台往右传送；当上腔的滚筒接近贴片工作台上端位置时，上腔升降感应阀接触上腔缓冲机构，使得上腔开始减速下压，以减轻滚筒对触摸屏面板等的瞬间压力。同时，传动底板继续前进，当接触位于行走传动机构端部的工作台缓冲机构时，贴片工作台则开始减速慢行，避免高速运动撞击贴片工作台上的触摸屏面板造成振动且对触摸屏面板造成破坏。触摸屏面板与触摸屏线路在贴片工作台行走过程中粘合在一起。完成贴片后，正压吸管自动关闭，上腔和贴片工作台回复原位，完成贴片过程。</p><p id=\"p0019\" num=\"0019\">本实用新型与现有技术相比，具有如下优点和有益效果：</p><p id=\"p0020\" num=\"0020\">1、本实用新型在贴片工作台四周设有微调组件，可进行前后左右的调节，使得触摸屏线路与触摸屏面板的对位准确，贴合效果精确。</p><p id=\"p0021\" num=\"0021\">2、本实用新型采用真空吸孔吸覆触摸屏面板及触摸屏线路，使其受外力保持均衡，触摸屏面板与触摸屏线路平稳，不易走动，能够有效确保加工质量。</p><p id=\"p0022\" num=\"0022\">3、本实用新型通过控制箱控制贴片工作台和上腔的运动，具有对位难度低、对位准确、不易跑位、贴片效果好、安全性能好、生产质量高等优点。</p><p id=\"p0023\" num=\"0023\">4、本实用新型设有工作台缓冲机构和上腔缓冲机构，使得上腔升降时和贴片工作台左右行走时的速度能够得到及时缓冲，达到瞬间减速的目的，避免撞击贴片工作台上的物件造成振动且对物件造成破坏，具有机器平稳、噪音小、设备周边环境气流好和洁净度高等优点。</p></disclosure><description-of-drawings id=\"description-of-drawings001\"><p id=\"p0024\" num=\"0024\">附图说明</p><p id=\"p0025\" num=\"0025\">图1是本实用新型的具体结构示意图。</p><p id=\"p0026\" num=\"0026\">图2是图1所示结构初始状态的俯视图。</p></description-of-drawings><mode-for-invention id=\"mode-for-invention001\"><p id=\"p0027\" num=\"0027\">具体实施方式</p><p id=\"p0028\" num=\"0028\">下面结合实施例及附图对本实用新型作进一步详细的描述，但本实用新型的实施方式不限于此。</p><p id=\"p0029\" num=\"0029\">实施例1</p><p id=\"p0030\" num=\"0030\">图1～图2示出了本实用新型的具体结构图，如图1所示，本触摸屏贴片机，包括机架1、行走传动机构4、贴片工作台9、驱动机构和上腔13，所述行走传动机构4固定于机架1上，所述贴片工作台9设于行走传动机构4上方，驱动机构设于贴片工作台9的一侧，驱动机构连接有转轴28，上腔13通过转轴28与驱动机构可翻转地连接并设于在贴片工作<!-- SIPO <DP n=\"2\"> -->台9的一侧；所述上腔13的水平高度高于贴片工作台9的水平高度，机架1的上方还设有两个上腔缓冲机构15，各个上腔缓冲机构15分别对应转轴28两侧设置，其高度高于贴片工作台9的高度；所述行走传动机构4的两端设有两个工作台缓冲机构3，并均固定于机架1上；上腔13和贴片工作台9均为腔体结构，其外侧均分别连接有与其连通的正压气管23、20，即上腔13外侧的正压气管23与上腔13的腔体连通，贴片工作台9外侧的正压气管20与贴片工作台9的腔体连通；所述上腔13的上表面均设有若干个真空吸孔27；贴片工作台9的上表面均设有若干个真空吸孔19；所述机架1内设有控制箱2，控制箱2分别连接行走传动机构4、驱动机构和正压气管20、23。</p><p id=\"p0031\" num=\"0031\">所述上腔缓冲机构15通过固定块26固定于机架1上；所述上腔缓冲机构15的上方对应设有上腔升降感应阀14，上腔升降感应阀14与驱动机构连接。</p><p id=\"p0032\" num=\"0032\">所述上腔缓冲机构15为一上腔缓冲头，所述上腔缓冲头下端连接有弹簧，弹簧固定于固定块上；上腔缓冲头为带硅胶头。</p><p id=\"p0033\" num=\"0033\">所述工作台缓冲机构3包括缓冲头、固定架和弹簧，所述缓冲头与弹簧连接，弹簧与固定架连接，固定架固定于机架上；缓冲头为带硅胶头。</p><p id=\"p0034\" num=\"0034\">两个上腔缓冲机构15分别设于转轴28的左右两边；两个工作台缓冲机构3分别设于行走传动机构4的两端。</p><p id=\"p0035\" num=\"0035\">所述贴片工作台9和行走传动机构4之间还设有固定机构，所述固定机构包括位置调节块8和传动底板6，所述传动底板6设于行走传动机构4，并与行走传动机构4连接；所述位置调节块8设于传动底板6的上方和贴片工作台9的下方，且分别与传动底板6和贴片工作台9连接。如图1所示，在贴片工作台9的侧边还设有前后调节阀12，用于调节贴片工作台9的前后位置。</p><p id=\"p0036\" num=\"0036\">如图2所示，所述位置调节块8的四个侧边上分别设有微调组件5。</p><p id=\"p0037\" num=\"0037\">如图2所示，所述贴片工作台9的边缘上设有靠位块7。</p><p id=\"p0038\" num=\"0038\">所述上腔13的边缘设有橡胶滚筒10。如图1所示，所述上腔13上还对应设有橡胶滚筒固定块11，与橡胶滚筒10的位置相对应设置。</p><p id=\"p0039\" num=\"0039\">所述驱动机构包括气缸17和气缸座16，气缸座16固定于机架1上，气缸17固定于气缸座16上；所述转轴28与气缸座16连接，并通过气缸座16支撑在机架上方。</p><p id=\"p0040\" num=\"0040\">所述行走传动机构4为滑轨组件，并与传动底板6滑动连接。</p><p id=\"p0041\" num=\"0041\">本实用新型的作用过程：开始时，如图2所示，上腔13处于转轴28的右边，将触摸屏面板24放置于上腔13上；将触摸屏线路21放置于贴片工作台9上，并由靠位块7进行L型靠位；通过控制箱2控制，分别开启连通贴片工作台9和上腔13的正压吸管，上腔13上的真空吸孔吸住触摸屏面板24，贴片工作台9上的真空吸孔吸住触摸屏线路21；通过控制箱2启动行走传动机构4和气缸17，气缸17通过转轴28将上腔13逆时针翻转，即向贴片工作台9翻转；传动底板6在行走传动机构4上往右行走，同时将贴片工作台9往右传送；如图1所示，当上腔13的滚筒接近贴片工作台9上端位置时，上腔升降感应阀14接触上腔缓冲机构15，使得上腔开始减速下压，以减轻滚筒对触摸屏面板24等的瞬间压力。同时，传动底板6继续前进，当接触位于行走传动机构4端部的工作台缓冲机构3时，贴片工作台9则开始减速慢行，避免高速运动撞击贴片工作台9上的触摸屏线路21造成振动且对触摸屏线路21造成破坏。触摸屏面板24与触摸屏线路21在贴片工作台9行走过程中粘合在一<!-- SIPO <DP n=\"3\"> -->起。完成贴片后，正压吸管自动关闭，上腔13和贴片工作台9回复原位，完成贴片过程。</p><p id=\"p0042\" num=\"0042\">实施例2</p><p id=\"p0043\" num=\"0043\">本实施例除下述特征外其他结构同实施例1：所述上腔缓冲机构的个数为四个，其中两个并列设于转轴的左边，另两个并列设于转轴的右边。</p><p id=\"p0044\" num=\"0044\">上述各实施例为本实用新型较佳的实施方式，但本实用新型的实施方式并不受上述实施例的限制，其他的任何未背离本实用新型的精神实质与原理下所作的改变、修饰、替代、组合、简化，均应为等效的置换方式，都包含在本实用新型的保护范围之内。</p></mode-for-invention><!-- SIPO <DP n=\"4\"> --></description><drawings><figure id=\"f0001\" num=\"0001\" figure-labels=\"图1\"><img id=\"ifi0001\" file=\"http://search.cnipr.com:8080/XmlData/xx/20101124/201020152076.3/HSA00000075229600011.GIF\" wi=\"617\" he=\"305\" img-content=\"drawing\" img-format=\"gif\" orientation=\"portrait\" inline=\"no\"/></figure><figure id=\"f0002\" num=\"0002\" figure-labels=\"图2\"><img id=\"ifi0002\" file=\"http://search.cnipr.com:8080/XmlData/xx/20101124/201020152076.3/HSA00000075229600012.GIF\" wi=\"585\" he=\"401\" img-content=\"drawing\" img-format=\"gif\" orientation=\"portrait\" inline=\"no\"/></figure><!-- SIPO <DP n=\"1\"> --></drawings></application-body></cn-patent-document>";
		BufferedReader bufferXml = new BufferedReader(new CharArrayReader(str
				.toCharArray()));
		SearchFunc s = new SearchFunc();
		System.out.println(s.desXmlParse(bufferXml, 5, 9));
		*/
		// str = str.replace("\"", "\\\"");
		// System.out.println(str);
		SearchAction sa = new SearchAction();
		
//		filterSemanticExp		
		
		String strWhere = "(名称=('计算机')) AND 主权项语义,摘要语义+='包括 阵列 基板 彩膜 基板 阵列 基板' NOT PATTYPE=(外观设计) NOT 公开年=(2001) NOT 主权项语义,摘要语义+='船底 舷侧 船体'";
		
		if(strWhere.indexOf("主权项语义,摘要语义+=")>-1) {
/*			Pattern pattern = Pattern.compile("([A-Z]){0,2}[0-9]+.([A-Z]|[0-9])");
			Matcher matcher = pattern.matcher(strWhere);
			while (matcher.find()) {
				findStr = matcher.group();
			}
*/
//			pattern = Pattern.compile("(file=\"[^\u4e00-\u9fa5]+?(." + strGif_Tif + ")\")+");
			List<String> strList = new ArrayList<String>();
//			Pattern pattern = Pattern.compile("(主权项语义,摘要语义+='[\\u0391-\\uFFE5]+')");
			Pattern pattern = Pattern.compile("'([^']*')");
			Matcher matcher = pattern.matcher(strWhere);
			int end = 0;
//			^[a-zA-Z]*$ 这个正则是以字母开头
			while (matcher.find()) {
//				System.out.println(matcher.group());				
				if(strWhere.indexOf("主权项语义,摘要语义+="+matcher.group())>-1) {
					String result = "主权项语义,摘要语义+='"+matcher.group()+"'";
					strList.add(strWhere.substring(end, matcher.start()-13));
					strList.add(result);
					end = matcher.end();
				}				
//				System.out.println(result);
//				strList.add(strWhere.substring(end, matcher.start()));				
			}
			String old = strWhere;
			strWhere = "";
			for (int i = 0; i < strList.size(); i++) {
				String str = (String) strList.get(i);
				if(str.indexOf("主权项语义,摘要语义+=")>-1)
				{
					str = "主权项语义,摘要语义+='" +sa.filterSemanticExp(str) + "'";
				}				
				strWhere += str + " ";
			}
			strWhere = strWhere + old.substring(end);
			
			System.out.println(strWhere);			
		}
	}

	public static float countTime(long begin,long end){
		float total_seceond = 0;
		try {
			long sss = end - begin;
//			System.out.println(sss);
			total_seceond = (end - begin)/1000.00F;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return total_seceond;
	}

	public static void main(String[] args) {
		long begin;
		long end;
		OverviewSearchResponse overviewResponse = null;
		ICoreBizFacade client = CoreBizClient.getCoreBizClient(0);
		try {
			begin = System.currentTimeMillis();
			System.out.println("begin......"+begin);
			
			overviewResponse = client.executeOutlineSearch("fmzl_ft,syxx_ft,wgzl_ab",
					"名称=(计算机)", "RELEVANCE", "", "主权项, 名称, 摘要", 0,
					0, false, 0, 5000,
					"", "3");
			
			end = System.currentTimeMillis();
			System.out.println("end......"+end);
			
			System.out.println(begin+"......"+overviewResponse.getPatentInfoList().size()+"条......"+ end + "........."+countTime(begin,end));
			
//			System.out.println(overviewResponse.getRecordCount());
			
		} catch (Exception ex) {
			overviewResponse = null;
			ex.printStackTrace();
		}
	}
}
