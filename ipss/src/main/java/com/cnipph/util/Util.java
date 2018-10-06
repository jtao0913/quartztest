package com.cnipph.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Liuc 实用函数
 */
public class Util {

	/**
	 * 跟踪日志
	 */
	private static final Log logger = LogFactory.getLog(Util.class);

	/**
	 * 清除Null字符串
	 * 
	 * @param str 源字符串
	 * @return str 处理后字符串
	 */
	public static String trimString(String str) {
		if (str == null) {
			str = new String();
		}
		str = str.trim();
		return str;
	}

	/**
	 * 去掉HTML标记
	 * 
	 * @param str
	 * @return result
	 */
	public static String StripHTML(String str) {
		Pattern pattern = Pattern.compile("<.+?>");
		Matcher matcher = pattern.matcher(str);
		String result = matcher.replaceAll("");
		result = trimString(result);
		return result;
	}

	/**
	 * 取得当前日期和时间
	 * 
	 * @return Date
	 */
	public static Date getDate() {
		TimeZone timeZone = TimeZone.getTimeZone("Asia/Shanghai"); // 取得北京所在时区的偏移量(GMT+8)
		Locale locale = Locale.CHINA; // 取得北京所在区域
		Calendar calendar = Calendar.getInstance(timeZone, locale);
		Date date = calendar.getTime();
		return date;
	}

	/**
	 * 取得当前日期和时间
	 * 
	 * @return String
	 */
	public static String getDateAndTime() {
		Date date = getDate();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateAndTime = simpleDateFormat.format(date);
		return dateAndTime;
	}

	/**
	 * 判断是否为GBK编码
	 * 
	 * @param string
	 * @return
	 * @throws java.io.UnsupportedEncodingException
	 */
	public static boolean isGBK(String string) throws java.io.UnsupportedEncodingException {
		byte[] bytes = string.replace('?', 'a').getBytes("ISO-8859-1");
		for (int i = 0; i < bytes.length; i++) {
			if (bytes[i] == 63) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 转换为GBK
	 * 
	 * @param string
	 * @return
	 * @throws java.io.UnsupportedEncodingException
	 */
	public static String toGBK(String string) throws java.io.UnsupportedEncodingException {
		if (string == null)
			return "";
		if (!isGBK(string)) {
			return new String(string.getBytes("ISO-8859-1"), "GBK");
		}
		return string;
	}

	/**
	 * 转换为ISO-8859-1
	 * 
	 * @param string
	 * @return
	 * @throws java.io.UnsupportedEncodingException
	 */
	public static String toISO_8859_1(String string) throws java.io.UnsupportedEncodingException {
		if (string == null)
			return "";
		if (isGBK(string)) {
			return new String(string.getBytes("GBK"), "ISO-8859-1");
		}
		return string;
	}

	/**
	 * 中文编码转换
	 * 
	 * @param str
	 * @return result
	 */
	public static String getGBKStr(String str) {
		String result = null;
		if (str == null) {
			return str;
		}
		try {
			result = new String(str.getBytes("ISO8859-1"), "GBK");
		} catch (UnsupportedEncodingException uee) {
			logger.error(uee.getMessage(), uee);
			result = str;
		}
		return result;
	}

	/**
	 * 将字符串数组用特定token间隔
	 * 
	 * @param array
	 * @param token
	 * @return resultStr
	 */
	public static String arrToString(String[] array, String token) {
		String resultStr = "";
		if (array == null || token == null) {
			return resultStr;
		}
		for (int i = 0; i < array.length; i++) {
			resultStr += array[i];
			if (i < array.length - 1) {
				resultStr += token;
			}
		}
		return resultStr;
	}

	/**
	 * 讲数组转化为链表
	 * 
	 * @param obj
	 * @return List
	 */
	public static List arrToList(Object[] obj) {
		List resultList = new ArrayList();
		for (int i = 0; i < obj.length; i++) {
			resultList.add(obj[i]);
		}
		return resultList;
	}

	/**
	 * 将含有特定分隔符的字符串按照分隔符拆分成List
	 * 
	 * @param str
	 * @param token
	 * @return List
	 */
	public static List stringToList(String str, String token) {
		List resultList = new ArrayList();
		if (str == null || token == null) {
			return resultList;
		}
		StringTokenizer stringTokenizer = new StringTokenizer(str, token);
		while (stringTokenizer.hasMoreElements()) {
			resultList.add(stringTokenizer.nextToken());
		}
		return resultList;
	}

	/**
	 * 二进制编码
	 * 
	 * @param src
	 * @return String
	 */
	public static String escape(String src) {
		int i;
		char j;
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length() * 6);
		for (i = 0; i < src.length(); i++) {
			j = src.charAt(i);
			if (Character.isDigit(j) || Character.isLowerCase(j) || Character.isUpperCase(j)) {
				tmp.append(j);
			} else if (j < 256) {
				tmp.append("%");
				if (j < 16)
					tmp.append("0");
				tmp.append(Integer.toString(j, 16));
			} else {
				tmp.append("%u");
				tmp.append(Integer.toString(j, 16));
			}
		}
		return tmp.toString();
	}

	/**
	 * 二进制解码
	 * 
	 * @param src
	 * @return String
	 */
	public static String unescape(String src) {
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length());
		int lastPos = 0, pos = 0;
		char ch;
		while (lastPos < src.length()) {
			pos = src.indexOf("%", lastPos);
			if (pos == lastPos) {
				if (src.charAt(pos + 1) == 'u') {
					ch = (char) Integer.parseInt(src.substring(pos + 2, pos + 6), 16);
					tmp.append(ch);
					lastPos = pos + 6;
				} else {
					ch = (char) Integer.parseInt(src.substring(pos + 1, pos + 3), 16);
					tmp.append(ch);
					lastPos = pos + 3;
				}
			} else {
				if (pos == -1) {
					tmp.append(src.substring(lastPos));
					lastPos = src.length();
				} else {
					tmp.append(src.substring(lastPos, pos));
					lastPos = pos;
				}
			}
		}
		return tmp.toString();
	}

