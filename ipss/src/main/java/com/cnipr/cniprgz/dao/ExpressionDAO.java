package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.ExpressionInfo;

public class ExpressionDAO {
/*	public int saveExpression(String strUserIp, int intUserID, String strWhere, String strChannelName, 
								String expName, long totalCount, String synonymous, int country) {
		
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
*/
	
	public int saveExpression(String strUserIp, int intUserID, String strWhere, String strSources,
			String strChannelName, String expName, long totalCount, String synonymous, int country) {

		int maxid = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String strSQL = "select count(intUserID) as RecordCount from ipr_saveexpression where intUserID=? and chrUserIP=?";
		boolean b_Add = true;
		try {
			conn = DBPoolAccessor.getConnection();
			/*
			 * ps = conn.prepareStatement(strSQL); ps.setInt(1, intUserID); ps.setString(2,
			 * strUserIp);
			 * 
			 * rs = ps.executeQuery(); if (rs.next()) { // 如果记录数大于50条那么删除第一条数据 if
			 * (rs.getInt("RecordCount") >= 50) { rs.close(); ps.close(); strSQL =
			 * "select id from ipr_saveexpression where intUserID=? and chrUserIP=? Order By intState,dtSearchTime"
			 * ; ps = conn.prepareStatement(strSQL); ps.setInt(1, intUserID);
			 * ps.setString(2, strUserIp); rs = ps.executeQuery(); if (rs.first()) { int
			 * iResultSetID = rs.getInt("id"); rs.close(); ps.close(); strSQL =
			 * "delete from ipr_saveexpression where intUserID=? and chrUserIP=? and id = ?"
			 * ; ps = conn.prepareStatement(strSQL); ps.setInt(1, intUserID);
			 * ps.setString(2, strUserIp); ps.setInt(3, iResultSetID); int i =
			 * ps.executeUpdate(); if (i >= 0) b_Add = true; else b_Add = false; } } else
			 * b_Add = true;
			 * 
			 * rs.close(); ps.close(); }
			 */
			if (b_Add) {
				strSQL = "select max(id) maxid from ipr_saveexpression";
				ps = conn.prepareStatement(strSQL);
				rs = ps.executeQuery();
				if (rs.next()) {
					maxid = rs.getInt("maxid");
					rs.close();
					ps.close();
				}
				
				java.text.SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String sSearchTime = sformat.format(new java.util.Date());

				expName = expName.replace("'", "\\\'");
				strWhere = strWhere.replace("'", "\\\'");
				
				strSQL = "insert into ipr_saveexpression (id,intUserID,chrUserIP,chrAliasName,chrExpression,chrSources,chrChannelID,intSearchCount,dtSearchTime,intState,intCountry,chrSynonymous) "
						+ "values "
						+ "("+(maxid + 1)+","
						+intUserID+","
						+"'"+strUserIp+"',"
						+"'"+expName+"',"
						+"'"+strWhere+"',"
						+"'"+strSources+"',"
						+"'"+strChannelName+"',"
						+totalCount+","
						+"'"+sSearchTime+"',"
						+"0,"
						+country+","
						+synonymous+")";
				
				ps = conn.prepareStatement(strSQL);
//				ps.setInt(1, maxid + 1);
//				ps.setInt(2, intUserID);
//				ps.setString(3, strUserIp);
//				ps.setString(4, expName);
//				ps.setString(5, strWhere);
//				ps.setString(6, strSources);
//				ps.setString(7, strChannelName);
//				ps.setLong(8, totalCount);
//				ps.setString(9, sSearchTime);
//				ps.setInt(10, 0);
//				ps.setInt(11, country);
//				ps.setString(12, synonymous);

				int ret = ps.executeUpdate();
				System.out.println(ret);
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

		return maxid + 1;
	}

	public int getTotalCount(String sql) {
//		List<ExpressionInfo> expList = new ArrayList<ExpressionInfo>();
		int totalpages = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			rs.last();
			totalpages = rs.getRow();
			
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

		return totalpages;
	}
	
	public List<ExpressionInfo> getExpBySql(String sql) {
		List<ExpressionInfo> expList = new ArrayList<ExpressionInfo>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				ExpressionInfo exp = new ExpressionInfo();
				exp.setId(rs.getInt("id"));
				exp.setName(rs.getString("chrAliasName"));
				exp.setExpression(rs.getString("chrExpression"));
				exp.setSources(rs.getString("chrSources"));
				exp.setChannel(rs.getString("chrChannelID"));
				exp.setHitCount(rs.getLong("intSearchCount"));
				exp.setChrSynonymous(rs.getInt("chrSynonymous"));
				
				String dtSearchTime = rs.getString("dtSearchTime");
				exp.setDtSearchTime(dtSearchTime!=null?dtSearchTime.substring(0, 10):"");
				int state = rs.getInt("intState");
				exp.setState(state);
				if (state == 0) {
					exp.setStateOperate("锁定");
				} else {
					exp.setStateOperate("解锁");
				}

				expList.add(exp);
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

		return expList;
	}
	
	public void updateState(int expId, int state) {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("update ipr_saveexpression set intState = ? where id = ?");
			ps.setInt(1, state);
			ps.setInt(2, expId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
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
	}

	public String updateName(int expId, String newname) {
		String result = "";
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("update ipr_saveexpression set chrAliasName = ? where id = ?");
			ps.setString(1, newname);
			ps.setInt(2, expId);
			if (ps.executeUpdate() == 1) {
				result = newname;
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return result;
	}	
	
	public int deleteExp(String expId) {
		int ret = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
//			ps = conn.prepareStatement("delete from ipr_saveexpression where id in ?");
//			ps.setString(1, "("+expId.replace("#", ",").replace("exp", "")+")");
			
//			System.out.println("delete from ipr_saveexpression where id in ("+expId.replace("#", ",").replace("exp_", "")+")");
			
//			ps = conn.prepareStatement("delete from ipr_saveexpression where id in ("+expId.replace("#", ",").replace("exp_", "")+")");
			ps = conn.prepareStatement("update ipr_saveexpression set intState = 1 where id in ("+expId.replace("#", ",").replace("exp_", "")+")");
			
			ret = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
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
		return ret;
	}

}
