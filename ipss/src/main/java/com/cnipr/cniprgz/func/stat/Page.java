package com.cnipr.cniprgz.func.stat;

import java.util.List;

public class Page<T> {

	private List<T> resultList;
	
	private int totalCount;
	
	private int totalPage;
	
	private int currentPage;
	
	private int pageSize = 10;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public List<T> getResultList() {
		return resultList;
	}

	public void setResultList(List<T> resultList) {
		this.resultList = resultList;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		pageSize = pageSize>0 ? pageSize : 10;
		int totalPage = (int) Math.ceil((totalCount - 1) / pageSize) + 1;
		setTotalPage(totalPage);
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
}
