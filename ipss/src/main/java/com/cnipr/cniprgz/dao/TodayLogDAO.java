package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.log.CniprLogger;

public class TodayLogDAO {

	public int insertLogBySql(String sql) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int updateResult = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			updateResult = ps.executeUpdate();
			CniprLogger.LogInfo("updateResult : " + updateResult);
		} catch (Exception e) {
			CniprLogger.LogError("TodayLogDAO -> insertLog error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return updateResult;
	}

	public int getLogCountByIp(String ip) {
		int count = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(*) as pagecount from ipr_today_logs  where ipr_today_logs.chrVisitIP ='"
							+ ip
							+ "' and ( ipr_today_logs.intGrantID=66 or ipr_today_logs.intGrantID=68) and ipr_today_logs.chrUserName='guest'");
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt("pagecount");
			}
		} catch (Exception e) {
			CniprLogger.LogError("TodayLogDAO -> insertLog error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return count;
	}
}
