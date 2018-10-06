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
public class TBAuthority implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8347570098222393516L;
	private String id;
	private String authority;
	private int type;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
	 
	 
	 

}