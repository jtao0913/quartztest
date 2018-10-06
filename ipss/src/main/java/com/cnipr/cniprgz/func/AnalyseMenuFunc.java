package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.dao.AnalyseMenuDAO;
import com.cnipr.cniprgz.entity.AnalyzeMenu;

public class AnalyseMenuFunc {
	private AnalyseMenuDAO analyseMenuDAO;
	public AnalyseMenuDAO getAnalyseMenuDAO() {
		return analyseMenuDAO;
	}
	public void setAnalyseMenuDAO(AnalyseMenuDAO analyseMenuDAO) {
		this.analyseMenuDAO = analyseMenuDAO;
	}
	
	public List<AnalyzeMenu> getAllAnalyseMenuInfo(String area) throws Exception {
		List<AnalyzeMenu> analysemenuList = new ArrayList<AnalyzeMenu>();		
		analysemenuList = analyseMenuDAO.getAllAnalyseMenu(area);		
		return analysemenuList;
	}
	
	public AnalyzeMenu getAnalyseMenuInfoByID(String id)  throws Exception {
		AnalyzeMenu analysemenu = analyseMenuDAO.getMenuInfoByID(id);		
		return analysemenu;
	}
	
}
