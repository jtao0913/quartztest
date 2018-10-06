package com.cnipr.cniprgz.log;

import org.apache.log4j.Logger;

/**
 * <p>
 * Title: FileServerLogger
 * </p>
 * <p>
 * Description: 日志
 * </p>
 * <p>
 * Copyright: Copyright (c) 2009
 * </p>
 * <p>
 * Company: cnipr
 * </p>
 * 
 * @author lq
 * @version 1.0
 */
public class CniprLogger {

	/**
	 * 
	 */
	public CniprLogger() {
		super();
		// TODO Auto-generated constructor stub
	}

	private static Logger logger = Logger.getLogger("log4j.properties");

	public static void LogInfo(String msg) {
		logger.info(msg);
	}

	public static void LogDebug(String msg) {
		logger.debug(msg);

	}

	public static void LogError(String msg) {
		logger.error("[ERROR] " + msg);

	}

	public static Logger getLogger() {
		return logger;
	}

	public static void main(String[] args) {
		CniprLogger.LogError("Hello,I am valley.");
		CniprLogger.LogInfo("this is the test.");
	}
}
