package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class AreacodeDAO {
	public HashMap<String, String> getAllAreacode() {
		java.util.LinkedHashMap<String, String> hm_allareacode = new java.util.LinkedHashMap<String,String>();
//		hm_allareacode.put(-1,"请选择...");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select chrAreaName,chrAreaCode from ipr_areacode ";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				hm_allareacode.put(rs.getString("chrAreaCode"),rs.getString("chrAreaName"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return hm_allareacode;
	}
	
	public static void main(String[] args){
	}
}
