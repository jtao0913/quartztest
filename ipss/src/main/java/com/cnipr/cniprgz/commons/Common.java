package com.cnipr.cniprgz.commons;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cnipr.cniprgz.entity.ChannelInfo;

public class Common {
	
	public static String getRemoteAddr(HttpServletRequest request) {
		/*	
		HttpSession session = request.getSession();
		String remoteAddr =  (String)session.getAttribute("remoteAddr");
	
		if(remoteAddr==null||remoteAddr.equals("")) {
			remoteAddr = request.getRemoteAddr();
			if(remoteAddr.equals("127.0.0.1")) {
			    String ip = request.getHeader("X-Real-IP");
			    if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
			    	remoteAddr=ip;
			    	session.setAttribute("remoteAddr",remoteAddr);
			    }
//			    out.println("X-Real-IP--------"+_ip);
			}
		}
		*/
		
		String remoteAddr = request.getRemoteAddr();
		if(remoteAddr.equals("127.0.0.1")) {
		    String ip = request.getHeader("X-Real-IP");
		    if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
		    	remoteAddr=ip;
//		    	session.setAttribute("remoteAddr",remoteAddr);
		    }
//		    out.println("X-Real-IP--------"+_ip);
		}
		return remoteAddr;
	}
	
	public static String getTRSTableName(Map<String, Object> application, String strChannels) {
		String strTRSTableName = "";
		
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");
		List<ChannelInfo> channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");
		
		List<ChannelInfo> channelList = new ArrayList<ChannelInfo>();

		if(channelList==null||channelList.size()==0){
			String[] arrdb = strChannels.split(",");
			
			Iterator<ChannelInfo> iter = channelInfoList_cn.iterator();
			while(iter.hasNext())
			{
				ChannelInfo channelinfo = ((ChannelInfo)iter.next());
				int channelid  = channelinfo.getIntChannelID();
				String channelname  = channelinfo.getChrTRSTable();
//				System.out.println(iter.next());
				for(int i=0;i<arrdb.length;i++){
					if(arrdb[i].equals(channelid+"")||arrdb[i].equals(channelname)){
						channelList.add(channelinfo);
					}
				}
			}
			
			iter = channelInfoList_fr.iterator();
			while(iter.hasNext())
			{
				ChannelInfo channelinfo = ((ChannelInfo)iter.next());
				int channelid  = channelinfo.getIntChannelID();
				String channelname  = channelinfo.getChrTRSTable();
//				System.out.println(iter.next());
				for(int i=0;i<arrdb.length;i++){
					if(arrdb[i].equals(channelid+"")||arrdb[i].equals(channelname)){
						channelList.add(channelinfo);
					}
				}
			}
		}
		
		String strSources = "";
		if (channelList != null && channelList.size() > 0) {
			strSources = "";
		}
//		TRS表名 （egg：发明专利，实用新型，外观设计） 保存表达式时用到
		

		for (ChannelInfo info : channelList) {
			strSources += info.getChrTRSTable() + ",";
			strTRSTableName += info.getChrChannelName() + ",";
		}

		if (strSources != null && !strSources.equals("")&& strSources.endsWith(","))
			strSources = strSources.substring(0, strSources.length() - 1);

		if (strTRSTableName != null && !strTRSTableName.equals("")&& strTRSTableName.endsWith(","))
			strTRSTableName = strTRSTableName.substring(0, strTRSTableName.length() - 1);
		
		return strTRSTableName;
	}
	
	public static String _getTRSTableNames(String tableIDs){
		String[] arr = null;
		if(tableIDs!=null && !tableIDs.equals("")){
			arr = tableIDs.split(",");
		}else{
			return "";
		}
/*
		for(key in item_arr){
			if (key){
				name=item_arr[key];
			}
		}
*/
		String strTRSTableIDs="";

		for (int i = 0; i < arr.length; i++) {
			if(arr[i].equals("14")){
				arr[i]="fmzl";
				strTRSTableIDs+="发明专利,";
			}
			if(arr[i].equals("15")){
				arr[i]="syxx";
				strTRSTableIDs+="实用新型,";
			}
			if(arr[i].equals("16")){
				arr[i]="wgzl";
				strTRSTableIDs+="外观专利,";
			}
			if(arr[i].equals("17")){
				arr[i]="fmsq";
				strTRSTableIDs+="发明授权,";
			}
			if(arr[i].equals("18")){
				arr[i]="uspatent";
				strTRSTableIDs+="美国,";
			}
			if(arr[i].equals("19")){
				arr[i]="jppatent";
				strTRSTableIDs+="日本,";
			}
			if(arr[i].equals("20")){
				arr[i]="gbpatent";
				strTRSTableIDs+="英国,";
			}
			if(arr[i].equals("21")){
				arr[i]="depatent";
				strTRSTableIDs+="德国,";
			}
			if(arr[i].equals("22")){
				arr[i]="frpatent";
				strTRSTableIDs+="法国,";
			}
			if(arr[i].equals("23")){
				arr[i]="eppatent";
				strTRSTableIDs+="欧洲,";
			}
			if(arr[i].equals("24")){
				arr[i]="wopatent";
				strTRSTableIDs+="wipo,";
			}
			if(arr[i].equals("25")){
				arr[i]="chpatent";
				strTRSTableIDs+="瑞士,";
			}
			if(arr[i].equals("5")){
				arr[i]="twpatent";	
				strTRSTableIDs+="台湾省,";
			}
			if(arr[i].equals("6")){
				arr[i]="hkpatent";
				strTRSTableIDs+="香港特区,";
			}
			if(arr[i].equals("26")){
				arr[i]="krpatent";
				strTRSTableIDs+="韩国,";
			}
			
			if(arr[i].equals("27")){
				arr[i]="supatent,rupatent";
				strTRSTableIDs+="俄罗斯,";
			}
			if(arr[i].equals("28")){
				arr[i]="aspatent";
				strTRSTableIDs+="东南亚,";
			}
			if(arr[i].equals("29")){
				arr[i]="gcpatent";
				strTRSTableIDs+="阿拉伯,";
			}
			
			if(arr[i].equals("63")){
				arr[i]="aupatent";
				strTRSTableIDs+="澳大利亚,";
			}
			if(arr[i].equals("70")){
				arr[i]="capatent";
				strTRSTableIDs+="加拿大,";
			}
			if(arr[i].equals("62")){
				arr[i]="atpatent";
				strTRSTableIDs+="奥地利,";
			}
			if(arr[i].equals("97")){
				arr[i]="itpatent";
				strTRSTableIDs+="意大利,";
			}
			if(arr[i].equals("122")){
				arr[i]="sepatent";
				strTRSTableIDs+="瑞典,";
			}
			
			if(arr[i].equals("60")){
				arr[i]="appatent,oapatent";
				strTRSTableIDs+="非洲地区,";
			}
			if(arr[i].equals("85")){
				arr[i]="espatent";
				strTRSTableIDs+="西班牙,";
			}
			if(arr[i].equals("130")){
				arr[i]="otherpatent";
				strTRSTableIDs+="其他国家,";
			}
			
		}
		
		strTRSTableIDs=strTRSTableIDs.substring(0,strTRSTableIDs.length()-1);
		//alert(strTRSTableIDs);
		if(strTRSTableIDs!=null && strTRSTableIDs!=""){
			strTRSTableIDs="["+strTRSTableIDs+"]";
		}

		return strTRSTableIDs;
	}
	
	public static Date stringToDate(String time) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		// ParsePosition pos = new ParsePosition(0);
		java.util.Date ctime = null;
		try {
			ctime = formatter.parse(time);
		} catch (ParseException e) {
			System.out.println("解析日期异常：" + time);
			e.printStackTrace();
		}

		return ctime;
	}

	/**
	 * 判断是否为数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 将字符串转换成xxxx-xx-xx格式
	 * 
	 * @param date
	 * @return
	 */
	public static String turn_date(String date) {
		String date_10 = "";
		if (date != null && date.equals("") == false)
			date = date.replace("-", ".");
		StringTokenizer d = new StringTokenizer(date, ".");
		int d_length = d.countTokens();
		String[] datenum = new String[d_length];
		for (int i = 0; i < d_length; i++) {
			datenum[i] = d.nextToken();
			if (i == 0 && datenum[i].length() == 2) {
				if (isNumeric(datenum[i])) {
					if (Integer.parseInt(datenum[i].substring(0, 1)) > 1)
						datenum[i] = "19" + datenum[i];
					else
						datenum[i] = "20" + datenum[i];
				}
			} else if (datenum[i].length() == 1) {
				if (isNumeric(datenum[i])) {
					if (Integer.parseInt(datenum[i]) < 10)
						datenum[i] = "0" + datenum[i];
				}
			}
		}
		for (int k = 0; k < d_length; k++) {
			if (k == (d_length - 1))
				date_10 = date_10 + datenum[k];
			else if (k == 0)
				date_10 = datenum[k] + ".";
			else
				date_10 = date_10 + datenum[k] + ".";

		}
		return date_10.trim();
	}

	/**
	 * 判断字符传是否为日期格式
	 * 
	 * @param datetime
	 * @return
	 */
	public static boolean isDate(String datetime) {
		datetime = datetime.replace(".", "-");
		DateFormat df = DateFormat.getDateInstance();
		try {
			Date d = df.parse(datetime);
			StringTokenizer t = new StringTokenizer(datetime, "-");
			int len = t.countTokens();
			String[] da = new String[len];
			for (int i = 0; i < len; i++) {
				da[i] = t.nextToken();
				if (i == 0) {
					if (da[i].length() != 2 && da[i].length() != 4
							&& isNumeric(da[i]))
						return false;
					else if (isNumeric(da[i]) && da[i].length() == 2) {
						int year = Integer.parseInt(da[i]);
						if (year < 49 && year > 20)
							return false;
					} else if (isNumeric(da[i]) && da[i].length() == 4) {
						int year = Integer.parseInt(da[i]);
						if (year < 1949 || year > 2080)
							return false;
					}
				}// 年
				else// 月和日判断
				{
					if (da[i].length() > 2)
						return false;
					else if (isNumeric(da[i]) == false)
						return false;
					else if (Integer.parseInt(da[i]) > 31)
						return false;
				}
			}
			return true;
		} catch (java.text.ParseException e) {
			return false;
		}
	}

	/**
	 * 将字符串中含有日期格式转换为xxxx-xx-xx标准格式
	 * 
	 * @param line
	 * @return
	 */
	public static String turn_hasDate(String line) {
		line = line.replace("　", " ");
		StringTokenizer token = new StringTokenizer(line, " ");
		String e[] = new String[token.countTokens()];
		String new_line = "";
		for (int i = 0; i < e.length; i++) {
			e[i] = token.nextToken();
			if (isDate(e[i]) == true)
				e[i] = turn_date(e[i]);

			new_line = new_line + " " + e[i];
		}

		return new_line.trim();
	}

	/**
	 * 统计汉字数
	 * 
	 * @param a
	 * @return
	 */
	public static int CountHanzi(String a) {
		int count = 0;
		char[] arr = a.toCharArray();
		for (int i = 0; i < arr.length; i++) {
			if (isHanZi(arr[i])) {
				count++;
			}
		}
		return count;
	}

	/**
	 * 判断是否为汉字
	 * 
	 * @param c
	 * @return
	 */
	public static boolean isHanZi(char c) {

		String regx = "[\\u4e00-\\u9fa5]+";
		Pattern p = Pattern.compile(regx);
		Matcher m = p.matcher(String.valueOf(c));
		return m.find() ? true : false;
	}

	/**
	 * 
	 * 
	 * @param c
	 * @return
	 */
	public static String formatWhere(String strWhere) {
		String where = "";

		StringBuffer sbKeyWord = new StringBuffer();
		StringBuffer sbDate = new StringBuffer();
		StringBuffer sbIpc = new StringBuffer();
		StringBuffer sbNumber = new StringBuffer();

		sbKeyWord
				.append("名称,申请（专利权）人,发明（设计）人,优先权号,专利代理机构,代理人,地址,申请国代码,国省代码,摘要,主权项 +=(");
		sbDate.append("申请日,公开（公告）日 +=(");
		sbIpc.append("主分类号,分类号 +=(");
		sbNumber.append("申请号,公开（公告）号+=(");

		String[] keywords = strWhere.split(" ");

		boolean hasDate = false;

		for (String keyword : keywords) {
			if (keyword.trim().equals("") || keyword.trim().equals("or")
					|| keyword.trim().equals("and")
					|| keyword.trim().equals("not")) {
				continue;
			}

			if (isDateFormat(keyword) && !hasDate) {
				sbDate.append(keyword).append(")");
				hasDate = true;
			} else if (isIPCFormat(keyword)) {
				String temp = keyword.trim();
				if (!keyword.contains("-")) {
					temp = keyword.trim().replace("/", " ");
					temp = temp.replaceAll("[\\pP‘’“”]", "").replace(" ", "/");
				}
				sbIpc.append("'%").append(temp).append("%'").append(" and ");
			} else if (isNumberFormat(keyword)) {
				// temp = temp.replaceAll("[\\pP‘’“”]", "").replace(" ", "/");
				// sbIpc.append("'%").append(temp).append("%'").append(" and ");
				sbNumber.append("'").append(formatNumber(keyword))
						.append("%' and ");
			} else {
				String s = keyword.replaceAll("[\\pP‘’“”]", "");
				if (s == null || s.trim().equals("")) {
					continue;
				}

				if (!keyword.endsWith("%")) {
					keyword = keyword + "%";
				}

				sbKeyWord
						.append("'")
						.append(keyword.replace("(", "").replace(")", "")
								.replace("（", "").replace("）", ""))
						.append("' and ");
			}
		}

		if (sbKeyWord.toString().endsWith(" and ")) {
			where += sbKeyWord.substring(0, sbKeyWord.length() - 5) + ") and ";
		}
		if (sbIpc.toString().endsWith(" and ")) {
			where += sbIpc.substring(0, sbIpc.length() - 5) + ") and ";
		}
		if (sbDate.toString().endsWith(")")) {
			where += sbDate + " and ";
		}
		if (sbNumber.toString().endsWith(" and ")) {
			where += sbNumber.substring(0, sbNumber.length() - 5) + ") and ";
		}

		if (where.endsWith(" and ")) {
			where = where.substring(0, where.length() - 5);
		}

		return where;
	}

	/**
	 * 判断是否为日期格式（四位、六位、八位日期判断）
	 * 
	 * @param c
	 * @return
	 */
	public static boolean isDateFormat(String keyword) {
		boolean flag = false;

		keyword = keyword.replace("-", "").replace(".", "").replace("/", "");
		
		String format = "yyyy";
		DateFormat df = new SimpleDateFormat(format);
		String s = "";
		Date d = null;
		try {
			d = df.parse(keyword);
			s = df.format(d);
		} catch (Exception e) {
			flag = false;
		}

		flag = (keyword.equals(s) && keyword.length() == format.length());
		
		if (!flag) {
			format = "yyyyMM";
			s = "";
			df = new SimpleDateFormat(format);
			try {
				d = df.parse(keyword);
				s = df.format(d);
			} catch (Exception e) {
				flag = false;
			}
			flag = (keyword.equals(s) && keyword.length() == format.length());
		}
		
		if (!flag) {
			format = "yyyyMMdd";
			s = "";
			df = new SimpleDateFormat(format);
			try {
				d = df.parse(keyword);
				s = df.format(d);
			} catch (Exception e) {
				flag = false;
			}
			flag = (keyword.equals(s) && keyword.length() == format.length());
		}
		
		return flag;
	}

	public static boolean isNumberFormat(String keyword) {
		boolean flag = false;

		while (keyword.trim().startsWith("%")) {
			keyword = keyword.substring(1, keyword.length());
		}

		while (keyword.trim().endsWith("%")) {
			keyword = keyword.substring(0, keyword.length() - 1);
		}
		
		try {
			int type = 1;
			Pattern pattern = null;
			if (keyword.contains(".")) {
				type = 1;
				pattern = Pattern.compile("([A-Z]){0,2}[0-9]+.([A-Z]|[0-9])");
			} else if (keyword.contains("(")) {
				type = 2;
				pattern = Pattern
						.compile("([A-Z]){0,2}[0-9]+\\(([A-Z][0-9]?)\\)");
			} else {
				type = 3;
				pattern = Pattern
						.compile("([A-Z]){0,2}([0-9]+)([A-Z]?)([0-9]+)");
			}

			String findStr = "";
			Matcher matcher = pattern.matcher(keyword.toUpperCase());
			if (matcher.find()) {
				findStr = matcher.group();
			}
			if (keyword.toUpperCase().equals(findStr)) {
				flag = true;
			}

			if (flag && type == 3) {
				pattern = Pattern.compile("([A-Z]){0,2}([0-9]+)[A-Z]([0-9]+)");
				matcher = pattern.matcher(keyword.toUpperCase());
				if (matcher.find()) {
				}
			}

		} catch (Exception e) {
		}

		return flag;
	}

	private static String formatNumber(String keyword) {
		String exp = "";

		while (keyword.trim().startsWith("%")) {
			keyword = keyword.substring(1, keyword.length());
		}

		while (keyword.trim().endsWith("%")) {
			keyword = keyword.substring(0, keyword.length() - 1);
		}

		if (!keyword.toUpperCase().matches("^[A-Z]{2}([\\s\\S]*)$")) {
			exp += "%";
		}

		try {
			Pattern pattern = Pattern
					.compile("([A-Z]){0,2}([0-9]+)[A-Z]([0-9]+)");
			Matcher matcher = pattern.matcher(keyword.toUpperCase());
			if (matcher.find()) {
				pattern = Pattern.compile("([A-Z]){0,2}([0-9]+)");
				matcher = pattern.matcher(keyword.toUpperCase());
				if (matcher.find()) {
					String finder = matcher.group(0);
					exp += finder + "(" + keyword.replace(finder, "") + ")";
				}
			}

		} catch (Exception e) {
			exp = keyword;
		}

		if (exp.equals("") || exp.equals("%")) {
			exp += keyword;
		}

		return exp;
	}

	public static boolean isIPCFormat(String keyword) {
		boolean flag = false;

		if (keyword == null || keyword.equals("")) {
			return flag;
		}

		String s = keyword.trim().replace("/", " ");
		if (!keyword.trim().contains("-")) {
			s = s.replaceAll("[\\pP‘’“”]", "").replace(" ", "/");
		}
		
		try {
			int length = s.length();
			Pattern pattern = null;
			if (keyword.trim().contains("-")) {
				pattern = Pattern.compile("[0-9]{2}-[0-9]{2}((-[A-Z]*[0-9]*)?)");
			} else {
				if (length == 1) {
					pattern = Pattern.compile("[A-H]");
				} else if (length == 3) {
					pattern = Pattern.compile("([A-H])[0-9]{2}");
				} else if (length == 4) {
					pattern = Pattern.compile("([A-H])[0-9]{2}[A-Z]");
				} else if (length == 5) {
					pattern = Pattern.compile("([A-H])[0-9]{2}[A-Z][0-9]{1}");
				} else if (length > 5) {
					if (s.contains("/")) {
						pattern = Pattern
								.compile("([A-H])[0-9]{2}[A-Z][0-9]{1,3}/[0-9]{0,2}");
					} else {
						pattern = Pattern.compile("([A-H])[0-9]{2}[A-Z][0-9]{1,3}");
					}

				}
			}
			

			String findStr = "";
			Matcher matcher = pattern.matcher(s.toUpperCase());
			if (matcher.find()) {
				findStr = matcher.group();
			}
			if (s.toUpperCase().equals(findStr)) {
				flag = true;
			}

		} catch (Exception e) {}

		return flag;
	}

	public static void main(String[] args) {
		// String s = "%G06F133/41%";// G06F13/14
		// System.out.println(isIPCFormat(s));
		String s = "%US3432412% G06F133/41% 14-02-C0564 (G06F133 and 2001 2012  (计算机 or 汽车%) US3432412.X  US3432412(X1) 火花塞";
		s = "1982.12.32";
		// System.out.println(isNumberFormat(s));
		// System.out.println(formatNumber(s));

		// if ("U213(21)".matches("^[A-Z]{2}([\\s\\S]*)$")) {
		// System.out.println("111111111111111");
		// }

		System.out.println(formatWhere(s));

		// s = "%G06%13/2%".replace("/", " ");
		// s = s.replaceAll("[\\pP‘’“”]", "");
		// System.out.println(s);
	}
}
