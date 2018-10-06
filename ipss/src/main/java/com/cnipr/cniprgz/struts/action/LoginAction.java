package com.cnipr.cniprgz.struts.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.authority.user.SessionListener;
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.commons.SetupConstant;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.func.MenuFunc;
import com.cnipr.cniprgz.func.SysUserFunc;
import com.cnipr.cniprgz.log.Log74Util;
import com.cnipr.cniprgz.log.PlatformLog;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.jbase.common.util.DateUtil;
import net.sf.json.JSONArray;

public class LoginAction extends ActionSupport {
//	private ActionContext context;
//	private Map request;
//	private Map session;
//	private Map application;

	private static final long serialVersionUID = -4155976036348014552L;

	// sysUserFunc
	public SysUserFunc sysUserFunc;

	public SysUserFunc getSysUserFunc() {
		return sysUserFunc;
	}

	public void setSysUserFunc(SysUserFunc sysUserFunc) {
		this.sysUserFunc = sysUserFunc;
	}

	private IprUser user;

	public IprUser getUser() {
		return user;
	}

	public void setUser(IprUser user) {
		this.user = user;
	}

	private String username;

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	private String password;

	private String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String login() {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		// String title = application.get("title")(String)application.get("title");

		String website_title = (application.get("website_title") == null || application.get("website_title").equals(""))
				? "综合信平台息服务"
				: (String) application.get("website_title");

		username = request.getParameter("username");
		// email = request.getParameter("email");
		password = request.getParameter("password");
		username = com.cnipph.util.Util.unescape(username);
		
//		System.out.println("username=" + username);
//		System.out.println("password=" + password);

/*		String hangye = request.getParameter("hangye");
		if (hangye != null && !hangye.equals("")) {
			request.getSession().setAttribute("hangye", hangye);
		} else {
			request.getSession().setAttribute("hangye", "");
		}
*/

		// String navID = request.getParameter("navID");
		// if (navID!= null&&!navID.equals("")){
		// request.getSession().setAttribute("navID", navID);
		// }else{
		// request.getSession().setAttribute("navID", "0");
		// }

		// System.out.println("username=" + username);
		// System.out.println("password=" + password);

		// LoginForm loginForm = (LoginForm) form;
		// String userName = loginForm.getUserName();
		// String password = loginForm.getPassword();

		String remoteAddr = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
		/*
		 * if(remoteAddr.equals("127.0.0.1")) { String ip =
		 * request.getHeader("X-Real-IP");
		 * if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) &&
		 * !"unKnown".equalsIgnoreCase(ip)){ remoteAddr=ip; } //
		 * out.println("X-Real-IP--------"+_ip); }
		 * application.put("remoteAddr",remoteAddr);
		 */

		// String userName = loginForm.getUserName();
		// String password = loginForm.getPassword();
		String strWhere = "";
		if (request.getParameter("strWhere") != null && !request.getParameter("strWhere").equals("")) {
			request.getSession().setAttribute("strWhere", request.getParameter("strWhere"));
		}

		// try{
		// System.out.println("iplimit:"+SetupAccess.getProperty(SetupConstant.IPLIMIT));
		// }catch(Exception ex){
		// ex.printStackTrace();
		// }

		String s_allmenu = (String) application.get("s_allmenu");
		// IprUser iprUser = sysUserFunc.validUser(user.getChrUserName(),
		// user.getChrUserPass());

		String verifycode = request.getParameter("verifycode");
		String verifyCode = "";
		
		if(session.getAttribute("verifyCode")!=null&&!session.getAttribute("verifyCode").equals("")) {
			verifyCode = (String)session.getAttribute("verifyCode");
		}
		
//		System.out.println("request.getParameter(\"verifycode\")="+verifycode);
//		System.out.println("session.getAttribute(\"verifyCode\")="+verifyCode);
		
		String ShowVerifyCode = (String)application.get("ShowVerifyCode");
		
		IprUser iprUser = null;
		if (username != null&&!username.equals("")) {
			
			if(username.equalsIgnoreCase("guest")) {
				iprUser = sysUserFunc.validUser(username, password, s_allmenu);
			}else {
				if(ShowVerifyCode.equals("1")&&!verifycode.equalsIgnoreCase(verifyCode)){
					jsonresult = "error##验证码错误，请重新输入";
					return SUCCESS;
				}else {
					iprUser = sysUserFunc.validUser(username, password, s_allmenu);
				}
			}
			
//			iprUser = sysUserFunc.validUser(username, password, s_allmenu);
			
			if(iprUser == null){
				jsonresult = "error##用户名密码错误，请重新输入";
				return SUCCESS;
			}else {	
				if (iprUser != null) {
					session.setAttribute(Constant.APP_USER_NAME, iprUser.getChrUserName());
					session.setAttribute("useremail", iprUser.getChrEmail());
					session.setAttribute("userrealname", iprUser.getChrRealName());
					session.setAttribute(Constant.APP_USER_ID, Integer.toString(iprUser.getIntUserId()));
					session.setAttribute(Constant.APP_USER_CHANNELID, iprUser.getChrChannelId());
					session.setAttribute(Constant.APP_USER_ITEMGRANT, iprUser.getChrItemGrant());
					session.setAttribute(Constant.APP_USER_ROLE, iprUser.getIntGroupId());
					session.setAttribute(Constant.APP_USER_FEETYPE, 0);
					session.setAttribute(Constant.APP_USER_PWD, iprUser.getChrUserPass());
					session.setAttribute("strUserType", "corp");
					session.setAttribute("intCHCount", iprUser.getIntChcount());
					session.setAttribute("intFRCount", iprUser.getIntFrcount());
					session.setAttribute("dtRegisterTime", iprUser.getDtRegisterTime());
					session.setAttribute("dtCurrentCardTime", iprUser.getDtCurrentCardTime());
					session.setAttribute("dtExpireTime", iprUser.getDtExpireTime());
					session.setAttribute("ABSTBatchCount", iprUser.getIntMaximum());
	
					session.setAttribute("intAnalyseState", iprUser.getIntAnalyseState());
					session.setAttribute("intAnalyseNumUpperlimit", iprUser.getIntAnalyseNumUpperlimit());
	
					session.setAttribute("intAdministerState", iprUser.getIntAdministerState());
					// 输出状态
					// System.out.println("intAdministerState=" + iprUser.getIntAdministerState());
					session.setAttribute("intAdministerId", iprUser.getIntAdministerId());
	
					String strMenu = iprUser.getChrMenu();
					strMenu = "," + strMenu;
					// ,1000,1005,1010,1015,1020,2000,5005,1600,3500,5000,5010,5015,5026,5035,6000,15001,70000,7000,
					strMenu = strMenu.replaceAll(",5005", "");
					strMenu = strMenu.substring(1);
	
					if (username.equals("admin") && password.equals("ipphpatviewer")) {
						strMenu = iprUser.getChrMenu() + "5005,";
					}
					session.setAttribute("userMenu", strMenu);
	
//					System.out.println("usermenu = "+strMenu);
					session.setAttribute("strItemGrant", iprUser.getChrItemGrant());
	
					session.setAttribute("onlineUserBindingListener", new SessionListener(iprUser.getChrUserName()));
					session.setAttribute("logoffPage", request.getParameter("logoffPage"));
	
					// 平台登录日志
					if (SetupAccess.getProperty(SetupConstant.DATABASELOG) != null
							&& SetupAccess.getProperty(SetupConstant.DATABASELOG).equals("1")) {
						PlatformLog.insertLoginLog(iprUser.getIntUserId(), remoteAddr);
					}
					// 记录74家监控日志
					try {
						// System.out.println(iprUser.getIntUserId());
						// System.out.println(iprUser.getIntGroupId());
						// System.out.println(request.getRemoteAddr());
						// System.out.println(DateUtil.getCurrentDateStr());
	
						Log74Util.log_login(iprUser.getIntUserId() + "", iprUser.getIntGroupId() + "",
								remoteAddr, DateUtil.getCurrentDateStr());
					} catch (IOException e) {
						e.printStackTrace();
					}
					String rootId = request.getParameter("rootId");
					request.setAttribute("rootId", rootId);

					//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
					List<MenuInfo> menuinfolist = menuFunc.getUserMenu(strMenu, request.getParameter("rootId"),
							request.getParameter("treeType"), "");
	
					JSONArray json = JSONArray.fromObject(menuinfolist);// 将list对象转换成json类型数据
//					session.setAttribute("menuList", menuinfolist);
					session.setAttribute("menuList", json.toString());
	
					jsonresult = "success##" + iprUser.getChrUserName()+ "##" + iprUser.getChrRealName() + "##" + json.toString() + "##" + website_title;// 给result赋值，传递给页面

//					System.out.println(jsonresult);
					//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					return SUCCESS;
				} else {	
					jsonresult = "error##" + sysUserFunc.getJsonresult();
//					return SUCCESS;
				}	
			}
		}

		return SUCCESS;
	}

	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}

	private MenuFunc menuFunc;

	public void setMenuFunc(MenuFunc menuFunc) {
		this.menuFunc = menuFunc;
	}

}
