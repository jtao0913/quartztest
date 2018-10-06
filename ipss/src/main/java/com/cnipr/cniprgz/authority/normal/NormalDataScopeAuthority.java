package com.cnipr.cniprgz.authority.normal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.authority.AbsDataAuthority;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.log.CniprLogger;

public class NormalDataScopeAuthority extends AbsDataAuthority{
	
	public boolean hasDataAuthority(String role, String funcName,
			String strChannels, int page) {
		return hasSearchScopeAuthority(role, funcName, strChannels, page);
	}

	private boolean hasSearchScopeAuthority(String role, String funcName, String strChannels, int page) {
		if (role == null || funcName == null || strChannels == null) {
			this.setAuthorityFlag(false);
		}
		
		String[] channelArray = strChannels.split(",");
		
		String sql = "select dataScope from ipr_dataauthority where role='" + role + "' and function='"+ funcName +"' and (";
		for (String channel : channelArray){
			sql += " dataKind = '" + channel + "' or ";
		}
		sql = sql.substring(0, sql.length() - 3) + ")";
		CniprLogger.LogDebug("SearchScopeAuthority hasAuthority sql is : " + sql);
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				int dataScope = Integer.parseInt(rs.getString("dataScope"));
				if (page > dataScope)
					this.setAuthorityFlag(false);
			}

		} catch (Exception e) {
			CniprLogger.LogError("SearchScopeAuthority getSearchScope happended error : " + e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
		return this.isAuthorityFlag();
	}
	
	public static void main(String[] args) {
		AbsDataAuthority sc = new NormalDataScopeAuthority();
		sc.hasDataAuthority("guest", "search", "14,15,16,5,2,3,4", 3);
		System.out.println(sc.isAuthorityFlag());
	}

}
