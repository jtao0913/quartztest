package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprNavtableInfo;

public class DataBaseMgrDAO {
	String strPath = "";

	public ArrayList<IprNavtableInfo> queryBySQL(String sql) {
		ArrayList<IprNavtableInfo> array = new ArrayList<IprNavtableInfo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				IprNavtableInfo navTable = new IprNavtableInfo();
				navTable.setId(rs.getInt("id"));
				navTable.setIntId(rs.getInt("intId"));
				navTable.setName(rs.getString("chrName"));
				navTable.setCnExpression(rs.getString("chrExpression"));
				navTable.setFrExpression(rs.getString("chrFRExpression"));
				navTable.setStrClass(rs.getString("chrClass"));
				navTable.setParentId(rs.getInt("intParentID"));
				navTable.setIntType(rs.getInt("intType"));
				navTable.setChrMemo(rs.getString("chrMemo"));
				navTable.setIntAdministerId(rs.getInt("intAdministerID"));
				navTable.setChrCNChannels(rs.getString("chrCNChannels"));
				navTable.setChrFRChannels(rs.getString("chrFRChannels"));
				navTable.setIntSequenceNum(rs.getInt("intSequenceNum"));
				navTable.setDtCreatetime(rs.getDate("dtCreatetime"));
				navTable.setHasChild(rs.getInt("hasChild"));
				array.add(navTable);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
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
		return array;

	}

