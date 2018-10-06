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
import com.cnipr.cniprgz.entity.TBDept;
import com.cnipr.cniprgz.entity.TBGroup;
import com.cnipr.cniprgz.entity.TBUser;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class TBUserDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createTBUser(TBUser tbuser)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into tb_user(user_id,group_id,memo,dept_id) values(?,?,?,?)");
		 	ps.setInt(1, tbuser.getUserId());
		 	ps.setInt(2,tbuser.getGroupId());
		    ps.setString(3, tbuser.getMemo()); 
		    ps.setInt(4, tbuser.getDeptId());
			re  = ps.executeUpdate();			 
			
		} catch (Exception e) {
			e.printStackTrace();
			tbuser = null;
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
	public TBUser getTBUser(int userId)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBUser tbuser = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from tb_user where user_id = ?");
		 	ps.setInt(1, userId); 
			rs = ps.executeQuery();
			if (rs.next()) {
				tbuser = new TBUser();
				tbuser.setUserId(userId);
				tbuser.setGroupId(rs.getInt("group_id"));
				tbuser.setMemo(rs.getString("memo"));  
				tbuser.setDeptId(rs.getInt("dept_id"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			tbuser = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return tbuser;

		
	}
	
	 
	
	public void delete(String id) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from tb_user" + " where user_id="+id+""; 
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
	
	
	public void updateUser(TBUser tbuser) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update tb_user set group_id=?,dept_id=?" + " where user_id="+tbuser.getUserId()+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(hql);
		   ps.setInt(1, tbuser.getGroupId() );
		   ps.setInt(2, tbuser.getDeptId());
		  
		   ps.executeUpdate();
		   
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	
	
	
public Pagination findUsers(int start,int pageSize) throws Exception{
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBUser tbuser = null;
		Pagination pagination = null;
		try {  
			 
			String sql =  "select * from tb_user  "; 
		 	
		 	conn = DBPoolAccessor.getConnection();
		 	PageBaseInfo pageInfo = new PageBaseInfo();
			PageSearchSupporter pss = new PageSearchSupporter();
			pageInfo = pss.accountPageinfo(conn, start, pageSize, sql); 
			pagination = new Pagination(start, pageSize, pageInfo.getCountRownum());
			String sqlsource = pss.getPageSearchSql(sql, start, pageSize);
			
			 
			ps = conn.prepareStatement(sqlsource);
			rs = ps.executeQuery();
			ArrayList<TBUser> result = new ArrayList<TBUser>();
			while (rs.next()) {
				tbuser = new TBUser();
				tbuser.setDeptId(rs.getInt("dept_id"));
				tbuser.setGroupId(rs.getInt("group_id"));
				tbuser.setUserId(rs.getInt("user_id"));
				 result.add(tbuser);
			} 
			
			pagination.setList(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			tbuser = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return pagination;

		
	}
}
