package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.dao.MenuDAO;
import com.cnipr.cniprgz.entity.MenuInfo;

public class MenuFunc {

	private MenuDAO menuDAO;
	
	public void setMenuDAO(MenuDAO menuDAO) {
		this.menuDAO = menuDAO;
	}

	public List<MenuInfo> getUserMenu(String strMenuIds, String rootId,
			String treeType,String autosearch) {
		
		strMenuIds = strMenuIds==null?"":strMenuIds;
		rootId = rootId==null?"":rootId;
		treeType = treeType==null?"":treeType;
		autosearch = autosearch==null?"":autosearch;
		
		List<MenuInfo> menuList = new ArrayList<MenuInfo>();

		String[] userMenuIdArray = strMenuIds.split(",");

		if (userMenuIdArray != null && userMenuIdArray.length > 0) {
			List<String> menuIdArrayList = getMenuIdArrayList(userMenuIdArray);
			for (String menuId : menuIdArrayList) {
				MenuInfo menu = menuDAO.getMenuInfo(menuId, menuIdArrayList);

				if (menu != null) {
					if (menuId.equals("1500")) {
						menu.setChrMenuURL(menu.getChrMenuURL().replace("$",
								rootId).replace("#", treeType).replace("^", autosearch));
					}

					menuList.add(menu);
				}
			}
		}

		return menuList;
	}

	private ArrayList<String> getMenuIdArrayList(String[] userMenuIdArray) {
		ArrayList<String> menuIdArrayList = new ArrayList<String>();
		for (String menuId : userMenuIdArray) {
			menuIdArrayList.add(menuId);
		}
		return menuIdArrayList;
	}

	public static void main(String[] args) {
		MenuFunc m = new MenuFunc();
		// List<MenuInfo> menuList =
		// m.getUserMenu("1000,1005,1010,1015,1020,1500,2000,2500,3000,3005,3010,3500,5000,5005,5010,5015,5020,5025,5030,5032,5035,10000,10010,5500,6000,");
		// System.out.println(menuList.toString());
	}

}
