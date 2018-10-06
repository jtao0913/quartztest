package com.cnipr.cniprgz.commons;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.log.CniprLogger;

public class Util {

	public static boolean isNumeric(String str){ 
	    Pattern pattern = Pattern.compile("[0-9]*"); 
	    return pattern.matcher(str).matches();    
	}

	public static String getTifName(int currentpage){
		String tifname = "";
		String zero = "";
		for(int i=0;i<(6-(new Integer(currentpage)).toString().length());i++)
		{
			zero += "0"; 
		}		
		tifname = zero + currentpage+".tif";
		
		return tifname;
	}
	
 	private final static byte[] val = { 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x01,
			0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
			0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F };
	
	public static String unescape(String s) {
		StringBuffer sbuf = new StringBuffer();
		int i = 0;
		int len = s.length();
		while (i < len) {
			int ch = s.charAt(i);
			if (ch == '+') { // + : map to ' '
				sbuf.append(' ');
			} else if ('A' <= ch && ch <= 'Z') { // 'A'..'Z' : as it was
				sbuf.append((char) ch);
			} else if ('a' <= ch && ch <= 'z') { // 'a'..'z' : as it was
				sbuf.append((char) ch);
			} else if ('0' <= ch && ch <= '9') { // '0'..'9' : as it was
				sbuf.append((char) ch);
			} else if (ch == '-' || ch == '_' // unreserved : as it was
					|| ch == '.' || ch == '!' || ch == '~' || ch == '*'
					// || ch == '/'' || ch == '('
					|| ch == ')') {
				sbuf.append((char) ch);
			} else if (ch == '%') {
				int cint = 0;
				if ('u' != s.charAt(i + 1)) { // %XX : map to ascii(XX)
					cint = (cint << 4) | val[s.charAt(i + 1)];
					cint = (cint << 4) | val[s.charAt(i + 2)];
					i += 2;
				} else { // %uXXXX : map to unicode(XXXX)
					cint = (cint << 4) | val[s.charAt(i + 2)];
					cint = (cint << 4) | val[s.charAt(i + 3)];
					cint = (cint << 4) | val[s.charAt(i + 4)];
					cint = (cint << 4) | val[s.charAt(i + 5)];
					i += 5;
				}
				sbuf.append((char) cint);
			}
			i++;
		}
		return sbuf.toString();
	}

	public static String getCookie(String strName, HttpServletRequest request)
			throws Exception {
		String strValue = "";
		Cookie ipc = null;
		Cookie cookies[] = request.getCookies();
		try {
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					ipc = cookies[i];
					if (ipc != null && ipc.getName().equals(strName)) {
						strValue = String.valueOf(ipc.getValue());
						break;
					}
				}
			}

			return strValue;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 生成验证码
	 * 
	 * @return
	 */
	public static String getCheckCode() {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sformat1 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd-HH-mm-ss");
		String sSearchTime1 = sformat1.format(dt);
		String[] st = new String[6];
		st = sSearchTime1.split("-");
		int os = Integer.parseInt(st[0]) + Integer.parseInt(st[1])
				+ Integer.parseInt(st[2]) + Integer.parseInt(st[3])
				+ Integer.parseInt(st[4]) + Integer.parseInt(st[5]);
		String checkCode = String.valueOf(os);

		return checkCode;
	}

