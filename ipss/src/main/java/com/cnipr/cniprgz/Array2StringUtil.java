/**
 * 
 */
package com.cnipr.cniprgz;

/**
 * @author 戴国栋
 *
 * create 2010-1-19
 * company 知识产权出版社
 *@version 1.0 
 */
public class Array2StringUtil {
	
	public static String parseArray(String sourceStr){
		String[] splitString=sourceStr.split(";");
		String targetStr="";
		for(String tempStr:splitString){
			targetStr +=tempStr.split("\t")[0]+" ";
		}
		return targetStr;
	}

}
