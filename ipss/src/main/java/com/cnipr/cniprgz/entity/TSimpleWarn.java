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
public class TSimpleWarn implements java.io.Serializable {

	private static final long serialVersionUID = -8347570098222393516L;
	private int id;
	
	private int userId;
	private String name;
	private String expression;
	private Integer area;
	private String channels;
	private Integer period;
	private Integer status;
	private Date createtime;
	private Date updatetime;
	private Date lastruntime;
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
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
	public Integer getArea() {
		return area;
	}
	public void setArea(Integer area) {
		this.area = area;
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
 	 

	 
	 

}