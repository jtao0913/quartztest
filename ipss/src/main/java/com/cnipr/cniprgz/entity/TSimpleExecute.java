package com.cnipr.cniprgz.entity;

import java.util.Date;

/**
 * TSimpleExecute entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class TSimpleExecute implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -7918490292149109638L;
	private Integer id;
	private TSimpleWarn TSimpleWarn;
	private Integer simpleWarnId;
	private Integer period;
	private Date pdStart;
	private Date pdEnd;
	private Date createtime;
	private Long amount;
	private Integer isnew;

	// Constructors

	/** default constructor */
	public TSimpleExecute() {
	}

	/** full constructor */
	public TSimpleExecute(TSimpleWarn TSimpleWarn, Integer period, Date pdStart,
			Date pdEnd, Date createtime) {
		this.TSimpleWarn = TSimpleWarn;
		this.period = period;
		this.pdStart = pdStart;
		this.pdEnd = pdEnd;
		this.createtime = createtime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public TSimpleWarn getTSimpleWarn() {
		return TSimpleWarn;
	}

	public void setTSimpleWarn(TSimpleWarn simpleWarn) {
		TSimpleWarn = simpleWarn;
	}

	public Integer getSimpleWarnId() {
		return simpleWarnId;
	}

	public void setSimpleWarnId(Integer simpleWarnId) {
		this.simpleWarnId = simpleWarnId;
	}

	public Integer getPeriod() {
		return period;
	}

	public void setPeriod(Integer period) {
		this.period = period;
	}

	public Date getPdStart() {
		return pdStart;
	}

	public void setPdStart(Date pdStart) {
		this.pdStart = pdStart;
	}

	public Date getPdEnd() {
		return pdEnd;
	}

	public void setPdEnd(Date pdEnd) {
		this.pdEnd = pdEnd;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public Integer getIsnew() {
		return isnew;
	}

	public void setIsnew(Integer isnew) {
		this.isnew = isnew;
	}

	 

}