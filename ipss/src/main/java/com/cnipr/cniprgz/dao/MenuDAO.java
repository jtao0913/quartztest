package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.cnipr.cniprgz.commons.ComparatorMenuId;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.log.CniprLogger;

public class MenuDAO {
/*	public List<MenuInfo> getUserMenu(int userID) {
		List<MenuInfo> menuList = new ArrayList<MenuInfo>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("SELECT ipmi.intMenuID, ipmi.chrMenuName, ipmi.chrMenuURL, ipmi.intExpandFlag FROM ipr_user_menu ium, ipr_param_menu_info ipmi where ium.intMenuID=ipmi.intMenuID and ipmi.intParentID=0 and ium.intUserID=? order by ipmi.intMenuID");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			while (rs.next()) {
				MenuInfo menuInfo = new MenuInfo();
				menuInfo.setIntMenuID(rs.getInt("intMenuID"));
				menuInfo.setChrMenuName(rs.getString("chrMenuName"));
				menuInfo.setChrMenuURL(rs.getString("chrMenuURL"));
				menuInfo.setChildMenu(getChildMenu(rs.getInt("intMenuID"), userID));
//				menuInfo.setIntExpandFlag(rs.getInt("intExpandFlag"));
				menuList.add(menuInfo);
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

		return menuList;
	}
	
	private List<MenuInfo> getChildMenu(int parentID, int userID) {
		List<MenuInfo> subMenuList = new ArrayList<MenuInfo>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("SELECT a.intMenuID, a.chrMenuName, a.chrMenuURL FROM ipr_param_menu_info a, ipr_user_menu b where a.intParentID=? and b.intUserID=? and a.intMenuID=b.intMenuID order by intMenuID");
			ps.setInt(1, parentID);
			ps.setInt(2, userID);
			rs = ps.executeQuery();
			while (rs.next()) {
				MenuInfo menuInfo = new MenuInfo();
				menuInfo.setIntMenuID(rs.getInt("intMenuID"));
				menuInfo.setChrMenuName(rs.getString("chrMenuName"));
				menuInfo.setChrMenuURL(rs.getString("chrMenuURL"));
				subMenuList.add(menuInfo);
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
		
		return subMenuList;
	}*/
	public static ArrayList<MenuInfo> getAllMenuInfo() {
		ArrayList<MenuInfo> almenu = new ArrayList<MenuInfo>();
		MenuInfo menuInfo = null;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("SELECT ium.intMenuID,ium.chrMenuName, ium.chrENMenuName, ium.chrMenuURL, ium.intParentID, ium.chrMenuType FROM ipr_user_menu ium where intState=1 order by intMenuID");
			rs = ps.executeQuery();
			while (rs.next()) {
				menuInfo = new MenuInfo();
				menuInfo.setIntMenuID(rs.getInt("intMenuID"));
				menuInfo.setChrMenuName(rs.getString("chrMenuName"));
				menuInfo.setChrEnMenuName(rs.getString("chrEnMenuName"));
				menuInfo.setChrMenuURL(rs.getString("chrMenuURL"));
				menuInfo.setMenuType(rs.getString("chrMenuType"));

				almenu.add(menuInfo);
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getMenuInfo error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return almenu;
	}
	
	/**
	 * [in] menuId: 菜单ID号
	 * [in] menuIdArrayList: 
	 */
	public MenuInfo getMenuInfo(String menuId, List<String> menuIdArrayList) {
		MenuInfo menuInfo = null;
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("SELECT ium.chrMenuName, ium.chrENMenuName, ium.chrMenuURL, ium.intParentID, ium.chrMenuType FROM ipr_user_menu ium where ium.intMenuID=" + menuId +" and intState=1 order by intMenuID");
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getInt("intParentID") == 0) {
					menuInfo = new MenuInfo();
					menuInfo.setIntMenuID(Integer.parseInt(menuId));
					menuInfo.setChrMenuName(rs.getString("chrMenuName"));
					menuInfo.setChrEnMenuName(rs.getString("chrEnMenuName"));
					menuInfo.setChrMenuURL(rs.getString("chrMenuURL"));
					menuInfo.setMenuType(rs.getString("chrMenuType"));
					menuInfo.setChildMenu(getChildMenu(menuId, menuIdArrayList));
				}
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getMenuInfo error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		return menuInfo;
	}
	