	/** */
	/**
	 * 从json对象集合表达式中得到一个java对象列表
	 * 
	 * @param jsonString
	 * @param pojoClass
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getList4Json(String jsonString, Class pojoClass) {
		List list = new ArrayList();
		try{
			JSONArray jsonArray = JSONArray.fromObject(jsonString);
			JSONObject jsonObject;
			Object pojoValue;	
//			PatentInfo pojoValue;
			
			for (int i = 0; i < jsonArray.size(); i++) {	
				jsonObject = jsonArray.getJSONObject(i);
				pojoValue = JSONObject.toBean(jsonObject, pojoClass);
				
//				pojoValue = (PatentInfo)JSONObject.toBean(jsonObject, pojoClass);
				
				list.add(pojoValue);	
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return list;
	}

	/**
	 * 删除文件夹
	 * 
	 * @param folderPath
	 *            文件夹完整绝对路径
	 * @return
	 */
	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			myFilePath.delete(); // 删除空文件夹
		} catch (Exception e) {
		}
	}

	/**
	 * 删除指定文件夹下所有文件
	 * 
	 * @param path
	 *            文件夹完整绝对路径
	 * @return
	 * @return
	 */
	public static boolean delAllFile(String path) {
		boolean bea = false;
		File file = new File(path);
		if (!file.exists()) {
			return bea;
		}
		if (!file.isDirectory()) {
			return bea;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				bea = true;
			}
		}
		return bea;
	}

	public static boolean isLetter(char c) {
		Pattern pattern = Pattern.compile("[a-zA-Z]+"); 
//		java.util.regex.Matcher m = pattern.matcher(str);
		Matcher mat = pattern.matcher(c+"");
		return mat.matches();
	}
	
	public static boolean isPicExis(String urlPath) {
		boolean flag = false;

		BufferedInputStream bis = null;
		HttpURLConnection httpUrl = null;
		URL url = null;
		// 建立链接
		try {
			url = new URL(urlPath);
			httpUrl = (HttpURLConnection) url.openConnection();
			httpUrl.setRequestProperty("Use-Contrl", "LIPTIFACTIVEX");
			httpUrl.setRequestProperty("Use-Agent", "LIREAD");
			httpUrl.setRequestProperty("Check-Code", getCheckCode());
			httpUrl.setRequestProperty("Connection", "Keep-Alive");
			httpUrl.setRequestProperty("Cache-Control", "no-cache");
			// 读取超时设置
			httpUrl.setReadTimeout(10000);
			// 连接超时设置
			httpUrl.setConnectTimeout(60000);
			// 连接指定的资源
			httpUrl.connect();
			// 获取网络输入流
			bis = new BufferedInputStream(httpUrl.getInputStream());
			CniprLogger.LogDebug("正在获取链接[" + urlPath + "]的内容...");
			return true;
		} catch (MalformedURLException e) {
			// e.printStackTrace();
		} catch (IOException e) {
			// e.printStackTrace();
		} finally {
			try {
				if (bis != null) {
					bis.close();
				}

				if (httpUrl != null) {
					httpUrl.disconnect();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	public static String getPatentTableByArea(Map<String, Object> application, String area) {
		String strSources = "";
		
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		
		area = (area==null||area.equals(""))?"cn":area;
		
		List<ChannelInfo> channelInfoList = area.equals("cn")?channelInfoList_cn:channelInfoList_fr;
		
		for(ChannelInfo ci:channelInfoList)  
		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());			
			strSources += ci.getChrTRSTable()+",";
		} 
		
		if(strSources.endsWith(",")){
			strSources=strSources.substring(0, strSources.length()-1);
		}
		return strSources;
	}
	
	public static String getCheckedPatentTableIDsByArea(Map<String, Object> application, String area) {
		String strSources = "";
		
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		
		area = (area==null||area.equals(""))?"cn":area;		
		List<ChannelInfo> channelInfoList = area.equals("cn")?channelInfoList_cn:channelInfoList_fr;
		
		for(ChannelInfo ci:channelInfoList)  
		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());
			if(ci.getChrCheck()!=null&&ci.getChrCheck().equals("checked")){
				strSources += ci.getIntChannelID()+",";
			}
		} 
		
		if(strSources.endsWith(",")){
			strSources=strSources.substring(0, strSources.length()-1);
		}
		return strSources;
	}
	
	public static String getPatentTableIDsByArea(Map<String, Object> application, String area) {
		String strSources = "";
		
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		
		area = (area==null||area.equals(""))?"cn":area;
		
		List<ChannelInfo> channelInfoList = area.equals("cn")?channelInfoList_cn:channelInfoList_fr;
		
		for(ChannelInfo ci:channelInfoList)  
		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());			
			strSources += ci.getIntChannelID()+",";
		} 
		
		if(strSources.endsWith(",")){
			strSources=strSources.substring(0, strSources.length()-1);
		}
		return strSources;
	}
	
	public static String getPatentTableIDsByAreaByIndexChecked(Map<String, Object> application, String area, String checked) {
		String strSources = "";
		
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		
		area = (area==null||area.equals(""))?"cn":area;
		
		List<ChannelInfo> channelInfoList = area.equals("cn")?channelInfoList_cn:channelInfoList_fr;
		
		for(ChannelInfo ci:channelInfoList)  
		{  
//			System.out.println(ci.getIntChannelID());
//			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());
			
			if(ci.getChrIndexCheck()!=null&&ci.getChrIndexCheck().toLowerCase().equals("checked")){
				strSources += ci.getIntChannelID()+",";
			}
		} 
		
		if(strSources.endsWith(",")){
			strSources=strSources.substring(0, strSources.length()-1);
		}
		return strSources;
	}
	
	public static String getPatentTable(Map<String, Object> application, String channelName) {
		String ret = "";
		
		if(channelName==null||channelName.equals("")){
			return "";
		}
		
		Pattern p=Pattern.compile("[0-9]+"); 
		Matcher m=p.matcher(channelName);
		if(!m.find()) {
			return channelName;
		}		
		
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");
		
		HashMap<Integer,String> hm_channel = new HashMap<Integer,String>();
		for(ChannelInfo ci:channelInfoList_fr)  
		{
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());
		}
		for(ChannelInfo ci:channelInfoList_cn)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());
		}
		for(ChannelInfo ci:channelInfoList_sx)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getIntChannelID(), ci.getChrTRSTable());
		} 
		///////////////////////////////////////////////////////////////////////////////////
		Iterator<?> iter = hm_channel.entrySet().iterator();
