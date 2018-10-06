package com.cnipr.cniprgz.task;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.impl.StdSchedulerFactory;

public class SimpleWarnMain {
	private static Scheduler sched;

	public static void run() throws Exception {
//		创建LzstoneTimeTask的定时任务
		JobDetail jobDetail = new JobDetail("SimpleWarnTimer", Scheduler.DEFAULT_GROUP, SimpleWarnTimer.class); 
//		System.out.println("?899999999999?");
//		目标 创建任务计划
//		CronTrigger trigger = new CronTrigger("lzstoneTrigger", "lzstone","0 59 23 L * ?");//"0 15 10 L * ?"每月最后一日的上午10:15触发
		
		CronTrigger trigger = new CronTrigger("lzstoneTrigger", "lzstone","0 59 23 * * ?");//每周四凌晨两点出发
		
//		CronTrigger trigger = new CronTrigger("lzstoneTrigger", "lzstone","20 44 16 * * ?");//每周四凌晨两点出发
		
//		0 0 12 * * ? 代表每天的中午12点触发
		sched = new StdSchedulerFactory().getScheduler();
		sched.scheduleJob(jobDetail, trigger);
		sched.start();
	}

	// 停止
	public static void stop() throws Exception {
		sched.shutdown();
	}
}
