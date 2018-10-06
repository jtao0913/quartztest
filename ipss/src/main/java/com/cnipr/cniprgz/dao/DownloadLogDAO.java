package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.cnipph.util.LogStatVO;
import com.cnipr.cniprgz.db.DBPoolAccessor;


public class DownloadLogDAO {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs=null;
	public boolean addDownloadLog(String username,String userid,String time,String type,String area,String number){
		
		boolean is=false;
		String sql="insert into ipr_download_stat(uuid,username,userid,type,visittime,area,number) value(?,?,?,?,?,?,?)";
//		System.out.println(sql);
		UUID uuid=UUID.randomUUID();
		try {
			conn = DBPoolAccessor.getConnection();
//			System.out.println("333::"+conn);
			ps = conn.prepareStatement(sql);
			ps.setString(1, uuid.toString());
			ps.setString(2, username);
			ps.setString(3, userid);
			ps.setString(4, type);
			ps.setString(5, time);
			ps.setString(6, area);
			ps.setString(7, number);
			ps.execute();
			is = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return is;
	}
	
	public int getLogStatCount(String username){
		String sql="select count(*) from ipr_user where 1=1 ";
		if(!"".equals(username)&&username!=null){
			sql+=" and ipr_user.chrUserName='"+username+"' ";
		}
		int a=0;
		try {
			conn=DBPoolAccessor.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				a=rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(ps!=null)ps.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return a;
	}
	
//	public List getAllStat(String fromtime,String totime){
//		String sql="select ";
//	}
	
	public List getLogStat(String currnetPage,String username,String fromtime,String totime){
		String sql="select distinct ipr_user.intUserID,ipr_user.chrUserName from ipr_user left join ipr_download_stat on ipr_user.intUserID=ipr_download_stat.userid where 1=1";
		
		if(!"".equals(username)&&username!=null){
			sql+=" and ipr_user.chrUserName='"+username+"' ";
		}
		
		if((!"".equals(fromtime)&&fromtime!=null)&&(!"".equals(totime)&&totime!=null)){
			sql+=" and (ipr_download_stat.visittime>='"+fromtime+" 00:00:00' and  ipr_download_stat.visittime<='"+totime+" 23:59:59') ";
		}
		
		sql+=" order by ipr_user.intUserID";
		if(currnetPage!=null){
			sql=sql+" LIMIT "+((Integer.parseInt(currnetPage)-1)*10)+","+10;
		}
//		System.out.println(sql);
		List el=new ArrayList();
		try {
			conn=DBPoolAccessor.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				LogStatVO svo=new LogStatVO();
				svo.setUserid(rs.getString("ipr_user.intUserID"));
				svo.setUsername(rs.getString("ipr_user.chrUserName"));
//				svo.setCount1(rs.getString("count1"));
//				svo.setCount2(rs.getString("count2"));
				el.add(svo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(ps!=null)ps.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return el;
	}
	
	public int getUserStat(String userid,String type,String area,String str){
		String sql="select sum(number) from ipr_download_stat where 1=1 ";
		
		if(userid!=null){
			sql+=" and userid="+userid;
		}
		
		if(type!=null){
			sql+=" and type='"+type+"' ";
		}
		
		if(area!=null){
			sql+=" and area='"+area+"' ";
		}
		
		if(str!=null&&!"".equals(str)){
			sql=sql+str;
		}
		System.out.println("数量：："+sql);
		int a=0;
		try {
			conn=DBPoolAccessor.getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()){
				a=rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(ps!=null)ps.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return a;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Long ctime=System.currentTimeMillis();
		Date d1=new Date(ctime);
//		System.out.println(d1);
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		System.out.println(sdf.format(d1));
	}

}
