package com.cnipr.cniprgz.entity;

public class ChannelInfo {
	private String chrChannelName;
	
	private String chrTRSTable;
	
	private int intChannelID;
	
	private String chrCheck; 
	
	private String chrIndexCheck;
	
	public String getChrIndexCheck() {
		return chrIndexCheck;
	}

	public void setChrIndexCheck(String chrIndexCheck) {
		this.chrIndexCheck = chrIndexCheck;
	}

	public String getChrCheck() {
		return chrCheck;
	}

	public void setChrCheck(String chrCheck) {
		this.chrCheck = chrCheck;
	}

	private int intContinent;	
	public int getIntContinent() {
		return intContinent;
	}
	public void setIntContinent(int intContinent) {
		this.intContinent = intContinent;
	}
	
	private String chrChannelCode;
	
	public String getChrChannelCode() {
		return chrChannelCode;
	}

	public void setChrChannelCode(String chrChannelCode) {
		this.chrChannelCode = chrChannelCode;
	}

	private String chrChannelMemo;
	
	private String demo;//最新日期
	
	private int intEnable;

	public String getChrChannelName() {
		return chrChannelName;
	}

	public void setChrChannelName(String chrChannelName) {
		this.chrChannelName = chrChannelName;
	}

	public String getChrTRSTable() {
		return chrTRSTable;
	}

	public void setChrTRSTable(String chrTRSTable) {
		this.chrTRSTable = chrTRSTable;
	}

	public int getIntChannelID() {
		return intChannelID;
	}

	public void setIntChannelID(int intChannelID) {
		this.intChannelID = intChannelID;
	}

	public String getChrChannelMemo() {
		return chrChannelMemo;
	}

	public void setChrChannelMemo(String chrChannelMemo) {
		this.chrChannelMemo = chrChannelMemo;
	}

	 

	public int getIntEnable() {
		return intEnable;
	}

	public void setIntEnable(int intEnable) {
		this.intEnable = intEnable;
	}

	public String getDemo() {
		return demo;
	}

	public void setDemo(String demo) {
		this.demo = demo;
	}
}
