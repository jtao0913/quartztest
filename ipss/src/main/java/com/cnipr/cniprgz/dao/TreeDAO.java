package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.log.CniprLogger;

public class TreeDAO {

	public List<IprNavtableInfo> getHYTreeNodes(int nodeId) {

		List<IprNavtableInfo> iprNavtableInfoList = new ArrayList<IprNavtableInfo>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from ipr_navtable where intParentID = ? and intType = 1");
			ps.setInt(1, nodeId);
			rs = ps.executeQuery();
			while (rs.next()) {
				IprNavtableInfo iprNavtableInfo = new IprNavtableInfo();
				iprNavtableInfo.setId(rs.getInt("Id"));
				iprNavtableInfo.setName(rs.getString("chrName"));
				iprNavtableInfo.setCnExpression(rs.getString("chrExpression"));
				iprNavtableInfo
						.setFrExpression(rs.getString("chrFRExpression"));
				iprNavtableInfoList.add(iprNavtableInfo);
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

		return iprNavtableInfoList;
	}

	public List<IprNavtableInfo> getTreeNodes(int nodeId, String searchType,
			int treeType, String userId) {
	 
		List<IprNavtableInfo> iprNavtableInfoList = new ArrayList<IprNavtableInfo>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String strSQL = "";
		
		if (treeType == 0 || userId == null) {
			strSQL = "select intID, chrName, chrExpression, chrFRExpression, chrClass, chrCNChannels, chrFRChannels from ipr_navtable where intParentID = "
					+ nodeId + " and intType = " + treeType + " order by intSequenceNum";
		} else if(nodeId == 0 && userId != null && (treeType==3 || treeType==1) ){
			strSQL = "select distinct a.intID, a.chrName, a.chrExpression, a.chrFRExpression, a.chrClass, a.chrCNChannels, a.chrFRChannels from ipr_navtable a, ipr_user_nav b where a.intParentID = "
					+ nodeId
					+ " and a.intType = "
					+ treeType
					+ " and a.intID = b.intNavID and b.intUserID=" + userId + " order by intSequenceNum";
		} else {
			strSQL = "select intID, chrName, chrExpression, chrFRExpression, chrClass, chrCNChannels, chrFRChannels from ipr_navtable where intParentID = "
				+ nodeId + " and intType = " + treeType + " order by intSequenceNum";
		}
		 
          //System.out.println(treeType+ " ,  strSQL="+strSQL);
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			// ps.setInt(1, nodeId);
			// ps.setInt(2, treeType);
			rs = ps.executeQuery();
			while (rs.next()) {
				IprNavtableInfo iprNavtableInfo = new IprNavtableInfo();
				iprNavtableInfo.setId(rs.getInt("intID"));
				iprNavtableInfo.setName(rs.getString("chrName"));
				// if (searchType.equals("cn")) {
				iprNavtableInfo.setCnExpression(rs.getString("chrExpression"));
				// } else {
				iprNavtableInfo
						.setFrExpression(rs.getString("chrFRExpression"));
				// }
				List<String> cnChannels = getCNChannels(rs
						.getString("chrCNChannels"));
				if (cnChannels.size() >= 2) {
					iprNavtableInfo.setChrCNChannels(cnChannels.get(0));
					iprNavtableInfo.setChrLapsedChannels(cnChannels.get(1));
				} else {
					iprNavtableInfo.setChrCNChannels(rs
							.getString("chrCNChannels"));
					iprNavtableInfo.setChrLapsedChannels(null);
				}

				iprNavtableInfo.setChrFRChannels(rs.getString("chrFRChannels"));
				iprNavtableInfo.setStrClass(rs.getString("chrClass"));

				iprNavtableInfoList.add(iprNavtableInfo);

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

		return iprNavtableInfoList;
	}

	public IprNavtableInfo getTreeNode(int nodeId, String searchType,
			int treeType, String userId) {

		IprNavtableInfo iprNavtableInfo = new IprNavtableInfo();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String strSQL = "";

		if (treeType == 0 || userId == null) {
			strSQL = "select intID, chrName, chrExpression, chrFRExpression, intParentID, chrClass, chrCNChannels, chrFRChannels from ipr_navtable where ";
			if (searchType.equals("child")) {
				strSQL += "intParentID = ";
			} else {
				strSQL += "intID = ";
			}
			strSQL += nodeId + " and intType = " + treeType;
		} else {
			strSQL = "select a.intID, a.chrName, a.chrExpression, a.chrFRExpression, a.intParentID, a.chrClass, a.chrCNChannels, a.chrFRChannels from ipr_navtable a, ipr_user_nav b where ";
			if (searchType.equals("child")) {
				strSQL += "a.intParentID = ";
			} else {
				strSQL += "a.intID = ";
			}
			strSQL += nodeId + " and a.intType = " + treeType
					+ " and a.intID = b.intNavID and b.intUserID=" + userId;
		}

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			// ps.setInt(1, nodeId);
			// ps.setInt(2, treeType);
			rs = ps.executeQuery();
			if (rs.next()) {
				iprNavtableInfo.setId(rs.getInt("intID"));
				iprNavtableInfo.setName(rs.getString("chrName"));
				iprNavtableInfo.setParentId(rs.getInt("intParentID"));
				if (searchType.equals("child")) {
					// if (searchType.equals("cn")) {
					iprNavtableInfo.setCnExpression(rs
							.getString("chrExpression"));
					// } else {
					iprNavtableInfo.setFrExpression(rs
							.getString("chrFRExpression"));
					List<String> cnChannels = getCNChannels(rs
							.getString("chrCNChannels"));
					// }
					if (cnChannels.size() >= 2) {
						iprNavtableInfo.setChrCNChannels(cnChannels.get(0));
						iprNavtableInfo.setChrLapsedChannels(cnChannels.get(1));
					} else {
						iprNavtableInfo.setChrCNChannels(rs
								.getString("chrCNChannels"));
						iprNavtableInfo.setChrLapsedChannels(null);
					}

					iprNavtableInfo.setChrFRChannels(rs
							.getString("chrFRChannels"));
					iprNavtableInfo.setStrClass(rs.getString("chrClass"));
				}
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

		return iprNavtableInfo;
	}
	
	public List<IprNavtableInfo> getIPCFourLev(String parentIPCCode) {
		List<IprNavtableInfo> iprNavtableInfoList = new ArrayList<IprNavtableInfo>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String strSQL = "select * from patent_grade7 where GRADETHREE='" + parentIPCCode + "' order by id"; 
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				IprNavtableInfo iprNavtableInfo = new IprNavtableInfo();
				iprNavtableInfo.setId(1000 + rs.getInt("id"));
				
				String strClass = rs.getString("GRADEFOUR");
				iprNavtableInfo.setCnExpression("pic=" + strClass);
				iprNavtableInfo
						.setFrExpression("pic=" + strClass);
				iprNavtableInfo.setName(strClass + " " + rs.getString("DESCRIPTION"));
				ChannelDAO channelDao = new ChannelDAO();
				
				iprNavtableInfo.setChrCNChannels(channelDao.getEnableChannelIds("cn"));
				iprNavtableInfo.setChrFRChannels(channelDao.getEnableChannelIds("fr"));

				iprNavtableInfo.setStrClass(strClass);

				iprNavtableInfoList.add(iprNavtableInfo);

			}

		} catch (Exception e) {
			CniprLogger.LogError("TreeDAO -> getIPCThirdLev error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return iprNavtableInfoList;
	}

	private List<String> getCNChannels(String chrChannels) {
		List<String> channelList = new ArrayList<String>();

		if (chrChannels != null && !chrChannels.equals("")) {
			String[] channelArray = chrChannels.split(",");
			String chrCNChannels = "";
			String chrLapsedChannels = "";
			for (String channel : channelArray) {
				if (channel.equals("2") || channel.equals("3")
						|| channel.equals("4")) {
					chrLapsedChannels += channel + ",";
				} else {
					chrCNChannels += channel + ",";
				}
			}
			if (chrLapsedChannels != null && !chrLapsedChannels.equals(""))
				chrLapsedChannels = chrLapsedChannels.substring(0,
						chrLapsedChannels.length() - 1);
			if (chrCNChannels != null && !chrCNChannels.equals(""))
				chrCNChannels = chrCNChannels.substring(0, chrCNChannels
						.length() - 1);
			channelList.add(chrCNChannels);
			channelList.add(chrLapsedChannels);
		} else {
			channelList.add(chrChannels);
		}

		return channelList;
	}

	public boolean isLeaf(int nodeId, int treeType) {
		boolean isleaf = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select Id from ipr_navtable where intParentID = ? and intType = ?");
			ps.setInt(1, nodeId);
			ps.setInt(2, treeType);
			rs = ps.executeQuery();
			if (!rs.next()) {
				isleaf = true;
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
		return isleaf;
	}

}
