package com.cnipr.cniprgz.entity;

import java.util.Map;

public class PageVisitLogInfo {

	private String visitType;
	
	private long totalVisitCount;
	
	private Map<String, Long> pageVisitMap;
	
	private String name;
	
	private int id;
	
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

	public String getVisitType() {
		return visitType;
	}

	public void setVisitType(String visitType) {
		this.visitType = visitType;
	}

	public long getTotalVisitCount() {
		return totalVisitCount;
	}

	public void setTotalVisitCount(long totalVisitCount) {
		this.totalVisitCount = totalVisitCount;
	}

	public Map<String, Long> getPageVisitMap() {
		return pageVisitMap;
	}

	public void setPageVisitMap(Map<String, Long> pageVisitMap) {
		this.pageVisitMap = pageVisitMap;
	}
}
