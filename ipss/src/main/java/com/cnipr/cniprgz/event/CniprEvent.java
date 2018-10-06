package com.cnipr.cniprgz.event;

import java.util.EventObject;
import java.util.List;

import com.cnipr.corebiz.search.entity.PatentInfo;

public class CniprEvent extends EventObject {

	private static final long serialVersionUID = -1061309263200940682L;

	public boolean isFireLogEvent;

	public boolean isFireFeeEvent;

	public List<PatentInfo> patentList;

	public int userId;

	public String funcName;

	public int startPage;

	public int endPage;

	public String userName;

	public String ip;
	
	public int feeType;

	// public boolean isFireLogEvent() {
	// return isFireLogEvent;
	// }
	//
	// public void setFireLogEvent(boolean isFireLog) {
	// this.isFireLogEvent = isFireLog;
	// }
	//
	// public boolean isFireFeeEvent() {
	// return isFireFeeEvent;
	// }
	//
	// public void setFireFeeEvent(boolean isFireFee) {
	// this.isFireFeeEvent = isFireFee;
	// }

	public CniprEvent(Object source, boolean isFireLogEvent,
			boolean isFireFeeEvent, List<PatentInfo> patentList, int userId,
			String userName, String funcName, int startPage, int endPage,
			String ip, int feeType) {
		super(source);
		this.isFireLogEvent = isFireLogEvent;
		this.isFireFeeEvent = isFireFeeEvent;
		this.patentList = patentList;
		this.userId = userId;
		this.startPage = startPage;
		this.endPage = endPage;
		this.userName = userName;
		this.ip = ip;
		this.funcName = funcName;
		this.feeType = feeType;
	}

}
