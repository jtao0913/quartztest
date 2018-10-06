/**
 * 
 */
package com.cnipr.util.patent.format;

import java.text.DateFormat;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Administrator
 *
 */
public class Common {
	
	/**
	 * 判断是否为数字
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str)
	{
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if( !isNum.matches() )
		{
		return false;
		}
		return true;
	} 
	
	/**
	 * 将字符串转换成xxxx-xx-xx格式
	 * @param date
	 * @return
	 */
	public static String turn_date(String date)
	{	
		String date_10="";
		if(date!=null && date.equals("")==false)
			date = date.replace("-", ".");
		StringTokenizer d = new StringTokenizer(date,".");
		int d_length =  d.countTokens();
		String[] datenum = new String[d_length];
		for(int i=0;i<d_length;i++)
		{
			datenum[i]=d.nextToken();
			if(i==0&&datenum[i].length()==2)
			{
				if(isNumeric(datenum[i]))
				{
				if(Integer.parseInt(datenum[i].substring(0,1))>1)
					datenum[i]="19"+datenum[i];
				else 
					datenum[i]="20"+datenum[i];
				}
			}
			else if(datenum[i].length()==1)
			{
				if(isNumeric(datenum[i]))
				{
				if(Integer.parseInt(datenum[i])<10)
					datenum[i]="0"+datenum[i];
				}
			}
		}
		for(int k=0;k<d_length;k++ )
		{
			if(k == (d_length-1))
				date_10=date_10+datenum[k];
			else if(k==0)
				date_10=datenum[k]+".";
			else
				date_10=date_10+datenum[k]+".";
				
		}
		return date_10.trim();
	}
	
	/**
	 * 判断字符传是否为日期格式
	 * @param datetime
	 * @return
	 */
	public static boolean isDate(String datetime){
		datetime = datetime.replace(".","-");
		DateFormat df = DateFormat.getDateInstance();
	      try {
	         Date d = df.parse(datetime);
	         StringTokenizer t = new StringTokenizer(datetime,"-");
	         int len = t.countTokens();
	         String [] da = new String[len];
	         for(int i=0;i<len;i++){
	        	 da[i]=t.nextToken();
	        	 if(i==0)
	        	 {
	        		 if(da[i].length()!=2&&da[i].length()!=4&&isNumeric(da[i]))
	        		 return false;
	        		 else if(isNumeric(da[i])&&da[i].length()==2)
	        		 {	int year = Integer.parseInt(da[i]);
	        			 if(year<49&&year>20)
	        				 return false;	        				 
	        		 }else if(isNumeric(da[i])&&da[i].length()==4){
	        			 int year = Integer.parseInt(da[i]);
	        			 if(year<1949||year>2080)
	        				 return false;	
	        		 }
	        	 }//年
	        	 else//月和日判断 
	        	 {
	        		 if(da[i].length()>2)
	        			 return false;
	        		 else if(isNumeric(da[i])==false)
	        			 return false;
	        		 else if(Integer.parseInt(da[i])>31)
	        			 return false;
	        	 }
	         }
	         return true;
	      }
	      catch(java.text.ParseException e) {
	         return false;
	      }
	}
	
	/**
	 * 将字符串中含有日期格式转换为xxxx-xx-xx标准格式
	 * @param line
	 * @return
	 */
	public static String turn_hasDate(String line){
		line=line.replace("　"," ");
		StringTokenizer token = new StringTokenizer(line," ");
		String e[]  = new String[token.countTokens()];
		String new_line ="";
		for(int i=0;i<e.length;i++)
		{
			e[i]=token.nextToken();
			if(isDate(e[i])==true)
				e[i]=turn_date(e[i]);
			
			new_line=new_line+" "+e[i];
		}
		
		return new_line.trim();
	}
	/**
	 * 统计汉字数
	 * @param a
	 * @return
	 */
	public static int CountHanzi(String a)  
	{
	   	int count =0;
	   	char[] arr = a.toCharArray();
        for (int i=0; i<arr.length; i++) {
            if (isHanZi(arr[i])) {
                count++;
            }
        }
        return count;
	}
	/**
	 * 判断是否为汉字
	 * @param c
	 * @return
	 */
	public static boolean isHanZi(char c) {
        
		String regx = "[\\u4e00-\\u9fa5]+";
        Pattern p = Pattern.compile(regx);
        Matcher m = p.matcher(String.valueOf(c));
        return m.find() ? true : false;
    }
}
