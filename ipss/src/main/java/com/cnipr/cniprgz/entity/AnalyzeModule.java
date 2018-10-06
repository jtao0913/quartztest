package com.cnipr.cniprgz.entity;

class Series{
	private String name;
	private String type;
	private int[] data;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int[] getData() {
		return data;
	}
	public void setData(int[] data) {
		this.data = data;
	}
}

public class AnalyzeModule {
//	private String title;
//	private String text;//'ECharts 入门示例'
//	tooltip : {},
	private Integer status;
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	private String analysisName;
	
	private String[] legend;
//	data : [ '销量' ]
	private String[] xAxisData;
//xAxis : {
//	data : [ "衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子" ]
//},
//	private String[] yAxis;
	
	public String[] getxAxisData() {
		return xAxisData;
	}
	public void setxAxisData(String[] xAxisData) {
		this.xAxisData = xAxisData;
	}

	private int[][] arrSeries;
//series : [ {
//	name : '销量',
//	type : 'bar',
//	data : [ 5, 20, 36, 10, 10, 20 ]
//} ]	
	
	public String getAnalysisName() {
		return analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}

	public String[] getLegend() {
		return legend;
	}

	public void setLegend(String[] legend) {
		this.legend = legend;
	}


	public int[][] getArrSeries() {
		return arrSeries;
	}

	public void setArrSeries(int[][] arrSeries) {
		this.arrSeries = arrSeries;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