	public PageBaseInfo queryList(int pageNo, int pageSize, int intType,
			int intParentId) {
		Connection conn = null;
		PageBaseInfo pageInfo = new PageBaseInfo();
		try {
			conn = DBPoolAccessor.getConnection();
			String sqlsource = "select id,intId,chrName,chrExpression,chrFRExpression,chrClass, intParentID,intType,chrMemo,intAdministerID,chrCNChannels,chrFRChannels,intSequenceNum,dtCreatetime,"
					+ " case when (select count(intParentID) from ipr_navtable t where t.intParentID=a.intId)<>0 then 1 else 0 end hasChild"
					+ " from ipr_navtable a where intParentID='"
					+ intParentId
					+ "' and intType='" + intType + "'";
			PageSearchSupporter ps = new PageSearchSupporter();
			pageInfo = ps.accountPageinfo(conn, pageNo, pageSize, sqlsource);
			if (pageInfo.getCountPagenum() < pageNo) {
				pageNo = pageInfo.getCountPagenum();
			}
			if (pageNo < 1) {
				pageNo = 1;
			}
			String sql = ps.getPageSearchSql(sqlsource, pageNo, pageSize);
			ArrayList<IprNavtableInfo> arr = this.queryBySQL(sql);
			pageInfo.setList(arr);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pageInfo;
	}

	/**
	 * 查询专利数据库信息不分页
	 */
	public List<IprNavtableInfo> queryForList(int intType, int intParentId,
			String userId) {
		List<IprNavtableInfo> array = new ArrayList<IprNavtableInfo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		if (intType == -1) {
			sql = "select id,intId,chrName,chrExpression,chrFRExpression,chrClass, intParentID,intType,chrMemo,intAdministerID,chrCNChannels,chrFRChannels,intSequenceNum,dtCreatetime,"
					+ " case when (select count(intParentID) from ipr_navtable t where t.intParentID=a.intId)<>0 then 1 else 0 end hasChild"
					+ " from ipr_navtable a where intParentID='"
					+ intParentId
					+ "' and (intType='1' or intType='2' or intType='3') order by intSequenceNum asc";
		} else {
			if (intParentId == Constant.HYK_ID
					|| intParentId == Constant.QYK_ID
					|| intParentId == Constant.GRK_ID) {
				sql = "select a.id,a.intId,a.chrName,a.chrExpression,a.chrFRExpression,a.chrClass, a.intParentID,a.intType,a.chrMemo,a.intAdministerID,a.chrCNChannels,a.chrFRChannels,a.intSequenceNum,a.dtCreatetime,"
						+ " case when (select count(intParentID) from ipr_navtable t where t.intParentID=a.intId)<>0 then 1 else 0 end hasChild"
						+ " from ipr_navtable a, ipr_user_nav b where a.intParentID='"
						+ intParentId
						+ "' and a.intType='"
						+ intType
						+ "' and a.intID = b.intNavID and b.intUserID="
						+ userId + " order by intSequenceNum asc";
			} else {
				sql = "select id,intId,chrName,chrExpression,chrFRExpression,chrClass, intParentID,intType,chrMemo,intAdministerID,chrCNChannels,chrFRChannels,intSequenceNum,dtCreatetime,"
						+ " case when (select count(intParentID) from ipr_navtable t where t.intParentID=a.intId)<>0 then 1 else 0 end hasChild"
						+ " from ipr_navtable a where intParentID='"
						+ intParentId
						+ "' and intType='"
						+ intType
						+ "' order by intSequenceNum asc";
			}

		}
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				IprNavtableInfo navTable = new IprNavtableInfo();
				navTable.setId(rs.getInt("id"));
				navTable.setIntId(rs.getInt("intId"));
				navTable.setName(rs.getString("chrName"));
				navTable.setCnExpression(rs.getString("chrExpression"));
				navTable.setFrExpression(rs.getString("chrFRExpression"));
				navTable.setStrClass(rs.getString("chrClass"));
				navTable.setParentId(rs.getInt("intParentID"));
				navTable.setIntType(rs.getInt("intType"));
				navTable.setChrMemo(rs.getString("chrMemo"));
				navTable.setIntAdministerId(rs.getInt("intAdministerID"));
				navTable.setChrCNChannels(rs.getString("chrCNChannels"));
				navTable.setChrFRChannels(rs.getString("chrFRChannels"));
				navTable.setIntSequenceNum(rs.getInt("intSequenceNum"));
				navTable.setDtCreatetime(rs.getDate("dtCreatetime"));
				navTable.setHasChild(rs.getInt("hasChild"));
				array.add(navTable);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
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
		return array;

	}

	public int newDataBase(IprNavtableInfo tbl) {
		int intID = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		// String sql = "insert into ipr_navtable(" + "intID," + "chrName,"
		// + "chrExpression," + "chrFRExpression," + "chrCNChannels,"
		// + "chrFRChannels," + "intSequenceNum," + "chrMemo,"
		// + "intParentId," + "dtCreatetime, intAdministerID) values("
		// + "select max(intID)+1,'" + tbl.getName() + "','"
		// + tbl.getCnExpression() + "','" + tbl.getFrExpression() + "','"
		// + tbl.getChrCNChannels() + "','" + tbl.getChrFRChannels()
		// + "','" + tbl.getIntSequenceNum() + "','" + tbl.getChrMemo()
		// + "','" + tbl.getParentId() + "'," + "now(), "+
		// tbl.getIntAdministerId() +")";
		String sql = "";
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select max(intID)+1 as maxid from ipr_navtable");
			rs = ps.executeQuery();
			if (rs.next()) {
				intID = rs.getInt("maxid");
				sql = "insert into ipr_navtable(" + "intID," + "chrName,"
						+ "chrExpression," + "chrFRExpression,"
						+ "chrCNChannels," + "chrFRChannels,"
						+ "intSequenceNum," + "chrMemo," + "intParentId,"
						+ "dtCreatetime,"
						+ "intType, intAdministerID) values('" + intID + "','"
						+ tbl.getName() + "','" + tbl.getCnExpression() + "','"
						+ tbl.getFrExpression() + "','"
						+ tbl.getChrCNChannels() + "','"
						+ tbl.getChrFRChannels() + "','"
						+ tbl.getIntSequenceNum() + "','" + tbl.getChrMemo()
						+ "','" + tbl.getParentId() + "'," + "now(),'"
						+ tbl.getIntType() + "', " + tbl.getIntAdministerId()
						+ ")";
			}
			rs.close();
			ps.close();
			ps = conn.prepareStatement(sql);
			ps.execute();
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
		return intID;
	}

	/**
	 * 
	 * 删除单个专利数据库
	 */
	public boolean deleteDataBase(int intId) {
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from ipr_navtable where intID='" + intId + "'";
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

	/**
	 * 查询单条专利数据库信息
	 */
	public IprNavtableInfo querySingleInfo(int intId) {
		IprNavtableInfo navTable = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select id,intId,chrName,chrExpression,chrFRExpression,chrClass, intParentID,intType,chrMemo,intAdministerID,chrCNChannels,chrFRChannels,intSequenceNum,dtCreatetime"
				+ " from ipr_navtable where intID='" + intId + "'";
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				navTable = new IprNavtableInfo();
				navTable.setId(rs.getInt("id"));
				navTable.setIntId(rs.getInt("intId"));
				navTable.setName(rs.getString("chrName"));
				navTable.setCnExpression(rs.getString("chrExpression"));
				navTable.setFrExpression(rs.getString("chrFRExpression"));
				navTable.setStrClass(rs.getString("chrClass"));
				navTable.setParentId(rs.getInt("intParentID"));
				navTable.setIntType(rs.getInt("intType"));
				navTable.setChrMemo(rs.getString("chrMemo"));
				navTable.setIntAdministerId(rs.getInt("intAdministerID"));
				navTable.setChrCNChannels(rs.getString("chrCNChannels"));
				navTable.setChrFRChannels(rs.getString("chrFRChannels"));
				navTable.setIntSequenceNum(rs.getInt("intSequenceNum"));
				navTable.setDtCreatetime(rs.getDate("dtCreatetime"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
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
		return navTable;
	}

	/**
	 * 修改专利数据库信息
	 */
	public boolean modifyDataBase(IprNavtableInfo navTable) {
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update ipr_navtable set chrName='" + navTable.getName()
				+ "'," + "intSequenceNum='" + navTable.getIntSequenceNum()
				+ "'," + "chrExpression='" + navTable.getCnExpression() + "',"
				+ "chrFRExpression='" + navTable.getFrExpression() + "',"
				+ "chrCNChannels='" + navTable.getChrCNChannels() + "',"
				+ "chrFRChannels='" + navTable.getChrFRChannels() + "',"
				+ "chrMemo='" + navTable.getChrMemo() + "' " + "where intID="
				+ navTable.getIntId();

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

	/**
	 * 取得导航菜单中的路径
	 */
	public String getPath(int intId, int intType) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select chrName,intParentID from ipr_navtable where intType="
				+ intType + " and intID=" + intId;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				int parentId = rs.getInt("intParentID");
				if (parentId != 0) {
					strPath = new StringBuffer().
					// append("<a href=\"list.jsp?parentid="+id+"\"
							// onClick=\"flushmainfr()\">"+rs.getString("chrName")+"</a>").
							append(strPath).toString();
					return strPath;
				} else {
					strPath = new StringBuffer().append(
							getPath(parentId, intType)).append(" \\ ")
							.toString();
					// append("<a href=\"list.jsp?parentid="+id+"\"
					// onClick=\"flushmainfr()\">"+rs.getString("chrName")+"</a>").toString();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
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
		return strPath;
	}

}
