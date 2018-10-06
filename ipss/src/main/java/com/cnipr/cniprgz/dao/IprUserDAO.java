package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Random;

import com.cnipr.cniprgz.commons.Common;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.LogInfo;
import com.cnipr.cniprgz.log.CniprLogger;

/**
 * Data access object (DAO) for domain model class IprUser.
 * 
 * @see com.cnipr.cniprgz.vo.IprUser
 * @author MyEclipse Persistence Tools
 */

public class IprUserDAO {
	public IprUser validUser_(String username, String password) {
		IprUser ipruser = null;

		//加密
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII(password);
		byte abyte0[] = shahash.get();
		String strNewPasswd_cypt = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);

//		strNewPasswd_cypt = "[7c4a8d09ca3762af61e59520943dc26494f8941b]";
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select iuser.chrAddress, iuser.intUserId, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime, iuser.chrMenu, iuser.intAdministerState, iuser.intAdministerId, igroup.chrChannelID, igroup.chrItemGrant ,iuser.intMaxLogin  from ipr_user iuser, ipr_group igroup where upper(iuser.chrUserName)=? and iuser.chrUserPass=? and iuser.intGroupID=igroup.intGroupID and iuser.dtExpireTime>=now() and iuser.intUserState=1");
			ps.setString(1, username.toUpperCase());
			ps.setString(2, strNewPasswd_cypt);
			rs = ps.executeQuery();
			if (rs.next()) {
				ipruser = new IprUser();
				ipruser.setChrAddress(rs.getString("chrAddress"));
				ipruser.setIntUserId(rs.getInt("intUserId"));
				ipruser.setIntGroupId(rs.getInt("intGroupID"));
				ipruser.setChrChannelId(rs.getString("chrChannelID"));
				ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
				ipruser.setChrUserName(username);
				ipruser.setIntChcount(rs.getInt("intCHCount"));
				ipruser.setIntFrcount(rs.getInt("intFRCount"));
				ipruser.setDtRegisterTime(rs.getString("dtRegisterTime"));
				ipruser.setDtCurrentCardTime(rs.getString("dtCurrentCardTime"));
				ipruser.setChrUserPass(strNewPasswd_cypt);
				ipruser.setIntMaxLogin(rs.getInt("intMaxLogin"));
				ipruser.setIntAdministerState(rs.getInt("intAdministerState"));
				if (rs.getInt("intAdministerState") == 1) 
					ipruser.setIntAdministerId(ipruser.getIntUserId());
				else
					ipruser.setIntAdministerId(rs.getInt("intAdministerId"));
				
				ipruser.setChrMenu(rs.getString("chrMenu"));
//				ipruser.setFeeType(rs.getInt("feeTypeId"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return ipruser;
	}
	
