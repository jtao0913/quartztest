package com.cnipr.cniprgz.dao.julei.bean;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;

import com.google.common.collect.Lists;


public class PatClusterSearchDTO implements Serializable{


	/**
	 * 聚类结构
	 */
	private List<Cluster> list = Lists.newArrayList();

	/**
	 * xml
	 */
	private String xml = "";

	/**
	 * 图形消息
	 */
	private String chartMsg = "";

	public List<Cluster> getList() {
		return list;
	}

	public void setList(List<Cluster> list) {
		this.list = list;
	}

	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public String getChartMsg() {
		return chartMsg;
	}

	public void setChartMsg(String chartMsg) {
		this.chartMsg = chartMsg;
	}
	
	
	private static final long serialVersionUID = -8905196784034649800L;
//	/** 检索信息Bean */
//	private SearchMessageBean searchMessageBean;
//
//	public SearchMessageBean getSearchMessageBean() {
//		return searchMessageBean;
//	} 
//
//	public void setSearchMessageBean(SearchMessageBean searchMessageBean) {
//		this.searchMessageBean = searchMessageBean;
//	}
	
	/** 
	 * 操作结果代码 
	 * 1:表示成功，其它均为失败
	 */
	private int returncode = 1;
	
	/** 
	 * 操作错误详细信息，成功时message为空串
	 */
	private String message = "";
	
	public int getReturncode() {
		return returncode;
	}

	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "CluResultModel [list=" + ArrayUtils.toString(list) + ", xml=" + xml + ", chartMsg=" + chartMsg + "]";
	}
	
}
