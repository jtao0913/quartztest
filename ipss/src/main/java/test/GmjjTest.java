package test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cnipr.cniprgz.db.DBPoolAccessor;

public class GmjjTest {
	
	private static void writelogs(String content){
		try {
//			D:\ben\morningreport
		     File file = new File("F:\\xxx.txt");
		     FileOutputStream fos = new FileOutputStream(file,true);
		     OutputStreamWriter osw = new OutputStreamWriter(fos,"UTF-8");
		     BufferedWriter bw = new BufferedWriter(osw);
		     
		     bw.write(content);
		     bw.newLine();
		     
		     bw.flush();
		     bw.close();
		     osw.close();
		     fos.close();
		}
		catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}

	private static int getParentIDbyID(String _class) {
		int id = 0;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String fieldname = "";
		int intParentID = 0;
		if(_class.length()==1) {
			fieldname = "class_A";
		}else if(_class.length()==2) {
			fieldname = "class_2";
		}else if(_class.length()==3) {
			fieldname = "class_3";
		}else if(_class.length()==4) {
			fieldname = "class_4";
		}

		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select * from ipr_navtable_gmjj where "+fieldname+"='"+_class+"'";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				id = rs.getInt("id");
//				str = "update ipr_gmjj set class_A_show=1 where class_A='"+content+"';";
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
		return id;
	}
	
	public static void main1(String[] args) {
		java.util.LinkedHashMap<String, String> hm_allareacode = new java.util.LinkedHashMap<String,String>();
//		hm_allareacode.put(-1,"请选择...");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int id = 0;
		String class_A = "";
		String class_2 = "";
		String class_3 = "";
		String class_4 = "";
		int intID = 0;
		int intParentID = 0;
		String chrExpression = "";
		String chrCNChannels = "";

		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select * from ipr_navtable_gmjj";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				class_A = rs.getString("class_A");
				class_2 = rs.getString("class_2");
				class_3 = rs.getString("class_3");
				class_4 = rs.getString("class_4");
				
				if(!class_A.equals("")&&class_2.equals("")&&class_3.equals("")&&class_4.equals("")){
					intID=id;
					intParentID=0;
					chrCNChannels="14,15";
					chrExpression="国民经济部="+class_A;
				}else if(!class_A.equals("")&&!class_2.equals("")&&class_3.equals("")&&class_4.equals("")){
					intID=id;
					intParentID=getParentIDbyID(class_A);
					chrCNChannels="14,15";
					chrExpression="国民经济大类="+class_2;
				}else if(!class_A.equals("")&&!class_2.equals("")&&!class_3.equals("")&&class_4.equals("")){
					intID=id;
					intParentID=getParentIDbyID(class_2);
					chrCNChannels="14,15";
					chrExpression="国民经济中类="+class_3;
				}else if(!class_A.equals("")&&!class_2.equals("")&&!class_3.equals("")&&!class_4.equals("")){
					intID=id;
					intParentID=getParentIDbyID(class_3);
					chrCNChannels="14,15";
					chrExpression="国民经济小类="+class_4;
				}				
				
				String str = "update ipr_navtable_gmjj set intID="+intID+",intParentID="+intParentID+","
						+ "chrCNChannels='"+chrCNChannels+"',chrExpression='"+chrExpression+"' where id="+id+";";
				writelogs(str);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}


	}

	public static void main(String[] args) {
		java.util.LinkedHashMap<String, String> hm_allareacode = new java.util.LinkedHashMap<String,String>();
//		hm_allareacode.put(-1,"请选择...");

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int id = 0;
		String class_A = "";
		String class_2 = "";
		String class_3 = "";
		String class_4 = "";
		int intID = 0;
		int intParentID = 0;
		String chrExpression = "";
		String chrCNChannels = "";

		try {
			conn = DBPoolAccessor.getConnection();
			String sql =  "select * from ipr_navtable_gmjj";
			
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				id = rs.getInt("id");
				class_A = rs.getString("class_A");
//				class_2 = rs.getString("class_2");
//				class_3 = rs.getString("class_3");
//				class_4 = rs.getString("class_4");
				
				String ipc = rs.getString("ipc");
				
				if(ipc!=null&&!ipc.equals("")){
					String chrClass = rs.getString("chrClass");
					
					String str = "update ipr_navtable_gmjj set chrExpression='国民经济大类="+chrClass.substring(0, 2)+"' where chrClass='"+chrClass.substring(0, 2)+"';";
					writelogs(str);
					
					str = "update ipr_navtable_gmjj set chrExpression='国民经济中类="+chrClass.substring(0, 3)+"' where chrClass='"+chrClass.substring(0, 3)+"';";
					writelogs(str);
				}				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}


	}

}
