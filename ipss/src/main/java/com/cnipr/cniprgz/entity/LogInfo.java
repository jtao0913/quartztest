package com.cnipr.cniprgz.entity;

public class LogInfo {
	private String strAPO;

	private String visitTime;

	private String visitIP;

	private int apoPage;

	private String strGrantName;

	public int getApoPage() {
		return apoPage;
	}

	public void setApoPage(int apoPage) {
		this.apoPage = apoPage;
	}

	public String getStrAPO() {
		return strAPO;
	}

	public void setStrAPO(String strAPO) {
		this.strAPO = strAPO;
	}

	public String getStrGrantName() {
		return strGrantName;
	}

	public void setStrGrantName(String strGrantName) {
		this.strGrantName = strGrantName;
	}

	public String getVisitIP() {
		return visitIP;
	}

	public void setVisitIP(String visitIP) {
		this.visitIP = visitIP;
	}

	public String getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}
}
