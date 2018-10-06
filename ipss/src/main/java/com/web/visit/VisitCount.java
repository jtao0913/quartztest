package com.web.visit;
import java.io.IOException;


public class VisitCount { 
		private static final long serialVersionUID = 1L;
		
		private static PropertyUtil property;
		static{
			property =  PropertyUtil.getInstance("visit.properties");
		}
		
		public  static  void set(String name,long value)
		{
			property.setProperty(name,value+"");
			try {
				property.saveProperty(); 
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		public  static  void set(String name,String value)
		{
			property.setProperty(name,value);
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
	/*	public static void main(String[] args)
		{
			
		//	VisitCount.set("Main", 3);
			System.out.println(VisitCount.get("Main"));
		}
*/
}
