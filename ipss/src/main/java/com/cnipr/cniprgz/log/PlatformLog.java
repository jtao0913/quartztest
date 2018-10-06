package com.cnipr.cniprgz.log;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class PlatformLog {

	/**
	 * 用户登录日志
	 * @param userName
	 * @param ipAddress
	 */
	public static void insertLoginLog(int userid,String ipAddress){
		String sql = "insert into ipr_login_logs(intGrantID,dtVisitTime,intUserID,chrVisitIP) values(301,now(),?,?)";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, ipAddress);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBPoolAccessor.closeAll(null,ps, conn);
		}
	}
	
	/**
	 * 专利检索日志
	 * @param userName
	 * @param ipAddress
	 * @param area
	 */
	public static void insertSearchLog(int userid,String userName,String ipAddress,String area){
		int grant=57;
		if(area!=null && "fr".equals(area)){
			grant = 95;
		}
		String sql = "insert into ipr_search_logs(intGrantID,dtVisitTime,intUserID,chrUserName,chrVisitIP) values(?,now(),?,?,?)";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grant);
			ps.setInt(2, userid);
			ps.setString(3, userName);
			ps.setString(4, ipAddress);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBPoolAccessor.closeAll(null,ps, conn);
		}
	}
	
	/**
	 * 专利检索日志
	 * @param userName
	 * @param ipAddress
	 * @param area
	 */
	public static void insertViewLog(String userName,String ipAddress,String area){
		int grant=57;
		if(area!=null && "fr".equals(area)){
			grant = 95;
		}
		String sql = "insert into ipr_view_logs(intGrantID,dtVisitTime,chrUserName,chrVisitIP) values(?,now(),?,?)";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grant);
			ps.setString(2, userName);
			ps.setString(3, ipAddress);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBPoolAccessor.closeAll(null,ps, conn);
		}
	}
	
	/**
	 * 专利检索日志
	 * @param userName
	 * @param ipAddress
	 * @param area
	 */
	public static void insertViewDocLog(String userName,String ipAddress,String source){
		int grant=62;
		if(source!=null && "SYXX".equals(source.toUpperCase())){
			grant = 71;
		}else if(source!=null && "WGZL".equals(source.toUpperCase())){
			grant = 80;
		}else if(source!=null && "FMSQ".equals(source.toUpperCase())){
			grant = 89;
		}
		String sql = "insert into ipr_view_doc_logs(intGrantID,dtVisitTime,chrUserName,chrVisitIP) values(?,now(),?,?)";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grant);
			ps.setString(2, userName);
			ps.setString(3, ipAddress);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBPoolAccessor.closeAll(null,ps, conn);
		}
	}
	
	/**
	 * 根据表名写入操作日志
	 * @param userName
	 * @param ipAddress
	 * @param table
	 */
	public static void insertTableLog(String userName,String ipAddress,String table){
		int grant=100;
		String sql = "insert into ipr_" + table + "_logs(intGrantID,dtVisitTime,chrUserName,chrVisitIP) values(?,now(),?,?)";
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grant);
			ps.setString(2, userName);
			ps.setString(3, ipAddress);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBPoolAccessor.closeAll(null,ps, conn);
		}
	}
}
