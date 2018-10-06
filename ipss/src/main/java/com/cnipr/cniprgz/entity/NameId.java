package com.cnipr.cniprgz.entity;

import java.io.Serializable;

public class NameId implements Serializable{
	private String chrName;
	private String chrExpression;
	private Integer id;
	public String getChrName() {
		return chrName;
	}
	public void setChrName(String chrName) {
		this.chrName = chrName;
	}
	public String getChrExpression() {
		return chrExpression;
	}
	public void setChrExpression(String chrExpression) {
		this.chrExpression = chrExpression;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((chrExpression == null) ? 0 : chrExpression.hashCode());
		result = prime * result + ((chrName == null) ? 0 : chrName.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		NameId other = (NameId) obj;
		if (chrExpression == null) {
			if (other.chrExpression != null)
				return false;
		} else if (!chrExpression.equals(other.chrExpression))
			return false;
		if (chrName == null) {
			if (other.chrName != null)
				return false;
		} else if (!chrName.equals(other.chrName))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "NameId [chrName=" + chrName + ", chrExpression=" + chrExpression + ", id=" + id + "]";
	}
	public NameId(String chrName, String chrExpression, Integer id) {
		super();
		this.chrName = chrName;
		this.chrExpression = chrExpression;
		this.id = id;
	}
	public NameId() {
		super();
	}
	
}
