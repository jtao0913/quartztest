package com.cnipr.cniprgz.servlet.proxy;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.commons.httpclient.NameValuePair;
import org.apache.http.NameValuePair;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.servlet.proxy.event.AuthorityValidListener;
import com.cnipr.cniprgz.servlet.proxy.event.IListener;
import com.cnipr.cniprgz.servlet.proxy.event.PostParameterValidListener;

public class CniprProxyServlet extends HttpServlet {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 541848120162426869L;
	// 检索平台地址
	private String url;

	// 网关验证结果，0表示验证通过，放行进入CNIPR；其他则不通过，直接返回该错误码；
	private String validCode;

	public String getValidCode() {
		return validCode;
	}

	public void setValidCode(String validCode) {
		this.validCode = validCode;
	}

	private HttpServletRequest request;

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	private Vector<IListener> listeners = new Vector<IListener>();

	/**
	 * Constructor of the object.
	 */
	public CniprProxyServlet() {
		super();
		this.addListener(new AuthorityValidListener());
		this.addListener(new PostParameterValidListener());
	}

	public synchronized void addListener(IListener a) {
		listeners.addElement(a);
	}

	public synchronized void removeListener(IListener a) {
		listeners.removeElement(a);
	}

	@SuppressWarnings( { "unchecked" })
	public void fireEvent(EventObject evt) {

		Vector currentListeners = null;

		synchronized (this) {
			currentListeners = (Vector) listeners.clone();
		}

		for (int i = 0; i < currentListeners.size(); i++) {
			IListener listener = (IListener) currentListeners.elementAt(i);
			listener.performed(evt);
		}
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// int validRes = CommonValid.valid();
		this.request = request;

		// 为预警开的用户验证接口
		if (request.getParameter("method") != null
				&& request.getParameter("method").equals("validUser")) {
			IprUserDAO userDAO = new IprUserDAO();
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out
					.println(userDAO.validUserForAlarmSys(request
							.getParameter("userName"), request
							.getParameter("userPWD")));
			out.flush();
			out.close();
			return;
		}

		this.fireEvent(new EventObject(this));
		if (!this.getValidCode().equals("0")) {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println(this.getValidCode());
			out.flush();
			out.close();
		} else {
			HttpSession session = request.getSession();
			String uid = DataAccess.getProperty("defaultUserId");
			
			autoLogin(session,Integer.parseInt(uid));
		 
		//	session.setAttribute(Constant.APP_USER_ID, DataAccess.getProperty("defaultUserId"));
			 
			session.setAttribute("logoffPage", "/gotoGOV.jsp");
			RequestDispatcher dispatcher = request
					.getRequestDispatcher("/search.do");
			dispatcher.forward(request, response);
		}
	}

	
	
	private int autoLogin(HttpSession session,int uid) {
		IprUserDAO iprUserDAO = new IprUserDAO();
		IprUser iprUser = iprUserDAO.getUserInfo(uid);
		 
		if(iprUser!=null)
		{
			session.setAttribute(Constant.APP_USER_NAME, iprUser
					.getChrUserName());
			session.setAttribute(Constant.APP_USER_ID, Integer
					.toString(iprUser.getIntUserId()));
			session.setAttribute(Constant.APP_USER_CHANNELID, iprUser
					.getChrChannelId());
			session.setAttribute(Constant.APP_USER_ITEMGRANT, iprUser
					.getChrItemGrant());
			session.setAttribute(Constant.APP_USER_ROLE, iprUser
					.getIntGroupId());
			session.setAttribute(Constant.APP_USER_FEETYPE, 0);
			session.setAttribute("strUserType", "corp");
			session.setAttribute("intCHCount", iprUser.getIntChcount());
			session.setAttribute("intFRCount", iprUser.getIntFrcount());
			session.setAttribute("dtRegisterTime", iprUser
					.getDtRegisterTime());
			session.setAttribute("dtCurrentCardTime", iprUser
					.getDtCurrentCardTime());
			session.setAttribute("intAdministerId", iprUser
					.getIntAdministerId());
			session.setAttribute("userMenu", iprUser.getChrMenu());	
			session.setAttribute("strItemGrant", iprUser.getChrItemGrant());
			 
		//session.setAttribute("logoffPage", "/index.htm");
		return 1;
		}else
			return -1;
	}
	
	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		url = DataAccess.getProperty("search_app_addr");
	}

	/**
	 * 将参数中的目标分离成由目标servlet名称和参数组成的数组
	 * 
	 * @param queryString
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	//20160127
	/*
	@SuppressWarnings("unchecked")
	private ArrayList<NameValuePair> parse123(Map map)
			throws UnsupportedEncodingException {
		ArrayList<NameValuePair> arr = new ArrayList<NameValuePair>();
		Iterator iter = map.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry me = (Entry) iter.next();
			String[] varr = (String[]) me.getValue();
			// 重新组装参数字符串
			for (int i = 0; i < varr.length; i++) {
				NameValuePair param = new NameValuePair(me.getKey().toString(),varr[i]);
				arr.add(param);
				// System.out.println("me.getKey()=" + me.getKey() +
				// ", me.getValue()=" + varr[i]);
				// 参数需要进行转码，实现字符集的统一
				// arr += "&" + me.getKey() + "="
				// + URLEncoder.encode(varr[i], "utf-8");
			}
		}
		// arr = arr.replaceAll("^&", "");
		return arr;
	}
*/
}
