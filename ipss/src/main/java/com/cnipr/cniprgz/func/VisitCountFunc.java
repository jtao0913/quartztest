package com.cnipr.cniprgz.func;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cnipr.cniprgz.dao.WebPageDAO;
import com.cnipr.cniprgz.entity.PageVisitLogInfo;

/**
 * 统计页面流量
 * 
 * @author Administrator
 * 
 */
public class VisitCountFunc {
	private WebPageDAO pageDAO;

	public void setPageDAO(WebPageDAO pageDAO) {
		this.pageDAO = pageDAO;
	}

	public void logPageVisit(String pageId, String pageType) {
		pageDAO.logVisit(pageId, pageType);
	}

	public Map<String, PageVisitLogInfo> getPageVisitLog(String startTime,
			String endTime) {
		Map<String, PageVisitLogInfo> pageVisitLogInfoMap = new HashMap<String, PageVisitLogInfo>();
		String pages = "main,all,MajorIndustries,areaIndustries";
		String[] pageArray = pages.split(",");
		
		for (String s : pageArray) {
			PageVisitLogInfo info = pageDAO.getPageVisitInfo(s, startTime, endTime);
			pageVisitLogInfoMap.put(s,info);
		}

		return pageVisitLogInfoMap;
	}
	
	public List<PageVisitLogInfo> getMemberVisitInfo() {
		return pageDAO.getMemberVisitInfo();
	}
	
	public void addMemberVisitLog(int userId) {
		pageDAO.addMemberVisitLog(userId);
	}
	
	public List<String> getMemberVisitHistory(int userId, String startTime, String endTime) {
		return pageDAO.getMemberVisitHistory(userId, startTime, endTime);
	}
}
