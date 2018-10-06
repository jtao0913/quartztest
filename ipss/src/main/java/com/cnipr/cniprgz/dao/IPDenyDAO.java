package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.cnipr.cniprgz.commons.ComparatorMenuId;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.log.CniprLogger;

public class IPDenyDAO {
	
	public static int insertIPDeny(String ip) {
		int ret = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		java.util.Date today = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String now = formatter.format(today);
        
		try {
			conn = DBPoolAccessor.getConnection();			
			ps = conn.prepareStatement("insert into ipr_denyIps(ip,visittime) values('"+ip+"','"+now+"')");
			ret = ps.executeUpdate();
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getChildMenu error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return ret;
	}
	
	
	public static void main(String[] a) {
	}
}
