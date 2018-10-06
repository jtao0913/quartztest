package com.cnipr.cniprgz.entity;

public class FavoriteInfo {
	
	private int index;
	
	private int id;

	private int intUserID;

	private String chrUserIP;

	private String chrAPO;

	private String chrTI;

	private String chrIPC;

	private String chrANN;

	private String dtSaveTime;

	private String chrChannelID;

	private int intCountry;

	public String getChrANN() {
		return chrANN;
	}

	public void setChrANN(String chrANN) {
		this.chrANN = chrANN;
	}

	public String getChrAPO() {
		return chrAPO;
	}

	public void setChrAPO(String chrAPO) {
		this.chrAPO = chrAPO;
	}

	public String getChrChannelID() {
		return chrChannelID;
	}

	public void setChrChannelID(String chrChannelID) {
		this.chrChannelID = chrChannelID;
	}

	public String getChrIPC() {
		return chrIPC;
	}

	public void setChrIPC(String chrIPC) {
		this.chrIPC = chrIPC;
	}

	public String getChrTI() {
		return chrTI;
	}

	public void setChrTI(String chrTI) {
		this.chrTI = chrTI;
	}

	public String getChrUserIP() {
		return chrUserIP;
	}

	public void setChrUserIP(String chrUserIP) {
		this.chrUserIP = chrUserIP;
	}

	public String getDtSaveTime() {
		return dtSaveTime;
	}

	public void setDtSaveTime(String dtSaveTime) {
		this.dtSaveTime = dtSaveTime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIntCountry() {
		return intCountry;
	}

	public void setIntCountry(int intCountry) {
		this.intCountry = intCountry;
	}

	public int getIntUserID() {
		return intUserID;
	}

	public void setIntUserID(int intUserID) {
		this.intUserID = intUserID;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

}
