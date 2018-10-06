package com.cnipr.cniprgz.task;

import java.util.Date;
import java.util.List;
import java.util.Timer;

import javax.servlet.ServletContext;

import net.jbase.common.page.Pagination;
import net.jbase.common.util.DateUtil;
import net.jbase.common.util.StringUtil;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.dao.TSimpleExecuteDAO;
import com.cnipr.cniprgz.dao.TSimpleWarnDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;

public class SimpleWarnTimer implements Job {
	public void execute(JobExecutionContext context) throws JobExecutionException {
		System.out.println("开始预警---");
		TSimpleWarnDAO simpleWarnDAO = new TSimpleWarnDAO();
		TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO();
		
		try{
			simpleExecuteDAO.deleteAll();
		}catch(Exception ex){}
		
//		查找用户全部可用状态的简单预警
		Pagination p = null;
		try {
			p = simpleWarnDAO.findSimpleWarns(-1, true, null, null, 1, -1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		if (p != null && p.getList() != null) {
			List<TSimpleWarn> able_warns = p.getList();

			/**
			 * 遍历每个简单预警对象
			 */
			for (int i = 0; i < able_warns.size(); i++) {
				TSimpleWarn simpleWarn = (TSimpleWarn) able_warns.get(i);
				int period = simpleWarn.getPeriod();//获得周期
				Date today = new Date();//当前时间
				
				int shouldDays = 0;//当前时间最大周期相对天数
				/*
				Date lastruntime = simpleWarn.getLastruntime();//当前最新执行的结束时间
				if (lastruntime == null)
					lastruntime = simpleWarn.getCreatetime();
				*/
				Date lastruntime = simpleWarn.getCreatetime();
				
				switch (period) {// 周期的天数
				case 1:// 每周
					shouldDays = 7;
					break;
				case 2: // 每两周
					shouldDays = 14;
					break;
				case 3: // 每月
//					shouldDays = DateUtil.daysBetween(DateUtil.getDateAddMonth(lastruntime, +1), lastruntime);
					shouldDays = DateUtil.daysBetween(lastruntime, DateUtil.getDateAddMonth(lastruntime, +1));
					break;
				case 4: // 每季度
//					shouldDays = DateUtil.daysBetween(DateUtil.getDateAddMonth(lastruntime, +3), lastruntime);
					shouldDays = DateUtil.daysBetween(lastruntime, DateUtil.getDateAddMonth(lastruntime, +3));
					break;
				}// end switch
				int able_execute_number = simpleWarn.getStatus();// 可以执行次数
				int day_between = DateUtil.daysBetween(lastruntime, today);// 最近一此预警和现在时间的天数
				Date new_pdStart = null;// 计算每一次预警的起始时间
				Date new_pdEnd = null; // 计算每一次预警的结束时间

				ChannelFunc channelFunc = new ChannelFunc();
				channelFunc.setChannelDAO(new ChannelDAO());
				SearchFunc searchFunc = new SearchFunc();

				if(day_between >= shouldDays){
					simpleExecuteDAO.deleteByWarnid(simpleWarn.getId());
				}
				
				for (int k = 0; day_between >= shouldDays && k < able_execute_number; k++)// 添加记录
				{
					try {
						TSimpleExecute new_simpleExecute = new TSimpleExecute();// 创建新的预警历史
						new_simpleExecute.setCreatetime(today);
						new_simpleExecute.setPeriod(period);
						new_simpleExecute.setSimpleWarnId(simpleWarn.getId());
						if (new_pdStart == null)
							new_pdStart = lastruntime;// 最近一次执行时间就是，起始时间
						else
							new_pdStart = new_pdEnd;
						new_pdEnd = DateUtil.addDays(new_pdStart, shouldDays);

						new_simpleExecute.setPdStart(new_pdStart);
						new_simpleExecute.setPdEnd(new_pdEnd);
						new_simpleExecute.setIsnew(1);
						long amount = (long) 0;
						String channelArray[] = StringUtil.splitStringToArray(
								simpleWarn.getChannels(), ",");
						List<ChannelInfo> channelList = channelFunc.getInfoMapByChannel(channelArray);

						// TRS表名 （egg：发明专利，实用新型，外观设计）
						String strTRSTableName = "";
						if (channelList != null){
							for (ChannelInfo info : channelList) {
								strTRSTableName += info.getChrTRSTable() + ",";
							}
							
							if(strTRSTableName.endsWith(",")){
								strTRSTableName = strTRSTableName.substring(0, strTRSTableName.length()-1);
							}
						}

						OverviewSearchResponse overviewResponse = searchFunc.overviewSearch("",strTRSTableName, simpleWarn
										.getExpression()
										+ " and 公开（公告）日=("
										+ DateUtil.format(new_pdStart, "yyyy.MM.dd")
										+ " to "
										+ DateUtil.format(new_pdEnd, "yyyy.MM.dd") + ")",
										"RELEVANCE", "", "主权项, 名称, 摘要", 2, 115,
										false, 0, 0, null, "SYNONYM_UTF8");
						if (overviewResponse != null)
							amount = overviewResponse.getRecordCount();
						
						new_simpleExecute.setAmount(amount);
						
						simpleExecuteDAO.createSimpleExecute(new_simpleExecute);
						// 创建预警历史
//						simpleWarnDAO.updateStatus(simpleWarn.getId() + "",	Constant.DECREASE, 1);// 执行一次执行一次状态。
						
						day_between = DateUtil.daysBetween(new_pdEnd, today);// 重新计算最近一此预警和现在时间的天数
						switch (period) {// 重新计算最近一次时间周期后的天数
						case 1:// 每周
							shouldDays = 7;
							break;
						case 2: // 每两周
							shouldDays = 14;
							break;
						case 3: // 每月
//							shouldDays = DateUtil.daysBetween(DateUtil.getDateAddMonth(new_pdEnd, +1), new_pdEnd);
							shouldDays = DateUtil.daysBetween(new_pdEnd, DateUtil.getDateAddMonth(new_pdEnd, +1));
							break;
						case 4: // 每季度
//							shouldDays = DateUtil.daysBetween(DateUtil.getDateAddMonth(new_pdEnd, +3), new_pdEnd);
							shouldDays = DateUtil.daysBetween(new_pdEnd, DateUtil.getDateAddMonth(new_pdEnd, +3));
							break;
						}// end switch
						simpleWarn.setLastruntime(new Date());

						simpleWarnDAO.updateLastRuntime(simpleWarn.getId() + "", simpleWarn);

					} catch (Exception e) {
						e.printStackTrace();
					}
				}// end for
				System.out.println(simpleWarn.getName() + "完成");
			}
		}
	}

}
