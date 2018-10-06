package com.cnipr.cniprgz.task;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import net.jbase.common.page.Pagination;
import net.jbase.common.util.DateUtil;
import net.jbase.common.util.StringUtil;
 
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.SetupAccess;
import com.cnipr.cniprgz.dao.ChannelDAO;
import com.cnipr.cniprgz.dao.TLawWarnDAO;
import com.cnipr.cniprgz.dao.TSimpleExecuteDAO;
import com.cnipr.cniprgz.dao.TSimpleWarnDAO;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.TLawWarn;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;
import com.cnipr.cniprgz.func.ChannelFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.cniprgz.servlet.SystemINIT;
import com.cnipr.corebiz.search.entity.LegalStatusInfo;
import com.cnipr.corebiz.search.ws.response.OverviewSearchResponse;

/**
 * 网站 数据定时删除
 * 
 * <pre>执行信息的如下 : </pre>
 * <ol>
 * 		
 * <ol>
 * 
 * @author YinXu
 * @link www.ourping.com
 */
public class LawWarnTimer {
	protected static final Logger logger =  Logger.getLogger(LawWarnTimer.class); 
	
	private final Timer timer = new Timer();
    private final int minutes = 2;
	
    private ServletContext sc;
    
    public LawWarnTimer(ServletContext sc){
    	this.sc = sc;
    }
    
    public void start() {
        GregorianCalendar curTime = new GregorianCalendar();
        String HOUR_OF_DAY = SetupAccess.getProperty("HOUR_OF_DAY");
        String MINUTE_OF_DAY = SetupAccess.getProperty("MINUTE_OF_DAY");
        int hour = 23;
        int minute = 59;
        
        if(StringUtil.hasText(HOUR_OF_DAY))
        	hour = Integer.parseInt(HOUR_OF_DAY);
        
        if(StringUtil.hasText(MINUTE_OF_DAY))
        	minute = Integer.parseInt(MINUTE_OF_DAY);
        
        curTime.set(GregorianCalendar.HOUR_OF_DAY, hour);
        curTime.set(GregorianCalendar.MINUTE, minute);
        
        timer.schedule(new TimerTask() {
            public void run() {
            	loadLawWarnData();
            }
             
            
            private void loadLawWarnData() {
            	try{
            		logger.info("开始定时法律状态预警数据..."); 
            		Date now = new Date();
            		Date yesterday = DateUtil.addDays(now, -1);  
            		TLawWarnDAO lawWarnDAO = new TLawWarnDAO();	
            		
            		try {
            			Pagination p = lawWarnDAO.findLawWarns(-1, true, null, null, 1, -1);
            			if(p!=null && p.getList()!=null)
            			{
            			List able_warns = p.getList(); 
            			/**
            			 * 遍历每个法律状态预警对象
            			 */
            			for(int i=0;i<able_warns.size();i++){
            				
            				TLawWarn lawWarn = (TLawWarn) able_warns.get(i);
            				int period = lawWarn.getPeriod();//获得周期					
            				Date today = new Date();//当前时间 
            				
            				int shouldDays = 0;//当前时间最大周期相对天数 
            				Date  lastruntime = lawWarn.getLastruntime();//当前最新执行的结束时间 
            				if(lastruntime==null)
            					lastruntime = lawWarn.getCreatetime();
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
            				int able_execute_number = lawWarn.getStatus();//可以执行次数 
            				int day_between = DateUtil.daysBetween(lastruntime,today);//最近一此预警和现在时间的天数 
            				Date new_pdStart = null;//计算每一次预警的起始时间
            				Date new_pdEnd = null; //计算每一次预警的结束时间
            				
            				ChannelFunc channelFunc = new ChannelFunc();
            				channelFunc.setChannelDAO(new ChannelDAO());
            				SearchFunc searchFunc = new SearchFunc(); 
            				
            				for(int k=0;day_between>=shouldDays && k<able_execute_number;k++)// 添加执行记录
            				{            					
            					try { 
            							if(new_pdStart==null)
            								new_pdStart = lastruntime;//最近一次执行时间就是，起始时间
            							else
            								new_pdStart = new_pdEnd; 					 
            								new_pdEnd = DateUtil.addDays(new_pdStart, shouldDays); 	
            								lawWarn.setLastruntime(new_pdEnd); 
            								lawWarnDAO.updateLastruntime(lawWarn.getId()+"", lawWarn);
            								
            								 List<LegalStatusInfo> list = searchFunc.legalStatusSearch("0","申请号="+lawWarn.getAn());
            								 
            								 if(list!=null && list.size()>0)
            								 {
	            								 LegalStatusInfo newLegalStatusInfo = list.get(0); 
	            								 Date lawWarnDate =  DateUtil.parseDate("yyyy.MM.dd",newLegalStatusInfo.getStrLegalStatusDay());
	            								 lawWarn.setLastupdatetime(lawWarn.getUpdatetime()==null?lawWarnDate:lawWarn.getUpdatetime());//记录上一次检索
	             								 lawWarn.setLastupdatestatus(lawWarn.getLastupdatestatus());//记录上一次检索
	            								 lawWarn.setUpdatetime(lawWarnDate); 
	            								 lawWarn.setUpdatestatus(newLegalStatusInfo.getStrLegalStatus());  
            								 }
            								 lawWarnDAO.updateLast(lawWarn.getId()+"", lawWarn);
            								 lawWarnDAO.updateNow(lawWarn.getId()+"", lawWarn);
            								//创建预警历史
            								lawWarnDAO.updateStatus(lawWarn.getId()+"", Constant.DECREASE, 1);//执行一次执行一次状态。 
            							 
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
            							 
            							
            				} catch (Exception e) { 
            					e.printStackTrace();
            				}
            			}//end for
             
            		} 
            		
            			
            			
            			
            			
            			}
            			
        			} catch (Exception e1) { 
        				e1.printStackTrace();
        			}
        			
            	
            		
            		
            		logger.info("定时法律状态预警数据数据成功");
            	}
            	catch(Exception ex){
            		ex.printStackTrace();
            		logger.error("定时法律状态预警数据失败....");
            	}
            }
            
            
            
            private void loadSimpleWarnData() { 
    			 
    			
    			TSimpleWarnDAO simpleWarnDAO = new TSimpleWarnDAO();			
    			TSimpleExecuteDAO simpleExecuteDAO = new TSimpleExecuteDAO(); 
    		 
    		
    			//查找用户全部可用状态的简单预警
    			Pagination p =null;
    			try {
    				p = simpleWarnDAO.findSimpleWarns(-1, true, null, null, 1, -1);
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
    							 
    							OverviewSearchResponse  overviewResponse = searchFunc.overviewSearch("0",strTRSTableName,
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
    		
    	  
    			 
    		}	 
            }
            
            
            
        }, curTime.getTime(),86400000);
    }


    public static void main(String[] args) {
    	//IndexTimer it = new IndexTimer();
    	//it.start();
	}
}
