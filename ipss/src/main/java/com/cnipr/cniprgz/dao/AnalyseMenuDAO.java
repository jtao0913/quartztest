package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.AnalyzeMenu;

public class AnalyseMenuDAO {
	
	public AnalyzeMenu getMenuInfoByID(String id) throws Exception{
		AnalyzeMenu analysemenu = null;
		if (id != null && !id.equals("")){
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement("select intID,chrName,intParentID,chrXAxis,chrYAxis,xAxisSize,yAxisSize,chrDefaultChart,chrChart,intCNFR,chrIntroduce,chrIcon from ipr_analyse where intID = ?");
				
				//Util.isNumeric
				if(Util.isNumeric(id)){
					ps.setInt(1, Integer.parseInt(id));
				}
				
				rs = ps.executeQuery();
				if (rs.next()) {
					analysemenu = new AnalyzeMenu();
					
					analysemenu.setIntID(rs.getInt("intID"));
					analysemenu.setChrName(rs.getString("chrName"));
					analysemenu.setIntParentID(rs.getInt("intParentID"));
					analysemenu.setChrXAxis(rs.getString("chrXAxis"));
					analysemenu.setChrYAxis(rs.getString("chrYAxis"));
					analysemenu.setxAxisSize(rs.getInt("xAxisSize"));
					analysemenu.setyAxisSize(rs.getInt("yAxisSize"));					
					analysemenu.setChrDefaultChart(rs.getString("chrDefaultChart"));
					analysemenu.setChrChart(rs.getString("chrChart"));
					analysemenu.setIntCNFR(rs.getInt("intCNFR"));
					analysemenu.setChrIntroduce(rs.getString("chrIntroduce"));					
					analysemenu.setChrIcon(rs.getString("chrIcon"));
				}
	
			} catch (Exception ex) {
//				e.printStackTrace();
				throw ex;
			} finally {
				DBPoolAccessor.closeAll(rs, ps, conn);
			}
		}
		return analysemenu;
	}

	public List<AnalyzeMenu> getAllAnalyseMenu(String area) throws Exception{
		List<AnalyzeMenu> analysemenuInfoList = new ArrayList<AnalyzeMenu>();
		AnalyzeMenu analysemenu = null;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String table = "ipr_analyse";
		if(area.equalsIgnoreCase("fr")||area.equalsIgnoreCase("en")) {
			table = "ipr_analyse_fr";
		}
		
		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select intID,chrName,intParentID,chrXAxis,chrYAxis,xAxisSize,yAxisSize,chrDefaultChart,chrChart,intCNFR,chrIntroduce,chrIcon from "+table+" where intEnable=1 order by intID";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery(sql);
			while (rs.next()) {
				analysemenu = new AnalyzeMenu();
				
				analysemenu.setIntID(rs.getInt("intID"));
				analysemenu.setChrName(rs.getString("chrName"));
				analysemenu.setIntParentID(rs.getInt("intParentID"));
				analysemenu.setChrXAxis(rs.getString("chrXAxis"));
				analysemenu.setChrYAxis(rs.getString("chrYAxis"));
				analysemenu.setxAxisSize(rs.getInt("xAxisSize"));
				analysemenu.setyAxisSize(rs.getInt("yAxisSize"));
				
				analysemenu.setChrDefaultChart(rs.getString("chrDefaultChart"));
				analysemenu.setChrChart(rs.getString("chrChart"));
				analysemenu.setChrIntroduce(rs.getString("chrIntroduce"));
				analysemenu.setIntCNFR(rs.getInt("intCNFR"));				
				analysemenu.setChrIcon(rs.getString("chrIcon"));
				
				analysemenuInfoList.add(analysemenu);
			}

		} catch (Exception ex) {
			throw ex;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return analysemenuInfoList;
	}
	
	
	public static void main(String[] args){
		AnalyseMenuDAO dao = new AnalyseMenuDAO();
	}
}
