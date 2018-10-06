package com.cnipr.cniprgz.func.print;

import java.util.List;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.func.AbsCniprFunc;
import com.cnipr.cniprgz.func.search.SearchFunc;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class PrintFunc extends AbsCniprFunc {

	private SearchFunc searchFunc;

	public void setSearchFunc(SearchFunc searchFunc) {
		this.searchFunc = searchFunc;
	}

	@SuppressWarnings("unchecked")
	public List<PatentInfo> abstractPrint(String strPatentList,
			Class<?> classType, boolean flag, int userId, String userName,
			String userIp, int feeType) throws Exception {

		List<PatentInfo> patentList = Util.getList4Json(strPatentList,
				PatentInfo.class);

		StringBuffer anBuf = new StringBuffer();
		StringBuffer dbBuf = new StringBuffer();

		for (PatentInfo patent : patentList) {
			anBuf.append(patent.getAn() + ",");
			dbBuf.append(patent.getSectionName() + ",");
		}
		String strWhere = anBuf.substring(0, anBuf.length() - 1);
		String strSources = dbBuf.substring(0, dbBuf.length() - 1);

		try {
			patentList = searchFunc.executeSearch(null, strSources, "申请号=("
					+ strWhere + ")", false, flag);
		} catch (Exception e) {
			throw e;
			// CniprLogger.LogError("PrintAction -> abstractPrint error: " +
			// e.getMessage());
		}

		// 触发监听事件
//		this.fireEvent(new CniprEvent(this, !flag, false, patentList, userId,
//				userName, Constant.AUTH_FUNC_ABSTRACT_PRINT, 0, 0, userIp, feeType));

		return patentList;
	}
}
