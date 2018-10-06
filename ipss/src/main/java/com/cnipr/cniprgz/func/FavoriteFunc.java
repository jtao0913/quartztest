package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.dao.FavoriteDAO;
import com.cnipr.cniprgz.entity.FavoriteInfo;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class FavoriteFunc {
	
	private FavoriteDAO favoriteDAO = new FavoriteDAO();

	public FavoriteDAO getFavoriteDAO() {
		return favoriteDAO;
	}

	public void setFavoriteDAO(FavoriteDAO favoriteDAO) {
		this.favoriteDAO = favoriteDAO;
	}

	public boolean saveFavorite(String strUserIp, int intUserId,
			String strUserType, List<PatentInfo> patentInfoList) {
		/*
		if (strUserType.equals("normal") || strUserType.equals("corp")) {
			int favoriteCount = favoriteDAO.getFavoriteCountByID(intUserId);

			if ((favoriteCount + patentInfoList.size()) <= Constant.MAX_FAVORITE_COUNT) {
				return addFavorite(strUserIp, intUserId, patentInfoList);
			} else {
				int delCount = favoriteCount - Constant.MAX_FAVORITE_COUNT
						+ patentInfoList.size();
				String sql = "select id from ipr_searchresult where intUserID="
						+ intUserId + " Order By dtSaveTime limit 0,"
						+ delCount + " ";
				boolean flag = favoriteDAO.delFavoriteByID(favoriteDAO
						.getDelFavoriteIdBySQL(sql));
				if (flag) {
					return addFavorite(strUserIp, intUserId, patentInfoList);
				} else {
					return false;
				}
			}
		} else {
			return true;
		}
		*/
		return addFavorite(strUserIp, intUserId, patentInfoList);
	}
	
//	public boolean saveFavorite(String strUserIp) {
//			return true;
//	}

	public List<FavoriteInfo> getFavorite(int intUserId, String strUserIp,
			String strUserType) {
		String sql = "";
		if (strUserType.equals("normal")) {
			sql = "select id,chrAPO,chrTI,chrChannelID,intCountry from ipr_searchresult where intUserID="
					+ intUserId + " Order By dtSaveTime DESC";
		} else {
			sql = "select id,chrAPO,chrTI,chrChannelID,intCountry from ipr_searchresult where intUserID="
					+ intUserId
					+ " and chrUserIP='"
					+ strUserIp
					+ "' Order By dtSaveTime DESC";
		}
		return favoriteDAO.getFavoriteBySQL(sql);
	}
	
	public void delFavorite(List<Integer> favoriteIdList) {
		favoriteDAO.delFavoriteByID(favoriteIdList);
	}
	
	public void delAllFavorite(int intUserId, String strUserIp,
			String strUserType) {
		String sql = "";
		if (strUserType.equals("normal")) {
			sql = "delete from ipr_searchresult where intUserID = " + intUserId;
		} else {
			sql = "delete from ipr_searchresult where intUserID = " + intUserId + " and chrUserIP = '" + strUserIp +"'";
		}
		favoriteDAO.delAllFavorite(sql);
	}

	private boolean addFavorite(String strUserIp, int intUserId,
			List<PatentInfo> patentInfoList) {
		boolean result = true;

		for (PatentInfo info : patentInfoList) {
			if (!favoriteDAO.addFavorite(strUserIp, intUserId, info))
				result = false;
		}

		return result;
	}
	
}
