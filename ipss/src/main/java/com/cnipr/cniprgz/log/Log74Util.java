package com.cnipr.cniprgz.log;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.jsp.PageContext;

import net.jbase.common.util.DateUtil;
import net.jbase.common.util.FileUtil;
import net.jbase.common.util.security.MD5;

import org.apache.log4j.Logger;

import com.cnipr.cniprgz.commons.Log74Access;
import com.cnipr.cniprgz.db.DBPoolAccessor;

public class Log74Util {

	private static final String LOG_HISTORY = "log74.history.open";
	private static final String LOG_OPEN = "log74.open";
	private static final String LOG_DIR = "log74.dir";
	private static final String LOG_AREACODE = "log74.areacode";
	private static final String LOG_SYSTEM_ID = "001";

	private static String HISTORY;
	private static String OPEN;
	private static String DIR;
	private static String AREACODE;
	private static String ERRORMESSAGE;

	private static String character = "utf-8";

	protected static final Logger logger = Logger.getLogger(Log74Util.class);

	/**
	 * 检测log74配置
	 * 
	 * @return
	 */
	public static String ckeckconfig() {
		ERRORMESSAGE = null;

		if (Log74Access.getProperty(LOG_OPEN) != null && Log74Access.getProperty(LOG_OPEN).equals("") == false)
			OPEN = Log74Access.getProperty(LOG_OPEN);
		else
			ERRORMESSAGE = LOG_OPEN + "读取失败";

		if (Log74Access.getProperty(LOG_HISTORY) != null && Log74Access.getProperty(LOG_HISTORY).equals("") == false)
			HISTORY = Log74Access.getProperty(LOG_HISTORY);
		else
			ERRORMESSAGE = HISTORY + "读取失败";

		if (Log74Access.getProperty(LOG_DIR) != null && Log74Access.getProperty(LOG_DIR).equals("") == false)
			DIR = Log74Access.getProperty(LOG_DIR);
		else
			ERRORMESSAGE = LOG_DIR + "读取失败";

		if (Log74Access.getProperty(LOG_AREACODE) != null && Log74Access.getProperty(LOG_AREACODE).equals("") == false)
			AREACODE = Log74Access.getProperty(LOG_AREACODE);
		else
			ERRORMESSAGE = LOG_AREACODE + "读取失败";
		if (ERRORMESSAGE != null)
			logger.info(getERRORMESSAGE());
		return ERRORMESSAGE;
	}

