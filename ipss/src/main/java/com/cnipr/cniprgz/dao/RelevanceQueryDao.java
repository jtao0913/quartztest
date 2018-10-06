/**
 * 
 */
package com.cnipr.cniprgz.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 * @author 戴国栋
 *
 * create 2010-1-15
 * company 知识产权出版社
 *@version 1.0 
 */
public class RelevanceQueryDao extends JdbcDaoSupport{
	
	public String getSimwords(String inputQuerys){
		String wordsArray="";
		try{
			if(inputQuerys==null||inputQuerys.equals("")){
				return "";
			}
			
			String sourceArray[]=inputQuerys.split("\\;");
			int sourceFlag=0;
			for(String tempStr:sourceArray){
				String[] inner=tempStr.split("\t");
				String sourceStr=inner[0];
				if(sourceFlag>5){
					break;
				}
				sourceFlag++;
				wordsArray+=getWords(sourceStr);
			}
		}
		catch(Exception e){
				
		}
		return wordsArray;
	}
	/**
	 * 同义词检索
	 * @param sourceStr
	 * @return
	 */
	@SuppressWarnings("unchecked")

	public String getWords(String sourceStr){
//		List<String> list=new ArrayList<String>();//20160127
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		
		String simWords = "";
		String simWordsFrommysql = "";
		String hsql="select simword from symdict where simword like '%"+sourceStr+"%'";
		//Type mismatch: cannot convert from List<Map<String,Object>> to List<String>
		list = getJdbcTemplate().queryForList(hsql);
		Iterator it=list.iterator();
		while(it.hasNext()){
			Map m=(Map)it.next();
			String tempStr=(String)m.get("simword");
			/**
			 * 如果没有在同义词典中发现;
			 */
			if(tempStr.indexOf(";")<0){
				tempStr=";"+tempStr+";";
			}
			if(tempStr.indexOf(";")==0&&tempStr.length()>1){
				tempStr=tempStr.substring(1,tempStr.length());
			}
			simWords+=tempStr;
			if(simWords.split(";").length<6){
				simWordsFrommysql=simWords.replaceAll(";", " ");
			}else{
				break;
			}
		}
		return simWordsFrommysql;
	}
}