	private List<MenuInfo> getChildMenu(String parentID, List<String> menuIdArrayList) {
		List<MenuInfo> subMenuList = new ArrayList<MenuInfo>();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("SELECT a.intMenuID, a.chrMenuName, a.chrENMenuName, a.chrMenuURL, a.chrMenuType FROM ipr_user_menu a where a.intParentID=?" +" order by intMenuID");
			ps.setInt(1, Integer.parseInt(parentID));
			rs = ps.executeQuery();
			while (rs.next()) {
				if (hasTheMenu(Integer.toString(rs.getInt("intMenuID")), menuIdArrayList)) {
					MenuInfo menuInfo = new MenuInfo();
					menuInfo.setIntMenuID(rs.getInt("intMenuID"));
					menuInfo.setChrMenuName(rs.getString("chrMenuName"));
					menuInfo.setChrEnMenuName(rs.getString("chrEnMenuName"));
					menuInfo.setChrMenuURL(rs.getString("chrMenuURL"));
					menuInfo.setMenuType(rs.getString("chrMenuType"));
					subMenuList.add(menuInfo);
				}
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getChildMenu error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}
		
		return subMenuList;
	}
	
	private boolean hasTheMenu(String menuId,  List<String> menuIdArrayList) {
		boolean flag = false;
		
		for (String userMenuId : menuIdArrayList) {
			if (userMenuId.equals(menuId)) {
				flag = true;
//				menuIdArrayList.remove(userMenuId);
				break;
			}
		}
		
		return flag;
	}
	
	
	public void updateMenu() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		Connection conn1 = null;
		PreparedStatement ps1 = null;
		
		try {
			conn = DBPoolAccessor.getConnection();
			conn1 = DBPoolAccessor.getConnection();
			ps = conn
					.prepareStatement("select * from ipr_user");
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int userid = rs.getInt("intUserID");
				String chrMenu =  rs.getString("chrMenu");
				String[] array = chrMenu.split(",");
				List userlist=new ArrayList();
				for (String ss : array) {
					if (ss != null && !ss.equals("") && !ss.equals("3100"))
						userlist.add(ss);
				}
//				userlist.add("3200");
				userlist.add("3300");
				ComparatorMenuId comparator=new ComparatorMenuId();
				Collections.sort(userlist, comparator);
				String newchrMenu = "";
				for (int i=0;i<userlist.size();i++){
					newchrMenu += userlist.get(i) + ","; 
				}

				
				ps1 = conn1
				.prepareStatement("update ipr_user set chrMenu='" + newchrMenu + "' where intUserID=" + userid);
				ps1.executeUpdate();
			}
		} catch (Exception e) {
			CniprLogger.LogError("MenuDAO -> getChildMenu error : "
					+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
			DBPoolAccessor.closeAll(null, ps1, conn1);
		}
	}
	
	
	public static void main(String[] a) {
//		String s = "1000,1005,1010,1015,1020,1500,2000,2500,3000,3005,3010,3500,5000,5005,5010,5015,5020,5025,5030,5035,5500,6000,";
//		String[] array = s.split(",");
//		List userlist=new ArrayList();
//		for (String ss : array) {
//			if (ss != null && !ss.equals(""))
//				userlist.add(ss);
//		}
//		userlist.add("3100");
//		userlist.add("3200");
//		
//		ComparatorUser comparator=new ComparatorUser();
//		Collections.sort(userlist, comparator);
//		
//		for (int i=0;i<userlist.size();i++){
//			System.out.println(userlist.get(i));
		(new MenuDAO()).updateMenu();
//		}
	}
}
