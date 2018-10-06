package com.cnipr.cniprgz.dao;

import java.io.Reader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.StringTools;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.FavoriteInfo;
import com.cnipr.cniprgz.entity.NameId;
import com.cnipr.cniprgz.entity.NodeModel;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class NodeDAO {	
	public int countByDiyParent(String treeType,int pid,String groupId){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int RecordCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			
			if(treeType!=null&&treeType.equals("0")){
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable_ipc where intParentID=?");
			}else if(treeType!=null&&treeType.equals("4")){
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable_gmjj where intParentID=?");
			}else if(treeType!=null&&treeType.equals("5")){
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_address where intParentID=?");
			}else if (treeType != null && treeType.equals("6")) {
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable_gd where intParentID=?");
			}else{
				ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable where intParentID=?");
			}
			
//			ps = conn.prepareStatement("select count(*) as RecordCount from ipr_navtable where intParentID=?");
			
			ps.setInt(1, pid);
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
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return RecordCount;
	}
	
	public static String getchrNameById(int id) {
		String chrName="";
		String sql="select chrName from ipr_navtable_gd where intID="+id;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				chrName=rs.getString("chrName");
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
		return chrName;
	}
	
	public static Map<String, String> getImageDate(){
		Map<String, String> images=new HashMap<>();
		String sql="select * from report_gd_image";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Reader reader=rs.getCharacterStream("date");
				char date[]=new char[262140];
				while((reader.read(date)) != -1) {
				}
				reader.close();
				String dd=new String(date);
				images.put(rs.getString("id"), dd);
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
		return images;
	}
	
	public static boolean updateImage(String date,String id) {
		boolean result=true;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("update report_gd_image set date=? where id=?");
			ps.setString(1, date);
			ps.setString(2, id);
			if (ps.executeUpdate() != 1)
				result = false;
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
		return result;
	}
	
	public List<NodeModel> getDiyNodeByParent111111111(int parentId,String treeType,String selTrade){
//		int treeType = 0;
		List<NodeModel> list = null;

		String strSQL = "select * from ipr_navtable where intParentID = "
						+ parentId + " and intType = " + treeType + " order by intSequenceNum";
		
		if(treeType!=null&&treeType.equals("0")){
			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("4")){
			strSQL = "select * from ipr_navtable_gmjj where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("5")){
			strSQL = "select * from ipr_address where intParentID = " + parentId + "";
		}
		
		String _strSQL = "";
		
		if(parentId==0
				||treeType!=null&&treeType.equals("5")&&(selTrade+"$").indexOf(parentId+"$")==-1
				){
			if(selTrade!=null&&!selTrade.trim().equals("")){
				String[] arrSelTrade = selTrade.split("[$]");
				
				for(int i=0;i<arrSelTrade.length&&!arrSelTrade[i].trim().equals("");i++){
					_strSQL+=" intID="+arrSelTrade[i]+ " or ";
				
				}
			}
			if(_strSQL.lastIndexOf(" or ")>-1){
				_strSQL = " and ("+_strSQL.substring(0, _strSQL.length()-4) + ")";
			}
		}
		
		strSQL = "select * from ipr_navtable where intParentID = " + parentId + " and intType = " + treeType + _strSQL +" order by intSequenceNum";
		
		if(treeType!=null&&treeType.equals("0")){
//			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " " + _strSQL +" order by chrClass";
			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("4")){
			strSQL = "select * from ipr_navtable_gmjj where intParentID = " + parentId + " and (class_A_show!='' or class_2_show!=''"
					+ " or class_3_show!='') "
					+ " order by chrClass";
			
/*			if(parentId==0) {
				strSQL = "select * from ipr_navtable_gmjj where  intParentID = " + parentId + " and class_2 ='' and class_A_show=1 order by id";
			}else 
				if(parentId!=null&&!parentId.equals("0")&&parentId.length()==1) {
					strSQL = "select * from ipr_navtable_gmjj where  intParentID ="+parentId+" and class_2!='' and class_2_show=1 and class_3='' order by id";
			}else
				if(parentId!=null&&parentId.length()==2) {
					strSQL = "select * from ipr_navtable_gmjj where   intParentID ="+parentId+" and class_3!='' and class_3_show=1 and class_4='' order by id";
			}else 
				if(parentId!=null&&parentId.length()==3) {
					strSQL = "select * from ipr_navtable_gmjj where intParentID ="+parentId+" and class_4!='' order by id";
			}*/
			
		}else if(treeType!=null&&treeType.equals("5")){
			strSQL = "select * from ipr_address where intParentID = " + parentId ;
//			if(parentId==0)
			if(!_strSQL.equals(""))
			{
//				strSQL += " and intID="+selTrade;
			}
		} else if (treeType != null && treeType.equals("6")) {
			strSQL = "select * from ipr_navtable_gd where intParentID = " + parentId;
			// if(parentId==0)
			if (!_strSQL.equals("")) {
				// strSQL += " and intID="+selTrade;
			}
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			list = new ArrayList<NodeModel>();
			
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
//				FavoriteInfo favoriteInfo = new FavoriteInfo();
//				favoriteInfo.setIndex(++i);
//				favoriteInfo.setId(rs.getInt("id"));
//				favoriteInfo.setChrAPO(rs.getString("chrAPO"));
//				favoriteInfo.setChrTI(rs.getString("chrTI"));
//				favoriteInfo.setChrChannelID(rs.getString("chrChannelID"));
//				favoriteInfo.setIntCountry(rs.getInt("intCountry"));
//				favoriteInfoList.add(favoriteInfo);
				
				NodeModel node = null;
				node = new NodeModel();
				node.setId(rs.getInt("intID"));
				node.setpId(rs.getInt("intParentID")+"");
				node.setName(rs.getString("chrName"));
				node.setClassname(rs.getString("chrClass"));
				node.setExpl(rs.getString("chrExpression"));
				node.setCnTrsExp(rs.getString("chrExpression"));
				node.setCnTrsTable(rs.getString("chrCNChannels"));				
				node.setSxTrsTable(rs.getString("chrSXChannels"));
				node.setCnTrsOption(0);
				node.setEnTrsExp(rs.getString("chrFRExpression"));
				node.setEnTrsTable(rs.getString("chrFRChannels"));
				node.setEnTrsOption(0);
				node.setGroupId("GROUPGUESST");
				
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
	
	//根据id查询标签
		public String getintIDById(int intParentID){
//			String strSQL = "select intID from ipr_navtable_gd where intParentID = " + intParentID;
			String strSQL = "select s_intID from ipr_navtable_gd where intID = " + intParentID;
			
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String intID="";
			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement(strSQL);
				rs = ps.executeQuery();
				int i = 0;
				while (rs.next()) {
					intID=rs.getString("s_intID");
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
			return intID;
		}
	
	//根据父id查询子ID以及标签和行业名称
	public List<NameId> getNameByParentId(int intParentID){
		String strSQL = "select chrName,chrExpression,Id from ipr_navtable_gd where intParentID = " + intParentID;
		List<NameId> nameIds=new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			nameIds = new ArrayList<NameId>();
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
				NameId nameId = null;
				nameId = new NameId();
				nameId.setChrName(rs.getString("chrName"));
				nameId.setChrExpression(rs.getString("chrExpression"));
				nameId.setId(rs.getInt("Id"));
				nameIds.add(nameId);
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
		return nameIds;
	}
	
	public List<NodeModel> getByParent(int parentId, String treeType, String selTrade){
		String strSQL = "select * from ipr_navtable_gd where intParentID = " + parentId;
		List<NodeModel> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			list = new ArrayList<NodeModel>();
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
				NodeModel node = null;
				node = new NodeModel();
				node.setId(rs.getInt("intID"));
				node.setpId(rs.getInt("intParentID") + "");
				node.setName(rs.getString("chrName"));
				node.setClassname(rs.getString("chrClass"));
				node.setExpl(rs.getString("chrExpression"));
				node.setCnTrsExp(rs.getString("chrExpression"));
				node.setCnTrsTable("14,15,16");
				//node.setCnTrsTable(rs.getString("chrCNChannels"));
				node.setSxTrsTable(rs.getString("chrSXChannels"));
				node.setCnTrsOption(0);
				node.setEnTrsExp(rs.getString("chrFRExpression"));
				//node.setEnTrsTable(rs.getString("chrFRChannels"));
				node.setEnTrsTable("18,19,20,21,22,23,24,25");
				node.setEnTrsOption(0);
				node.setGroupId("GROUPGUESST");
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
	
	public List<NodeModel> getDiyNodeByParent(int parentId,String treeType,String selTrade){
		List<NodeModel> list = null;

/*		String strSQL = "select * from ipr_navtable where intParentID = "
						+ parentId + " and intType = " + treeType + " order by intSequenceNum";*/
		
		String strSQL = "select * from ipr_navtable where intParentID = "
				+ parentId + " and intType = " + treeType + " order by intID";
		
		if(treeType!=null&&treeType.equals("0")){
			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("4")){
			strSQL = "select * from ipr_navtable_gmjj where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("5")){
			strSQL = "select * from ipr_address where intParentID = " + parentId + "";
		}
		
		String _strSQL = "";
		
		if(parentId==0
				||treeType!=null&&treeType.equals("5")&&(selTrade+"$").indexOf(parentId+"$")==-1)
		{
			if(selTrade!=null&&!selTrade.trim().equals("")){
				String[] arrSelTrade = selTrade.split("[$]");
				
				for(int i=0;i<arrSelTrade.length&&!arrSelTrade[i].trim().equals("");i++){
					_strSQL+=" intID="+arrSelTrade[i]+ " or ";
				
				}
			}
			if(_strSQL.lastIndexOf(" or ")>-1){
				_strSQL = " and ("+_strSQL.substring(0, _strSQL.length()-4) + ")";
			}
		}
		
		strSQL = "select * from ipr_navtable where intParentID = " + parentId + " and intType = " + treeType + _strSQL +" order by intID";
		
		if(treeType!=null&&treeType.equals("0")){
//			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " " + _strSQL +" order by chrClass";
			strSQL = "select * from ipr_navtable_ipc where intParentID = " + parentId + " order by chrClass";
		}else if(treeType!=null&&treeType.equals("4")){
			strSQL = "select * from ipr_navtable_gmjj where intParentID = " + parentId + " and (class_A_show!='' or class_2_show!=''"
					+ " or class_3_show!='') "
					+ " order by chrClass";
			
/*			if(parentId==0) {
				strSQL = "select * from ipr_navtable_gmjj where  intParentID = " + parentId + " and class_2 ='' and class_A_show=1 order by id";
			}else 
				if(parentId!=null&&!parentId.equals("0")&&parentId.length()==1) {
					strSQL = "select * from ipr_navtable_gmjj where  intParentID ="+parentId+" and class_2!='' and class_2_show=1 and class_3='' order by id";
			}else
				if(parentId!=null&&parentId.length()==2) {
					strSQL = "select * from ipr_navtable_gmjj where   intParentID ="+parentId+" and class_3!='' and class_3_show=1 and class_4='' order by id";
			}else 
				if(parentId!=null&&parentId.length()==3) {
					strSQL = "select * from ipr_navtable_gmjj where intParentID ="+parentId+" and class_4!='' order by id";
			}*/
			
		}else if(treeType!=null&&treeType.equals("5")){
			strSQL = "select * from ipr_address where intParentID = " + parentId ;
//			if(parentId==0)
			if(!_strSQL.equals(""))
			{
//				strSQL += " and intID="+selTrade;
			}
		}
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			list = new ArrayList<NodeModel>();
			
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(strSQL);
			rs = ps.executeQuery();
			int i = 0;
			while (rs.next()) {
//				FavoriteInfo favoriteInfo = new FavoriteInfo();
//				favoriteInfo.setIndex(++i);
//				favoriteInfo.setId(rs.getInt("id"));
//				favoriteInfo.setChrAPO(rs.getString("chrAPO"));
//				favoriteInfo.setChrTI(rs.getString("chrTI"));
//				favoriteInfo.setChrChannelID(rs.getString("chrChannelID"));
//				favoriteInfo.setIntCountry(rs.getInt("intCountry"));
//				favoriteInfoList.add(favoriteInfo);
				
				NodeModel node = null;
				node = new NodeModel();
				node.setId(rs.getInt("intID"));
				node.setpId(rs.getInt("intParentID")+"");
				node.setName(rs.getString("chrName"));
				node.setClassname(rs.getString("chrClass"));
				node.setExpl(rs.getString("chrExpression"));
				node.setCnTrsExp(rs.getString("chrExpression"));
				node.setCnTrsTable(rs.getString("chrCNChannels"));				
				node.setSxTrsTable(rs.getString("chrSXChannels"));
				node.setCnTrsOption(0);
				node.setEnTrsExp(rs.getString("chrFRExpression"));
				node.setEnTrsTable(rs.getString("chrFRChannels"));
				node.setEnTrsOption(0);
				node.setGroupId("GROUPGUESST");
				
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
	
	
	public boolean addFavorite(String strUserIp, int intUserId,
			PatentInfo patentInfo) {
		boolean result = false;

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			java.text.SimpleDateFormat sformat = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			String time = sformat.format(new java.util.Date());

			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("insert into ipr_searchresult(intUserID,chrUserIP,chrAPO,chrTI,chrIPC,chrANN,dtSaveTime,chrChannelID,intCountry) values (?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, intUserId);
			ps.setString(2, strUserIp);
			ps.setString(3, patentInfo.getAn());
			ps.setString(4, patentInfo.getTi());
			ps.setString(5, patentInfo.getPic());
			ps.setString(6, patentInfo.getAgt());
			ps.setString(7, time);
			ps.setString(8, patentInfo.getSectionName());
			if (patentInfo.getCountryCode().equalsIgnoreCase("CN"))
				ps.setInt(9, 0);
			else
				ps.setInt(9, 1);
			int rs = ps.executeUpdate();
			if (rs == 1) {
				result = true;
			}

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
		return result;
	}

	public NodeModel getNodeInfoByID(String treeType,String nodeid) {
		String navtable = treeType.equals("0")?"ipr_navtable_ipc":"ipr_navtable";
		
		if(treeType.equals("0")) {
			navtable = "ipr_navtable_ipc";
		}else if(treeType.equals("4")) {
			navtable = "ipr_navtable_gmjj";
		}else if(treeType.equals("5")) {
			navtable = "ipr_address";
		}else {
			navtable = "ipr_navtable";
		}
		
		NodeModel node = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select intID,chrName,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels from "+ navtable +" where intID="+nodeid);
			rs = ps.executeQuery();
			int i = 0;
			if (rs.next()) {
				node = new NodeModel();
				node.setId(rs.getInt("intID"));
				node.setName(rs.getString("chrName"));
				node.setCnTrsExp(rs.getString("chrExpression"));
				node.setEnTrsExp(rs.getString("chrFRExpression"));
				node.setCnTrsTable(rs.getString("chrCNChannels"));
				node.setEnTrsTable(rs.getString("chrFRChannels"));
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
		return node;
	}
	
	public NodeModel getNodeInfoByID2(String treeType, String nodeid) {
		String navtable = "ipr_navtable_gd";

		NodeModel node = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(
					"select intID,chrName,chrExpression,chrFRExpression,chrCNChannels,chrFRChannels from " + navtable
							+ " where intID=" + nodeid);
			rs = ps.executeQuery();
			int i = 0;
			if (rs.next()) {
				node = new NodeModel();
				node.setId(rs.getInt("intID"));
				node.setName(rs.getString("chrName"));
				node.setCnTrsExp(rs.getString("chrExpression"));
				node.setEnTrsExp(rs.getString("chrFRExpression"));
				node.setCnTrsTable("14,15,16");
				node.setEnTrsTable("18,19,20,21,22,23,24,25");
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
		return node;
	}

	public int getFavoriteCountByID(int intUserID) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int favoriteCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(intUserID) as RecordCount from ipr_searchresult where intUserID=?");
			ps.setInt(1, intUserID);
			rs = ps.executeQuery();
			if (rs.next()) {
				favoriteCount = rs.getInt("RecordCount");
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
		return favoriteCount;
	}

	public int getFavoriteCountByIDIP(int intUserID, String strUserIp) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		int favoriteCount = 0;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select count(intUserID) as RecordCount from ipr_searchresult where intUserID=? and chrUserIP=?");
			ps.setInt(1, intUserID);
			ps.setString(2, strUserIp);
			rs = ps.executeQuery();
			if (rs.next()) {
				favoriteCount = rs.getInt("RecordCount");
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
		return favoriteCount;
	}

	public List<Integer> getDelFavoriteIdBySQL(String sql) {
		List<Integer> result = new ArrayList<Integer>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				result.add(rs.getInt("id"));
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
		return result;
	}

	public boolean delFavoriteByID(List<Integer> favoriteIdList) {
		boolean result = true;

		for (Integer favoriteId : favoriteIdList) {
			Connection conn = null;
			PreparedStatement ps = null;

			try {
				conn = DBPoolAccessor.getConnection();
				ps = conn
						.prepareStatement("delete from ipr_searchresult where id = ?");
				ps.setInt(1, favoriteId);

				if (ps.executeUpdate() != 1)
					result = false;

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
		}

		return result;
	}

	public void delAllFavorite(String sql) {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
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
	}
}
