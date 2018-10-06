package com.cnipr.cniprgz.func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.commons.IP2Long;
import com.cnipr.cniprgz.db.DBPoolAccessor;

public class IPLimitFunc {

	/**
	 * 修改ip限制
	 * @param userName
	 * @param ipAddress
	 */
	public void updateIpLimit(String userName,String ipAddress){
		if(ipAddress!=null){
			ipAddress = ipAddress.replace("，", ";");
			ipAddress = ipAddress.replace(",", ";");
			ipAddress = ipAddress.replace("；", ";");
			String[] ipArray = ipAddress.split(";");
			//删除已有信息
			deleteIPAddress(userName);
			for(String ip : ipArray){
				String[] arr = ip.split("-");
				String startIP = null;
				String endIP = null;
				if(arr.length==1){
					startIP = arr[0].trim();
					endIP = arr[0].trim();
				}else if(arr.length>1){
					if(arr[0].trim().equals(arr[1].trim())){
						startIP = arr[0].trim();
						endIP = arr[0].trim();
					}else{
						startIP = arr[0].trim();
						endIP = arr[1].trim();
					}
				}
				//增加修改后的信息
				addIPAddress(userName,startIP,endIP);
			}
			
		}
	}
	
	/**
	 * 删除ip限制信息
	 * @param userName
	 */
	public void deleteIPAddress(String userName){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "delete from ipr_ipaddress where chrUserName=?";
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			int i = ps.executeUpdate();
			System.out.println(i); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
	}
	
	public void addIPAddress(String userName,String startIP,String endIP){
		if(startIP!=null && endIP!=null){
			long start = IP2Long.ipToLong(startIP);
			long end = IP2Long.ipToLong(endIP);
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "insert into ipr_ipaddress(chrUserName,intBeginIP,intEndIP) values(?,?,?)";
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1, userName);
				ps.setLong(2, start);
				ps.setLong(3, end);
				int i = ps.executeUpdate();
				System.out.println(i); 
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBPoolAccessor.closeAll(rs, ps, conn);
			}
		}
	}
}
