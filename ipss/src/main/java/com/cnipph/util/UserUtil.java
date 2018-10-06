package com.cnipph.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserUtil {
	Connection conn=null;
	PreparedStatement stmt = null;
	ResultSet rs=null;
	public List getAllUser(){
		List ul=new ArrayList();
		String sql="select * from user";
		try {
			conn=this.getConnection();
			stmt=conn.prepareStatement(sql);
			rs=stmt.executeQuery();
			String us_pd="";
			while(rs.next()){
				us_pd=rs.getString("name")+"_"+rs.getString("realname");
				ul.add(us_pd);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(stmt!=null)stmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return ul;
	}
	
	public String addUser(List sl){
		String erro="";
		try {
			
			conn=this.getConnection();
			for(int a=0;a<sl.size();a++){
				String sql=sl.get(a)+"";
				try{
					stmt=conn.prepareStatement(sql);
					stmt.execute();
				}catch(Exception er){
					erro=erro+sql+"***";
				}
	    		
	    		
	    	}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(stmt!=null)stmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		return erro;
		
	}
	
	
	public static Connection getConnection() {
		String DB_URL = "jdbc:mysql://localhost:3306/ipss?characterEncoding=UTF-8&useUnicode=TRUE";// "jdbc:oracle:thin:@192.168.3.227:1521:orcl";
		String DB_DRIVER = "com.mysql.jdbc.Driver";// "oracle.jdbc.driver.OracleDriver";
		String DB_USERNAME = "root";// "cnipr1";
		String DB_PASSWORD = "root";// "cnipr1";
		Connection conn = null;
		try {
			Class.forName(DB_DRIVER);
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
