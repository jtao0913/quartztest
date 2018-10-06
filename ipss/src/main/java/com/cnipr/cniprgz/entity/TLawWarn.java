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
public class TLawWarn implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8347570098222393516L;
	private int id; 
	private int userId;
	private String name;
	private String an;
	private String pn;
	private String channels;
	private Integer period;
	private Integer status;
	private Date createtime;
	private Date updatetime;
	private Date lastruntime;
	private String lastupdatestatus;
	private String updatestatus;
	private Date lastupdatetime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	 
	public String getChannels() {
		return channels;
	}
	public void setChannels(String channels) {
		this.channels = channels;
	}
	public Integer getPeriod() {
		return period;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public Date getLastruntime() {
		return lastruntime;
	}
	public void setLastruntime(Date lastruntime) {
		this.lastruntime = lastruntime;
	}
	public String getAn() {
		return an;
	}
	public void setAn(String an) {
		this.an = an;
	}
	public String getPn() {
		return pn;
	}
	public void setPn(String pn) {
		this.pn = pn;
	}
	public String getLastupdatestatus() {
		return lastupdatestatus;
	}
	public void setLastupdatestatus(String lastupdatestatus) {
		this.lastupdatestatus = lastupdatestatus;
	}
	public String getUpdatestatus() {
		return updatestatus;
	}
	public void setUpdatestatus(String updatestatus) {
		this.updatestatus = updatestatus;
	}
	public Date getLastupdatetime() {
		return lastupdatetime;
	}
	public void setLastupdatetime(Date lastupdatetime) {
		this.lastupdatetime = lastupdatetime;
	}
 	 

	 
	 

}