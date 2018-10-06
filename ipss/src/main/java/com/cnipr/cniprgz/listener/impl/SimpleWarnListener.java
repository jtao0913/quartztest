package com.cnipr.cniprgz.listener.impl;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.cnipr.cniprgz.task.SimpleWarnMain;

public class SimpleWarnListener implements ServletContextListener {
	private Timer timer = null;

//	初始化监听器，创建实例，执行任务
	public void contextInitialized(ServletContextEvent event) {
		try {
			SimpleWarnMain.run();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//	销毁监听器，停止执行任务
	public void contextDestroyed(ServletContextEvent event) {
		try {
			SimpleWarnMain.stop();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
