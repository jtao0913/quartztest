package com.fync.quartz;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

/**
 * 创建任务调度，并执行
 * @author long
 *
 */
public class MainScheduler {
    
//    创建调度器
    public static Scheduler getScheduler() throws SchedulerException{
        SchedulerFactory schedulerFactory = new StdSchedulerFactory();
        return schedulerFactory.getScheduler();
    }

    private static Scheduler scheduler;
    
	public static void schedulerJob() throws SchedulerException{
//        创建任务
        JobDetail jobDetail = JobBuilder.newJob(MyJob.class).withIdentity("job1", "group1").build();
//        创建触发器 每3秒钟执行一次
/*        Trigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger1", "group3")
                            .withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInSeconds(3).repeatForever())
                            .build();
                            
                            
    Trigger t2 = newTrigger()
        .withIdentity("myTrigger2")
        .forJob("myJob2")
        .withSchedule(dailyAtHourAndMinute(11, 30)) // execute job daily at 11:30
        .modifiedByCalendar("myHolidays") // but not on holidays
        .build();
                            
                            
*/
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        Date myStartTime = new Date();
		try {
			myStartTime = df.parse("2018-10-03 21:42");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}        
        
        Trigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger1", "group3")
        		.startAt(myStartTime)
                .build();
        
        scheduler = getScheduler();
//        将任务及其触发器放入调度器
        scheduler.scheduleJob(jobDetail, trigger);
//        调度器开始调度任务
        scheduler.start();
        
//        scheduler.shutdown();
    }
    
    public static void main(String[] args) throws SchedulerException {
        MainScheduler mainScheduler = new MainScheduler();
        mainScheduler.schedulerJob();
    }
}

class MyJob implements Job{
    public static int compare_date(String DATE1, String DATE2) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                System.out.println("dt1 在dt2前");
                return 1;
            } else if (dt1.getTime() < dt2.getTime()) {
                System.out.println("dt1在dt2后");
                return -1;
            } else {
                return 0;
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return 0;
    }

	public void execute(JobExecutionContext context)
            throws JobExecutionException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        times++;
        
        System.out.println(sdf.format(new Date()));
    }

}