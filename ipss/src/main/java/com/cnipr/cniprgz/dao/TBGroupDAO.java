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
import com.cnipr.cniprgz.entity.TBAuthority;
import com.cnipr.cniprgz.entity.TBGroup;
import com.cnipr.cniprgz.entity.TSimpleWarn;

 

 
 

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class TBGroupDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createGroup(TBGroup tbgroup)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into tb_group(group_name,authority_id,group_memo,total_num) values(?,?,?,?)");
		 	ps.setString(1, tbgroup.getGroupName());
		 	ps.setString(2,tbgroup.getAuthorityId());
		    ps.setString(3,tbgroup.getGroupMemo()); 
		    ps.setInt(4, tbgroup.getTotalNum() );
			re  = ps.executeUpdate();
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			tbgroup = null;
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
	public TBGroup getGroup(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBGroup tbgroup = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from tb_group where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				tbgroup = new TBGroup();
				tbgroup.setId(rs.getInt("id"));
				tbgroup.setAuthorityId(rs.getString("authority_id"));
				tbgroup.setGroupMemo(rs.getString("group_memo"));
				tbgroup.setTotalNum(rs.getInt("total_num"));
				tbgroup.setGroupName(rs.getString("group_name"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			tbgroup = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return tbgroup;

		
	}
	
	public ArrayList<TBGroup> getGroups()  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		 
		TBGroup tbgroup = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select *  from tb_group ";
			
			
			ps = conn.prepareStatement(sql);
		 
			rs = ps.executeQuery();
			ArrayList<TBGroup> list =  new ArrayList<TBGroup>();
			
			
			while (rs.next()) {
				tbgroup = new TBGroup();
				tbgroup.setId(rs.getInt("id"));
				tbgroup.setAuthorityId(rs.getString("authority_id"));
				tbgroup.setGroupMemo(rs.getString("group_memo"));
				tbgroup.setGroupName(rs.getString("group_name"));
				tbgroup.setTotalNum(rs.getInt("total_num"));
				 list.add(tbgroup);
			} 
			return list;
		} catch (Exception e) {			
			e.printStackTrace();
			tbgroup = null;		
			
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return null;

		
	}
	 
	
	
	
	public void delete(String id) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from tb_group" + " where id="+id+""; 
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
	
	
	
	public void updateGroup(TBGroup tbgroup) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update tb_group set group_name=?,authority_id=?,group_memo=?,total_num=?" + " where id="+tbgroup.getId()+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(hql);
		   ps.setString(1, tbgroup.getGroupName());
		   ps.setString(2, tbgroup.getAuthorityId());
		   ps.setString(3, tbgroup.getGroupMemo());
		   ps.setInt(4, tbgroup.getTotalNum());
		   ps.executeUpdate();
		   
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
}
