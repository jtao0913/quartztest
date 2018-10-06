package com.cnipr.cniprgz.func.charge;

import java.util.List;

import com.cnipr.corebiz.search.entity.PatentInfo;

public class BillingContext {
	private AbsBillingAlgorithm billingAlgorithm;

	public BillingContext(int billingStrategy, List<PatentInfo> patentList,
			String userName, String funcName, int startPage, int endPage,
			String ip) {
		switch (billingStrategy) {
		case (1):
			billingAlgorithm = new PointCardBillingAlgorithm(patentList,
					userName, funcName, startPage, endPage);
			break;
		default:
			billingAlgorithm = new PointCardBillingAlgorithm(patentList,
					userName, funcName, startPage, endPage);
			break;
		}
	}

	public BillingContext(AbsBillingAlgorithm billingAlgorithm) {
		this.billingAlgorithm = billingAlgorithm;
	}

	public int doBilling() {
		return billingAlgorithm.doBilling();
	}
}
