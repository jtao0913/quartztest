package com.cnipr.cniprgz.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;

import com.cnipr.cniprgz.log.CniprLogger;

public class DBPoolAccessor {

	private static DataSource ds;

	/**
	 * 获取数据库连接
	 */
	public static Connection getConnection() {

		Connection conn = null;
		try {
			if (ds == null) {
				final ClassPathResource res = new ClassPathResource(
						"applicationContext.xml");
				final BeanFactory factory = new XmlBeanFactory(res);
				ds = (DataSource) factory.getBean("dataSource");
			}
			conn = ds.getConnection();
		} catch (BeansException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void closeAll(ResultSet rs, PreparedStatement ps,
			Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			CniprLogger
					.LogError("DBPoolAccessor close connection happended error : "
							+ e.getMessage());
		}
	}

}
