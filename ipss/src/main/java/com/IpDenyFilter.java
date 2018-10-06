package com;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cnipr.cniprgz.dao.IPDenyDAO;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.cache.RemovalListener;
import com.google.common.cache.RemovalNotification;
import com.opensymphony.xwork2.ActionContext;

public class IpDenyFilter implements Filter {
	private ActionContext cxt = ActionContext.getContext();
//	private Map<String, Object> application = cxt.getApplication();
	
	private static int limitSecond = 1;//每xx秒
	private static long limitTime = 3;//超过xx次
	private static int toStopSecond = 3600;//每xx秒超过xx次后停止XX秒
	private static LoadingCache<String,Long> denyIps = null;
	private static LoadingCache<String, Long[]> ipAccessTimeCache = null;//Object[] time(long) 和 writeTime(long)

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String limitSecondStr = filterConfig.getInitParameter("limitSecond");
		if(limitSecondStr!=null){
			try {
				limitSecond = Integer.parseInt(limitSecondStr);
			} catch (NumberFormatException e) {
				throw new RuntimeException("IpDenyFilter在web.xml中的配置参数limitSecond需要配置成一个整数");
			}
		}
		String limitTimeStr = filterConfig.getInitParameter("limitTime");
		if(limitTimeStr!=null){
			try {
				limitTime = Integer.parseInt(limitTimeStr);
			} catch (NumberFormatException e) {
				throw new RuntimeException("IpDenyFilter在web.xml中的配置参数limitTime需要配置成一个整数");
			}
		}
		String toStopSecondStr = filterConfig.getInitParameter("toStopSecond");
		if(toStopSecondStr!=null){
			try {
				toStopSecond = Integer.parseInt(toStopSecondStr);
			} catch (NumberFormatException e) {
				throw new RuntimeException("IpDenyFilter在web.xml中的配置参数toStopSecond需要配置成一个整数");
			}
		}
		ipAccessTimeCache =
				CacheBuilder.newBuilder()
					.maximumSize(50000L) //最大缓存50000个对象
					.removalListener(new RemovalListener<String, Long[]>() {
						@Override
						public void onRemoval(RemovalNotification<String, Long[]> notification) {
							// TODO Auto-generated method stub
						}
					}) //注册缓存对象移除监听器
//					.ticker(Ticker.systemTicker()) //定义缓存对象失效的时间精度为纳秒级
					.build(new CacheLoader<String, Long[]>(){
						@Override
						public Long[] load(String key) throws Exception {
							return null;
						}
					});
		denyIps =
				CacheBuilder.newBuilder()
				.expireAfterWrite(toStopSecond, TimeUnit.SECONDS)
				.maximumSize(50000L) //最大缓存50000个对象
				.removalListener(new RemovalListener<String, Long>() {
					@Override
					public void onRemoval(RemovalNotification<String, Long> notification) {
						
					}
				})//注册缓存对象移除监听器
//				.ticker(Ticker.systemTicker()) //定义缓存对象失效的时间精度为纳秒级
				.build(new CacheLoader<String, Long>(){ 
					@Override
					public Long load(String key) throws Exception {
						return null;
					}
				});
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String ip = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
		/*
		String strWhere = (String)session.getAttribute("strWhere");
		if(strWhere!=null) {				
			System.out.println("1..."+strWhere);		
			if(strWhere.toUpperCase().equals("主分类号=G%")) {
				denyIps.put(ip, System.currentTimeMillis());
			}
		}
		
		String _strWhere = request.getParameter("strWhere");
		if(_strWhere!=null) {				
			System.out.println("2..."+_strWhere);
			if(_strWhere.toUpperCase().equals("主分类号=G%")) {
				denyIps.put(ip, System.currentTimeMillis());
			}
		}	
		
		String nodeId = request.getParameter("nodeId");
		if(nodeId!=null&&!nodeId.equals("")){
			com.cnipr.cniprgz.dao.NodeDAO nodedao = new com.cnipr.cniprgz.dao.NodeDAO();
			com.cnipr.cniprgz.entity.NodeModel node = nodedao.getNodeInfoByID("0", nodeId);
			String selectexp = node.getCnTrsExp();
			System.out.println("3..."+selectexp);
			if(selectexp.toUpperCase().equals("主分类号=G%")) {
				denyIps.put(ip, System.currentTimeMillis());
			}
		}
		*/
		

		Long itg = denyIps.getIfPresent(ip);
		if (itg != null) {
			int deltStopSecond = toStopSecond - ((int) ((System.currentTimeMillis() - itg) / 1000L));
			System.out.println(ip + "超过访问次数,还要等=" + deltStopSecond);
			response.getWriter().print("你的行为已经被记录,多次发生,报警处理!如有需要请商务合作解决！4001880860");
			return;
		}

		/*
		 * String url = request.getRequestURI(); String _url = url.toLowerCase();
		 * if(_url.contains("/view.do")){ _url = "view.do"; }else
		 * if(_url.contains("/search.do")){ _url = "search.do"; }else
		 * if(_url.contains("/xml.do")){ _url = "xml.do"; }else
		 * if(_url.contains("/download.do")){ _url = "download.do"; } String key =
		 * ip+"_"+_url;
		 */

		String url = request.getRequestURI();
		String _url = url.toLowerCase();
		if (!_url.contains(".do")) {
			chain.doFilter(request, response);
		} else
		{
//			String key = ip;
			Long[] _ls = ipAccessTimeCache.getIfPresent(ip);
			if (_ls != null) {
				long deltMs = (System.currentTimeMillis() - _ls[1]);
				if (_ls[0].compareTo(limitTime) < 0) {// 访问次数小于limitTime
					if (deltMs < limitSecond * 1000) {
						_ls[0] = _ls[0] + 1L;
						ipAccessTimeCache.put(ip, _ls);
					} else {
						ipAccessTimeCache.put(ip, new Long[] { 1L, System.currentTimeMillis() });
					}
					chain.doFilter(request, response);
				} else {// 访问次数大于limitTime,看时间周期
					if (deltMs <= limitSecond * 1000) {
						// 被拦截
						if (denyIps.getIfPresent(ip) == null) {
							denyIps.put(ip, System.currentTimeMillis());
							IPDenyDAO.insertIPDeny(ip);
						}
						System.out.println(ip + "超过访问限制，第一次被拦截");
						response.getWriter().print("你的行为已经被记录,多次发生,报警处理!如有需要请商务合作解决！4001880860");
						return;
					} else {
						ipAccessTimeCache.put(ip, new Long[] { 1L, System.currentTimeMillis() });
						chain.doFilter(request, response);
					}
				}
			} else {
				ipAccessTimeCache.put(ip, new Long[] { 1L, System.currentTimeMillis() });
				chain.doFilter(request, response);
			}
		}
	}

	@Override
	public void destroy() {
	}

	/**
	 * 获取请求服务的机器的ip地址
	 * 
	 * @param request
	 * @return
	 */
	private String getRealip(HttpServletRequest request)
	{
		String ip = "";
		if (request != null)
		{
			ip = request.getHeader("x-forwarded-for");
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
			{
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
			{
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
			{
				ip = com.cnipr.cniprgz.commons.Common.getRemoteAddr(request);
				if (ip.equals("0:0:0:0:0:0:0:1"))
				{
					ip = "127.0.0.1";
				}
			}
		}
		return ip;
	}
}