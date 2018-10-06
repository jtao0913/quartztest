package com.cnipr.cniprgz.log;

import java.util.List;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.dao.TodayLogDAO;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class OperationRec {

	public void recordLog(List<PatentInfo> patentList, String userName,
			String funcName, int startPage, int endPage, String ip) {
		TodayLogDAO todayLogDao = new TodayLogDAO();
		if (startPage > 0) {
			for (int i = startPage; i <= endPage; i++) {
				todayLogDao.insertLogBySql(getSQLString(patentList.get(0),
						userName, funcName, startPage++, ip));
			}
		} else {
			for (PatentInfo patent : patentList) {
				todayLogDao.insertLogBySql(getSQLString(patent, userName,
						funcName, 0, ip));
			}
		}
	}

	// sql eg: insert into
	// ipr_today_logs(chrAPO, chrPhysicalPath, intGrantID, dtVisitTime,
	// chrVisitIP, chrUserName, intAPOPage, intChannelId)
	// select 'CN85100284','',
	// (SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName
	// = 'downloadXml'),
	// '2009-12-30 10:52:39', '192.168.3.180', 'cnipr', 12,
	// (select intChannelID from ipr_channel where chrTRSTable like '%fmzl_ft%')
	// from dual
	// WHERE not exists (select * from ipr_today_logs
	// where chrVisitIP='192.168.3.180' and intGrantID =
	// (SELECT ipr_grant.intGrantID FROM ipr_grant
	// WHERE ipr_grant.chrGrantName = 'downloadXml')
	// and chrAPO='CN85100284' and intAPOPage=12)
	private String getSQLString(PatentInfo patent, String userName,
			String funcName, int page, String ip) {
		StringBuffer sql = new StringBuffer();
		sql
				.append(
						"insert into ipr_today_logs(chrAPO, chrPhysicalPath, intGrantID, dtVisitTime, chrVisitIP, chrUserName, intAPOPage, intChannelId) ")
				.append(" select '")
				.append(patent.getAn())
				.append("','")
				.append(
						(patent.getTifDistributePath() == null) ? "" : patent
								.getTifDistributePath())
				.append("',(")
				.append(
						"SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName =  '"
								+ funcName + "'), '")
				.append(Util.getCurrentTime())
				.append("', '")
				.append(ip)
				.append("', '")
				.append(userName)
				.append("', ")
				.append(page)
				.append(", ")
				.append(
						"(select intChannelID from ipr_channel where chrTRSTable like '%"
								+ patent.getSectionName() + "%')")
				.append("from dual ")
				.append(
						"WHERE not exists (select * from ipr_today_logs where chrVisitIP='"
								+ ip
								+ "' and intGrantID = (SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName =  '"
								+ funcName + "') and chrAPO='").append(
						patent.getAn())
				.append("' and intAPOPage=" + page + ")");
		CniprLogger.LogDebug("OperationRec -> recordLog debug sql: "
				+ sql.toString());
		return sql.toString();
	}
}