//		while (iter.hasNext()) {
//			Map.Entry entry = (Map.Entry) iter.next();
//			Object key = entry.getKey();
//			Object val = entry.getValue();
//			
//			System.out.println((Integer)entry.getKey() + "-------------------------" + (String)entry.getValue());
//		}

		if(channelName!=null&&!channelName.equals("")){
			String[] arr  = channelName.split(",");
			
			for(int n=0;n<arr.length;n++){
				
				if(isNumeric(arr[n])){
					
					iter = hm_channel.entrySet().iterator();
					
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						int key = (Integer)entry.getKey();
						String val = (String)entry.getValue();
						
						if(Integer.parseInt(arr[n])==key) {
							ret += val+",";
						}
					}
				}else {
					ret += arr[n]+",";
				}
			}
		}

		if(ret.endsWith(",")){
			ret=ret.substring(0, ret.length()-1);
		}
		if(ret.equals("")){
			ret = channelName;
		}
		return ret;
	}
	
	public static String getPatentTableName(Map<String, Object> application, String channelName) {
		String ret = "";
		
		if(channelName==null||channelName.equals("")){
			return "";
		}
		
		Pattern p=Pattern.compile("[0-9a-zA-Z]+"); 
		Matcher m=p.matcher(channelName);
		if(!m.find()) {
			return channelName;
		}		
		
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_sx = (List<ChannelInfo>)application.get("channelInfoList_sx");
		
		HashMap<String,String> hm_channel = new HashMap<String,String>();
		for(ChannelInfo ci:channelInfoList_fr)  
		{
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		for(ChannelInfo ci:channelInfoList_cn)  
		{  
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		}
		for(ChannelInfo ci:channelInfoList_sx)  
		{
//			System.out.println(ci.getIntChannelID());
			hm_channel.put(ci.getChrTRSTable(), ci.getChrChannelName());
		} 
		///////////////////////////////////////////////////////////////////////////////////
		Iterator<?> iter = hm_channel.entrySet().iterator();
//		while (iter.hasNext()) {
//			Map.Entry entry = (Map.Entry) iter.next();
//			Object key = entry.getKey();
//			Object val = entry.getValue();
//			
//			System.out.println((Integer)entry.getKey() + "-------------------------" + (String)entry.getValue());
//		}

		if(channelName!=null&&!channelName.equals("")){
			String[] arr  = channelName.split(",");
			
			for(int n=0;n<arr.length;n++){
				
/*				if(isNumeric(arr[n])){					
					iter = hm_channel.entrySet().iterator();
					while (iter.hasNext()) {
						Map.Entry entry = (Map.Entry) iter.next();
						int key = (Integer)entry.getKey();
						String val = (String)entry.getValue();
					
						if(Integer.parseInt(arr[n])==key) {
							ret += val+",";
						}
					}
				}else {
					ret += arr[n]+",";
				}
*/				
				iter = hm_channel.entrySet().iterator();				
				while (iter.hasNext()) {
					Map.Entry entry = (Map.Entry) iter.next();
					String key = (String)entry.getKey();
					String val = (String)entry.getValue();
				
					if(arr[n].equals(key)) {
						ret += val+",";
					}
				}
				
			}
		}

		if(ret.endsWith(",")){
			ret=ret.substring(0, ret.length()-1);
		}
		if(ret.equals("")){
			ret = channelName;
		}
		return ret;
	}
	
	public static String getPatentType(String channelName) {
		String patentType = "";
		try {
			if (channelName.indexOf("fmzl") > -1) {
				patentType = "fm";
			}
			if (channelName.indexOf("syxx") > -1) {
				patentType = "xx";
			}
			if (channelName.indexOf("wgzl") > -1) {
				patentType = "wg";
			}
			if (channelName.indexOf("fmsq") > -1) {
				patentType = "sq";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return patentType;
	}
	
	public static String getPatentTypeName(String channelName) {
		String patentType = "";
		try {
			if (channelName.indexOf("fmzl") > -1) {
				patentType = "发明";
			}
			if (channelName.indexOf("syxx") > -1) {
				patentType = "新型";
			}
			if (channelName.indexOf("wgzl") > -1) {
				patentType = "外观";
			}
			if (channelName.indexOf("fmsq") > -1) {
				patentType = "授权";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return patentType;
	}
	
	public static String getShortAN(String strPD, String strAN) {
		String strANShort = strAN;
		// if (Integer.parseInt(strPD.substring(0, 4)) < 1989)
		{
			if (strAN.indexOf(".") > -1) {
				strANShort = strAN.substring(0, strAN.indexOf("."));
			}
		}
		strANShort = strANShort.toUpperCase().replace("CN", "");

		return strANShort;
	}

	public static String processTifImgTag(String s, String channelName,
			String strPD, String strAN) {
		Pattern pattern = Pattern.compile("SRC=\"[^\u4e00-\u9fa5]+."
				+ "(tif|TIF)" + "\"");
		Matcher matcher = pattern.matcher(s);

		int end = 0;
		List<String> strList = new ArrayList<String>();
		while (matcher.find()) {
			String strImgName = matcher.group().substring("SRC=\"".length(),
					matcher.group().lastIndexOf("\""));
			String picURL = DataAccess.getProperty("PicServerURL") + "XmlData/"
					+ getPatentType(channelName) + "/"
					+ strPD.replaceAll("\\.", "") + "/"
					+ getShortAN(strPD, strAN) + "/" + strImgName;
			String result = "SRC=\"" + picURL + "\"";
			// System.out.println(result);
			strList.add(s.substring(end, matcher.start()));
			strList.add(result);
			end = matcher.end();
		}

		String old = s;
		s = "";
		for (int i = 0; i < strList.size(); i++) {
			s += (String) strList.get(i);
		}
		s = (s + old.substring(end))
				.replaceAll(
						"(<img)|(<IMG)",
						"<embed type=\"image/tiff\" negative=no  bgcolor=\"#FFFFFF\" toolbar=\"off\" MOUSEMODE=\"none\"");
		return s;
	}

	public static String getCurrentTime() {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sy1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// date.setSeconds(date.getSeconds() - 5);
		String currentTime = sy1.format(date);
		return currentTime;
	}

	/*
	 * list去重
	 */
	@SuppressWarnings("unchecked")
	public static List removeDuplicateObj(List list) {
		Set someSet = new HashSet(list);

		// 将Set中的集合，放到一个临时的链表中(tempList)
		Iterator iterator = someSet.iterator();
		List tempList = new ArrayList();
		int i = 0;
		while (iterator.hasNext()) {

			tempList.add(iterator.next().toString());
			i++;
		}
		return tempList;
	}

	/**
	 * 将频道号拆成中文【0】和英文【1】
	 * 
	 * @param channelIds
	 * @return
	 */
	public static String[] splitCnAndEnChannels(String channelIds) {
		String[] channels = { "", "" };
		String[] channelArray = channelIds.trim().split(",");

		if (channelArray != null && channelArray.length > 0) {
			StringBuffer cnChannels = new StringBuffer();
			StringBuffer enChannels = new StringBuffer();
			for (String channel : channelArray) {
				if (channel.equals("14") || channel.equals("15")
						|| channel.equals("16") || channel.equals("17")
						|| channel.equals("34") || channel.equals("35")
						|| channel.equals("36")) {
					cnChannels.append(channel).append(",");
				} else {
					enChannels.append(channel).append(",");
				}
			}
			if (cnChannels != null && cnChannels.toString().length() >= 2)
				channels[0] = cnChannels.toString().substring(0,
						cnChannels.length() - 1);

			if (enChannels != null && enChannels.toString().length() >= 2)
				channels[1] = enChannels.toString().substring(0,
						enChannels.length() - 1);
		}

		return channels;
	}

	/**
	 * 比较string类型日期 日期格式：2010.04.07
	 * 
	 * @param args
	 */
	public static boolean compareDate(String date) {
		boolean flag = false;

		if (date == null || date.equals("")) {
			return flag;
		}

		int res = date.compareTo(DataAccess.getProperty("PDF_Date"));

		if (res >= 0) {
			flag = true;
		}

		return flag;
	}

	public static int[] getBelongAccount(HttpServletRequest request) {
		String userId = "1";
			//(String) request.getSession().getAttribute(Constant.APP_USER_ID);
		int roleId = 2;
			//(Integer) request.getSession().getAttribute("user_group");

		int[] rs = { 0, 0 };

		rs[0] = Integer.parseInt(userId);
		rs[1] = roleId;

		if (roleId == 4) {
			rs[0] = (Integer) request.getSession().getAttribute(
					"intAdministerId");
			rs[1] = (Integer) request.getSession().getAttribute("adminRoleId");
		}

		return rs;
	}

	public static Map<String, String> getCheckedChannelMap(String strChannels) {
		Map<String, String> checkedChannelMap = new HashMap<String, String>();

		if (strChannels != null && !strChannels.equals("null")
				&& !strChannels.equals("")) {
			String[] channelArray = strChannels.split(",");
			for (String channelId : channelArray) {
				checkedChannelMap.put(channelId, "checked");
			}
		}

		return checkedChannelMap;
	}

	public static String formatDecimal(String format, int number) {
		java.text.DecimalFormat df = new java.text.DecimalFormat(format);
		return df.format(number);
	}

	public static String addTimeByMonth(int extensionMonth) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new java.util.Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(time);
		cal.add(Calendar.MONTH, extensionMonth);
		Date date = cal.getTime();
		return formatter.format(date);
	}

	public static void main(String[] args) {
		// String s = "一种含有四氟乙烯、乙烯三元共聚物的生产\n" +
		// "方法，本法在四氟乙烯-乙烯溶液沉淀聚合体系" +
		// "中，用过碳酸酯作引发剂，1,2,2-三氯，1,2," +
		// "2-三氟乙烷作介质。选用分子式为CnR<SUB>2n+2</SUB>的" +
		// "化合物作气相链调节剂控制共聚物分子量。其中" +
		// "n＝0，1或2，R＝H，Cl或F。分子式为CF<SUB>2</SUB>"+
		// "XOCF<SUB>2</SUB>X′或"+
		// "<IMG SRC=\"85100468_AB_0.TIF\" WIDTH=245 HEIGHT=102>"+
		// "的化合物作第三单"+
		// "体，其中X＝X′＝Cl或F，R＝CF<SUB>3</SUB>或CH<SUB>3</SUB>，" +
		// "R′＝CF<SUB>3</SUB>，CH<SUB>3</SUB>或H，R″＝H或F。共聚物内"+
		// "单体克分子组成为四氟乙烯60-40％，乙烯40-"+
		// "60％，第三单体为前二者总和的0.1-10％。";
		// System.out.print(Util.processTifImgTag(s, "fmzl","1985.09.10",
		// "CN85100468"));
		// String s =
		// "[{\"chrCNChannels\":\"\",\"chrFRChannels\":\"\",\"chrLapsedChannels\":\"\",\"chrMemo\":\"\",\"cnExpression\":\"\",\"dtCreatetime\":null,\"frExpression\":\"\",\"hasChild\":0,\"id\":749,\"intAdministerId\":0,\"intId\":0,\"intSequenceNum\":0,\"intType\":0,\"name\":\"行业专题库\",\"parentId\":0,\"strClass\":\"A\"}]";
		// List<IprNavtableInfo> l = Util.getList4Json(s,
		// IprNavtableInfo.class);
		System.out.print(getTifName(58));
		// System.out.print(Util.isPicExis("http://202.99.194.152:808/XmlData/fm//19851010/85103560/85103560.tif"));
	}
}
