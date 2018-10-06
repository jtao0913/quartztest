package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.FavoriteInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class FavoriteDAO {

	public boolean addFavorite(String strUserIp, int intUserId,
			PatentInfo patentInfo) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			java.text.SimpleDateFormat sformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = sformat.format(new java.util.Date());

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into ipr_searchresult(intUserID,chrUserIP,chrAPO,chrTI,chrIPC,chrANN,dtSaveTime,chrChannelID,intCountry) values (?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, intUserId);
			ps.setString(2, strUserIp);
			ps.setString(3, patentInfo.getAn());
			ps.setString(4, patentInfo.getTi());
			ps.setString(5, patentInfo.getPic());
			ps.setString(6, patentInfo.getAgt());
			ps.setString(7, time);
			ps.setString(8, patentInfo.getSectionName());
			if (patentInfo.getCountryCode().equalsIgnoreCase("CN"))
				ps.setInt(9, 0);
			else
				ps.setInt(9, 1);
			int rs = ps.executeUpdate();
			if (rs == 1) {
				result = true;
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

	public List<FavoriteInfo> getFavoriteBySQL(String sql) {
		List<FavoriteInfo> favoriteInfoList = new ArrayList<FavoriteInfo>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
				FavoriteInfo favoriteInfo = new FavoriteInfo();
				favoriteInfo.setIndex(++i);
				favoriteInfo.setId(rs.getInt("id"));
				favoriteInfo.setChrAPO(rs.getString("chrAPO"));
				favoriteInfo.setChrTI(rs.getString("chrTI"));
				favoriteInfo.setChrChannelID(rs.getString("chrChannelID"));
				favoriteInfo.setIntCountry(rs.getInt("intCountry"));
				favoriteInfoList.add(favoriteInfo);
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
		return favoriteInfoList;
	}

	public int getFavoriteCountByID(int intUserID) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int favoriteCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(intUserID) as RecordCount from ipr_searchresult where intUserID=?");
			ps.setInt(1, intUserID);
			rs = ps.executeQuery();
			if (rs.next()) {
				favoriteCount = rs.getInt("RecordCount");
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
		return favoriteCount;
	}

	public int getFavoriteCountByIDIP(int intUserID, String strUserIp) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int favoriteCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(intUserID) as RecordCount from ipr_searchresult where intUserID=? and chrUserIP=?");
			ps.setInt(1, intUserID);
			ps.setString(2, strUserIp);
			rs = ps.executeQuery();
			if (rs.next()) {
				favoriteCount = rs.getInt("RecordCount");
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
		return favoriteCount;
	}

	public List<Integer> getDelFavoriteIdBySQL(String sql) {
		List<Integer> result = new ArrayList<Integer>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				result.add(rs.getInt("id"));
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
		return result;
	}

	public boolean delFavoriteByID(List<Integer> favoriteIdList) {
		boolean result = true;

		for (Integer favoriteId : favoriteIdList) {
			Connection conn = null;
			PreparedStatement ps = null;

			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn
						.prepareStatement("delete from ipr_searchresult where id = ?");
				ps.setInt(1, favoriteId);

				if (ps.executeUpdate() != 1)
					result = false;

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

		return result;
	}

	public void delAllFavorite(String sql) {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
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
}
