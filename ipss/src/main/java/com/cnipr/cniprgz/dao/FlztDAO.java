package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.ExpressionInfo;

public class FlztDAO {
	public int saveExpression(String strUserIp, int intUserID,
			String strWhere, String strChannelName, String expName,
			long totalCount, String synonymous, int country) {
		
		int maxid = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String strSQL = "select count(intUserID) as RecordCount from ipr_saveexpression where intUserID=? and chrUserIP=?";
		boolean b_Add = false;
		try {
			conn = DBPoolAccessor.getConnection();

			ps = conn.prepareStatement(strSQL);
			ps.setInt(1, intUserID);
			ps.setString(2, strUserIp);

			rs = ps.executeQuery();
			if (rs.next()) {
				// 如果记录数大于50条那么删除第一条数据
				if (rs.getInt("RecordCount") >= 50) {
					rs.close();
					ps.close();
					strSQL = "select id from ipr_saveexpression where intUserID=? and chrUserIP=? Order By intState,dtSearchTime";
					ps = conn.prepareStatement(strSQL);
					ps.setInt(1, intUserID);
					ps.setString(2, strUserIp);
					rs = ps.executeQuery();
					if (rs.first()) {
						int iResultSetID = rs.getInt("id");
						rs.close();
						ps.close();
						strSQL = "delete from ipr_saveexpression where intUserID=? and chrUserIP=? and id = ?";
						ps = conn.prepareStatement(strSQL);
						ps.setInt(1, intUserID);
						ps.setString(2, strUserIp);
						ps.setInt(3, iResultSetID);
						int i = ps.executeUpdate();
						if (i >= 0)
							b_Add = true;
						else
							b_Add = false;
					}
				} else
					b_Add = true;

				rs.close();
				ps.close();
			}

			if (b_Add) {
				
				strSQL = "select max(id) maxid from ipr_saveexpression";
				ps = conn.prepareStatement(strSQL);
				rs = ps.executeQuery();
				if (rs.next()) {
					maxid = rs.getInt("maxid");
					rs.close();
					ps.close();
				}				
				
				java.text.SimpleDateFormat sformat = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				String sSearchTime = sformat.format(new java.util.Date());

				ps = conn.prepareStatement("insert into ipr_saveexpression (id,intUserID,chrUserIP,chrAliasName,chrExpression,chrChannelID,intSearchCount,dtSearchTime,intState,intCountry,chrSynonymous) values (?,?,?,?,?,?,?,?,?,?,?)");
				ps.setInt(1, maxid+1);
				ps.setInt(2, intUserID);
				ps.setString(3, strUserIp);
				ps.setString(4, expName);
				ps.setString(5, strWhere);
				ps.setString(6, strChannelName);
				ps.setLong(7, totalCount);
				ps.setString(8, sSearchTime);
				ps.setInt(9, 0);
				ps.setInt(10, country);
				ps.setString(11, synonymous);
			 
				ps.executeUpdate();				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
				e.printStackTrace();
			}
		}
		
		return maxid+1;
	}

	public Map<String,String> getFlztBySql(String sql) {
		Map<String,String> map_flzt = new HashMap<String,String>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
//		chrFlztInfo,chrGroupFlztInfo
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				map_flzt.put(rs.getString("chrFlztInfo"),rs.getString("chrGroupFlztInfo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
				e.printStackTrace();
			}
		}

		return map_flzt;
	}

}