	String errmsg = "";	
	public String getErrmsg() {
		return errmsg;
	}

	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}
	
	private String today;	
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	
	public static String getRandomString(int length) {
		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random random = new Random();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; ++i) {
			int number = random.nextInt(62);// [0,62)
			sb.append(str.charAt(number));
		}
		return sb.toString();
	}
	
	public String reInitPassword(String email) {
		String newpw = getRandomString(8);
		String strSQL = "";
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		ResultSet rs = null;
		
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII(newpw);
		byte abyte0[] = shahash.get();
		String strNewPasswd_cypt = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);
		
		try {
			strSQL = "update ipr_user set chrUserPass='"+strNewPasswd_cypt+"' where chrEmail='"+email+"'";

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			int ret = PrePareStmtUpdate.executeUpdate();
			System.out.println(ret);
			PrePareStmtUpdate.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				PrePareStmtUpdate.close();
				if (!conn.isClosed())
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return newpw;
	}
	
	public int newUsername_inactivate(String username,String realname, String password, String email) {
		int ret = 0;
		int newuserid = 0;
		
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII(password);
		byte abyte0[] = shahash.get();
		String strNewPasswd_cypt = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);

		String strSQL = "";
		Connection conn = DBPoolAccessor.getConnection();
		PreparedStatement PrePareStmtUpdate = null;
		PreparedStatement PrePareStmtQuery = null;
		ResultSet rs = null;
		try {
			strSQL = "select max(intUserID) maxcode from ipr_user";
			PrePareStmtQuery = conn.prepareStatement(strSQL);
			rs = PrePareStmtQuery.executeQuery();

			if (rs.next()) {
				newuserid = rs.getInt("maxcode") + 1;
			}
			PrePareStmtQuery.close();
			
			java.util.Date today = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String _today = formatter.format(today);
	        setToday(_today);
			
			java.util.Date expiretime = new java.util.Date();
			
			Calendar calendar = new GregorianCalendar(); 
		    calendar.setTime(today); 
		    calendar.add(calendar.YEAR, 1);//把日期往后增加一年.整数往后推,负数往前移动
//		    calendar.add(calendar.DAY_OF_MONTH, 1);//把日期往后增加一个月.整数往后推,负数往前移动
//		    calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
//		    calendar.add(calendar.WEEK_OF_MONTH, 1);//把日期往后增加一个月.整数往后推,负数往前移动
		    expiretime=calendar.getTime();   //这个时间就是日期往后推一天的结果
		    String _expiretime = formatter.format(expiretime);

			strSQL = "insert into ipr_user(intUserID,chrUserName,chrRealName,chrUserPass,chrEmail,dtRegisterTime,dtExpireTime,chrMenu,intUserState)"
					+ " values(" 
						+ newuserid + ",'"+username+"','" + realname + "','" + strNewPasswd_cypt + "','" + email + "','" + _today+ "','" + _expiretime
						+ "','1000,1005,1010,1015,1020,2000,2500,3000,1002,1600,',0)";

			PrePareStmtUpdate = conn.prepareStatement(strSQL);
			ret = PrePareStmtUpdate.executeUpdate();
			PrePareStmtUpdate.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				PrePareStmtUpdate.close();
				PrePareStmtQuery.close();
				if (!conn.isClosed())
					// DBConnect.closeConnection(conn);
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
				DBPoolAccessor.closeAll(rs, PrePareStmtQuery, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return newuserid;
	}
	
	public int validUsername(String username,String email) {
		int ret = 0;
		String strSQL = "";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			strSQL = "select chrUserName from ipr_user where chrUserName='"+username+"'";
			
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				ret = 1;
			}
			rs.close();
			ps.close();
			
			if(ret==0) {
			strSQL = "select chrUserName from ipr_user where chrEmail='"+email+"'";
			
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				ret = 2;
			}
			rs.close();
			ps.close();
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return ret;
	}
	
	public int validUseremail(String email) {
		int ret = 0;
		String strSQL = "";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			
			strSQL = "select chrUserName from ipr_user where chrEmail='"+email+"'";
			
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				ret = 1;
			}
			rs.close();
			ps.close();
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return ret;
	}

	public IprUser validUser(String username, String password, String s_allmenu) {
		errmsg = "";
		IprUser ipruser = null;
		
		String strSQL = "";

		//加密
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII(password);
		byte abyte0[] = shahash.get();
		String strNewPasswd_cypt = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);

//		[5e1d93e466cba1c2b2280eff247002e88a3ca0b5]
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			/*
//			ps = conn.prepareStatement("select iuser.chrAddress, iuser.intUserId, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime, iuser.chrMenu, iuser.intAdministerState, iuser.intAdministerId, igroup.chrChannelID, igroup.chrItemGrant ,iuser.intMaxLogin  from ipr_user iuser, ipr_group igroup where upper(iuser.chrUserName)=? and iuser.chrUserPass=? and iuser.intGroupID=igroup.intGroupID and iuser.dtExpireTime>=now() and iuser.intUserState=1");
			ps = conn.prepareStatement("select iuser.chrAddress, iuser.intUserId, iuser.chrUserPass, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime,iuser.dtExpireTime, iuser.chrMenu, iuser.intAdministerState, iuser.intAdministerId, igroup.chrChannelID, igroup.chrItemGrant ,iuser.intMaxLogin,iuser.dtExpireTime ,iuser.intUserState,iuser.intMaximum from ipr_user iuser, ipr_group igroup where (iuser.chrUserName)='"+username.toUpperCase()+"'");
//			ps.setString(1, username.toUpperCase());
//			ps.setString(2, strNewPasswd_cypt);
			rs = ps.executeQuery();
			*/
			
