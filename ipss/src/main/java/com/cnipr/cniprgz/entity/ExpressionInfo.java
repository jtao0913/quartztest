package com.cnipr.cniprgz.entity;

public class ExpressionInfo {
	private int id;

	private int userID;

	private String userIP;

	private String name;

	private String expression;

	private String channel;

	private long hitCount;

	private int state;

	private String stateOperate;

	private int chrSynonymous;

	private String Sources;
	
	private String dtSearchTime;

	public String getDtSearchTime() {
		return dtSearchTime;
	}

	public void setDtSearchTime(String dtSearchTime) {
		this.dtSearchTime = dtSearchTime;
	}

	public String getSources() {
		return Sources;
	}

	public void setSources(String sources) {
		Sources = sources;
	}

	private String channeltable;
	
	public String getChanneltable() {
		return channeltable;
	}

	public void setChanneltable(String channeltable) {
		this.channeltable = channeltable;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public long getHitCount() {
		return hitCount;
	}

	public void setHitCount(long hitCount) {
		this.hitCount = hitCount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUserIP() {
		return userIP;
	}

	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getStateOperate() {
		return stateOperate;
	}

	public void setStateOperate(String stateOperate) {
		this.stateOperate = stateOperate;
	}

	public int getChrSynonymous() {
		return chrSynonymous;
	}

	public void setChrSynonymous(int chrSynonymous) {
		this.chrSynonymous = chrSynonymous;
	}
}
