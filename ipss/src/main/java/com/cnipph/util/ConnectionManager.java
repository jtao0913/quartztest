package com.cnipph.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionManager {
	public static Connection getConnection() {
		String DB_URL = ConfigBundle.getString("jdbc.url");// "jdbc:oracle:thin:@192.168.3.227:1521:orcl";
		String DB_DRIVER = ConfigBundle.getString("jdbc.driver");// "oracle.jdbc.driver.OracleDriver";
		String DB_USERNAME = ConfigBundle.getString("jdbc.username");// "cnipr1";
		String DB_PASSWORD = ConfigBundle.getString("jdbc.password");// "cnipr1";
		Connection conn = null;
		try {
			Class.forName(DB_DRIVER);
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
}