	/**
	 * 取得Request的Post流
	 * 
	 * @param request
	 * @return result
	 * @throws IOException
	 */
	public static String getRequestStr(HttpServletRequest request) throws IOException {
		int contentLength = request.getContentLength();
		byte[] arr = new byte[contentLength];
		ServletInputStream sin = null;
		String result = "";
		try {
			sin = request.getInputStream();
			if (sin.readLine(arr, 0, contentLength) != -1) {
				result = new String(arr);
			}
		} catch (IOException ioe) {
			logger.error(ioe.getMessage(), ioe);
			throw ioe;
		}
		return result;
	}

	/**
	 * 解析Request的Post流
	 * 
	 * @param src
	 * @return hashMap
	 */
	public static HashMap parseRequestStr(String src) {
		HashMap hashMap = new HashMap();
		String[] param = src.split("&");
		for (int i = 0; i < param.length; i++) {
			String paramStr = param[i];
			int mark = paramStr.indexOf("=");
			String key = paramStr.substring(0, mark);
			String value = paramStr.substring(mark + 1);
			hashMap.put(key, value);
		}
		return hashMap;
	}

	// ****************UTF-8编码转换为GB2312*******begin*******
	private static int by2int(int b) {
		return b & 0xff;
	}

	public static String UTF82GB2312(String param) {
		try {
			param = new String(param.getBytes("ISO8859-1"), "UTF-8");
			byte[] bytes = param.getBytes("UTF-8");
			param = UTF82GB2312(bytes);
			return param;
		} catch (Exception e) {
			return null;
		}
	}

	public static String UTF82GB2312(byte buf[]) {
		int len = buf.length;
		StringBuffer sb = new StringBuffer(len / 2);
		for (int i = 0; i < len; i++) {
			if (by2int(buf[i]) <= 0x7F)
				sb.append((char) buf[i]);
			else if (by2int(buf[i]) <= 0xDF && by2int(buf[i]) >= 0xC0) {
				int bh = by2int(buf[i] & 0x1F);
				int bl = by2int(buf[++i] & 0x3F);
				bl = by2int(bh << 6 | bl);
				bh = by2int(bh >> 2);
				int c = bh << 8 | bl;
				sb.append((char) c);
			} else if (by2int(buf[i]) <= 0xEF && by2int(buf[i]) >= 0xE0) {
				int bh = by2int(buf[i] & 0x0F);
				int bl = by2int(buf[++i] & 0x3F);
				int bll = by2int(buf[++i] & 0x3F);
				bh = by2int(bh << 4 | bl >> 2);
				bl = by2int(bl << 6 | bll);
				int c = bh << 8 | bl;
				// 空格转换为半角
				if (c == 58865) {
					c = 32;
				}
				sb.append((char) c);
			}
		}
		return sb.toString();
	}
	// ****************UTF-8编码转换为GB2312*******end*******
}