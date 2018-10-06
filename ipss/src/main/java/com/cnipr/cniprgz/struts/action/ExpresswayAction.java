package com.cnipr.cniprgz.struts.action;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.net.URLDecoder;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.jbase.common.util.StringUtil;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.func.ExpressionFunc;
import com.cnipr.cniprgz.func.VisitCountFunc;
import com.cnipr.cniprgz.security.SecurityTools;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 快速通道  -  从首页直接进入相应的检索频道
 * @author lq
 */
///expressway.do
public class ExpresswayAction extends ActionSupport {
	
	private VisitCountFunc visitFunc;
	
	public void setVisitFunc(VisitCountFunc visitFunc) {
		this.visitFunc = visitFunc;
	}
	
	public ExpressionFunc expFunc;
	
	public void setExpFunc(ExpressionFunc expFunc) {
		this.expFunc = expFunc;
	}

//	public ActionForward quickShowChannelForm (ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response) {

	 public String thirdPartySearch() throws Exception{
			ActionContext cxt = ActionContext.getContext();
	    	Map<String, Object> application = cxt.getApplication();
			HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
			HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
			HttpSession session = request.getSession();
			
			if(session.getAttribute(Constant.APP_USER_NAME)==null){
				autoLogin(request.getSession(),3);
			}
			
			String channelId = request.getParameter("strChannels");
			request.setAttribute("strChannel", (channelId == null) ? "" : channelId);
			
			String tabno = request.getParameter("tabno");
			request.setAttribute("tabno", (tabno == null) ? "" : tabno);
			
			String area = request.getParameter("area");
			request.setAttribute("area", (area == null||area.equals("")) ? "cn" : area);
			
//			request.setAttribute("strChannel", (area.equals("cn")) ? com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"cn","checked") : com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"fr","checked"));
//			request.setAttribute("strChannels", (area.equals("cn")) ? com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"cn","checked") : com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"fr","checked"));
			
			String quickSearch = request.getParameter("quickSearch");
			request.setAttribute("quickSearch", (quickSearch == null) ? "" : quickSearch);
			
//			String simpleSearch = request.getParameter("simpleSearch");
//			request.setAttribute("simpleSearch", (simpleSearch == null) ? "" : simpleSearch); 
			request.setAttribute("simpleSearch", "1"); 
			
			String keywords = request.getParameter("keywords");
			if(keywords!=null && keywords.equals("")==false)
				try {
					keywords = URLEncoder.encode(keywords,"utf-8");
				} catch (UnsupportedEncodingException e) { 
					e.printStackTrace();
				}
			request.setAttribute("keywords", (keywords == null) ? "" : keywords);
			
			String colname = request.getParameter("colname");
			request.setAttribute("colname", (colname == null) ? "" : colname);
//			session.setAttribute("colname", (colname == null) ? "" : colname);
			
			String content = request.getParameter("content");
			request.setAttribute("content", (content == null) ? "" : content);
//			session.setAttribute("content", (content == null) ? "" : content);
			
			request.setAttribute("strWhere", colname+""+content);
//			request.setAttribute("strChannels", colname+""+content);
			
			String pageType = request.getParameter("pageType");
			if (channelId != null && pageType!= null) {
				visitFunc.logPageVisit(channelId, pageType);
			}
			
			String right = request.getParameter("right");
			request.setAttribute("right", (right == null) ? "" : right);		
			
			String julei = request.getParameter("julei");
			request.setAttribute("julei", (julei == null) ? "" : julei);
			
			String fenxi = request.getParameter("fenxi");
			request.setAttribute("fenxi", (fenxi == null) ? "" : fenxi);		
			
			return SUCCESS;
		}
	
	public String wapexpresssearch() throws Exception{
//		ActionContext cxt = ActionContext.getContext();
//	   	Map<String, Object> application = cxt.getApplication();
//		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
//		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
//		HttpSession session = request.getSession();
			
//		System.out.println("wapexpresssearch.....");
		return SUCCESS;
	}
	
	public String expressSearch() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String uid = request.getParameter("uid");
		String securityKey = request.getParameter("securityKey");
		
		if(uid!=null && securityKey!=null)
		{
			if(SecurityTools.getSecurityCode(uid).equals(securityKey))
			{
//				autoLogin(request.getSession(),Integer.parseInt(uid));
			}else
			{
				return ERROR;
			}
		}else
//		 快速进入检索频道时，自动使用默认用户登录
		{
			if(StringUtil.hasText(uid)==false)
				uid =  DataAccess.getProperty("defaultUserId");
//			autoLogin(request.getSession(),Integer.parseInt(uid));
		}
		
		String channelId = request.getParameter("strChannels");
		request.setAttribute("strChannel", (channelId == null) ? "" : channelId);
		
//		channelId = "14,15,16";
		 
		String tabno = request.getParameter("tabno");
		request.setAttribute("tabno", (tabno == null) ? "" : tabno);
		
		String area = request.getParameter("area");
		request.setAttribute("area", (area == null||area.equals("")) ? "cn" : area);
		
//		request.setAttribute("strChannel", (area.equals("cn")) ? com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"cn","checked") : com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"fr","checked"));
//		request.setAttribute("strChannels", (area.equals("cn")) ? com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"cn","checked") : com.cnipr.cniprgz.commons.Util.getPatentTableIDsByAreaChecked(application,"fr","checked"));
		
