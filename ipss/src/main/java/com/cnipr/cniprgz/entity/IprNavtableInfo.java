package com.cnipr.cniprgz.entity;

import java.util.Date;

public class IprNavtableInfo {
	private int id;
	
	private int intId;

	private String name;

	private String cnExpression;

	private String frExpression;

	private String strClass;

	private int parentId;
	
	private int intType;
	
	private String chrMemo;
	
	private int intAdministerId;
	
	private String chrCNChannels;
	
	private String chrFRChannels;
	
	private String chrLapsedChannels;
	
	private int intSequenceNum;
	
	private Date dtCreatetime;
	
	private int isSelected;
	
	/** 增加的标识位，判断该目录是否有子节点 0为无子节点，1为有子节点*/
	private int hasChild;

	public int getHasChild() {
		return hasChild;
	}

	public void setHasChild(int hasChild) {
		this.hasChild = hasChild;
	}

	public String getCnExpression() {
		return cnExpression;
	}

	public int getIntId() {
		return intId;
	}

	public void setIntId(int intId) {
		this.intId = intId;
	}

	public int getIntType() {
		return intType;
	}

	public void setIntType(int intType) {
		this.intType = intType;
	}

	public String getChrMemo() {
		return chrMemo;
	}

	public void setChrMemo(String chrMemo) {
		this.chrMemo = chrMemo;
	}

	public int getIntAdministerId() {
		return intAdministerId;
	}

	public void setIntAdministerId(int intAdministerId) {
		this.intAdministerId = intAdministerId;
	}

	public int getIntSequenceNum() {
		return intSequenceNum;
	}

	public void setIntSequenceNum(int intSequenceNum) {
		this.intSequenceNum = intSequenceNum;
	}

	public Date getDtCreatetime() {
		return dtCreatetime;
	}

	public void setDtCreatetime(Date dtCreatetime) {
		this.dtCreatetime = dtCreatetime;
	}

	public void setCnExpression(String cnExpression) {
		this.cnExpression = cnExpression;
	}

	public String getFrExpression() {
		return frExpression;
	}

	public void setFrExpression(String frExpression) {
		this.frExpression = frExpression;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getStrClass() {
		return strClass;
	}

	public void setStrClass(String strClass) {
		this.strClass = strClass;
	}

	public String getChrCNChannels() {
		return chrCNChannels;
	}

	public void setChrCNChannels(String chrCNChannels) {
		this.chrCNChannels = chrCNChannels;
	}

	public String getChrFRChannels() {
		return chrFRChannels;
	}

	public void setChrFRChannels(String chrFRChannels) {
		this.chrFRChannels = chrFRChannels;
	}

	public String getChrLapsedChannels() {
		return chrLapsedChannels;
	}

	public void setChrLapsedChannels(String chrLapsedChannels) {
		this.chrLapsedChannels = chrLapsedChannels;
	}

	public int getIsSelected() {
		return isSelected;
	}

	public void setIsSelected(int isSelected) {
		this.isSelected = isSelected;
	}
}
