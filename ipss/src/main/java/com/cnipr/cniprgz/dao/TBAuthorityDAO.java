package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.jbase.common.hibernate3.OrderBy;
import net.jbase.common.page.Pagination;
import net.jbase.common.util.StringUtil;
 
import antlr.collections.List;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.LogInfo;
import com.cnipr.cniprgz.entity.TBAuthority;

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class TBAuthorityDAO {
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public TBAuthority getAuthority(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBAuthority authority = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select *  from tb_authority where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				 authority = new TBAuthority();
				 authority.setAuthority(rs.getString("authority"));
				 authority.setId(rs.getString("id"));
				 authority.setType(rs.getInt("type")); 
			} 
		} catch (Exception e) {
			e.printStackTrace();
			authority = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return authority;

		
	}
	
	public ArrayList<TBAuthority> getAuthoritys(int type)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBAuthority authority = null;
		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select *  from tb_authority where type = "+type;
			if(type==-1)
				 sql =  "select *  from tb_authority ";
			
			ps = conn.prepareStatement(sql);
		 
			rs = ps.executeQuery();
			ArrayList<TBAuthority> list =  new ArrayList<TBAuthority>();
			while (rs.next()) {
				 authority = new TBAuthority();
				 authority.setAuthority(rs.getString("authority"));
				 authority.setId(rs.getString("id"));
				 authority.setType(rs.getInt("type")); 
				 list.add(authority);
			} 
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			authority = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return null;

		
	}
	   
	
	 
}
