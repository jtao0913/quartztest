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

 

 
 

/**
 * 
 * Description: 法律状态预警任务信息数据处理接口
 */

public class TLawWarnDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createLawWarn(TLawWarn lawWarn)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into t_law_warn(user_id,name,an,pn,channels,period,status,createtime,updatetime,lastruntime," +
							"lastupdatestatus,updatestatus , lastupdatetime) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		 	ps.setInt(1, lawWarn.getUserId());
		 	ps.setString(2,lawWarn.getName());
		    ps.setString(3,lawWarn.getAn());
		 	ps.setString(4,lawWarn.getPn());
		 	ps.setString(5,lawWarn.getChannels());
		 	ps.setInt(6,lawWarn.getPeriod());
		 	ps.setInt(7,lawWarn.getStatus());
		 	ps.setDate(8, lawWarn.getCreatetime()==null?null:new Date(lawWarn.getCreatetime().getTime()));
		 	ps.setDate(9, lawWarn.getUpdatetime()==null?null:new Date(lawWarn.getUpdatetime().getTime()));
		 	ps.setDate(10,lawWarn.getLastruntime()==null? null: new Date(lawWarn.getLastruntime().getTime())); 
		 	ps.setString(11, lawWarn.getLastupdatestatus());
		 	ps.setString(12,lawWarn.getUpdatestatus()); 
		 	ps.setDate(13,lawWarn.getLastupdatetime()==null?null:new Date(lawWarn.getLastupdatetime().getTime())); 
		 	
			re  = ps.executeUpdate();			 
			
		} catch (Exception e) {
			e.printStackTrace();
			lawWarn = null;
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
	public TLawWarn getLawWarn(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TLawWarn lawWarn = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select *  from t_law_warn where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				 lawWarn = new TLawWarn();
				 lawWarn.setId(rs.getInt("id"));
				 lawWarn.setUserId(rs.getInt("user_id"));
				 lawWarn.setAn(rs.getString("an"));
				 lawWarn.setChannels(rs.getString("channels"));
				 lawWarn.setCreatetime(rs.getDate("createtime"));
				 lawWarn.setPn(rs.getString("pn"));
				 lawWarn.setLastruntime(rs.getDate("lastruntime"));
				 lawWarn.setName(rs.getString("name"));
				 lawWarn.setPeriod(rs.getInt("period"));
				 lawWarn.setStatus(rs.getInt("status"));
				 lawWarn.setUpdatetime(rs.getDate("updatetime")); 
				 lawWarn.setLastupdatestatus(rs.getString("lastupdatestatus"));
				 lawWarn.setUpdatestatus(rs.getString("updatestatus"));
				 lawWarn.setLastupdatetime(rs.getDate("lastupdatetime"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			lawWarn = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return lawWarn;

		
	}
	
	public int countLawWarn(int userid)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TLawWarn lawWarn = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(*) from t_law_warn where user_id = ?");
		 	ps.setInt(1, userid); 
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			lawWarn = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return 0;

		
	}
	/**
	 * 更新简单预警周期
	 * @param id
	 * @param Period 周期
	 * @throws Exception
	 */
	public void updateNamePeriod(String id,int period,String name) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update t_law_warn set period="+period;
			if(StringUtil.hasText(name))
				hql+= ",name='"+name+"'";
			
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
	
	
	/**
	 * 取得用户用户下的简单预警任务列表
	 * @param userId
	 * @param orders
	 * @param start
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public Pagination findLawWarns(int userId,boolean status,String order,String sort, int start,int pageSize) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TLawWarn lawWarn = null;
		Pagination pagination = null;
		try { 
			
			String sql =  "select * from t_law_warn where user_id =  "+userId;
			
			if(userId==-1)
				sql =  "select * from t_law_warn where 1=1" ;
			
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
			ArrayList<TLawWarn> result = new ArrayList<TLawWarn>();
			while (rs.next()) {
				 lawWarn = new TLawWarn();
				 lawWarn.setId(rs.getInt("id"));
				 lawWarn.setUserId(rs.getInt("user_id"));
				 lawWarn.setAn(rs.getString("an"));
				 lawWarn.setChannels(rs.getString("channels"));
				 lawWarn.setCreatetime(rs.getDate("createtime"));
				 lawWarn.setPn(rs.getString("pn"));
				 lawWarn.setLastruntime(rs.getDate("lastruntime"));
				 lawWarn.setName(rs.getString("name"));
				 lawWarn.setPeriod(rs.getInt("period"));
				 lawWarn.setStatus(rs.getInt("status"));
				 lawWarn.setUpdatetime(rs.getDate("updatetime")); 
				 lawWarn.setLastupdatestatus(rs.getString("lastupdatestatus"));
				 lawWarn.setUpdatestatus(rs.getString("updatestatus"));
				 lawWarn.setLastupdatetime(rs.getDate("lastupdatetime"));
				 result.add(lawWarn);
			} 
			
			pagination.setList(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			lawWarn = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return pagination;

	}

	
	/**
	 * 修改预警状态
	 * @param id
	 * @param operator 操作方式(INCREASE +1 DECREASE -1 +exe_num 0)
	 * @throws Exception
	 */
	public void updateStatus(String id,String operator,int exe_num) throws Exception{  
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			 
			String sql = "";
			if(Constant.INCREASE.equals(operator)){
				sql = ("update T_law_Warn set status=status+"+exe_num+" where id="+id+"");
			}
			else{
				if(Constant.DECREASE.equals(operator)){
					sql = ("update T_law_Warn set status=status-"+exe_num+" where id="+id+"");
				}
			}    
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(sql);
		   ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	 
	public void updateLast(String id,TLawWarn lawWarn) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update t_law_warn set lastupdatetime=?,lastupdatestatus=?"; 
			hql+=" where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
			ps.setDate(1, new Date(lawWarn.getLastupdatetime().getTime()));
			ps.setString(2, lawWarn.getLastupdatestatus());
		    ps.executeUpdate();
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	
	public void updateNow(String id,TLawWarn lawWarn) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update T_law_Warn set updatetime=?,updatestatus=?"; 
			hql+=" where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
			ps.setDate(1, new Date(lawWarn.getUpdatetime().getTime()));
			ps.setString(2, lawWarn.getUpdatestatus());
		    ps.executeUpdate();
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	public void updateLastruntime(String id,TLawWarn lawWarn) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update t_law_warn set lastruntime=? "; 
			hql+=" where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
			ps.setDate(1, new Date(lawWarn.getLastruntime().getTime()));
			 
		    ps.executeUpdate();
		    
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
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
			String hql = "delete from T_law_Warn" + " where id="+id+""; 
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
