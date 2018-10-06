package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.jbase.common.hibernate3.OrderBy;
import net.jbase.common.page.Pagination;
import net.jbase.common.util.StringUtil;
 
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.LogInfo;
import com.cnipr.cniprgz.entity.TLawWarn;
import com.cnipr.cniprgz.entity.TbReport;

 

 
 

/**
 * 
 * Description: 检索报告数据处理接口
 */

public class TbReportDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createTbReport(TbReport tbReport)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into tb_report(name,user_id,exp,channels,type,createtime,status) values(?,?,?,?,?,?,?)");
		 	ps.setString(1, tbReport.getName());
		 	ps.setInt(2, tbReport.getUserId());
		    ps.setString(3, tbReport.getExp());
		 	ps.setString(4, tbReport.getChannels());
		 	ps.setInt(5, tbReport.getType());
		 	ps.setDate(6,  tbReport.getCreatetime()==null?null:new Date(tbReport.getCreatetime().getTime()));
		 	ps.setInt(7, tbReport.getStatus()); 
			re  = ps.executeUpdate();			 
			
		} catch (Exception e) {
			e.printStackTrace();
			tbReport = null;
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
		return re;

		
	}
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public TbReport getTbReport(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TbReport tbReport = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select *  from tb_report where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				tbReport = new TbReport();
				tbReport.setId(rs.getInt("id"));
				tbReport.setUserId(rs.getInt("user_id"));			 
				tbReport.setChannels(rs.getString("channels"));
				tbReport.setCreatetime(rs.getDate("createtime")); 
				tbReport.setName(rs.getString("name")); 
				tbReport.setStatus(rs.getInt("status"));
				tbReport.setExp(rs.getString("exp"));
				tbReport.setPath(rs.getString("path"));
				tbReport.setType(rs.getInt("type"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			tbReport = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return tbReport;		
	}
	
	
	
	public int countTbReport(int userid)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TbReport tbReport = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(*) from tb_Report where user_id = ?");
		 	ps.setInt(1, userid); 
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			tbReport = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return 0;

		
	}
	 
	
	/**
	 * 取得用户用户下的简单预警任务列表
	 * @param userId
	 * @param orders
	 * @param start
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public Pagination findTbReport(int userId,boolean status,String order,String sort, int start,int pageSize) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TbReport tbReport = null;
		Pagination pagination = null;
		try { 
			
			String sql =  "select * from Tb_Report where user_id =  "+userId;
			
			if(userId==-1)
				sql =  "select * from Tb_Report where 1=1" ;
			
			if(status)
			{
				sql +=" and status > 0";
			}
			
			if(StringUtil.hasText(order))
			{
				sql +=" order by "+order;				
				if(StringUtil.hasText(sort))
				{
					sql +="  "+sort;
				}
			} 
		 	
		 	conn = DBPoolAccessor.getConnection();
		 	PageBaseInfo pageInfo = new PageBaseInfo();
			PageSearchSupporter pss = new PageSearchSupporter();
			if(pageSize>0)
			pageInfo = pss.accountPageinfo(conn, start, pageSize, sql); 
			pagination = new Pagination(start, pageSize, pageInfo.getCountRownum());
			
			String sqlsource = pss.getPageSearchSql(sql, start, pageSize);
			if(pageSize==-1)
				sqlsource = sql;
		 
			ps = conn.prepareStatement(sqlsource);
			rs = ps.executeQuery();
			ArrayList<TbReport> result = new ArrayList<TbReport>();
			while (rs.next()) { 
				 tbReport = new TbReport();
					tbReport.setId(rs.getInt("id"));
					tbReport.setUserId(rs.getInt("user_id"));			 
					tbReport.setChannels(rs.getString("channels"));
					tbReport.setCreatetime(rs.getDate("createtime")); 
					tbReport.setName(rs.getString("name")); 
					tbReport.setStatus(rs.getInt("status"));
					tbReport.setExp(rs.getString("exp"));
					tbReport.setPath(rs.getString("path"));
					tbReport.setType(rs.getInt("type"));
				 result.add(tbReport);
			} 
			
			pagination.setList(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			tbReport = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return pagination;

	}

	
	   
	
	/**
	 * 更新简单预警周期
	 * @param id
	 * @param Period 周期
	 * @throws Exception
	 */
	public void delete(String id) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from tb_Report" + " where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(hql);
		   ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	
	 
}
