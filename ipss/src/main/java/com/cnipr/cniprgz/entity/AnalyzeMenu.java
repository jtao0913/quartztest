package com.cnipr.cniprgz.entity;

public class AnalyzeMenu  implements  java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer intID;
	private String chrName;
	private Integer intParentID;
	private String chrXAxis;
	private String chrYAxis;
	private Integer xAxisSize;
	private Integer yAxisSize;	
	
	public Integer getxAxisSize() {
		return xAxisSize;
	}

	public void setxAxisSize(Integer xAxisSize) {
		this.xAxisSize = xAxisSize;
	}

	public Integer getyAxisSize() {
		return yAxisSize;
	}

	public void setyAxisSize(Integer yAxisSize) {
		this.yAxisSize = yAxisSize;
	}

	private String chrDefaultChart;
	private String chrChart;
	private Integer intCNFR;
	private String chrIntroduce;
	private String chrIcon;

	public Integer getIntID() {
		return intID;
	}

	public void setIntID(Integer intID) {
		this.intID = intID;
	}

	public String getChrName() {
		return chrName;
	}

	public void setChrName(String chrName) {
		this.chrName = chrName;
	}

	public Integer getIntParentID() {
		return intParentID;
	}

	public void setIntParentID(Integer intParentID) {
		this.intParentID = intParentID;
	}

	public String getChrXAxis() {
		return chrXAxis;
	}

	public void setChrXAxis(String chrXAxis) {
		this.chrXAxis = chrXAxis;
	}

	public String getChrYAxis() {
		return chrYAxis;
	}

	public void setChrYAxis(String chrYAxis) {
		this.chrYAxis = chrYAxis;
	}

	public String getChrDefaultChart() {
		return chrDefaultChart;
	}

	public void setChrDefaultChart(String chrDefaultChart) {
		this.chrDefaultChart = chrDefaultChart;
	}

	public String getChrChart() {
		return chrChart;
	}

	public void setChrChart(String chrChart) {
		this.chrChart = chrChart;
	}

	public Integer getIntCNFR() {
		return intCNFR;
	}

	public void setIntCNFR(Integer intCNFR) {
		this.intCNFR = intCNFR;
	}

	public String getChrIntroduce() {
		return chrIntroduce;
	}

	public void setChrIntroduce(String chrIntroduce) {
		this.chrIntroduce = chrIntroduce;
	}

	public String getChrIcon() {
		return chrIcon;
	}

	public void setChrIcon(String chrIcon) {
		this.chrIcon = chrIcon;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
