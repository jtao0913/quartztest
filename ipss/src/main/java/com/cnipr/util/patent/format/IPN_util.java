package com.cnipr.util.patent.format;

import net.jbase.common.util.StringUtil;
 
 
 

/**
 * @author Administrator
 *
 */
public class IPN_util {

	/**
	 * input : WO00/11698 德 2000.03.02
	 * 		   2005-04-14  WO2005/034328  英
	 * output:
	 * 国际公布日	“国际公布号”号码处理方法	样例
	 1997.02.06—2002.06.20	
		如果年代信息为4位数字，则去掉最左侧的2位数字；如果流水号为6位数字，则去掉流水号最左侧的1位数字。然后去掉所有国际公布号中的“/”。.
		WO2002/026294
		→WO0226294；
		WO01/082346
		→WO0182346
	2002.07.04—2002.12.05	
	    如果年代信息为4位数字，则去掉最左侧的2位数字；如果流水号为5位数字，则在流水号最左侧的增加1位数字“0”。然后去掉所有国际公布号中的“/”。	WO2002/068641
		→WO02068641；
		WO02/55070
		→WO02055070
	2002.12.19—2002.12.27	
		如果年代信息为4位数字，则去掉最左侧的2位数字；如果流水号为0+5位数字，则在流水号最左侧的数字“0”改为“1”，然后去掉所有国际公布号中的“/”。	WO2002/002650
		→WO02102650；
		WO02/000168
		→WO02100168
	2003.01.03—2003.12.24
		如果年代信息为4位数字，则去掉最左侧的2位数字；如果流水号为5位数字，则在流水号最左侧增加一个“0”，然后去掉所有国际公布号中的“/”。	WO03/00998
		→WO03000998；
		WO2003/006700
		→WO03006700
	2003.12.31—2008.10.16	
		直接去掉所有国际公布号中的“/”。	WO2004/022100
		→WO2004022100
	
	 * @param args ipn
	 */
	public static String toWIPO(String ipn){
		if(StringUtil.hasText(ipn))
		{	
			ipn = ipn.replace("　", " ");//去全角
			String ipn_item[] = StringUtil.tokenizeToStringArray(ipn," ");
			String wo_str = "";//公布号
			String ipn_date = ""	;//公布日		
			/**
			 * 分析国际公布，判断公布号
			 */
			for(int i=0;i<ipn_item.length;i++)
			{
				if(StringUtil.startsWithIgnoreCase(ipn_item[i], "WO") 
						&&  
						StringUtil.countOccurrencesOf(ipn_item[i], "/")!=0)
					wo_str = ipn_item[i].substring(2);//得到不含有wo的ipn
				else
					if(Common.isDate(ipn_item[i]))
						ipn_date = Common.turn_date(ipn_item[i]);
			}
			
			if(StringUtil.hasText(wo_str) && StringUtil.hasText(ipn_date))
			{
				if(ipn_date.compareTo("1997.02.06")>=0 && ipn_date.compareTo("2002.06.20")<=0)
					{
						String wo_item[] = StringUtil.splitStringToArray(wo_str, "/");
						//如果年代信息为4位数字，则去掉最左侧的2位数字
						 if(wo_item[0].length()==4)
						 {
							 return wo_str.substring(2).replace("/", "");
						 }else
							 return wo_str.replace("/", "");//去掉所有/
							
					}
				else  
				 if(ipn_date.compareTo("2002.07.04")>=0 && ipn_date.compareTo("2002.12.05")<=0)
				 {
						String wo_item[] = StringUtil.splitStringToArray(wo_str, "/");
						//如果年代信息为4位数字，则去掉最左侧的2位数字
						String result = wo_str;
						 if(wo_item[0].length()==4)
						 {
							 if(wo_item[1]!=null && wo_item[1].length()==5)
								 result = wo_str.substring(2).replace("/", "0");
							 else
								 result = wo_str.substring(2).replace("/", "");
						 }else
							 {
							 if(wo_item[1]!=null && wo_item[1].length()==5)
								 result = wo_str.replace("/", "0");
							 else
								 result = wo_str.replace("/", "");
							 }
						 return result;
				 }
			    else 
				 if(ipn_date.compareTo("2002.12.19")>=0 && ipn_date.compareTo("2002.12.27")<=0)
				 {
						String wo_item[] = StringUtil.splitStringToArray(wo_str, "/");
						//如果年代信息为4位数字，则去掉最左侧的2位数字
						String result = wo_str;
						 if(wo_item[0].length()==4)
						 {
							 if(wo_item[1]!=null && wo_item[1].length()==6 && wo_item[1].startsWith("0"))
								 result = wo_str.substring(2).replace("/0", "1");
							 else
								 result = wo_str.substring(2).replace("/", "");
						 }else
							 {
							 if(wo_item[1]!=null && wo_item[1].length()==6 && wo_item[1].startsWith("0"))
								 result = wo_str.replace("/0", "1");
							 else
								 result = wo_str.replace("/", "");
							 }
						 return result;
				 }
				else  
				 if(ipn_date.compareTo("2003.01.03")>=0 && ipn_date.compareTo("2003.12.24")<=0) 
					 {
							String wo_item[] = StringUtil.splitStringToArray(wo_str, "/");
							//如果年代信息为4位数字，则去掉最左侧的2位数字
							String result = wo_str;
							 if(wo_item[0].length()==4)
							 {
								 if(wo_item[1]!=null && wo_item[1].length()==5 )
									 result = wo_str.substring(2).replace("/", "0");
								 else
									 result = wo_str.substring(2).replace("/", "");
							 }else
								 {
								 if(wo_item[1]!=null && wo_item[1].length()==5)
									 result = wo_str.replace("/", "0");
								 else
									 result = wo_str.replace("/", "");
								 }
							 return result;
					 } 
				else  
				 if(ipn_date.compareTo("2003.12.31")>=0)
					 {
					   return wo_str.replace("/", "");
					 }
				return wo_str;
			}else 
				return null;
		}
		else 
			return null;
		
	}
	public static void main(String[] args) {
		
		System.out.println(IPN_util.toWIPO("WO2002/26294 中 2002.09.3"));
	}

}
