package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.dao.NavtableDAO;
import com.cnipr.cniprgz.entity.ExpressionInfo;
import com.trs.was.WASException;

public class HangyeFunc {

	private NavtableDAO navtableDAO;

	public NavtableDAO getNavtableDAO() {
		return navtableDAO;
	}

	public void setNavtableDAO(NavtableDAO navtableDAO) {
		this.navtableDAO = navtableDAO;
	}

	public int insertInfo(int intParentID, int intSequenceNum, String chrName, String chrMemo, String chrExpression,
			String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID, String intType)
			throws WASException {
		int ret = navtableDAO.insertInfo(intParentID, intSequenceNum, chrName, chrMemo, chrExpression, chrFRExpression,
				chrCNChannels, chrFRChannels, intAdministerID, (intType));
		return ret;
	}

	public int editInfo(int intParentID,int intID, int intSequenceNum, String chrName, String chrMemo, String chrExpression,
			String chrFRExpression, String chrCNChannels, String chrFRChannels, int intAdministerID, String intType)
			throws WASException {
		int ret = navtableDAO.editInfo(intParentID, intID, intSequenceNum, chrName, chrMemo, chrExpression, chrFRExpression,
				chrCNChannels, chrFRChannels, intAdministerID,intType);
		return ret;
	}

	public int deleteAll(int intID, int intAdministerID) throws Exception {
		int ret = 0;
		try {
			navtableDAO.deleteAll(intID, intAdministerID);
			return 1;
		} catch (Exception ex) {
			return -1;
		}
	}
	
	public int deleteExpNode(int intID) throws Exception {
		int ret = 0;
		try {
			navtableDAO.deleteExpNode(intID);
			return 1;
		} catch (Exception ex) {
			return -1;
		}
	}

	// public int saveExpression(String strUserIp, int intUserID,
	// String strWhere, String strChannelName, String expName, long totalCount,
	// String synonymous, int country) {
	// //String sql = "insert into ";
	// if (synonymous == null)
	// synonymous = "0";
	//
	// if (expName == null) {
	// expName = strWhere.substring(0,(strWhere.length()>23?23:strWhere.length()));
	// if (strWhere.length()>23) {
	// expName += "......";
	// }
	// }
	// return expDAO.saveExpression(strUserIp, intUserID, strWhere, strChannelName,
	// expName, totalCount, synonymous, country );
	// }
	//
	// public List<ExpressionInfo> getExp(int userID, String userIP, int intCountry)
	// {
	// String sql = "select id, chrAliasName, chrExpression, chrChannelID,
	// chrSynonymous, intSearchCount, intState from ipr_saveexpression where
	// intUserID="
	// + userID + " and intCountry=" + intCountry;
	// if(userIP != null)
	// sql += " and chrUserIP='" + userIP + "'";
	//
	// sql += " order by dtSearchTime DESC";
	//
	// return expDAO.getExpBySql(sql);
	// }
	//
	// public void updateState(int expId, int state) {
	// int st = 1- state;
	// expDAO.updateState(expId, st);
	// }
	//
	// public int deleteExp(int expId) {
	// return expDAO.deleteExp(expId);
	// }

}
