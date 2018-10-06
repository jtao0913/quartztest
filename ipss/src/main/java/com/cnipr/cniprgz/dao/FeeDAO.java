package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.log.CniprLogger;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class FeeDAO {

	public void deducted(PatentInfo patent, String userName, String funcName,
			int feeType, int page) {
		StringBuffer sql = new StringBuffer();

		sql.append(
				"select c.intChannelType, f.fee ")
				.append("from ipr_channel c, ipr_func_fee f ")
				.append(" where f.feeTypeId = " + feeType)
				.append(" and f.grantId = (SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName =  '"
								+ funcName + "')" )
				.append(" and c.intChannelID = f.channelId ")
				.append(" and c.chrTRSTable like '%"
							+ patent.getSectionName() + "%'")
				.append(
						" and not exists (select * from ipr_today_logs where chrUserName='"
								+ userName
								+ "' and intGrantID = (SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName =  '"
								+ funcName + "') and chrAPO='").append(
						patent.getAn())
				.append("' and intAPOPage=" + page + ")");;
		CniprLogger.LogInfo("FeeDAO -> deducted debug sql: "
						+ sql.toString());
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String deductedType = "";
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			if (rs.next()) {
				int channelType = rs.getInt("intChannelType");
				int fee = rs.getInt("fee");
				
				if (fee > 0) {
					if (channelType == 0) {
						deductedType = "intCHCount";
					} else {
						deductedType = "intFRCount";
					}
					
					StringBuffer updateSql = new StringBuffer();
					updateSql.append("update ipr_user set ").append(deductedType)
						.append(" = ").append(deductedType).append(" - ").append(fee)
						.append(" where chrUserName='").append(userName).append("'");
					ps.executeUpdate(updateSql.toString());
				}
			}
		} catch (Exception e) {
			CniprLogger.LogError("FeeDAO -> deducted is error: "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
	}
}
