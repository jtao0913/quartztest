package com.fync.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
/**
 * 创建要被定执行的任务类
 * @author long
 *
 */
public class MyJob1 implements Job{

	int times;
	
    public int getTimes() {
		return times;
	}

	public void setTimes(int times) {
		this.times = times;
	}

	public void execute(JobExecutionContext context)
            throws JobExecutionException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        times++;
        
        
        System.out.println(times+"........"+sdf.format(new Date()));
    }

}