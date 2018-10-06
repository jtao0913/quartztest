package com.cnipr.cniprgz.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.db.DBPoolAccessor;

public class SecurityDAO {
	public String getBlackList(String ip) {
		StringBuffer blackList = new StringBuffer();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select * from ipr_blacklist where blackIP=? and date(addTime) = curdate()");
			ps.setString(1, ip);
			rs = ps.executeQuery();
			while(rs.next()){
				blackList.append(ip);
				blackList.append(",");
				blackList.append(rs.getString("addTime").substring(0, 19));
				blackList.append(",");
				blackList.append(rs.getString("todayCount"));
				blackList.append(";");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return blackList.toString();
	}

	public void addBlackList(String ip) {
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("insert into ipr_blacklist(blackIP, addTime) values (?,?)");
			ps.setString(1, ip);
			ps.setString(2, Util.getCurrentTime());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	public void updateBlackList(String ip) {
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("UPDATE ipr_blacklist SET todayCount=todayCount+1, addTime=? where blackIP=? and date(addTime) = curdate()");
			ps.setString(1, Util.getCurrentTime());
			ps.setString(2, ip);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}

	public static void main(String[] args) {
		SecurityDAO dao = new SecurityDAO();
//		dao.addBlackList("192.168.3.81");
//		dao.updateBlackList("192.168.3.81");
		System.out.println(dao.getBlackList("192.168.3.81"));
	}
}
