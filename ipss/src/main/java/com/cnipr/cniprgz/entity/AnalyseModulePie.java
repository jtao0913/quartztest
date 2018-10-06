package com.cnipr.cniprgz.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class AnalyseModulePie {

	private Integer status;
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	private String analysisName;
	
    private TreeMap<String,Integer> results;
	public TreeMap<String, Integer> getResults() {
		return results;
	}
	public void setResults(TreeMap<String, Integer> results) {
		this.results = results;
	}

	private ArrayList<Map.Entry<String,Integer>> list_data_single;
	public ArrayList<Map.Entry<String, Integer>> getList_data_single() {
		return list_data_single;
	}
	public void setList_data_single(ArrayList<Map.Entry<String, Integer>> list_data_single) {
		this.list_data_single = list_data_single;
	}
	
	private String[][] arr_data_single;
	public String[][] getArr_data_single() {
		return arr_data_single;
	}
	public void setArr_data_single(String[][] arr_data_single) {
		this.arr_data_single = arr_data_single;
	}

	public String getAnalysisName() {
		return analysisName;
	}

	public void setAnalysisName(String analysisName) {
		this.analysisName = analysisName;
	}


	public static void main(String[] args) {
		

	}

}
