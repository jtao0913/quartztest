package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.dao.ExpressionDAO;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.entity.ExpressionInfo;
import com.cnipr.cniprgz.entity.IprUser;

public class ExpressionFunc {
	private IprUserDAO iprUserDAO;
	public IprUserDAO getIprUserDAO() {
		return iprUserDAO;
	}
	public void setIprUserDAO(IprUserDAO iprUserDAO) {
		this.iprUserDAO = iprUserDAO;
	}
	
	private ExpressionDAO expDAO;

	public ExpressionDAO getExpDAO() {
		return expDAO;
	}

	public void setExpDAO(ExpressionDAO expDAO) {
		this.expDAO = expDAO;
	}
 
	public int saveExpression(String strUserIp, int intUserID, String strWhere, String strSources, String strChannelName, 
			String expName, long totalCount, String synonymous, int country) {
//		String sql = "insert into ";
		
		strWhere=strWhere.replace("申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=", "快速检索=");
		strWhere=strWhere.replace("主权项语义,摘要语义+=", "语义检索=");
		
		if (synonymous == null)
			synonymous = "0";
		
		if (expName == null) {
			expName = strWhere.substring(0,(strWhere.length()>23?23:strWhere.length()));
			if (strWhere.length()>23) {
				expName += "......";
			}
		}
		return expDAO.saveExpression(strUserIp, intUserID, strWhere,  strSources,strChannelName, expName, totalCount, synonymous, country  );
	}
	
	private int totalpages;
	public void setTotalpages(int totalpages) {
		this.totalpages = totalpages;
	}
	
	public List<ExpressionInfo> getExp(int userID, String userIP, int intCountry,int pageno) {
		String sql = "select id, chrAliasName, chrExpression, chrSources, chrChannelID, chrSynonymous, intSearchCount, intState,dtSearchTime from ipr_saveexpression where intUserID="
				+ userID;
//				+ " and intCountry=" + intCountry;
//		if(logicexp==1)
		
		if(intCountry!=2){
//			sql += " and intCountry=" + intCountry + " and chrSynonymous=1";
			sql += " and intCountry=" + intCountry;
		}
		
		sql += " and intState=0";
//		else{
//			sql += " and chrSynonymous=1";
//		}
		
		if(userIP != null){
			IprUser u = iprUserDAO.getUserInfo(userID);
			
			if(u.getChrUserName().equalsIgnoreCase("guest")){
				sql += " and chrUserIP='" + userIP + "'";
			}
		}
		
		if(totalpages==0) {
			int count = getTotalCount(sql);
			int pages = count/10;
			
//			System.out.println(pages%10);
			
			if(count%10>0) {
				pages++;
			}
			
			setTotalpages(pages);
		}
		
		sql += " order by dtSearchTime DESC";
		
		sql += " LIMIT "+(pageno-1)*10+",10";
		
		return expDAO.getExpBySql(sql);
	}
	
	public ExpressionInfo getExpbyID(int expid) {
		String sql = "select id, chrAliasName, chrExpression, chrSources, chrChannelID, chrSynonymous, intSearchCount, intState,dtSearchTime from ipr_saveexpression where id="
				+ expid;
		
		return expDAO.getExpBySql(sql).get(0);
	}
	
	public int getTotalpages() {
		return totalpages;
	}
	private int getTotalCount(String sql)
	{
		return expDAO.getTotalCount(sql);
	}
	
	public void updateState(int expId, int state) {
		int st = 1- state;
		expDAO.updateState(expId, st);
	}
	
	public int deleteExp(String expId) {
		return expDAO.deleteExp(expId);
	}
}
