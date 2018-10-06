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
import com.cnipr.cniprgz.entity.TBDept;
import com.cnipr.cniprgz.entity.TBGroup;
import com.cnipr.cniprgz.entity.IprAgency;
import com.cnipr.cniprgz.entity.TSimpleExecute;
import com.cnipr.cniprgz.entity.TSimpleWarn;

 

 
 

/**
 * 
 * Description: 简单预警任务信息数据处理接口
 */

public class IprAgencyDAO {
	 
	
	 
	
	
	/**
	 * 根据编号查找简单预警任务
	 * @param id
	 * @return
	 * @throws DAOException
	 */
	public IprAgency getIprAgency(String id)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		IprAgency iprAgency = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select * from ipr_agency where id = ?");
		 	ps.setString(1, id); 
			rs = ps.executeQuery();
			if (rs.next()) {
				iprAgency = new IprAgency();
				iprAgency.setId(id); 
				iprAgency.setAddress(rs.getString("address"));
				iprAgency.setAgent(rs.getString("agent"));
				iprAgency.setCity(rs.getString("city"));
				iprAgency.setManager(rs.getString("manager"));
				iprAgency.setName(rs.getString("name"));
				iprAgency.setParter(rs.getString("parter"));
				iprAgency.setPhone(rs.getString("phone"));
				iprAgency.setProvince(rs.getString("province"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			iprAgency = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return iprAgency;

		
	}
	
	 
	
	public List getProvince()  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		IprAgency iprAgency = null;
		List list= null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select province from ipr_agency group by province"); 
			rs = ps.executeQuery();
			 list= new ArrayList();
			while (rs.next()) { 
				list.add(rs.getString("province"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			iprAgency = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return list;

		
	}
	
	 
	public List getCity(String province)  throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		IprAgency iprAgency = null;
		List list= null;
		try {
			conn = DBPoolAccessor.getConnection();
			String sql = "select city from ipr_agency where province='"+province+"' group by city ";
			if(StringUtil.hasText(province)==false)
				sql = "select city from ipr_agency  group by city ";
			ps = conn.prepareStatement(sql); 
			rs = ps.executeQuery();
			 list= new ArrayList();
			while (rs.next()) { 
				list.add(rs.getString("city"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
			iprAgency = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return list;

		
	}
	
	
	 
	
	
	
	
public Pagination findAgencys(String agent,String name, String province , String city, int start,int pageSize) throws Exception{
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		IprAgency IprAgency = null;
		Pagination pagination = null;
		try {  
			 
			String sql =  "select * from ipr_agency where 1=1  "; 
		 	
			if(StringUtil.hasText(agent))
			{
				sql += " and agent like '%"+agent+"%'";
			}
			
			if(StringUtil.hasText(name))
			{
				sql += " and name like '%"+name+"%'";
			}
			
			if(StringUtil.hasText(province))
			{
				sql += " and   province='"+province+"'";
			}
			
			
			if(StringUtil.hasText(city))
			{
				sql += " and   city='"+city+"'";
			}
			
			conn = DBPoolAccessor.getConnection();
		 	PageBaseInfo pageInfo = new PageBaseInfo();
			PageSearchSupporter pss = new PageSearchSupporter();
			pageInfo = pss.accountPageinfo(conn, start, pageSize, sql); 
			
			pagination = new Pagination(start, pageSize, pageInfo.getCountRownum());
			String sqlsource = pss.getPageSearchSql(sql, start, pageSize);
			
			 
			ps = conn.prepareStatement(sqlsource);
			rs = ps.executeQuery();
			ArrayList<IprAgency> result = new ArrayList<IprAgency>();
			while (rs.next()) {
				IprAgency iprAgency = new IprAgency();
				iprAgency.setId(rs.getString("id")); 
				iprAgency.setAddress(rs.getString("address"));
				iprAgency.setAgent(rs.getString("agent"));
				iprAgency.setCity(rs.getString("city"));
				iprAgency.setManager(rs.getString("manager"));
				iprAgency.setName(rs.getString("name"));
				iprAgency.setParter(rs.getString("partner"));
				iprAgency.setPhone(rs.getString("phone"));
				iprAgency.setProvince(rs.getString("province")); 
				result.add(iprAgency);
			} 
			
			pagination.setList(result);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			IprAgency = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return pagination;

		
	}
}