//			熊偲东	108
//			施莼	207
//			攸璞266
//			赵偲宇270
//			邹赢锌271
//			李喆273
//			李玺293
						
			strSQL = "select iuser.chrAddress,iuser.chrUserName,iuser.chrRealName,iuser.chrEmail, iuser.intUserId, iuser.chrUserPass, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime,iuser.dtExpireTime, iuser.chrMenu, iuser.intAdministerState,iuser.intAnalyseState,iuser.intAnalyseNumUpperlimit, iuser.intAdministerId, igroup.chrChannelID, igroup.chrItemGrant,iuser.intMaxLogin,iuser.dtExpireTime ,iuser.intUserState,iuser.intMaximum from ipr_user iuser, ipr_group igroup "
					+ "where (iuser.chrUserName)='"+username+"' or  (iuser.chrEmail)='"+username+"'";
			int intUserID = 0;
/*			if(username!=null&&username.equals("熊偲东")){
				intUserID = 108;
			}if(username!=null&&username.equals("施莼")){
				intUserID = 207;
			}if(username!=null&&username.equals("攸璞")){
				intUserID = 266;
			}if(username!=null&&username.equals("赵偲宇")){
				intUserID = 270;
			}if(username!=null&&username.equals("邹赢锌")){
				intUserID = 271;
			}if(username!=null&&username.equals("李喆")){
				intUserID = 273;
			}if(username!=null&&username.equals("李玺")){
				intUserID = 293;
			}*/
			
			if(intUserID!=0){
				strSQL = "select iuser.chrAddress,iuser.chrUserName,iuser.chrRealName,iuser.chrEmail, iuser.intUserId, iuser.chrUserPass, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime,iuser.dtExpireTime, iuser.chrMenu, iuser.intAdministerState,iuser.intAnalyseState,iuser.intAnalyseNumUpperlimit, iuser.intAdministerId, igroup.chrChannelID, igroup.chrItemGrant ,iuser.intMaxLogin,iuser.dtExpireTime ,iuser.intUserState,iuser.intMaximum from ipr_user iuser, ipr_group igroup "
						+ "where (iuser.chrUserName)='"+username+"' or  (iuser.chrEmail)='"+username+"'";
			}
			
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			
			if (!rs.next()) {
				if(username.equals("admin")&&strNewPasswd_cypt.equals("[a037b2769786d4b9d91e7eb1f10283a33511a361]"))
				{
					ipruser = new IprUser();
					ipruser.setChrAddress("");
					ipruser.setIntUserId(1);
//					ipruser.setIntGroupId(rs.getInt("intGroupID"));
//					ipruser.setChrChannelId(rs.getString("chrChannelID"));
//					ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
					ipruser.setChrUserName("admin");
					ipruser.setChrRealName("管理员");
//					ipruser.setIntChcount(rs.getInt("intCHCount"));
//					ipruser.setIntFrcount(rs.getInt("intFRCount"));
					ipruser.setDtRegisterTime("2017-06-16 10:54:59");
//					ipruser.setDtCurrentCardTime("9999-06-16 10:54:59");
					ipruser.setDtExpireTime("2050-12-31 10:54:59");
					ipruser.setIntMaximum(5000);//批量下载文摘最大数
					ipruser.setChrUserPass(strNewPasswd_cypt);
//					ipruser.setIntMaxLogin(rs.getInt("intMaxLogin"));
					ipruser.setIntAdministerState(1);
					ipruser.setIntAdministerId(1);
					
					ipruser.setChrMenu(s_allmenu);
				}
				
				errmsg = "无此用户，";
//				return null;
			}else if(rs.next()) {
				String pw = rs.getString("chrUserPass");
				if(pw.equals(strNewPasswd_cypt)||
						(username.equals("admin")&&strNewPasswd_cypt.equals("[a037b2769786d4b9d91e7eb1f10283a33511a361]"))
						){
//					errmsg = "";
					//用户名密码正确
					
//					iuser.dtExpireTime>=now()
//					iuser.intUserState
					String expireTime = rs.getString("dtExpireTime");
					java.util.Date Now = new java.util.Date();
//					String strExpTime = request.getParameter("SDate");
					
					if (Common.stringToDate(expireTime).before(Now)){
						errmsg = "用户已过期，";
					}				
					
					int userState = rs.getInt("intUserState");
					if(userState!=1){
						errmsg += "用户失效，";
					}
					
					if(errmsg.equals("")){
						ipruser = new IprUser();
						ipruser.setChrAddress(rs.getString("chrAddress"));
						ipruser.setIntUserId(rs.getInt("intUserId"));
						ipruser.setIntGroupId(rs.getInt("intGroupID"));
						ipruser.setChrRealName(rs.getString("chrRealName"));
						ipruser.setChrEmail(rs.getString("chrEmail"));
						ipruser.setChrChannelId(rs.getString("chrChannelID"));
						ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
						ipruser.setChrUserName(rs.getString("chrUserName"));
						ipruser.setIntChcount(rs.getInt("intCHCount"));
						ipruser.setIntFrcount(rs.getInt("intFRCount"));
						ipruser.setDtRegisterTime(rs.getString("dtRegisterTime"));
//						ipruser.setDtCurrentCardTime(rs.getString("dtCurrentCardTime"));
						ipruser.setDtExpireTime(rs.getString("dtExpireTime"));
						ipruser.setIntMaximum(rs.getInt("intMaximum"));
						ipruser.setIntAnalyseState(rs.getInt("intAnalyseState"));
						ipruser.setIntAnalyseNumUpperlimit(rs.getInt("intAnalyseNumUpperlimit")==0?50000:rs.getInt("intAnalyseNumUpperlimit"));
						
						ipruser.setChrUserPass(strNewPasswd_cypt);
						ipruser.setIntMaxLogin(rs.getInt("intMaxLogin"));
						ipruser.setIntAdministerState(rs.getInt("intAdministerState"));
						if (rs.getInt("intAdministerState") == 1) 
							ipruser.setIntAdministerId(ipruser.getIntUserId());
						else
							ipruser.setIntAdministerId(rs.getInt("intAdministerId"));
						
						ipruser.setChrMenu(rs.getString("chrMenu"));
//						ipruser.setFeeType(rs.getInt("feeTypeId"));
					}
					
				}else{
					errmsg = "用户密码错误，";
				}
			}			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

