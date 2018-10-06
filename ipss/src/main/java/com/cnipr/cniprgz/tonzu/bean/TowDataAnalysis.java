package com.cnipr.cniprgz.tonzu.bean;
import java.util.ArrayList;
import java.util.List;

/**
 * 处理二维数据BEAN
 */
public class TowDataAnalysis {
	List<String> listSX=null;
	List<String> listSY=null;
	List<Integer> listIX=null;
	List<Integer> listIY=null;
	
	Object[][] obj=null;
	public List<String> getListSX() {
		return listSX;
	}

	public void setListSX(List<String> listSX) {
		if(null==listSX){
			listSX=new ArrayList<String>();
		}
		this.listSX = listSX;
	}

	public List<String> getListSY() {
		return listSY;
	}

	public void setListSY(List<String> listSY) {
		if(null==listSY){
			listSY=new ArrayList<String>();
		}
		this.listSY = listSY;
	}

	public List<Integer> getListIX() {
		return listIX;
	}

	public void setListIX(List<Integer> listIX) {
		if(null==listIX){
			listIX=new ArrayList<Integer>();
		}
		this.listIX = listIX;
	}

	public List<Integer> getListIY() {
		return listIY;
	}

	public void setListIY(List<Integer> listIY) {
		if(null==listIY){
			listIY=new ArrayList<Integer>();
		}
		this.listIY = listIY;
	}

	public Object[][] getObj() {
		return obj;
	}

	public void setObj(Object[][] obj) {
		if(null==obj){
			obj=new Object[5][5];
		}
		this.obj = obj;
	}
}
