package com.cnipr.cniprgz.commons;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Properties;

import com.web.visit.PropertyUtil;

public class DataAccess {
	private static Properties _properties = null;

	/**
	 * @wfunction  
	 * @wparam key
	 * @wreturn
	 */
	private static PropertyUtil property;
	static{
		property =  PropertyUtil.getInstance("/app.properties");
	}	
	
	public static String getProperty_(String key) {
		if (_properties == null) {
			try {
//				InputStream ins = DataAccess.class
//						.getResourceAsStream("/app.properties","UTF-8"));
//				_properties = new Properties();
//				_properties.load(ins);
				
				_properties=new Properties();         
				_properties.load(new InputStreamReader(DataAccess.class.getClassLoader().getResourceAsStream("/app.properties"), "UTF-8")); 

				
			} catch (Exception ex) {
				_properties = null;
			}
		}

		System.out.println(_properties.getProperty(key));
//		String result= "";
//		try{			
//			result=new String(_properties.getProperty(key).getBytes("ISO-8859-1"), "utf-8");
//		}catch(Exception ex){}
		
		return _properties.getProperty(key);
	}
	
	public static String getProperty(String key) {
		if (_properties == null) {
			try {
				InputStream ins = DataAccess.class
						.getResourceAsStream("/app.properties");
				_properties = new Properties();
				_properties.load(ins);
			} catch (Exception ex) {
				_properties = null;
			}
		}

		return _properties.getProperty(key);
	}
	
	

	public static void main(String[] args) {
		try {

			String result = new String(getProperty("title").getBytes(
					"ISO-8859-1"), "utf-8");//
			System.out.println(result);

		} catch (Exception ex) {
		}
		getProperty("title");
	}
	
	public static void set(String key,String value) { 
		property.setProperty(key,value);
		try {
			property.saveProperty(); 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public  static String get(String name)
	{   
		return property.getProperty(name);
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
