package com.cnipr.cniprgz.struts.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.func.SysUserFunc;
import com.cnipr.cniprgz.func.stat.StatBean;
import com.cnipr.cniprgz.func.stat.StatFunc;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.trs.usermanage.UserManage;

public class UserAction extends ActionSupport {

	public SysUserFunc sysUserFunc;

	public void setSysUserFunc(SysUserFunc sysUserFunc) {
		this.sysUserFunc = sysUserFunc;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	public String getUserStatus() throws Exception{

		
		return SUCCESS;
	}
	
//	public String managesystem() throws Exception{
//		return SUCCESS;
//	}
	
	public String warnCreate() throws Exception{
		return SUCCESS;
	}
	
	public String getMyWarm() throws Exception{
		return SUCCESS;
	}
	
	public String warnExecuteList() throws Exception{
		return SUCCESS;
	}
	
	public String warnExecuteDo() throws Exception{
		return SUCCESS;
	}
	
	public String warnEdit() throws Exception{
		return SUCCESS;
	}
	
	public String warnEditDo() throws Exception{
		return SUCCESS;
	}	
	
	public String getUserList() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String adminState = request.getParameter("adminState");
		request.setAttribute("adminState", "0");
		
		return SUCCESS;
	}
	public String getAdminList() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		
		String adminState = request.getParameter("adminState");
		request.setAttribute("adminState", "1");
		return SUCCESS;
	}
	
	public String adduser() throws Exception{
		return SUCCESS;
	}
	
	public String deleteuser() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		
		String userIds = request.getParameter("userIds");
		
		UserManage usermanage=new UserManage();
		
		String[] arrUserId=userIds.split(",");
		
		for(int i=0;i<arrUserId.length;i++) {
			usermanage.deleteUser(Integer.parseInt(arrUserId[i]));
		}
		jsonresult = "success";
		
		return SUCCESS;
	}
	
	public String addusersubmit() throws Exception{
		return SUCCESS;
	}	
	
	public String updateuser() throws Exception{
		return SUCCESS;
	}
	
	public String updateusersubmit() throws Exception{
		return SUCCESS;
	}
	

	
	public String hangyemanage() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		
		List<ChannelInfo> channelInfoList_cn = (List<ChannelInfo>)application.get("channelInfoList_cn");//全部CN
		
		List<ChannelInfo> _channelInfoList_fr = (List<ChannelInfo>)application.get("channelInfoList_fr");//全部FR
		List<ChannelInfo> channelInfoList_fr = new ArrayList<ChannelInfo>();

		for (ChannelInfo channelInfo : _channelInfoList_fr) {
			/*if (channelId.contains(Integer.toString(channelInfo
					.getIntChannelID()))) { 
				channelInfo.setChrCheck("checked");
			} else {
				channelInfo.setChrCheck("");
			}*/
				
			if(channelInfo.getChrCheck()!=null&&channelInfo.getChrCheck().equals("checked")) {
				channelInfoList_fr.add(channelInfo);
			}
		}

		request.setAttribute("channel_cn", channelInfoList_cn);
		request.setAttribute("channel_fr", channelInfoList_fr);
		
		return SUCCESS;
	}

	public String assignhangye() throws Exception{
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
//		intUserID,String tradeInfo1,String tradeInfo3
    	
    	String userIDs=request.getParameter("userIDs");
//    	System.out.println(userIDs);
    	
    	int assignUserID = Integer.parseInt(request.getParameter("assignUserID"));
    	String tradeInfo=request.getParameter("tradeInfo");
		
    	UserManage usermanage=new UserManage();
		int ret = usermanage.assignTrade(assignUserID,tradeInfo);

		if (ret!=1) {
			jsonresult = "error";
		}else {			
			String userID[];		//用户ID
			String userNav1[];
			String userNav3[];

			userID=userIDs.split(",");

			userNav1=new String[userID.length];
			userNav3=new String[userID.length];
			
//			UserManage usermanage=new UserManage();
			for(int i=0;i<userID.length;i++){
				userNav1[i]=usermanage.getUserTradeInfoByUserID(Integer.parseInt(userID[i]),1);		
				userNav3[i]=usermanage.getUserTradeInfoByUserID(Integer.parseInt(userID[i]),3);
			}
			
			String UserSelTradeInfo1 = "";
			for(int i=0;i<userNav1.length;i++)
			{
				if(!UserSelTradeInfo1.equals("")){
					UserSelTradeInfo1+="=";
				}
				UserSelTradeInfo1+=userNav1[i].trim();
			}
			
			String UserSelTradeInfo3 = "";
			for(int i=0;i<userNav3.length;i++)
			{
				if(!UserSelTradeInfo3.equals("")){
					UserSelTradeInfo3+="=";
				}
				UserSelTradeInfo3+=userNav3[i].trim();
			}
			
			jsonresult = "success##"+UserSelTradeInfo1+"##"+UserSelTradeInfo3;//给result赋值，传递给页面
		}
    	
		return SUCCESS;
	}
	
	public String statmanage() throws Exception{
		return SUCCESS;
	}
	
	public String statdetail() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpSession session = request.getSession();
		
		StatFunc statFunc = new StatFunc();
		
		int userid = Integer.parseInt(request.getParameter("userid"));
		String earliesttime = statFunc.getEarliestTime(userid);	
		if(earliesttime.length()==21){
			earliesttime = earliesttime.substring(0, 7);
//			System.out.println("earliesttime="+earliesttime);
//			String userName = request.getParameter("userName");
			String statrealname = request.getParameter("statrealname");
			
			String begin_recepttime = request.getParameter("begin_recepttime");
			
//			System.out.println("begin_recepttime="+begin_recepttime);
			
			String startYear = "";
			String startMonth = "";
			
			if(begin_recepttime!=null&&!begin_recepttime.equals("")) {
				startYear = begin_recepttime.substring(0, 4);
				startMonth = begin_recepttime.substring(5, 7);
				
//				int int_startyear = Integer.parseInt(startYear);
//				int int_startmonth = Integer.parseInt(startMonth);
//				
//				int int_earliestyear = Integer.parseInt(earliesttime.substring(0, 4));
//				int int_earliestmonth = Integer.parseInt(earliesttime.substring(5, 7));
				
				if(Integer.parseInt(startYear+""+startMonth)<=Integer.parseInt(earliesttime.substring(0, 4)+""+earliesttime.substring(5, 7))) {
					
				}else {
					earliesttime = startYear+"-"+startMonth;
				}
			}
			/////////////////////////////////////////////////////////////////////////
			String nowYear = "";
			String nowMonth = "";
			String end_recepttime = request.getParameter("end_recepttime");
//			System.out.println("end_recepttime="+end_recepttime);
			
			java.util.Date now = new java.util.Date();
			java.text.SimpleDateFormat formatYear = new java.text.SimpleDateFormat("yyyy");
			java.text.SimpleDateFormat formatMonth = new java.text.SimpleDateFormat("MM");
			nowYear = formatYear.format(now);
			nowMonth = formatMonth.format(now);
			
//			if(endYear==null || "".equals(endYear)){
//				endYear = formatYear.format(now);
//			}
//			if(endMonth==null || "".equals(endMonth)){
//				endMonth = formatMonth.format(now);
//			}
			
			String endyearmonth = "";
			String endYear = "";
			String endMonth = "";
			if(end_recepttime!=null&&!end_recepttime.equals("")) {
				endYear = end_recepttime.substring(0, 4);
				endMonth = end_recepttime.substring(5, 7);
				
//				int int_nowyear = Integer.parseInt(nowYear);
//				int int_nowmonth = Integer.parseInt(nowMonth);
//				
//				int int_endyear = Integer.parseInt(endYear);
//				int int_endmonth = Integer.parseInt(endMonth);
				
				if(Integer.parseInt(endYear+""+endMonth)<=Integer.parseInt(nowYear+""+nowMonth)) {
					endyearmonth = endYear+"-"+endMonth;
				}else {
					endyearmonth = nowYear+"-"+nowMonth;
				}
					
			}else {
				endyearmonth = nowYear+"-"+nowMonth;
			}

/*			if(startYear==null || "".equals(startYear)){
				startYear = "2011";
			}
			if(startMonth==null || "".equals(startMonth)){
				startMonth = "01";
			}
*/
//			List<StatBean> resultList = statFunc.statDetail(userName, startYear + "-" + startMonth,endYear+"-"+endMonth);
			List<StatBean> resultList = statFunc.statDetail(userid, earliesttime,endyearmonth);
			request.setAttribute("resultList", resultList);			
			request.setAttribute("statrealname", statrealname);
			request.setAttribute("userid", userid);
		}else {
			request.setAttribute("resultList", null);
		}
		
		return SUCCESS;
	}
	
	public String passwdchange() throws Exception{
		return SUCCESS;
	}	
	
	public String mytreehangye() throws Exception{
		return SUCCESS;
	}	
	
	public String mytreesubject() throws Exception{
		return SUCCESS;
	}
	
	public String mytreeipc() throws Exception{
		return SUCCESS;
	}
	
	public String mytreegmjj() throws Exception{
		return SUCCESS;
	}
	
	public String mytreeaddress() throws Exception{
		return SUCCESS;
	}
	/*public ActionForward changePwd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {*/	
	public String changePwd() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		int userId = Integer.parseInt((String) request.getSession()
				.getAttribute(Constant.APP_USER_ID));
		String oldPWD = request.getParameter("oldpasswd");
		String newPWD = request.getParameter("newpasswd");

		request.setAttribute("pwdChangeRes", Integer.toString(sysUserFunc
				.changePWD(userId, oldPWD, newPWD)));

		//return mapping.findForward("pcResult");
		return SUCCESS;
	}
	
	
	//public ActionForward changeLimit(ActionMapping mapping, ActionForm form,
	//		HttpServletRequest request, HttpServletResponse response) {
	public String changeLimit() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
		String userid = request.getParameter("userid"); 
		String limit[] = request.getParameterValues("limit");
		String limitStr  = "";
		if(limit!=null)
			for(int i=0;i<limit.length;i++)
			{
				limitStr+=limit[i]+";";
			}
		sysUserFunc.getIprUserDAO().changeUserGrant(Integer.parseInt(userid), limitStr);
		
		request.setAttribute("jsonResult", "{jsonMessage:\"true\"}");	 
		//return mapping.findForward("changeLimit");
		return SUCCESS;
	}
	
	public String getChangeInfoPage(HttpServletRequest request,
			HttpServletResponse response) {
		int userId = Integer.parseInt((String) request.getSession()
				.getAttribute(Constant.APP_USER_ID));

		IprUser userInfo = sysUserFunc.getUserInfo(userId);

		request.setAttribute("userInfo", userInfo);

		return SUCCESS;
	}

	
	//public ActionForward getUserInfoLimit(ActionMapping mapping,
	//		ActionForm form, HttpServletRequest request,
	//		HttpServletResponse response) {
	//	String userid = request.getParameter("userid"); 
	//	IprUser userInfo = sysUserFunc.getUserInfo(Integer.parseInt(userid)); 
	//	request.setAttribute("userInfo", userInfo); 
	//	return mapping.findForward("userLimit");
	//}
		
	public String getUserInfoLimit() throws Exception{
		ActionContext cxt = ActionContext.getContext();
		HttpServletRequest request = (HttpServletRequest)cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();
			
		String userid = request.getParameter("userid"); 
		IprUser userInfo = sysUserFunc.getUserInfo(Integer.parseInt(userid)); 
		request.setAttribute("userInfo", userInfo); 
//		return mapping.findForward("userLimit");
		return SUCCESS;
	}

	
	
	// public ActionForward changeUserInfo(ActionMapping mapping, ActionForm form,
	//		HttpServletRequest request, HttpServletResponse response) {
	public String changeInfoPage() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		int userId = Integer.parseInt((String) request .getSession()
				.getAttribute(Constant.APP_USER_ID));
		
		String userName = request.getParameter("realname"); 
		String phone = request.getParameter("phone");
		String mobile = request.getParameter("mobile");
		String fax = request.getParameter("fax");
		String email = request.getParameter("email");
		String department = request.getParameter("department");
		String address = request.getParameter("address");

		request.setAttribute("changeInfoResult", Integer.toString(sysUserFunc
				.changeUserInfo(userId, userName, phone, mobile, fax, email,
						department, address)));

		// return mapping.findForward("changeInfoPage");
		return SUCCESS;
	}

	public String getUserLogs(
			HttpServletRequest request, HttpServletResponse response) {
		int intStartYear = Integer.parseInt(request.getParameter("startyear"));
		int intStartMonth = Integer
				.parseInt(request.getParameter("startmonth"));
		int intStartDay = Integer.parseInt(request.getParameter("startday"));

		int intEndYear = Integer.parseInt(request.getParameter("endyear"));
		int intEndMonth = Integer.parseInt(request.getParameter("endmonth"));
		int intEndDay = Integer.parseInt(request.getParameter("endday"));

		int iCurrentPage = 0;
		try {
			iCurrentPage = (request.getParameter("currentpage") == null) ? 1
					: Integer.parseInt(request.getParameter("currentpage"));
		} catch (Exception e) {
			iCurrentPage = 1;
		}
		
		String strStartStatTime = intStartYear+"-"+intStartMonth+"-"+intStartDay+" 00:00:00";
		String strEndStatTime = intEndYear+"-"+intEndMonth+"-"+intEndDay+" 23;59:29";
		
		PageBaseInfo logInfo = sysUserFunc.getUserLogs((String) request.getSession()
				.getAttribute(Constant.APP_USER_NAME), strStartStatTime, strEndStatTime, iCurrentPage, 20);
		
		request.setAttribute("startyear", intStartYear);
		request.setAttribute("startmonth", intStartMonth);
		request.setAttribute("startday", intStartDay);
		request.setAttribute("endyear", intEndYear);
		request.setAttribute("endmonth", intEndMonth);
		request.setAttribute("endday", intEndDay);
		
		request.setAttribute("logInfo", logInfo);

		return SUCCESS;
	}
}
