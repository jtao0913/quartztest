package com.cnipr.cniprgz.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.log.CniprLogger;
import com.opensymphony.xwork2.ActionContext;

/**
 * 调用方式：在页面中直接调用下面代码 StopRefresh stopRefresh = new StopRefresh();
 * stopRefresh.limitTime =4;//可以不设置，默认10秒
 * stopRefresh.refreshCount=2;//可以不设置，默认5次
 * stopRefresh.redirectPage="/index.jsp";////可以不设置，/index.jsp
 * stopRefresh.blackPage="/index.jsp";////可以不设置，/index.jsp stopRefresh.blackList =
 * "192.168.61.110,2009-08-03 10:00:00,20;";//后面一定要有分号
 * if(stopRefresh.stopRefreshPage(request,response)){ return; }
 * 
 * @author Administrator
 * 
 */
public class StopRefresh {

	public SecurityDAO securityDAO = new SecurityDAO();

	// 刷新的时间段,单位：秒
	public int limitTime = 120;

	// 刷新的时间段的最大刷新次数
	public int refreshCount = 60;

	// 超过刷新次数后跳转的页面
	public String redirectPage = "/include/functionremind.htm";

	// 192.168.61.110,yyyy-MM-dd HH:mm:ss,10;192.168.61.111,yyyy-MM-dd
	// HH:mm:ss,100(IP,具体开始时间,禁用时间)
	public String blackList = "";

	public String blackPage = "/cniprGZ/stopRefresh.jsp";

	public static final SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	/**
	 * 阻止频繁刷新同一页面
	 */
	@SuppressWarnings("unchecked")
	public boolean stopRefreshPage(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ActionContext cxt = ActionContext.getContext();
    	Map<String, Object> application = cxt.getApplication();
    	
		// 判断是否超出次数或黑名单
		boolean isOverTime = false;

		String blackIP = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
		
		if(blackIP.equals("127.0.0.1")) {
		    String ip = request.getHeader("X-Real-IP");
		    if(org.apache.commons.lang.StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
		    	blackIP=ip;
		    }
//		    out.println("X-Real-IP--------"+_ip);
		}
		
		CniprLogger.LogDebug("the ip is : "+ blackIP) ;
		blackList = securityDAO.getBlackList(blackIP);
//		blackList = "123.120.24.117,2009-12-21 18:43:15,2;";
		CniprLogger.LogDebug("from db blackList :" + blackList);
		
		int todayCount = 0;

		// PrintWriter out = response.getWriter();
		String htmlContent = "<script type=\"text/javascript\">window.location.href='"
				+ redirectPage + "'</script>";

		String curPath = request.getServletPath();// 当前路径
		int latestRefreshNum = 0;// 最后一次保存的刷新

		TreeMap<Date, Integer> stopRefreshMap = null;
		HttpSession session = request.getSession();
		if (null != session.getAttribute("stopRefreshMap" + curPath)) {
			CniprLogger.LogDebug("in  if ");
			stopRefreshMap = (TreeMap<Date, Integer>) session
					.getAttribute("stopRefreshMap" + curPath);

			if (stopRefreshMap.size() != 0) {
				Date latestDate = stopRefreshMap.lastKey();// 上一次刷新的次数
				latestRefreshNum = stopRefreshMap.get(latestDate) + 1;// 次数加1

				Date newDate = new Date();
				// out.println(newDate);
				stopRefreshMap.put(newDate, latestRefreshNum);

				// 最新刷新时间的前10秒的时间
				Date tempDate = new Date(newDate.getTime() - limitTime * 1000L);

				// 删除不需要的对象(超过limitTime秒前的对象)
				Iterator<Date> iterator = stopRefreshMap.keySet().iterator();
				while (iterator.hasNext()) {
					Date date = iterator.next();
					if ((tempDate.compareTo(date)) > 0) {
						iterator.remove();// 这行代码是关键,不然在对一个map进行迭代遍历并删除一些符合条件的键值对的时候，容易出现java.util.ConcurrentModificationException
						// 这个异常。
						stopRefreshMap.remove(date);
					}
				}

				session.setAttribute("stopRefreshMap" + curPath,
								stopRefreshMap);

				int countNum = stopRefreshMap.get(stopRefreshMap.lastKey()) - stopRefreshMap.get(stopRefreshMap.firstKey());
				// out.println(countNum);
				// 判断refreshCount秒内刷新的次数是否超出了指定的次数
				if (countNum >= refreshCount) {
					isOverTime = true;
				}

				boolean isBlackList = false;
				try {
					if (blackList.trim().length() > 0) {

						int position = blackList.indexOf(blackIP);
						if (position != -1) {
							String[] black = blackList.split(",");
							todayCount = Integer
									.parseInt(black[black.length -1].replace(";", ""));
							if (todayCount >= 2) {
								response.getWriter().println(
										"<script type=\"text/javascript\">window.location.href='"
												+ blackPage + "'</script>");
								return true;
							}
							isBlackList = true;
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				if (isOverTime) {
					PrintWriter out = response.getWriter();
					if (isBlackList) {
						securityDAO.updateBlackList(blackIP);
//						out.println("<script type=\"text/javascript\">window.location.href='"
//										+ blackPage + "'</script>");
					} else {
						securityDAO.addBlackList(blackIP);
						
					}
					out.println(htmlContent);
					// 删除不需要的对象(超过limitTime秒前的对象)
					Iterator<Date> iterator1 = stopRefreshMap.keySet().iterator();
					while (iterator1.hasNext()) {
						Date date = iterator1.next();
						if (date != stopRefreshMap.lastKey()) {
							iterator1.remove();// 这行代码是关键,不然在对一个map进行迭代遍历并删除一些符合条件的键值对的时候，容易出现java.util.ConcurrentModificationException
							// 这个异常。
							stopRefreshMap.remove(date);
						}
					}
					out.flush();
					out.close();

				}
			}

		} else {
			stopRefreshMap = new TreeMap<Date, Integer>();
			stopRefreshMap.put(new Date(), 1);
			session.setAttribute("stopRefreshMap" + curPath, stopRefreshMap);

		}
		CniprLogger.LogDebug("isBlack = " + isOverTime);
		CniprLogger.LogDebug("----- ------------- -----");
		return isOverTime;
	}

	public static void main(String args[]) {
		//boolean isBlackList = false;
		String blackList = "192.168.158.90,2009-08-04 16:06:00,120;";
		try {
			if (blackList.trim().length() > 0) {
				String blackIP = "192.168.158.90";
				int position = blackList.indexOf(blackIP);
				System.out.println(position);
				if (position != -1) {
					Date date = dateFormat.parse(blackList.substring(position
							+ blackIP.length() + 1, position + blackIP.length()
							+ 21));
					Date newDate2 = new Date();
					if (newDate2.getTime() < (date.getTime() + Long
							.parseLong(blackList.substring(position
									+ blackIP.length() + 21, blackList.indexOf(
									";", position))) * 60 * 1000)) {
						System.out.println("blackIP:" + (new Date()));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}