/**
 * 
 */
package com.cnipr.cniprgz.struts.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import com.cnipr.cniprgz.func.search.SemanticSearch;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author 戴国栋
 *
 * create 2010-1-12
 * company 知识产权出版社
 *@version 1.0 
 */
public class PatentWordtips extends ActionSupport {
	
	private SemanticSearch semanticSearchImpl;
	
	public SemanticSearch getSemanticSearchImpl() {
		return semanticSearchImpl;
	}

	public void setSemanticSearchImpl(SemanticSearch semanticSearchImpl) {
		this.semanticSearchImpl = semanticSearchImpl;
	}
	/*
	public ActionForward getWordTips(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		
		PrintWriter out=null;
		JSONArray jsonObj=new JSONArray();
		String inputQuerys=request.getParameter("q")==null||request.getParameter("q").trim().equals("")?"":request.getParameter("q");
		
		try{
			inputQuerys=new String(inputQuerys.getBytes("ISO-8859-1"),"UTF-8");
			String[] wordTips=semanticSearchImpl.getWordTips(inputQuerys);
			for(String tempWords:wordTips){
				jsonObj.add(new String(tempWords.getBytes("UTF-8"),"ISO-8859-1"));
			}
			out=response.getWriter();
			out.print(jsonObj);
		}catch(Exception e){
			return null;
		}finally{
			if (out != null)
			out.close();
		}
		return null;
	}
	public ActionForward getAutoIndex(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		
		String autoIndex="";
		String appno=request.getParameter("appno");		
		String searchdb= request.getParameter("dbname");
		
		PrintWriter out=null;
		try{
			out=response.getWriter();
			autoIndex=semanticSearchImpl.getSemanticResult(appno, searchdb, "", "", "", "", 500, 20);
			autoIndex=new String(autoIndex.getBytes("UTF-8"),"ISO-8859-1");
			out.print(autoIndex);
		}catch(Exception e){
			
		}finally{
			out.close();
		}
		return null;
	}
	*/
}
