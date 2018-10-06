package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.commons.Util;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.ChannelInfo;

public class ChannelDAO {
	public ChannelInfo getChannelInfoByID(String channelID) throws Exception{
		ChannelInfo channelInfo = null;
		if (channelID != null && !channelID.equals("")){
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
	
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement("select chrChannelName,chrTRSTable,chrChannelMemo,intEnable,demo,chrCheck,chrIndexCheck from ipr_channel where intChannelID = ? or chrTRSTable = ?");
				
				//Util.isNumeric
				if(Util.isNumeric(channelID)){
					ps.setInt(1, Integer.parseInt(channelID));
				}else{
					ps.setInt(1, 0);
				}
				ps.setString(2, channelID);
				
				rs = ps.executeQuery();
				if (rs.next()) {
					channelInfo = new ChannelInfo();
					channelInfo.setChrChannelName(rs.getString("chrChannelName"));
					channelInfo.setChrTRSTable(rs.getString("chrTRSTable"));
					channelInfo.setIntEnable(rs.getInt("intEnable"));
					channelInfo.setChrChannelMemo(rs.getString("chrChannelMemo"));
					channelInfo.setDemo(rs.getString("demo"));
					channelInfo.setIntChannelID(Integer.parseInt(channelID));
				}
	
			} catch (Exception e) {
//				e.printStackTrace();
				throw e;
			} finally {
				DBPoolAccessor.closeAll(rs, ps, conn);
			}
		}
		return channelInfo;
	}

	public List<ChannelInfo> getChannels(String area) {
		List<ChannelInfo> channelInfoList = new ArrayList<ChannelInfo>();

		int intChannelType = 0;
		
		if (area.equalsIgnoreCase("fr")) {
			intChannelType = 1;
		} else if (area.equalsIgnoreCase("cn")) {
			intChannelType = 0;
		} else if (area.equalsIgnoreCase("sx")) {
			intChannelType = 2;
		}else if(area.equalsIgnoreCase("all"))
		{
			intChannelType = -1;
		}
		else {
			intChannelType = 2;
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select intChannelID,chrTRSTable,chrChannelName,chrCheck,chrIndexCheck,intContinent,intEnable,chrChannelMemo,demo from ipr_channel " +
						"where intChannelType = ? and intEnable = 1 order by intChannelID";
			
			if(intChannelType==-1)
					sql =  "select intChannelID,chrTRSTable,chrChannelName,chrCheck,chrIndexCheck,intContinent,intEnable,chrChannelMemo,demo from ipr_channel " +
						"where intEnable = 1 order by intChannelID";
			
			ps = conn.prepareStatement(sql);
			if(intChannelType != -1){
				ps.setInt(1, intChannelType);
			}
			
			rs = ps.executeQuery();
			while (rs.next()) {
				ChannelInfo channelInfo = new ChannelInfo();
				channelInfo.setIntChannelID(rs.getInt("intChannelID"));
				channelInfo.setChrTRSTable(rs.getString("chrTRSTable"));
				channelInfo.setChrChannelCode((rs.getString("chrTRSTable").toUpperCase()).replace(",", "").replace("PATENT", ""));				
				
				channelInfo.setChrChannelName(rs.getString("chrChannelName"));
				channelInfo.setChrCheck(rs.getString("chrCheck"));
				channelInfo.setChrIndexCheck(rs.getString("chrIndexCheck"));
				channelInfo.setIntContinent(rs.getInt("intContinent"));				
				channelInfo.setIntEnable(rs.getInt("intEnable"));
				channelInfo.setChrChannelMemo(rs.getString("chrChannelMemo"));
				channelInfo.setDemo(rs.getString("demo"));
				channelInfoList.add(channelInfo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return channelInfoList;
	}
	
	
 
	
	
	public String getEnableChannelIds(String area) {

		String strChannel = "";

		int intChannelType = 0;

		if (!area.equalsIgnoreCase("cn")) {
			intChannelType = 1;
		}

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select intChannelID,chrChannelName,chrCheck from ipr_channel where intChannelType = ? and intEnable = 1");
			ps.setInt(1, intChannelType);
			rs = ps.executeQuery();
			while (rs.next()) {
				strChannel += rs.getInt("intChannelID") + ",";
			}
            
			if (strChannel != null && !strChannel.equals(""))
				strChannel = strChannel.substring(0, strChannel.length() - 1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return strChannel;
	}

	public String getChannelsIDByName(String channelsName) {
		String[] channelNameArray =  channelsName.split(",");
		
		String sql = "select intChannelID from ipr_channel where ";
		for (String channel : channelNameArray){
			sql += " chrTRSTable like '%" + channel + "%' or ";
		}
		sql = sql.substring(0, sql.length() - 3);
		
		ArrayList<Integer> channelIdList = new ArrayList<Integer>();
		String strChannelIDs = "";
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				channelIdList.add(rs.getInt("intChannelID"));
			}

			for(Integer channelID : channelIdList) {
				strChannelIDs += channelID + ",";
			}
			strChannelIDs = strChannelIDs.substring(0, strChannelIDs.length() - 1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
		return strChannelIDs;
	}
	
	
	public int changeMemo(int channelId, String Memo) {
		int result = 0; 

		Connection conn = null;
		PreparedStatement ps = null;
		try {

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("update ipr_channel set chrChannelMemo = ? where intChannelID = ?");
			ps.setString(1, Memo);
			ps.setInt(2, channelId); 
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}

		return result;
	}

	
	public int changeDemo(int channelId, String demo) {
		int result = 0; 

		Connection conn = null;
		PreparedStatement ps = null;
		try {

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("update ipr_channel set demo = ? where intChannelID = ?");
			ps.setString(1, demo);
			ps.setInt(2, channelId); 
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}

		return result;
	}
	
	
	public String getEnablechrTRSTables(String area) {

		String strChannel = "";

		int intChannelType = 0;

		if (!area.equalsIgnoreCase("cn")) {
			intChannelType = 1;
		}

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select chrTRSTable from ipr_channel where intChannelType = ?");
			ps.setInt(1, intChannelType);
			rs = ps.executeQuery();
			while (rs.next()) {
				strChannel += rs.getString("chrTRSTable") + ",";
			}
            
			if (strChannel != null && !strChannel.equals(""))
				strChannel = strChannel.substring(0, strChannel.length() - 1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return strChannel;
	}
	
	public static void main(String[] args){
		ChannelDAO dao = new ChannelDAO();
		System.out.print(dao.getChannelsIDByName("fmzl_ab,fmzl_ft,twzl,fmzl_sx"));
	}
}
