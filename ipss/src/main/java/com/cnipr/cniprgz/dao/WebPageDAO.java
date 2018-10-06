package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.PageVisitLogInfo;
import com.cnipr.cniprgz.log.CniprLogger;

/**
 * 记录页面访问情况
 * 
 * @author Administrator
 * 
 */
public class WebPageDAO {

	/**
	 * 添加访问记录
	 * 
	 * @param pageId
	 * @param pageType
	 */
	public void logVisit(String pageId, String pageType) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			java.text.SimpleDateFormat sformat = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			String time = sformat.format(new java.util.Date());

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into ipr_webpage_visit_log (pageId,pageType,visitTime) values (?,?,?)");
			ps.setString(1, pageId);
			ps.setString(2, pageType);
			ps.setString(3, time);
			ps.executeUpdate();
		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> logVisit error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}

	// public void logMemberVisit(int userId) {
	// Connection conn = null;
	// PreparedStatement ps = null;
	// try {
	// java.text.SimpleDateFormat sformat = new SimpleDateFormat(
	// "yyyy-MM-dd HH:mm:ss");
	// String time = sformat.format(new java.util.Date());
	//
	// conn = DBPoolAccessor.getConnection();
	// ps = conn
	// .prepareStatement("insert into ipr_user_login_log(intUserId,dtVisitTime) values (?,?)");
	// ps.setInt(1, userId);
	// ps.setString(2, time);
	// ps.executeUpdate();
	// } catch (Exception e) {
	// CniprLogger.LogError("WebPageDAO -> logMemberVisit error : "
	// + e.getMessage());
	// } finally {
	// DBPoolAccessor.closeAll(null, ps, conn);
	// }
	// }

	/*
	 * Select ipr_user.chrUserName, count(ipr_user_login_log.id) As state0 From
	 * ipr_user_login_log Inner Join ipr_user On ipr_user_login_log.intUserId =
	 * ipr_user.intUserId Group By ipr_user_login_log.intUserId
	 */

	public List<PageVisitLogInfo> getMemberVisitInfo() {

		List<PageVisitLogInfo> list = new ArrayList<PageVisitLogInfo>();

		String sql = "Select ipr_user.intUserId, ipr_user.chrUserName, count(ipr_user_login_log.id) As mcount From ipr_user_login_log Inner Join ipr_user On ipr_user_login_log.intUserId = ipr_user.intUserId Group By ipr_user_login_log.intUserId";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				PageVisitLogInfo info = new PageVisitLogInfo();
				info.setId(rs.getInt("intUserId"));
				info.setName(rs.getString("chrUserName"));
				info.setTotalVisitCount(rs.getLong("mcount"));
				list.add(info);
			}
		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> getMemberVisitInfo error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return list;
	}

	public PageVisitLogInfo getPageVisitInfo(String visitType,
			String startTime, String endTime) {
		PageVisitLogInfo pageVisitLogInfo = new PageVisitLogInfo();
		pageVisitLogInfo.setVisitType(visitType);

		long totalCount = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		Map<String, Long> pageVisitMap = new HashMap<String, Long>();
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select id, name, pageType from ipr_webpage where pageType=?");
			ps.setString(1, visitType);
			rs = ps.executeQuery();
			while (rs.next()) {
				totalCount += getVisitCountByType(visitType,
						rs.getString("id"), rs.getString("name"), pageVisitMap,
						startTime, endTime);
			}
			pageVisitLogInfo.setTotalVisitCount(totalCount);
			pageVisitLogInfo.setPageVisitMap(pageVisitMap);
		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> getPageVisitInfo error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return pageVisitLogInfo;
	}

	// 获取某一数据库内各个栏目的访问次数
	private long getVisitCountByType(String visitType, String id, String name,
			Map<String, Long> pageVisitMap, String startTime, String endTime) {
		long count = 0;

		String sql = "select count(*) as num from ipr_webpage_visit_log where pageType=? and pageId=?";
		if (startTime != null && !startTime.equals("") && endTime != null
				&& !endTime.equals("")) {
			sql += " and visitTime between '" + startTime + "' and '" + endTime
					+ "'";
		}

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, visitType);
			ps.setString(2, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getLong("num");
				pageVisitMap.put(name, count);
			}

		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> getVisitCountByType error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return count;
	}

	public void addMemberVisitLog(int userId) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into ipr_user_login_log(intUserId,dtVisitTime) values (?,NOW())");
			ps.setInt(1, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> addMemberVisitLog error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}

	public List<String> getMemberVisitHistory(int userId, String startTime, String endTime) {
		List<String> historyList = new  ArrayList<String>();
		
		String sql = "select dtvisitTime from ipr_user_login_log where intUserId=? ";
		
		if (startTime != null && !startTime.equals("") && endTime != null
				&& !endTime.equals("")) {
			sql += " and dtvisitTime between '" + startTime + "' and '" + endTime
					+ "'";
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while (rs.next()) {
				historyList.add(rs.getString("dtvisitTime"));
			}
		} catch (Exception e) {
			CniprLogger.LogError("WebPageDAO -> getMemberVisitHistory error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return historyList;
	}

	public static void main(String[] args) {
//		WebPageDAO dao = new WebPageDAO();
//		// dao.getPageVisitInfo("areaIndustries", "2010-03-01", "2010-03-06");
//		List<String> historyList =dao.getMemberVisitHistory(1,"2009-03-09", "2009-03-11");
//		System.out.println("111111111111111111111");
	}

}
