package com.cnipr.cniprgz.dao.julei.bean;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CluDisplayParser {

	private static Logger logger = LoggerFactory.getLogger(CluDisplayParser.class);

	/**
	 * 取得显示字段
	 * 
	 * @param display
	 * @param patent
	 * @return String
	 * @throws ClusteringException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public static String getDisplay(String display, Patent patent) {
		if (display == null || "".equals(display)) {
			throw new RuntimeException("显示参数不正确");
		}
		String[] arr = display.split(",");
		if (arr == null || arr.length != 2) {
			throw new RuntimeException("显示参数不正确");
		}
		String dis1 = null;
		String dis2 = null;
		try {
			dis1 = BeanUtils.getProperty(patent, arr[0]);
			dis2 = BeanUtils.getProperty(patent, arr[1]);
		} catch (IllegalAccessException e) {
			logger.error("显示参数不正确",e);
			throw new RuntimeException("显示参数不正确");
		} catch (InvocationTargetException e) {
			logger.error("显示参数不正确",e);
			throw new RuntimeException("显示参数不正确");
		} catch (NoSuchMethodException e) {
			logger.error("显示参数不正确",e);
			throw new RuntimeException("显示参数不正确");
		}
		return dis1 + " : " + dis2;
	}
}