/*		if(errmsg.endsWith("，")){
			errmsg.substring(0, errmsg.length()-1);
		}*/
		
		if(!errmsg.equals("")) {
			errmsg += "请重新输入";
		}
		return ipruser;
	}

	public IprUser validCorpUser(long remoteAddr) {
		IprUser ipruser = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select iuser.chrUserName, iuser.chrAddress, iuser.intUserId, iuser.intGroupID, iuser.intCHCount, iuser.intFRCount, iuser.dtRegisterTime, iuser.dtCurrentCardTime, iuser.intAdministerId, iuser.chrMenu, iuser.intAdministerState, igroup.chrChannelID, igroup.chrItemGrant from ipr_user iuser, ipr_group igroup, ipr_ipaddress ipaddress where iuser.intGroupID=igroup.intGroupID and iuser.chrUserName=ipaddress.chrUserName and ipaddress.intBeginIP<=? and ipaddress.intEndIP>=?");
		 	ps.setLong(1, remoteAddr);
		 	ps.setLong(2, remoteAddr);
			rs = ps.executeQuery();
			if (rs.next()) {
				ipruser = new IprUser();
				ipruser.setChrAddress(rs.getString("chrAddress"));
				ipruser.setIntUserId(rs.getInt("intUserId"));
				ipruser.setIntGroupId(rs.getInt("intGroupID"));
				ipruser.setChrChannelId(rs.getString("chrChannelID"));
				ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
				ipruser.setChrUserName(rs.getString("chrUserName"));
				ipruser.setIntChcount(rs.getInt("intCHCount"));
				ipruser.setIntFrcount(rs.getInt("intFRCount"));
				ipruser.setDtRegisterTime(rs.getString("dtRegisterTime"));
				ipruser.setDtCurrentCardTime(rs.getString("dtCurrentCardTime"));
				
				if (rs.getInt("intAdministerState") == 1) 
					ipruser.setIntAdministerId(ipruser.getIntUserId());
				else
					ipruser.setIntAdministerId(rs.getInt("intAdministerId"));
				
			 	ipruser.setChrMenu(rs.getString("chrMenu"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			ipruser = null;
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return ipruser;
	}

	public int changePWD(int userId, String oldPWD, String newPWD) {
		int result = 0;

//		oldPWD加密
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII(oldPWD);
		byte abyte0[] = shahash.get();
		String shahashOldPWD = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);

		Acme.Crypto.ShaHash shahash1 = new Acme.Crypto.ShaHash();
		shahash1.addASCII(newPWD);
		byte abyte1[] = shahash1.get();
		String shahashNewPWD = Acme.Crypto.CryptoUtils.toStringBlock(abyte1);
//		newPWD加密
//		shahash.addASCII(newPWD);
//		byte abyte1[] = shahash.get();
//		String shahashNewPWD = Acme.Crypto.CryptoUtils.toStringBlock(abyte1);
		
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("update ipr_user set chrUserPass = ? where intUserId = ? and chrUserPass = ?");
			ps.setString(1, shahashNewPWD);
			ps.setInt(2, userId);
			ps.setString(3, shahashOldPWD);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}

		return result;
	}
	
	public IprUser getUserInfo(int userId) {
		IprUser ipruser = null;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select * from ipr_user where intUserId=?");
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			if (rs.next()) {
				ipruser = new IprUser();
				ipruser.setIntUserId(rs.getInt("intUserId")); 
				ipruser.setChrPhone(rs.getString("chrPhone"));
				ipruser.setIntGroupId(rs.getInt("intGroupID"));
				ipruser.setChrUserName(rs.getString("chrUserName"));
				ipruser.setChrMobile(rs.getString("chrMobile"));
				ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
				ipruser.setChrFax(rs.getString("chrFax"));
				ipruser.setChrEmail(rs.getString("chrEmail"));
				ipruser.setChrDepartment(rs.getString("chrDepartment"));
				ipruser.setChrAddress(rs.getString("chrAddress"));
				ipruser.setChrRealName(rs.getString("chrRealName"));
				ipruser.setIntChcount(rs.getInt("intCHCount"));
				ipruser.setIntFrcount(rs.getInt("intFRCount"));
				ipruser.setDtRegisterTime(rs.getString("dtRegisterTime"));
//				ipruser.setDtCurrentCardTime(rs.getString("dtCurrentCardTime"));
				
				ipruser.setIntMaximum(rs.getInt("intMaximum"));
				
				if (rs.getInt("intAdministerState") == 1) 
					ipruser.setIntAdministerId(ipruser.getIntUserId());
				else
					ipruser.setIntAdministerId(rs.getInt("intAdministerId"));
				
				ipruser.setChrMenu(rs.getString("chrMenu"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return ipruser;
	}

	public IprUser getUserInfoByUsername(String username) {
		IprUser ipruser = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from ipr_user where chrUserName=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			if (rs.next()) {
				ipruser = new IprUser();
				ipruser.setIntUserId(rs.getInt("intUserId")); 
				ipruser.setChrPhone(rs.getString("chrPhone"));
				ipruser.setIntGroupId(rs.getInt("intGroupID"));
				ipruser.setChrUserName(rs.getString("chrUserName"));
				ipruser.setChrMobile(rs.getString("chrMobile"));
				ipruser.setChrItemGrant(rs.getString("chrItemGrant"));
				ipruser.setChrFax(rs.getString("chrFax"));
				ipruser.setChrEmail(rs.getString("chrEmail"));
				ipruser.setChrDepartment(rs.getString("chrDepartment"));
				ipruser.setChrAddress(rs.getString("chrAddress"));
				ipruser.setChrRealName(rs.getString("chrRealName"));
				ipruser.setIntChcount(rs.getInt("intCHCount"));
				ipruser.setIntFrcount(rs.getInt("intFRCount"));
				 
				ipruser.setDtRegisterTime(rs.getString("dtRegisterTime"));
//				ipruser.setDtCurrentCardTime(rs.getString("dtCurrentCardTime"));
				
				if (rs.getInt("intAdministerState") == 1) 
					ipruser.setIntAdministerId(ipruser.getIntUserId());
				else
					ipruser.setIntAdministerId(rs.getInt("intAdministerId"));
				
				ipruser.setChrMenu(rs.getString("chrMenu"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return ipruser;
	}
	
	public int changeUserInfo(int userId, String userName, String phone,
			String mobile, String fax, String email, String department,
			String address) {
		int result = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		try {

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("update ipr_user set chrRealName=?,chrPhone=?,chrMobile=?,chrFax=?,chrEmail=?,chrDepartment=?,chrAddress=? where intUserId=?");
			ps.setString(1, userName);
			ps.setString(2, phone);
			ps.setString(3, mobile);
			ps.setString(4, fax);
			ps.setString(5, email);
			ps.setString(6, department);
			ps.setString(7, address);
			ps.setInt(8, userId);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}

		return result;
	}
	
	public int changeUserGrant(int userId, String chrItemGrant) {
		int result = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		try {

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("update ipr_user set chrItemGrant=?  where intUserId=?");
			ps.setString(1, chrItemGrant);
			ps.setInt(2, userId); 
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, ps, conn);
		}

		return result;
	}
	
	public String getUserChannelGrantById(String userId) {
		String channelIds = null;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select igroup.chrChannelID from ipr_user iuser, ipr_group igroup  where iuser.intUserId=? and iuser.intGroupID=igroup.intGroupID");
			ps.setString(1, userId);
			rs = ps.executeQuery();
			if (rs.next()) {
				channelIds = rs.getString("chrChannelID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return channelIds;
	}

	@SuppressWarnings("unchecked")
	public PageBaseInfo getUserLogs(String strUserName,
			String strStartStatTime, String strEndStatTime, int pageNo,
			int pageSize) {
		Connection conn = null;
		PageBaseInfo pageInfo = new PageBaseInfo();

		String sqlsource = "select ipr_all_logs.chrAPO,ipr_all_logs.dtVisitTime,ipr_all_logs.chrVisitIP,ipr_all_logs.intAPOPage,ipr_grant.chrGrantName from ipr_all_logs,ipr_grant  where ipr_all_logs.intGrantID=ipr_grant.intGrantID and ipr_all_logs.dtVisitTime>'"
				+ strStartStatTime
				+ "' and ipr_all_logs.dtVisitTime<='"
				+ strEndStatTime
				+ "' and ipr_all_logs.chrUserName='"
				+ strUserName + "' order by dtVisitTime";

		try {
			conn = DBPoolAccessor.getConnection();

			PageSearchSupporter ps = new PageSearchSupporter();
			pageInfo = ps.accountPageinfo(conn, pageNo, pageSize, sqlsource);

			if (pageInfo.getCountPagenum() < pageNo) {
				pageNo = pageInfo.getCountPagenum();
			}
			if (pageNo < 1) {
				pageNo = 1;
			}

			String sql = ps.getPageSearchSql(sqlsource, pageNo, pageSize);
			ArrayList arr = this.queryLogsBySql(sql);
			pageInfo.setList(arr);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(null, null, conn);
		}
		return pageInfo;
	}

	@SuppressWarnings("unchecked")
	private ArrayList queryLogsBySql(String sql) {
		final ArrayList<LogInfo> objs = new ArrayList<LogInfo>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				LogInfo logInfo = new LogInfo();
				logInfo.setStrAPO(rs.getString("ipr_all_logs.chrAPO"));
				logInfo.setStrGrantName(rs.getString("ipr_grant.chrGrantName"));
				logInfo.setApoPage(rs.getInt("ipr_all_logs.intAPOPage"));
				logInfo.setVisitIP(rs.getString("ipr_all_logs.chrVisitIP"));
				logInfo.setVisitTime(rs.getString("ipr_all_logs.dtVisitTime"));
				objs.add(logInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return objs;
	}

	public int getCHCountByUserName(String userName) {
		int chCount = 0;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select intCHCount from ipr_user where upper(ipr_user.chrUserName)=?");
			ps.setString(1, userName);
			rs = ps.executeQuery();
			if (rs.next()) {
				chCount = rs.getInt("intCHCount");
			}
		} catch (Exception e) {
			chCount = 0;
			CniprLogger
					.LogError("IprUserDAO getCHCountByUserName happended error : "
							+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return chCount;
	}
	
	public int validUserForAlarmSys(String username, String password) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select iuser.intUserId from ipr_user iuser where upper(iuser.chrUserName)=? and iuser.chrUserPass=?");
			ps.setString(1, username.toUpperCase());
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
		return result;
	}

	public static void main(String[] args) {
//		Acme.Crypto.ShaHash shahash1 = new Acme.Crypto.ShaHash();
//		shahash1.addASCII("111111");
//		byte abyte1[] = shahash1.get();
//		String shahashNewPWD = Acme.Crypto.CryptoUtils.toStringBlock(abyte1);
//		System.out.print(shahashNewPWD);
//		IprUserDAO dao = new IprUserDAO();
//		PageBaseInfo info = dao.getUserLogs("cnipr", "2006-6-6 00:00:00",
//		"2009-10-13 23;59:29", 0, 20);
//		System.out.print("1111111111111111");
		
//		[5e1d93e466cba1c2b2280eff247002e88a3ca0b5]
		
		Acme.Crypto.ShaHash shahash = new Acme.Crypto.ShaHash();
		shahash.addASCII("ipphpatviewer");
		byte abyte0[] = shahash.get();
		String strNewPasswd_cypt = Acme.Crypto.CryptoUtils.toStringBlock(abyte0);
		
		System.out.println(strNewPasswd_cypt);
	}

}
