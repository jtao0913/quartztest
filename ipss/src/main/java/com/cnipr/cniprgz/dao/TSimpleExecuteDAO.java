package com.cnipr.cniprgz.dao;

  
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;

import net.jbase.common.hibernate3.Finder;
import net.jbase.common.page.Pagination;  
import net.jbase.common.util.StringUtil;
 

/**
 * 
 * Description: 简单任务执行记录数据处理接口
 */
public class TSimpleExecuteDAO {
	 
	
    public int createSimpleExecute(TSimpleExecute simpleExecute) throws Exception{
    	Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into t_simple_execute(simple_warn_id,period,pd_start,pd_end,amount,isnew) values(?,?,?,?,?,?)");
		 	ps.setInt(1, simpleExecute.getSimpleWarnId());
		 	ps.setInt(2,simpleExecute.getPeriod());
		    ps.setDate(3,simpleExecute.getPdStart()==null?null:new Date(simpleExecute.getPdStart().getTime()));
		 	ps.setDate(4,simpleExecute.getPdEnd()==null?null:new Date(simpleExecute.getPdEnd().getTime()));
		 	ps.setLong(5,simpleExecute.getAmount());
		 	ps.setInt(6,simpleExecute.getIsnew());
		 	 
			re  = ps.executeUpdate();
			 
		} catch (Exception e) {
			e.printStackTrace();
			simpleExecute = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return re;
    }
	/**
	 * 根据编号查找的简单任务执行记录数据
	 * 
	 * @param  id  编号
	 * @return TSimpleExecute 用户对象
	 * @throws DAOException
	 */	
	public TSimpleExecute getSimpleExecute(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleExecute simpleExecute = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select *  from t_simple_Execute where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				simpleExecute = new TSimpleExecute();
				simpleExecute.setId(rs.getInt("id"));
				simpleExecute.setPdEnd(rs.getDate("pd_end"));
				simpleExecute.setPdStart(rs.getDate("pd_start"));
				simpleExecute.setPeriod(rs.getInt("period"));
				simpleExecute.setSimpleWarnId(rs.getInt("simple_warn_id"));  
				simpleExecute.setAmount(rs.getLong("amount"));
				simpleExecute.setIsnew(rs.getInt("isnew"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			simpleExecute = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return simpleExecute;

	}
	

	/**
	 * 根据任务编号、周期末时间查找最新执行记录
	 * @param simpleWarnId
	 * @param pdEnd
	 * @return
	 * @throws DAOException
	 */
	public TSimpleExecute findNewSimpleExecute(String simpleWarnId,String pdEnd) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleExecute simpleExecute = null;
		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select bean.* from t_simple_Execute bean "+ 
			"where bean.pd_End=(select max(bean2.pd_End) from t_simple_Execute bean2 where bean2.simple_Warn_Id="+simpleWarnId+") and bean.simple_Warn_Id="+simpleWarnId;
						 
			ps = conn.prepareStatement(sql);
		 	 
			rs = ps.executeQuery();
			if (rs.next()) {
				simpleExecute = new TSimpleExecute();
				simpleExecute.setId(rs.getInt("id"));
				simpleExecute.setPdEnd(rs.getDate("pd_end"));
				simpleExecute.setPdStart(rs.getDate("pd_start"));
				simpleExecute.setPeriod(rs.getInt("period"));
				simpleExecute.setSimpleWarnId(rs.getInt("simple_warn_id")); 
				simpleExecute.setAmount(rs.getLong("amount"));
				simpleExecute.setIsnew(rs.getInt("isnew"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			simpleExecute = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return simpleExecute;
	}
	
	/**
	 * 取得简单执行记录列表
	 * @param simpleWarnId
	 * @param orders
	 * @param start
	 * @param pageSize
	 * @return
	 * @throws DAOException
	 */
	public Pagination findSimpleExecutes(String simpleWarnId,int start,int pageSize) throws Exception
	{		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleExecute simpleExecute = null;
		Pagination pagination = null;
		try {
			String sql =  "select * from t_simple_Execute where simple_warn_id = "+simpleWarnId +" order by pd_end desc"; 
		 	
		 	conn = DBPoolAccessor.getConnection();
		 	PageBaseInfo pageInfo = new PageBaseInfo();
			PageSearchSupporter pss = new PageSearchSupporter();
			pageInfo = pss.accountPageinfo(conn, start, pageSize, sql); 
			pagination = new Pagination(start, pageSize, pageInfo.getCountRownum());
			String sqlsource = pss.getPageSearchSql(sql, start, pageSize);			
			 
			ps = conn.prepareStatement(sqlsource);
			rs = ps.executeQuery();
			ArrayList<TSimpleExecute> result = new ArrayList<TSimpleExecute>();
			while (rs.next()) {
				simpleExecute = new TSimpleExecute();
				simpleExecute.setId(rs.getInt("id"));
				simpleExecute.setPdEnd(rs.getDate("pd_end"));
				simpleExecute.setPdStart(rs.getDate("pd_start"));
				simpleExecute.setPeriod(rs.getInt("period"));
				simpleExecute.setSimpleWarnId(rs.getInt("simple_warn_id"));  
				simpleExecute.setAmount(rs.getLong("amount"));
				simpleExecute.setIsnew(rs.getInt("isnew"));
				 result.add(simpleExecute);
			} 
			
			pagination.setList(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			simpleExecute = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return pagination;
	}

  
	public void deleteAll() throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from T_Simple_execute"; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
		   ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	 
	public void delete(String id) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from T_Simple_execute" + " where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
		   ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	public void deleteByWarnid(int warnid){
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from T_Simple_execute" + " where simple_warn_id=" + warnid; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
		   ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	
	
	public void updateIsnew(String id,int isnew) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update T_Simple_execute set isnew="+isnew;  
			hql+=" where id='"+id+"'";
			
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