	/**
	 * 读取并写入字典表
	 */
	public static void createdict() {
		if (ckeckconfig() == null) {
			if (OPEN.equals("1")) {
				File dict_dir = new File(DIR + "/" + AREACODE + "_" + LOG_SYSTEM_ID + "_dict/");
				if (dict_dir.exists() == false)
					dict_dir.mkdirs();

				/* 用户组字典 */
				String sql = "select intGroupID,chrGroupName from ipr_group";
				Connection conn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try {
					conn = DBPoolAccessor.getConnection();
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					if (rs != null) {

						File dict_dept = new File(dict_dir, "dict_dept.txt");
						if (dict_dept.exists())
							FileUtil.deleteFile(dict_dept.getAbsolutePath());
						if (dict_dept.exists() == false) {
							dict_dept.createNewFile();
						}
						while (rs.next()) {
							String fileContent = "operateDepId=" + rs.getInt("intGroupID") + ";operateDep="
									+ rs.getString("chrGroupName") + "\r\n";
							FileUtil.writeFile(dict_dept.getAbsolutePath(), fileContent, character, true);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					DBPoolAccessor.closeAll(rs, ps, conn);
				}
				/* 用户组字典结束 */

				/* 功能模块字典 */
				URL url = Log74Util.class.getResource("/dict_module.txt");
				// System.out.println(url.getPath());
				File in = new File(url.getPath());
				File out = new File(dict_dir, "dict_module.txt");
				try {
					FileUtil.copy(in, out);
				} catch (IOException e) {
					e.printStackTrace();
				}
				/* 功能模块字典结束 */
			}
		}

	}

	/**
	 * 读取并写入历史日志,目前只有用户历史
	 */
	public static void createhistory() {
		if (ckeckconfig() == null) {
			if (OPEN.equals("1")) {
				File history_dir = new File(DIR + "/" + AREACODE + "_" + LOG_SYSTEM_ID + "_history/");
				if (history_dir.exists() == false)
					history_dir.mkdirs();
				/* 用户表 */
				String sql = "select intUserID,chrUserName,dtRegisterTime,dtExpireTime,intGroupID from ipr_user";
				Connection conn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try {
					conn = DBPoolAccessor.getConnection();
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					if (rs != null) {

						File history_user = new File(history_dir, AREACODE + "_" + LOG_SYSTEM_ID + "_user_history.log");

						if (history_user.exists() == false)// 默认一次写入，若存在则不再写日志
						{
							history_user.createNewFile();
							while (rs.next()) {
								MD5 md5 = new MD5();
								String fileContent = "operateUser=" + rs.getString("chrUserName") + ";"
										+ "operateUserId=" + rs.getString("intUserID") + ";" + "operateDepId="
										+ rs.getInt("intGroupID") + ";" + "ip=;" + "operateType=create;"
										+ "operateTime=" + rs.getString("dtRegisterTime") + ";" + "check="
										+ md5.md5(rs.getString("chrUserName") + rs.getString("intUserID")
												+ rs.getInt("intGroupID") + "create" + rs.getString("dtRegisterTime"))
										+ "\r\n";
								FileUtil.writeFile(history_user.getAbsolutePath(), fileContent, character, true);
							}
						} else {
							if (HISTORY.equals("1"))// 开启重写历史记录
							{
								FileUtil.deleteFile(history_user.getAbsolutePath());
								history_user.createNewFile();
								while (rs.next()) {
									MD5 md5 = new MD5();
									String fileContent = "operateUser=" + rs.getString("chrUserName") + ";"
											+ "operateUserId=" + rs.getString("intUserID") + ";" + "operateDepId="
											+ rs.getInt("intGroupID") + ";" + "ip=;" + "operateType=create;"
											+ "operateTime=" + rs.getString("dtRegisterTime") + ";" + "check="
											+ md5.md5(rs.getString("chrUserName") + rs.getString("intUserID")
													+ rs.getInt("intGroupID") + "create"
													+ rs.getString("dtRegisterTime"))
											+ "\r\n";
									FileUtil.writeFile(history_user.getAbsolutePath(), fileContent, character, true);
								}
							}

						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					DBPoolAccessor.closeAll(rs, ps, conn);
				}
				/* 用户表结束 */
			}
		}
	}

	/**
	 * 系统登录增量日志
	 * 
	 * @throws IOException
	 */
	public static void log_login(String operateUserId, String operateDepId, String ip, String operateTime)
			throws IOException {
		if (ckeckconfig() == null) {
			if (OPEN.equals("1")) {
				String datestr = DateUtil.getCurrentDateStr("yyyyMMdd");

				File log_dir = new File(DIR + "/" + AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "/");
				if (log_dir.exists() == false)
					log_dir.mkdirs();
				/* 登录 */

				File log_login = new File(log_dir, AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "_login.log");
				if (log_login.exists() == false) {
					log_login.createNewFile();
				}

				MD5 md5 = new MD5();
				String fileContent = "operateUserId=" + operateUserId + ";" + "operateDepId=" + operateDepId + ";"
						+ "ip=" + ip + ";" + "operateTime=" + operateTime + ";" + "check="
						+ md5.md5(operateUserId + operateDepId + ip + operateTime) + "\r\n";
				FileUtil.writeFile(log_login.getAbsolutePath(), fileContent, character, true);

				/* 结束 */
			}
		}
	}

	/**
	 * 系统功能使用增量日志
	 * 
	 * @throws IOException
	 */
	public static void log_func(String moduleId, String operateUserId, String operateDepId, String ip,
			String operateTime, String operateData, String operateAmount) throws IOException {
		if (ckeckconfig() == null) {
			if (OPEN.equals("1")) {
				String datestr = DateUtil.getCurrentDateStr("yyyyMMdd");

				File log_dir = new File(DIR + "/" + AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "/");
				if (log_dir.exists() == false)
					log_dir.mkdirs();
				/* 系统功能 */

				File log_func = new File(log_dir, AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "_func.log");
				if (log_func.exists() == false) {
					log_func.createNewFile();
				}

				MD5 md5 = new MD5();
				String fileContent = "moduleId=" + moduleId + ";" + "operateData=" + operateData + ";"
						+ "operateUserId=" + operateUserId + ";" + "operateDepId=" + operateDepId + ";" + "ip=" + ip
						+ ";" + "operateTime=" + operateTime + ";" + "operateAmount=" + operateAmount + ";" + "check="
						+ md5.md5(moduleId + operateData + operateUserId + operateDepId + ip + operateTime
								+ operateAmount)
						+ "\r\n";
				FileUtil.writeFile(log_func.getAbsolutePath(), fileContent, character, true);

				/* 系统功能结束 */
			}
		}
	}

	/**
	 * 系统用户增量日志
	 * 
	 * @throws IOException
	 */
	public static void log_user(String operateUser, String operateUserId, String operateDepId, String ip,
			String operateType, String operateTime) throws IOException {
		if (ckeckconfig() == null) {
			if (OPEN.equals("1")) {
				String datestr = DateUtil.getCurrentDateStr("yyyyMMdd");

				File log_dir = new File(DIR + "/" + AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "/");
				if (log_dir.exists() == false)
					log_dir.mkdirs();
				/* 用户表 */

				File log_user = new File(log_dir, AREACODE + "_" + LOG_SYSTEM_ID + "_" + datestr + "_user.log");
				if (log_user.exists() == false) {
					log_user.createNewFile();
				}

				MD5 md5 = new MD5();
				String fileContent = "operateUser=" + operateUser + ";" + "operateUserId=" + operateUserId + ";"
						+ "operateDepId=" + operateDepId + ";" + "ip=" + ip + ";" + "operateType=" + operateType + ";"
						+ "operateTime=" + operateTime + ";" + "check="
						+ md5.md5(operateUser + operateUserId + operateDepId + ip + operateType + operateTime) + "\r\n";
				FileUtil.writeFile(log_user.getAbsolutePath(), fileContent, character, true);

				/* 用户表结束 */
			}
		}
	}

	public static String getHISTORY() {
		return HISTORY;
	}

	public static void setHISTORY(String history) {
		HISTORY = history;
	}

	public static String getOPEN() {
		return OPEN;
	}

	public static void setOPEN(String open) {
		OPEN = open;
	}

	public static String getDIR() {
		return DIR;
	}

	public static void setDIR(String dir) {
		DIR = dir;
	}

	public static String getAREACODE() {
		return AREACODE;
	}

	public static void setAREACODE(String areacode) {
		AREACODE = areacode;
	}

	public static String getERRORMESSAGE() {
		return ERRORMESSAGE;
	}

	public static void setERRORMESSAGE(String errormessage) {
		ERRORMESSAGE = errormessage;
	}

	public static String getLOG_HISTORY() {
		return LOG_HISTORY;
	}

	public static String getLOG_OPEN() {
		return LOG_OPEN;
	}

	public static String getLOG_DIR() {
		return LOG_DIR;
	}

	public static String getLOG_AREACODE() {
		return LOG_AREACODE;
	}

}
