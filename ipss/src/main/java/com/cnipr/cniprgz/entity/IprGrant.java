package com.cnipr.cniprgz.entity;

public class IprGrant {
	private int intGrantId;
	private String chrGrantName;
	private int intChannelId;
	private String chrGrantMemo;
	private int intPrice;
	private String isSelected = "";
	
	public int getIntGrantId() {
		return intGrantId;
	}
	public void setIntGrantId(int intGrantId) {
		this.intGrantId = intGrantId;
	}
	public String getChrGrantName() {
		return chrGrantName;
	}
	public void setChrGrantName(String chrGrantName) {
		this.chrGrantName = chrGrantName;
	}
	public int getIntChannelId() {
		return intChannelId;
	}
	public void setIntChannelId(int intChannelId) {
		this.intChannelId = intChannelId;
	}
	public String getChrGrantMemo() {
		return chrGrantMemo;
	}
	public void setChrGrantMemo(String chrGrantMemo) {
		this.chrGrantMemo = chrGrantMemo;
	}
	public int getIntPrice() {
		return intPrice;
	}
	public void setIntPrice(int intPrice) {
		this.intPrice = intPrice;
	}
	public String getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(String isSelected) {
		this.isSelected = isSelected;
	}
}
