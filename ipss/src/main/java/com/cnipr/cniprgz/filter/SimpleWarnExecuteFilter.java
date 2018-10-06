/**
 * 
 */
package com.cnipr.cniprgz.filter;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.jbase.common.page.Pagination;
import net.jbase.common.util.DateUtil;
import net.jbase.common.util.StringUtil;

 
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.dao.TSimpleExecuteDAO;
import com.cnipr.cniprgz.dao.TSimpleWarnDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;
import com.opensymphony.xwork2.ActionContext;

/**
 * 
 */
public class SimpleWarnExecuteFilter implements Filter {

	private String onErrorUrl;

	private FilterConfig filterConfig;

	public void init(FilterConfig config) throws ServletException {

		filterConfig = config;
		onErrorUrl = filterConfig.getInitParameter("onError");
		if (onErrorUrl == null || "".equals(onErrorUrl)) {
			onErrorUrl = "/index.jsp";
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain next) throws IOException, ServletException {
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();
		 
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		// Current session
		 
		if(httpRequest.getSession().getAttribute(
				Constant.APP_USER_ID)!=null)
		{
			String userId = (String) httpRequest.getSession().getAttribute(
					Constant.APP_USER_ID);
			int userid = Integer.parseInt(userId);
			
			TSimpleWarnDAO simpleWarnDAO = new TSimpleWarnDAO();			
			TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO(); 
		 
		
			//查找用户全部可用状态的简单预警
			Pagination p =null;
			try {
				p = simpleWarnDAO.findSimpleWarns(userid, true, null, null, 1, -1);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			if(p!=null && p.getList()!=null)
			{
			List able_warns = p.getList();
			
			/**
			 * 遍历每个简单预警对象
			 */
			for(int i=0;i<able_warns.size();i++){
				
				TSimpleWarn simpleWarn = (TSimpleWarn) able_warns.get(i);
				int period = simpleWarn.getPeriod();//获得周期					
				Date today = new Date();//当前时间 
				
				int shouldDays = 0;//当前时间最大周期相对天数 
				Date  lastruntime = simpleWarn.getLastruntime();//当前最新执行的结束时间 
				if(lastruntime==null)
					lastruntime = simpleWarn.getCreatetime();
				switch(period){//周期的天数
				case 1://每周
					shouldDays=7;break;
				case 2: //每两周
					shouldDays=14;break;
				case 3: //每月
					shouldDays=DateUtil.daysBetween(DateUtil.getDateAddMonth(lastruntime, +1), lastruntime);
					break;
				case 4: //每季度
					shouldDays=DateUtil.daysBetween(DateUtil.getDateAddMonth(lastruntime, +3), lastruntime);
					break;
				}//end switch
				int able_execute_number = simpleWarn.getStatus();//可以执行次数 
				int day_between = DateUtil.daysBetween(lastruntime,today);//最近一此预警和现在时间的天数 
				Date new_pdStart = null;//计算每一次预警的起始时间
				Date new_pdEnd = null; //计算每一次预警的结束时间
				
				ChannelFunc channelFunc = new ChannelFunc();
				channelFunc.setChannelDAO(new ChannelDAO());
				SearchFunc searchFunc = new SearchFunc(); 
				
				for(int k=0;day_between>=shouldDays && k<able_execute_number;k++)// 添加记录
				{
					
					try {
							TSimpleExecute new_simpleExecute = new TSimpleExecute();//创建新的预警历史
							new_simpleExecute.setCreatetime(today);
							new_simpleExecute.setPeriod(period);
							new_simpleExecute.setSimpleWarnId(simpleWarn.getId()); 
							if(new_pdStart==null)
								new_pdStart = lastruntime;//最近一次执行时间就是，起始时间
							else
								new_pdStart = new_pdEnd; 					 
								new_pdEnd = DateUtil.addDays(new_pdStart, shouldDays); 	
								
							new_simpleExecute.setPdStart(new_pdStart);
							new_simpleExecute.setPdEnd(new_pdEnd);
							new_simpleExecute.setIsnew(1);
							long amount = (long)0; 
							String channelArray[]  = StringUtil.splitStringToArray(simpleWarn.getChannels(),",");
							List<ChannelInfo> channelList = channelFunc.getInfoMapByChannel(channelArray);
							 
							// TRS表名 （egg：发明专利，实用新型，外观设计）  
							String strTRSTableName = "";
							if(channelList!=null)
							for (ChannelInfo info : channelList) { 
								strTRSTableName += info.getChrTRSTable() + ",";
							}
							
							String wap = request.getParameter("wap")==null?"":request.getParameter("wap");
							
							OverviewSearchResponse  overviewResponse = searchFunc.overviewSearch(wap, strTRSTableName,
										simpleWarn.getExpression()+" and 公开（公告）日=("+DateUtil.format(new_pdStart,"yyyy.MM.dd")+" to "+DateUtil.format(new_pdEnd,"yyyy.MM.dd")+")", 
										"RELEVANCE", "",
										  "主权项, 名称, 摘要", 2, 115, false, 0, 0, null, "SYNONYM_UTF8");
							if(overviewResponse!=null)
								amount = overviewResponse.getRecordCount();
								
								new_simpleExecute.setAmount(amount);
							 
								simpleExecuteDAO.createSimpleExecute(new_simpleExecute);
								//创建预警历史
								simpleWarnDAO.updateStatus(simpleWarn.getId()+"", Constant.DECREASE, 1);//执行一次执行一次状态。 
							 
							day_between = DateUtil.daysBetween(new_pdEnd,today);//重新计算最近一此预警和现在时间的天数
							switch(period){//重新计算最近一次时间周期后的天数
							case 1://每周
								shouldDays=7;break;
							case 2: //每两周
								shouldDays=14;break;
							case 3: //每月
								shouldDays=DateUtil.daysBetween(DateUtil.getDateAddMonth(new_pdEnd, +1), new_pdEnd);
								break;
							case 4: //每季度
								shouldDays=DateUtil.daysBetween(DateUtil.getDateAddMonth(new_pdEnd, +3), new_pdEnd);
								break;
							}//end switch
							simpleWarn.setLastruntime(new Date());
						 
						 
							simpleWarnDAO.updateLastRuntime(simpleWarn.getId()+"", simpleWarn);
							
				} catch (Exception e) { 
					e.printStackTrace();
				}
			}//end for
 
		} 
		
	  
			next.doFilter(request, response);
		}	 
		}
		 
	}
	
	 

	public void destroy() {
	}

	public static void main(String[] args){
//		String[] channelArray = {"1","2","3","4"};
//		String[] userChannelArray = {"1","2","8","3","4","5","7"};
//		System.out.println(ChannelFilter.checkChannelRight(channelArray, userChannelArray));
	}
}
