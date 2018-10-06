package com.cnipr.cniprgz.entity;

import java.util.List;

public class GMJJModel {
	private String id;
	
	private String pId;
	
	private String name;
		
	private boolean isIsParent;
	
	private boolean open;
	
	private List<GMJJModel> children;
	
	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		if(pId != null && !"".equals(pId) && "0".equals(pId)){
			this.isIsParent = true;
		}
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isIsParent() {
		return isIsParent;
	}

	public void setIsParent(boolean isParent) {
		this.isIsParent = isParent;
	}

	public List<GMJJModel> getChildren() {
		return children;
	}

	public void setChildren(List<GMJJModel> children) {
		this.children = children;
	}

}
