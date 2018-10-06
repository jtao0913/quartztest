package com.cnipr.cniprgz.func.charge;

import java.util.List;

import com.cnipr.cniprgz.dao.FeeDAO;
import com.cnipr.corebiz.search.entity.PatentInfo;

public class PointCardBillingAlgorithm extends AbsBillingAlgorithm{
	
	private List<PatentInfo> patentList;
	
	private String userName;
	
	private String funcName;
	
	private int startPage;
	
	private int endPage;
	
	public PointCardBillingAlgorithm(List<PatentInfo> patentList,
			String userName, String funcName, int startPage, int endPage) {
		this.patentList = patentList;
		this.userName = userName;
		this.funcName = funcName;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	
	@Override
	public int doBilling() {
		if (startPage > 0) {
			for (int i = startPage; i <= endPage; i++) {
				deducted(patentList.get(0), userName, funcName, 1, startPage++);
			}
		} else {
			for (PatentInfo patent : patentList) {
				deducted(patent, userName, funcName, 1, 0);
			}
		}
		
		return 0;
	}

	private void deducted(PatentInfo patent, String userName, String funcName, int feeType, int page) {
		FeeDAO feeDAO = new FeeDAO();
		feeDAO.deducted(patent, userName, funcName, feeType, page);
	}
}