		String quickSearch = request.getParameter("quickSearch");
		request.setAttribute("quickSearch", (quickSearch == null) ? "" : quickSearch);
		
//		String simpleSearch = request.getParameter("simpleSearch");
//		request.setAttribute("simpleSearch", (simpleSearch == null) ? "" : simpleSearch); 
		request.setAttribute("simpleSearch", "1"); 
		
		String keywords = request.getParameter("keywords");
		if(keywords!=null && keywords.equals("")==false)
			try {
				keywords = URLEncoder.encode(keywords,"utf-8");
			} catch (UnsupportedEncodingException e) { 
				e.printStackTrace();
			}
		request.setAttribute("keywords", (keywords == null) ? "" : keywords);
		
		String colname = request.getParameter("colname");
		request.setAttribute("colname", (colname == null) ? "" : colname);
//		session.setAttribute("colname", (colname == null) ? "" : colname);
		
		String content = request.getParameter("content");
		request.setAttribute("content", (content == null) ? "" : content);
//		session.setAttribute("content", (content == null) ? "" : content);
		
		request.setAttribute("strWhere", colname+""+content);
//		request.setAttribute("strChannels", colname+""+content);
		
		String pageType = request.getParameter("pageType");
		if (channelId != null && pageType!= null) {
			visitFunc.logPageVisit(channelId, pageType);
		}
		
		String right = request.getParameter("right");
		request.setAttribute("right", (right == null) ? "" : right);		
		
		String julei = request.getParameter("julei");
		request.setAttribute("julei", (julei == null) ? "" : julei);
		
		String fenxi = request.getParameter("fenxi");
		request.setAttribute("fenxi", (fenxi == null) ? "" : fenxi);		
		
		
		String userID = (String) request.getSession().getAttribute(Constant.APP_USER_ID);
		String userIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr( request);
		int intCountry = (area != null && area.equalsIgnoreCase("fr")) ? 1 : 0;
		
/*				String commonExp = ParseSemanticExp.getSemanticExp(strWhere)[2];
		String relation = ParseSemanticExp.getSemanticExp(strWhere)[0];
		String semantic = overviewResponse.getPatentWords();
		if (semantic != null && !semantic.equals("")) {
			semantic = "ss=" + Array2StringUtil.parseArray(semantic);
			strWhere = commonExp + relation + semantic;
		}*/

//		expid = expFunc.saveExpression(userIP, Integer.parseInt(userID),
//				strWhere, strTRSTableName, null, totalRecord, request
//						.getParameter("synonymous"), intCountry);
				
		return SUCCESS;
	}
	
	
	/**
	 * 快速进入检索频道时，自动使用默认用户登录
	 * @param session
	 */
	private void autoLogin(HttpSession session) {		 
		
		session.setAttribute(Constant.APP_USER_NAME, DataAccess.getProperty("defaultUserName"));
		session.setAttribute(Constant.APP_USER_ID, DataAccess.getProperty("defaultUserId"));
		session.setAttribute(Constant.APP_USER_ROLE, DataAccess.getProperty("defaultUserRoleID"));
		session.setAttribute(Constant.APP_USER_PWD, DataAccess.getProperty("defaultUserPwd"));
		session.setAttribute("intAdministerId", DataAccess.getProperty("intAdministerId"));
		session.setAttribute("userMenu", DataAccess.getProperty("defaultUserMenu"));
		session.setAttribute(Constant.APP_USER_FEETYPE, 0);
		session.setAttribute("strUserType", "corp");
		session.setAttribute("intAdministerId", 1);
		session.setAttribute("logoffPage", "/index.htm");
	}	
	
	private int autoLogin(HttpSession session,int uid) {
		IprUserDAO iprUserDAO = new IprUserDAO();
		IprUser iprUser = iprUserDAO.getUserInfo(uid);
		
		if(iprUser!=null)
		{
			session.setAttribute(Constant.APP_USER_NAME, iprUser.getChrUserName());
			session.setAttribute(Constant.APP_USER_ID, Integer.toString(iprUser.getIntUserId()));
			session.setAttribute(Constant.APP_USER_CHANNELID, iprUser.getChrChannelId());
			session.setAttribute(Constant.APP_USER_ITEMGRANT, iprUser.getChrItemGrant());
			session.setAttribute(Constant.APP_USER_ROLE, iprUser.getIntGroupId());
			session.setAttribute(Constant.APP_USER_FEETYPE, 0);
			session.setAttribute("strUserType", "corp");
			session.setAttribute("intCHCount", iprUser.getIntChcount());
			session.setAttribute("intFRCount", iprUser.getIntFrcount());
			session.setAttribute("dtRegisterTime", iprUser.getDtRegisterTime());
			session.setAttribute("dtCurrentCardTime", iprUser.getDtCurrentCardTime());
			session.setAttribute("intAdministerId", iprUser.getIntAdministerId());
			session.setAttribute("userMenu", iprUser.getChrMenu());	
			session.setAttribute("strItemGrant", iprUser.getChrItemGrant());
			
			session.setAttribute("ABSTBatchCount", iprUser.getIntMaximum());
			 
			//session.setAttribute("logoffPage", "/index.htm");
			return 1;
		}else
			return -1;
	}
	
	
}
