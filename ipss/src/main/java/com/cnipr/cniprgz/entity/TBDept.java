package com.cnipr.cniprgz.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * TSimpleWarn entity.
 * 
 * @author MyEclipse Persistence Tools
 */
@SuppressWarnings("unchecked")
public class TBDept implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8347570098222393516L;
	 
	private int id;
	private String deptName;
	private int display;
	private int topId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public int getDisplay() {
		return display;
	}
	public void setDisplay(int display) {
		this.display = display;
	}
	public int getTopId() {
		return topId;
	}
	public void setTopId(int topId) {
		this.topId = topId;
	}

	 
	 

}