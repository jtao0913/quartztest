package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
import com.cnipr.cniprgz.entity.TBDept;
import com.cnipr.cniprgz.entity.TBGroup;
import com.cnipr.cniprgz.entity.TSimpleWarn;

 

 
 

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class TBDeptDAO {
	 
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public int createDept(TBDept tbdept)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null; 
		int re = -10;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into tb_dept(dept_name,display,top_id) values(?,?,?)");
		 	ps.setString(1, tbdept.getDeptName());
		 	ps.setInt(2,tbdept.getDisplay());		   
		    ps.setInt(3, tbdept.getTopId());
			re  = ps.executeUpdate();
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			tbdept = null;
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
		return re;

		
	}
	 
	public String  getParentDepts(int id,String href)throws Exception
	{
		List parents = new ArrayList();
		TBDept dept = this.getDept(id);
		 
		while(dept!=null)
		{
			parents.add(dept);
			dept = this.getDept(dept.getTopId());
		}
		String s = "<a href='"+href+"topid=0'>根目录</a>   ";
		if(parents!=null && parents.size()>0 )
		for(int i=0;i<parents.size();i++)
		{
			TBDept dt = (TBDept) parents.get(i);
			s+=" -> "+"<a href='"+href+"topid="+dt.getId()+"'>"+ dt.getDeptName()+"</a>";
		}
		return s;
	}
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public TBDept getDept(int id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		TBDept tbdept = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from tb_dept where id = ?");
		 	ps.setInt(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				tbdept = new TBDept();
				tbdept.setId(rs.getInt("id"));
				tbdept.setDeptName(rs.getString("dept_name"));
				tbdept.setDisplay(rs.getInt("display"));
				tbdept.setTopId(rs.getInt("top_id"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			tbdept = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return tbdept;

		
	}
	
	public ArrayList<TBDept> getDepts(int topid)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		 
		TBDept tbdept = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
		
			String sql =  "select *  from tb_dept where top_id="+topid; 
			if(topid==-1)
				sql =  "select *  from tb_dept "; 
			ps = conn.prepareStatement(sql);
		 
			rs = ps.executeQuery();
			ArrayList<TBDept> list =  new ArrayList<TBDept>();
			
			
			while (rs.next()) {
				tbdept = new TBDept(); 
				tbdept.setId(rs.getInt("id"));
				tbdept.setDeptName(rs.getString("dept_name"));
				tbdept.setDisplay(rs.getInt("display"));
				tbdept.setTopId(rs.getInt("top_id"));
				 list.add(tbdept);
			} 
			return list;
		} catch (Exception e) {			
			e.printStackTrace();
			tbdept = null;		
			
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return null;

		
	}
	 
	
	
	
	public void delete(String id) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "delete from tb_dept" + " where id="+id+""; 
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
	
	
	public void updateDept(TBDept tbdept) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			String hql = "update tb_dept set dept_name=?,top_id=?,display=?" + " where id="+tbdept.getId()+""; 
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(hql);
		   ps.setString(1, tbdept.getDeptName());
		   ps.setInt(2, tbdept.getTopId());
		   ps.setInt(3, tbdept.getDisplay());
		   
		   ps.executeUpdate();
		   
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}
	}
	
	
}
