package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.jbase.common.page.Pagination;
import net.jbase.common.util.StringUtil;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.TSimpleWarn;

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class TSimpleWarnDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createSimpleWarn(TSimpleWarn simpleWarn)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into t_simple_warn(user_id,name,expression,area,channels,period,status,createtime,updatetime,lastruntime," +
							"lastupdateamount,lastupdate) values(?,?,?,?,?,?,?,?,?,?,?,?)");
		 	ps.setInt(1, simpleWarn.getUserId());
		 	ps.setString(2,simpleWarn.getName());
		    ps.setString(3,simpleWarn.getExpression());
		 	ps.setInt(4,simpleWarn.getArea());
		 	ps.setString(5,simpleWarn.getChannels());
		 	ps.setInt(6,simpleWarn.getPeriod());
		 	ps.setInt(7,simpleWarn.getStatus());
		 	ps.setDate(8, simpleWarn.getCreatetime()==null?null:new Date(simpleWarn.getCreatetime().getTime()));
		 	ps.setDate(9, simpleWarn.getUpdatetime()==null?null:new Date(simpleWarn.getUpdatetime().getTime()));
		 	ps.setDate(10,simpleWarn.getLastruntime()==null? null: new Date(simpleWarn.getLastruntime().getTime())); 
		 	ps.setInt(11,0);
		 	ps.setDate(12,null); 
			re  = ps.executeUpdate();
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			simpleWarn = null;
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
	public TSimpleWarn getSimpleWarn(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleWarn simpleWarn = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select *  from t_simple_warn where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				 simpleWarn = new TSimpleWarn();
				 simpleWarn.setId(rs.getInt("id"));
				 simpleWarn.setUserId(rs.getInt("user_id"));
				 simpleWarn.setArea(rs.getInt("area"));
				 simpleWarn.setChannels(rs.getString("channels"));
				 simpleWarn.setCreatetime(rs.getDate("createtime"));
				 simpleWarn.setExpression(rs.getString("expression"));
				 simpleWarn.setLastruntime(rs.getDate("lastruntime"));
				 simpleWarn.setName(rs.getString("name"));
				 simpleWarn.setPeriod(rs.getInt("period"));
				 simpleWarn.setStatus(rs.getInt("status"));
//				 simpleWarn.setUpdatetime(rs.getDate("updatetime")); 
			} 
		} catch (Exception e) {
			e.printStackTrace();
			simpleWarn = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return simpleWarn;

		
	}
	
	public int countSimpleWarn(int userid)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleWarn simpleWarn = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(*) from t_simple_warn where user_id = ?");
		 	ps.setInt(1, userid); 
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			simpleWarn = null;
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
			String hql = "update T_Simple_Warn set period="+period;
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
	public Pagination findSimpleWarns(int userId,boolean status,String order,String sort, int start,int pageSize) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TSimpleWarn simpleWarn = null;
		Pagination pagination = null;
		try { 
			String sql =  "select * from t_simple_warn where user_id =  "+userId;
			if(userId==-1)
				  sql =  "select * from t_simple_warn where 1=1 ";
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
			
//			sql = "select * from t_simple_warn where id=6";
		 	
		 	conn = DBPoolAccessor.getConnection();
		 	PageBaseInfo pageInfo = new PageBaseInfo();
			PageSearchSupporter pss = new PageSearchSupporter();
			if(pageSize>0){
				pageInfo = pss.accountPageinfo(conn, start, pageSize, sql); 
			}
			pagination = new Pagination(start, pageSize, pageInfo.getCountRownum());
			
			String sqlsource = pss.getPageSearchSql(sql, start, pageSize);
			if(pageSize==-1)
				sqlsource = sql;
		 
			ps = conn.prepareStatement(sqlsource);
			rs = ps.executeQuery();
			ArrayList<TSimpleWarn> result = new ArrayList<TSimpleWarn>();
			while (rs.next()) {
				 simpleWarn = new TSimpleWarn();
				 simpleWarn.setId(rs.getInt("id"));
				 
				 
				 simpleWarn.setUserId(rs.getInt("user_id"));
				 simpleWarn.setArea(rs.getInt("area"));
				 simpleWarn.setChannels(rs.getString("channels"));
				 
//				 System.out.println("updatetime = "+rs.getString("updatetime"));
				 
				 simpleWarn.setCreatetime(rs.getDate("createtime"));
				 simpleWarn.setExpression(rs.getString("expression"));
				 
				 try{
//					 rs.getDate("lastruntime");
					 simpleWarn.setLastruntime(rs.getDate("lastruntime"));					 
				 }catch(java.sql.SQLException ex){
					 simpleWarn.setLastruntime(null);
				 }
				 
				 simpleWarn.setName(rs.getString("name"));
				 simpleWarn.setPeriod(rs.getInt("period"));
				 simpleWarn.setStatus(rs.getInt("status"));
				 
				 try{
//					 rs.getDate("updatetime");
					 simpleWarn.setUpdatetime(rs.getDate("updatetime"));
				 }catch(java.sql.SQLException ex){
					 simpleWarn.setUpdatetime(null);
				 }
				 
				 result.add(simpleWarn);
			} 
			
			pagination.setList(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			simpleWarn = null;
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
				sql = ("update T_Simple_Warn set status=status+"+exe_num+" where id="+id+"");
			}
			else{
				if(Constant.DECREASE.equals(operator)){
					sql = ("update T_Simple_Warn set status=status-"+exe_num+" where id="+id+"");
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
	 
	public void updateLastRuntime(String id,TSimpleWarn simpleWarn) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update T_Simple_Warn set lastruntime=?"; 
			hql+=" where id="+id+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(hql);
			ps.setDate(1, new Date(simpleWarn.getLastruntime().getTime()));
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
			String hql = "delete from T_Simple_Warn" + " where id="+id+""; 
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
