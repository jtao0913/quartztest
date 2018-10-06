package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.lang.StringEscapeUtils;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.log.CniprLogger;
import com.trs.usermanage.Tools;
import com.trs.was.WASException;

public class NavtableDAO {

	public IprNavtableInfo getNavtable(String navid) {

		IprNavtableInfo iprNavtableInfo = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(
					"SELECT n.chrName, n.chrExpression, n.chrFRExpression, n.intParentID, n.intType,n.intAdministerID FROM ipr_navtable n where n.intID="
							+ navid);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getInt("intParentID") == 0) {
					iprNavtableInfo = new IprNavtableInfo();
					iprNavtableInfo.setIntId(Integer.parseInt(navid));
					iprNavtableInfo.setCnExpression(rs.getString("chrExpression"));
					iprNavtableInfo.setFrExpression(rs.getString("chrFRExpression"));
					iprNavtableInfo.setIntAdministerId(rs.getInt("intAdministerID"));
					iprNavtableInfo.setParentId(rs.getInt("intParentID"));
					iprNavtableInfo.setName(rs.getString("chrName"));
				}
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getMenuInfo error : " + e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return iprNavtableInfo;

	}

	public int insertInfo(int intParentID, int intSequenceNum, String chrName, String chrMemo, String chrExpression,
			String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID, String intType)
			throws WASException {
		
		int ret = 0;
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
//			conn = DBConnect.getConnection();
			String strSQL = "";
			strSQL = "select chrName from ipr_navtable where chrName='"+chrName+"' and intParentID="+intParentID+" and intType="+intType;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();
			if (rs.next()) {
				return -2;
			}else {
			
			int maxcodeID = 0;
			strSQL = "select max(intID) maxcode from ipr_navtable";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			while (rs.next()) {
				maxcodeID = rs.getInt("maxcode") + 1;
			}
			PrePareStmtQuery.close();
			if ((intType == null) || (intType.equals(""))) {
				intType = "1";
			}
			
			chrExpression = chrExpression.replace("'", "''");
			chrFRExpression = chrFRExpression.replace("'", "''");
			
			strSQL = "insert into ipr_navtable(intID,intSequenceNum,chrName,chrExpression,chrFRExpression,intParentID,intType,chrMemo,chrCNChannels,chrFRChannels,intAdministerID) values("
					+ maxcodeID + "," + intSequenceNum + ",'" + chrName.trim() + "','" + chrExpression.trim() + "','"
					+ chrFRExpression.trim() + "'," + intParentID + "," + intType + ",'" + chrMemo.trim() + "','"
					+ chrCNChannels + "','" + chrFRChannels + "'," + intAdministerID + ")";

//			Tools.writelog(strSQL);

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			ret = PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();

/*			if (intParentID > 0) {
				intParentID = 1;
			}*/

			return 1;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
			return -1;
		} catch (Exception ex) {
			ex.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(PrePareStmtUpdate!=null) {
					PrePareStmtUpdate.close();
				}
				if(PrePareStmtQuery!=null) {
					PrePareStmtQuery.close();
				}
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

	}

	public int editInfo(int intParentID, int intID, int intSequenceNum, String chrName, String chrMemo, String chrExpression,
			String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID, String intType)
			throws WASException {
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtQuery = null;
		PreparedStatement PrePareStmtUpdate = null;
		ResultSet rs = null;
		String strSQL = "";
		
		try {
			// conn = DBConnect.getConnection();
			strSQL = "select chrName from ipr_navtable where intID!="+intID+" and chrName='"+chrName+"' and intParentID="+intParentID+" and intType="+intType;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();
			if (rs.next()) {
				return -2;
			}else {
			
			chrExpression = StringEscapeUtils.escapeSql(chrExpression);
			chrFRExpression = StringEscapeUtils.escapeSql(chrFRExpression);

			strSQL = "update ipr_navtable set intSequenceNum=" + intSequenceNum + "," + " chrName='"
					+ chrName.trim() + "'," + "chrExpression='" + chrExpression.trim() + "'," + "chrFRExpression='"
					+ chrFRExpression.trim() + "'," + "chrMemo='" + chrMemo.trim() + "'," + "chrCNChannels='"
					+ chrCNChannels + "'," + "chrFRChannels='" + chrFRChannels + "' " + "where intAdministerID="
					+ intAdministerID + " and intID=" + intID;

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();

			/*
			strSQL = "select intParentID from ipr_navtable where intAdministerID=" + intAdministerID + " and intID="
					+ intID;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();
			int intParentID = 0;
			while (rs.next()) {
				intParentID = rs.getInt("intParentID");
			}
			if (intParentID > 0) {
				return 1;
			}
			rs.close();
			PrePareStmtQuery.close();
			*/
			
/*			int[] arrTRSTable = getTRSTable(chrExpression, chrFRExpression, chrCNChannels, chrFRChannels);

			strSQL = "delete from ipr_user_nav where intNavID=" + intID;

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();*/
			return 1;
			}
		} catch (SQLException ex) {
			return -1;
		} finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(PrePareStmtUpdate!=null) {
					PrePareStmtUpdate.close();
				}
				if(PrePareStmtQuery!=null) {
					PrePareStmtQuery.close();
				}
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	private int[] getTRSTable(String chrExpression, String chrFRExpression, String chrCNChannels, String chrFRChannels)
			throws WASException {
		int[] arr = (int[]) null;
		try {
			String strChannels = "";

			strChannels = strChannels + chrCNChannels + ",";
			strChannels = strChannels + chrFRChannels;

			if (!strChannels.equals("")) {
				String[] arrTRSTable = strChannels.split(",");
				arr = new int[arrTRSTable.length];
				for (int i = 0; i < arrTRSTable.length; i++) {
					arr[i] = Integer.parseInt(arrTRSTable[i]);
				}

			}

		} catch (Exception ex) {
			throw new WASException(ex.getMessage());
		}
		return arr;
	}

	public void deleteAll(int intID, int intAdministerID) throws Exception {
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			// conn = DBConnect.getConnection();
			String strSQL = "";
			strSQL = "delete from ipr_navtable where intID=" + intID;
			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();

			strSQL = "select intParentID from ipr_navtable where intID=" + intID;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();
			int intParentID = 0;
			while (rs.next()) {
				intParentID = rs.getInt("intParentID");
			}
			rs.close();
			PrePareStmtQuery.close();

			if (intParentID == 0) {
				strSQL = "delete from ipr_user_nav where intNavID=" + intID;

				PrePareStmtUpdate = conn.prepareStatement(strSQL);
				PrePareStmtUpdate.executeUpdate();
				PrePareStmtUpdate.close();
			}

			boolean bflag = has_child(intID, intAdministerID);
			if (bflag) {
				strSQL = "select * from ipr_navtable where intAdministerID=" + intAdministerID + " and intParentID="
						+ intID;

				PrePareStmtQuery = conn.prepareStatement(strSQL);
				rs = PrePareStmtQuery.executeQuery();

				while (rs.next()) {
					int intChildID = rs.getInt("intID");

					deleteAll(intChildID, intAdministerID);
				}
			}
		} catch (Exception ex) {
			throw new WASException(ex.getMessage());
		} finally {
			try {
				rs.close();
				PrePareStmtUpdate.close();
				PrePareStmtQuery.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	public void deleteExpNode(int intID) throws Exception {
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			// conn = DBConnect.getConnection();
			String strSQL = "";
			strSQL = "delete from ipr_navtable where intID=" + intID;
			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();

			strSQL = "select intParentID from ipr_navtable where intID=" + intID;
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();
			int intParentID = 0;
			while (rs.next()) {
				intParentID = rs.getInt("intParentID");
			}
			rs.close();
			PrePareStmtQuery.close();
			
			if (intParentID == 0) {
				strSQL = "delete from ipr_user_nav where intNavID=" + intID;

				PrePareStmtUpdate = conn.prepareStatement(strSQL);
				PrePareStmtUpdate.executeUpdate();
				PrePareStmtUpdate.close();
			}
			
			boolean bflag = has_child(intID);
			if (bflag) {
//				strSQL = "select * from ipr_navtable where intAdministerID=" + intAdministerID + " and intParentID=" + intID;
				strSQL = "select * from ipr_navtable where intParentID=" + intID;

				PrePareStmtQuery = conn.prepareStatement(strSQL);
				rs = PrePareStmtQuery.executeQuery();

				while (rs.next()) {
					int intChildID = rs.getInt("intID");

					deleteExpNode(intChildID);
				}
			}
		} catch (Exception ex) {
			throw new WASException(ex.getMessage());
		} finally {
			try {
				rs.close();
				PrePareStmtUpdate.close();
				PrePareStmtQuery.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	
	public boolean has_child(int parentid, int intAdministerID) throws WASException {
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		boolean bflag = false;
		try {
			// conn = DBConnect.getConnection();
			String strSQL = "select * from ipr_navtable where intAdministerID=" + intAdministerID + " and intParentID="
					+ parentid;
			PrePareStmt = conn.prepareStatement(strSQL);
			rs = PrePareStmt.executeQuery();

			bflag = rs.next();
		} catch (Exception ex) {
			throw new WASException(ex.getMessage());
		} finally {
			try {
				rs.close();
				PrePareStmt.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return bflag;
	}

	public boolean has_child(int parentid) throws WASException {
		// Connection conn = null;
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmt = null;
		ResultSet rs = null;
		boolean bflag = false;
		try {
			// conn = DBConnect.getConnection();
			String strSQL = "select * from ipr_navtable where intParentID="
					+ parentid;
			PrePareStmt = conn.prepareStatement(strSQL);
			rs = PrePareStmt.executeQuery();

			bflag = rs.next();
		} catch (Exception ex) {
			throw new WASException(ex.getMessage());
		} finally {
			try {
				rs.close();
				PrePareStmt.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmt, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		return bflag;
	}

}
