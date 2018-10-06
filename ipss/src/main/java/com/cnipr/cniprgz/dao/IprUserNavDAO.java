package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class IprUserNavDAO {
	public boolean addUserNav(int userId, int navId) {
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into ipr_user_nav(intUserID, intNavID) values("
				+ userId  + ", " + navId +  ")";
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
}
