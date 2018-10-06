package com.cnipr.cniprgz.struts.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.func.FavoriteFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.corebiz.search.entity.PatentInfo;
import com.cnipr.corebiz.search.ws.response.DetailSearchResponse;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.cnipr.cniprgz.commons.Util;

public class FavoriteAction extends ActionSupport {
	public FavoriteFunc favoriteFunc;
	
	public SearchFunc searchFunc;

	public FavoriteFunc getFavoriteFunc() {
		return favoriteFunc;
	}

	public void setFavoriteFunc(FavoriteFunc favoriteFunc) {
		this.favoriteFunc = favoriteFunc;
	}
	
	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}

//	public ActionForward getFavorite(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
		
//saveFavorite("<%=strUserIp%>", "<%=strUserId%>", "<%=strUserType%>", patentList);
	
//saveFavorite("<%=strUserIp%>", "<%=strUserId%>", "<%=strUserType%>", patentList);
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	public String saveFavorite() throws Exception{
		try{
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
			int intUserId = Integer.parseInt((String) request.getSession().getAttribute(Constant.APP_USER_ID));
			String strUserType = (String) request.getSession().getAttribute("strUserType");
			String strUserIp = com.cnipr.cniprgz.commons.Common.getRemoteAddr( request);
			
	//		request.setAttribute("favoriteList", favoriteFunc.getFavorite(intUserId, strUserIp, strUserType));
			
			String strPatentList = request.getParameter("favoritepatents");
			
			strPatentList = java.net.URLDecoder.decode(strPatentList,"UTF-8");
						
			List<PatentInfo> patentList = new ArrayList<PatentInfo>();
			List<PatentInfo> _patentList = null;
			_patentList = (List<PatentInfo>)request.getSession().getAttribute("list");
			
			String[] arrPatentAn = strPatentList.split(",");
//			 for(int i=0;i<arrPatentAn.length;i++){
//				 PatentInfo _pi = patentList.
//			 }
			 
			 Iterator<PatentInfo> iter = _patentList.iterator();				 
			 while(iter.hasNext())  
			 {  
				 PatentInfo pi = iter.next();

				 for(int i=0;i<arrPatentAn.length;i++){
					 if(pi.getAn().equals(arrPatentAn[i])){
						 patentList.add(pi);
					 }						 
				 }					 
			     //System.out.println(iter.next());  
			 }
//			List<PatentInfo> patentInfoList = Util.getList4Json(strPatentList,PatentInfo.class);
			
			favoriteFunc.saveFavorite(strUserIp, intUserId, strUserType, patentList);			
		}catch(Exception ex){
			throw ex;
		}
		jsonresult = "收藏成功";
		
		return SUCCESS;
	}	
	
	public String getFavorite(){
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
		int intUserId = Integer.parseInt((String) request.getSession()
				.getAttribute(Constant.APP_USER_ID));
		String strUserType = (String) request.getSession().getAttribute(
				"strUserType");
		String strUserIp = com.cnipr.cniprgz.commons.Common.getRemoteAddr( request);
		request.setAttribute("favoriteList", favoriteFunc.getFavorite(
				intUserId, strUserIp, strUserType));
//		return mapping.findForward("favoriteList");
		return SUCCESS;
	}

//	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
		
	public String getDetail(){
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
		String strWhere = request.getParameter("strWhere");
		String strSources = request.getParameter("strSources");
//		System.out.println(searchFunc);
		DetailSearchResponse detailResponse = null;

		String wap = request.getParameter("wap")==null?"":request.getParameter("wap");
		
		try {
			detailResponse = searchFunc.detailSearch( wap, strSources, strWhere, "", "",
					null, 0, 0, false, -1, "all");
		} catch (Exception e) {
//			this.saveErrors(request, errors);//20160127
//			return mapping.findForward("searchError");
			return ERROR;
		}

		request.setAttribute("dbName", strSources);
		request.setAttribute("patentInfo", detailResponse.getPatentInfo());
//		return mapping.findForward("detail");
		return SUCCESS;
	}

//	public ActionForward delSingleFavorite(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) {
		
	public String delSingleFavorite(){
			ActionContext cxt = ActionContext.getContext();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
//		if(session.getAttribute(Constant.APP_USER_ID)==null){
//			return LOGIN;
//		}
			
		String favoriteId = request.getParameter("favoriteId");
		if (favoriteId != null && !favoriteId.equals("")) {
			List<Integer> favoriteIdList = new ArrayList<Integer>();
			favoriteIdList.add(Integer.parseInt(favoriteId));
			favoriteFunc.delFavorite(favoriteIdList);
		}
//		return getFavorite(mapping, form, request, response);
		return getFavorite();
	}

//	public ActionForward delAllFavorite(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {
		
	public String delAllFavorite(){
			ActionContext cxt = ActionContext.getContext();
			Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
		
		int intUserId = Integer.parseInt((String) request.getSession()
				.getAttribute(Constant.APP_USER_ID));
		String strUserType = (String) request.getSession().getAttribute(
				"strUserType");
		String strUserIp = com.cnipr.cniprgz.commons.Common.getRemoteAddr( request);

		favoriteFunc.delAllFavorite(intUserId, strUserIp, strUserType);
//		return getFavorite(mapping, form, request, response);
		return SUCCESS;
	}

}
