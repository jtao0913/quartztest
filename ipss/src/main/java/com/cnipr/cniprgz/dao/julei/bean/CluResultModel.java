package com.cnipr.cniprgz.dao.julei.bean;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;

import com.google.common.collect.Lists;


public class CluResultModel implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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

	@Override
	public String toString() {
		return "CluResultModel [list=" + ArrayUtils.toString(list) + ", xml=" + xml + ", chartMsg=" + chartMsg + "]";
	}
	
}
