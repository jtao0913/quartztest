package com.cnipr.cniprgz.struts.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.entity.AnalyzeMenu;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.func.AnalyseMenuFunc;
import com.cnipr.cniprgz.func.SysUserFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;

public class AnalyseMenuAction extends ActionSupport {
	
	public AnalyseMenuFunc analyseMenuFunc;	
	public AnalyseMenuFunc getAnalyseMenuFunc() {
		return analyseMenuFunc;
	}
	public void setAnalyseMenuFunc(AnalyseMenuFunc analyseMenuFunc) {
		this.analyseMenuFunc = analyseMenuFunc;
	}

	private static final long serialVersionUID = 6496676670824054280L;
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	public String getAllAnalyseMenuInfo() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
//		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String area = request.getParameter("area");
		area = (area==null||area.equals(""))?"cn":area;
		
//		int cnfr = Integer.parseInt(request.getParameter("cnfr")==null?"0":request.getParameter("cnfr"));
		
		List<AnalyzeMenu> analysemenuList = analyseMenuFunc.getAllAnalyseMenuInfo(area);
		
//		session.setAttribute("analysemenuList",analysemenuList);
		
		JSONArray json = JSONArray.fromObject(analysemenuList);//将list对象转换成json类型数据
		
//		jsonresult = "success##"+json.toString();//给result赋值，传递给页面
		jsonresult = json.toString();
		
		return SUCCESS;
	}
	
	public String getMenuInfoByID() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String analyseMenuID = request.getParameter("analyseMenuID");		
		AnalyzeMenu analyzeMenu = analyseMenuFunc.getAnalyseMenuInfoByID(analyseMenuID);
		
		JSONArray json = JSONArray.fromObject(analyzeMenu);//将list对象转换成json类型数据
		
		jsonresult = json.toString();
		
		return SUCCESS;
	}	
}
