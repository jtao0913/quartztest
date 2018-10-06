package com.cnipr.cniprgz.commons;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Properties;

import com.web.visit.PropertyUtil;
 

public class Log74Access {
	private static Properties _properties = null;

	private static PropertyUtil property;
	static{
		property =  PropertyUtil.getInstance("/log74.properties");
	}
	
	public static void set(String key,String value) {  
		property.setProperty(key,value);
		try {
			property.saveProperty(); 
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public  static String get(String name)
	{   
		return property.getProperty(name);
	}
	
	/**
	 * @wfunction  
	 * @wparam key
	 * @wreturn
	 */
	public static String getProperty(String key) {
		if (_properties == null) {
			try {
				InputStream ins = Log74Access.class
						.getResourceAsStream("/log74.properties");
				_properties = new Properties();
				_properties.load(ins);
			} catch (Exception ex) {
				_properties = null;
			}
		}

		return _properties.getProperty(key);
	}

	public static boolean IsStringNumber(String number) {

		if (number != null && number.length() > 0) {

			for (int i = 0; i < number.length(); i++) {
				char tempChar = number.charAt(i);
				if (tempChar < '0' || tempChar > '9') {
					return false;
				}
			}
			return true;
		}
		return false;
	}

	public static String getCurrentTime() {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sy1 = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentTime = sy1.format(date);
		return currentTime;
	}

	public static String getStartTime() {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sy1 = new SimpleDateFormat("yyyyMMddHHmmss");
		//date.setSeconds(date.getSeconds() - 5);
		String currentTime = sy1.format(date);
		return currentTime;
	}

	public static String getMsTime() {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sy1 = new SimpleDateFormat("yyyyMMddHHmmssS");
		String currentTime = sy1.format(date);
		return currentTime;
	}

}
