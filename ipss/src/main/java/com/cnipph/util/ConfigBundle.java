package com.cnipph.util;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Liuc 资源控制
 */
public class ConfigBundle {

	/**
	 * 跟踪日志
	 */
	private static final Log logger = LogFactory.getLog(ConfigBundle.class);

	/**
	 * 资源绑定
	 */
	private static ResourceBundle resourceBundle;

	/**
	 * 资源路径
	 */
	private static final String RESOURCE_PATH = "resources";

	/**
	 * 取得绑定字符
	 * 
	 * @param str
	 *            源字符串
	 * @return String
	 */
	public static String getString(String str) {
		String result = "";
		try {
			result = getResourceBundle().getString(str);
		} catch (MissingResourceException mre) {
			logger.error(mre.getMessage(), mre);
		}
		return result;
	}

	/**
	 * 取得绑定资源
	 * 
	 * @return ResourceBundle
	 */
	private static ResourceBundle getResourceBundle() {
		if (resourceBundle == null) {
			resourceBundle = ResourceBundle.getBundle(RESOURCE_PATH);
		}
		return resourceBundle;
	}
}