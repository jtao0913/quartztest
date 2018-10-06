package com.cnipr.cniprgz.entity;

import java.util.List;

public class NodeModel {
	private Integer id;
	
	private String pId;
	
	private String name;
	
	private String expl;
	
	private boolean isIsParent;
	
	private boolean open;
	
	private String classname;

	private String cnTrsTable;
	
	private String cnTrsTableName; 
	
	private String sxTrsTable;

	private String cnTrsExp;
	
	private String enTrsTable;
	
	private String enTrsTableName;
	
	public String getCnTrsTableName() {
		return cnTrsTableName;
	}

	public void setCnTrsTableName(String cnTrsTableName) {
		this.cnTrsTableName = cnTrsTableName;
	}

	public String getEnTrsTableName() {
		return enTrsTableName;
	}

	public void setEnTrsTableName(String enTrsTableName) {
		this.enTrsTableName = enTrsTableName;
	}

	private String enTrsExp;
	
	private Integer cnTrsOption;
	
	private Integer enTrsOption;
	
	private boolean checked;
	
	private String groupId;	
	
	private List<NodeModel> children;
	
	public String getSxTrsTable() {
		return sxTrsTable;
	}

	public void setSxTrsTable(String sxTrsTable) {
		this.sxTrsTable = sxTrsTable;
	}
	
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public String getCnTrsTable() {
		return cnTrsTable;
	}
	
	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public void setCnTrsTable(String cnTrsTable) {
		this.cnTrsTable = cnTrsTable;
	}

	public String getCnTrsExp() {
		return cnTrsExp;
	}

	public void setCnTrsExp(String cnTrsExp) {
		this.cnTrsExp = cnTrsExp;
	}

	public String getEnTrsTable() {
		return enTrsTable;
	}

	public void setEnTrsTable(String enTrsTable) {
		this.enTrsTable = enTrsTable;
	}

	public String getEnTrsExp() {
		return enTrsExp;
	}

	public void setEnTrsExp(String enTrsExp) {
		this.enTrsExp = enTrsExp;
	}

	public Integer getCnTrsOption() {
		return cnTrsOption;
	}

	public void setCnTrsOption(Integer cnTrsOption) {
		this.cnTrsOption = cnTrsOption;
	}

	public Integer getEnTrsOption() {
		return enTrsOption;
	}

	public void setEnTrsOption(Integer enTrsOption) {
		this.enTrsOption = enTrsOption;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}
	
	public String getExpl() {
		return expl;
	}

	public void setExpl(String expl) {
		this.expl = expl;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
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

	public List<NodeModel> getChildren() {
		return children;
	}

	public void setChildren(List<NodeModel> children) {
		this.children = children;
	}

}
