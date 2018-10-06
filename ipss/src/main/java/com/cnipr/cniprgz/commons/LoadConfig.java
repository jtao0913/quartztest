package com.cnipr.cniprgz.commons;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.ChannelInfo;
import com.cnipr.cniprgz.entity.MenuInfo;

public class LoadConfig {

	public List<MenuInfo> getMenuInfo(String menuIDs) {

		List<MenuInfo> menuinfolist = null;
		
		if (menuIDs != null && !menuIDs.equals("")){
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
	
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement("select chrUserName,chrMenu from ipr_user where chrUserName='admin' or chrUserName='guest'");
//				ps.setInt(1, Integer.parseInt(channelID));
				rs = ps.executeQuery();
				while (rs.next()) {
//					channelInfo = new ChannelInfo();
//					channelInfo.setChrChannelName(rs.getString("chrChannelName"));
//					channelInfo.setChrTRSTable(rs.getString("chrTRSTable"));
//					channelInfo.setIntEnable(rs.getInt("intEnable"));
//					channelInfo.setChrChannelMemo(rs.getString("chrChannelMemo"));
//					channelInfo.setDemo(rs.getString("demo"));
//					channelInfo.setIntChannelID(Integer.parseInt(channelID));
					
					if(rs.getString("chrUserName")!=null&&rs.getString("chrUserName").equals("guest")){
						if(rs.getString("chrMenu")!=null&&!(rs.getString("chrMenu")).equals("")){
							
						}
					}
					
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBPoolAccessor.closeAll(rs, ps, conn);
			}
		}
		
//		List<MenuInfo> menuinfolist = menuFunc.getUserMenu(strMenuIds,request.getParameter("rootId"), request.getParameter("treeType"),autosearch);
		return menuinfolist;
	}
	
}
