package com.cnipr.cniprgz.dao;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.GMJJModel;

public class GmjjDAO {	
	public int countByDiyParent(String treeType,String parentId,String groupId){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int RecordCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			
/*			if(treeType!=null&&treeType.equals("0")){
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable_ipc where intParentID=?");
			}else{
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable where intParentID=?");
			}*/
			String strSQL = "";
			
			if(parentId!=null&&parentId.equals("0")) {
				strSQL = "select count(*) as RecordCount from ipr_navtable_gmjj where class_2 ='' and class_A_show=1 order by id";
			}else if(parentId!=null&&parentId.length()==1) {
					strSQL = "select count(*) as RecordCount from ipr_navtable_gmjj where class_A ='"+parentId+"' and class_A_show=1 and class_3='' order by id";
			}else if(parentId!=null&&parentId.length()==2) {
					strSQL = "select count(*) as RecordCount from ipr_navtable_gmjj where class_2 ='"+parentId+"' and class_2_show=1 and class_4='' order by id";
			}else if(parentId!=null&&parentId.length()==3) {
					strSQL = "select count(*) as RecordCount from ipr_navtable_gmjj where class_3 ='"+parentId+"' and class_3_show=1 and class_4!='' order by id";
			}
			
			ps = conn.prepareStatement(strSQL);
			
//			ps.setString(1, pid);
			rs = ps.executeQuery();
			if (rs.next()) {
				RecordCount = rs.getInt("RecordCount");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
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
		return RecordCount;
	}	
	
	public List<GMJJModel> getDiyNodeByParent(String parentId,String treeType,String selTrade){
//		int treeType = 0;
		List<GMJJModel> list = null;
		
		String strSQL = "";
		
		if(parentId!=null&&parentId.equals("0")) {
			strSQL = "select * from ipr_navtable_gmjj where class_2 ='' and class_A_show=1 order by id";
		}else 
			if(parentId!=null&&!parentId.equals("0")&&parentId.length()==1) {
				strSQL = "select * from ipr_navtable_gmjj where class_A ='"+parentId+"' and class_2!='' and class_2_show=1 and class_3='' order by id";
		}else 
			if(parentId!=null&&parentId.length()==2) {
				strSQL = "select * from ipr_navtable_gmjj where class_2 ='"+parentId+"' and class_3!='' and class_3_show=1 and class_4='' order by id";
		}else 
			if(parentId!=null&&parentId.length()==3) {
				strSQL = "select * from ipr_navtable_gmjj where class_3 ='"+parentId+"' and class_4!='' order by id";
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			list = new ArrayList<GMJJModel>();
			
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
				GMJJModel node = null;
				node = new GMJJModel();
//				node.setId(rs.getInt("intID")+"");
//				node.setpId(rs.getInt("intParentID")+"");
				node.setName(rs.getString("chrName"));
				
				if(parentId!=null&&parentId.equals("0")) {
//					strSQL = "select * from ipr_gmjj where class_2 ='' order by id";
					node.setId(rs.getString("class_A"));
					node.setpId("0");
				}else 
					if(parentId!=null&&parentId.length()==1) {
//						strSQL = "select * from ipr_gmjj where class_A ='"+parentId+"' and class_3='' order by id";
						node.setId(rs.getString("class_2"));
						node.setpId(rs.getString("class_A"));						
				}else 
					if(parentId!=null&&parentId.length()==2) {
//						strSQL = "select * from ipr_gmjj where class_2 ='"+parentId+"' and class_4='' order by id";
						node.setId(rs.getString("class_3"));
						node.setpId(rs.getString("class_2"));
					}else 
					if(parentId!=null&&parentId.length()==3) {
//						strSQL = "select * from ipr_gmjj where class_3 ='"+parentId+"' and class_4!='' order by id";
						node.setId(rs.getString("class_4"));
						node.setpId(rs.getString("class_3"));
				}				
				list.add(node);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
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
		
		return list;
	}
	
	public static void main(String[] args) {
		HashSet<String> hashset = new HashSet<String>();

		String strSQL = "select * from ipr_navtable_gmjj where (ipc is not null) and ipc!=''";

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
				hashset.add(rs.getString("class_A"));
				hashset.add(rs.getString("class_2"));
				hashset.add(rs.getString("class_3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
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
		
		Iterator<String> it = hashset.iterator();
		 while (it.hasNext()) {
			 String content = it.next();
//		   System.out.println(str);
		   String str = "";
		   
		   if(content.length()==1) {
			   str = "update ipr_navtable_gmjj set class_A_show=1 where class_A='"+content+"';";
		   }
		   if(content.length()==2) {
			   str = "update ipr_navtable_gmjj set class_2_show=1 where class_2='"+content+"';";
		   }
		   if(content.length()==3) {
			   str = "update ipr_navtable_gmjj set class_3_show=1 where class_3='"+content+"';";
		   }
		   
		   writelogs(str);
		 }
	}
	
	public static void writelogs(String content){
		try {
		     File file = new File("D:\\monitor.txt");
		     FileOutputStream fos = new FileOutputStream(file,true);
		     OutputStreamWriter osw = new OutputStreamWriter(fos);
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
}
