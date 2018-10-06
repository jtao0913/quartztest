package com.cnipr.cniprgz.entity;

import java.util.List;

public class MenuInfo implements java.io.Serializable{
//	private static final long serialVersionUID = -1L;
	
	private int intMenuID;
	
	private String chrMenuName;
	
	private String chrMenuURL;
	
	private int intParentID;
	
	private List<MenuInfo> childMenu;
	
	private String menuType;
	
	private String chrEnMenuName;
	
	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getChrEnMenuName() {
		return chrEnMenuName;
	}

	public void setChrEnMenuName(String chrEnMenuName) {
		this.chrEnMenuName = chrEnMenuName;
	}

	public List<MenuInfo> getChildMenu() {
		return childMenu;
	}

	public void setChildMenu(List<MenuInfo> childMenu) {
		this.childMenu = childMenu;
	}

	public String getChrMenuName() {
		return chrMenuName;
	}

	public void setChrMenuName(String chrMenuName) {
		this.chrMenuName = chrMenuName;
	}

	public String getChrMenuURL() {
		return chrMenuURL;
	}

	public void setChrMenuURL(String chrMenuURL) {
		this.chrMenuURL = chrMenuURL;
	}

	public int getIntMenuID() {
		return intMenuID;
	}

	public void setIntMenuID(int intMenuID) {
		this.intMenuID = intMenuID;
	}

	public int getIntParentID() {
		return intParentID;
	}

	public void setIntParentID(int intParentID) {
		this.intParentID = intParentID;
	}

}
