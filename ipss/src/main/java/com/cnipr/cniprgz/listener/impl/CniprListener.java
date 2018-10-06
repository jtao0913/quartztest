package com.cnipr.cniprgz.listener.impl;

import com.cnipr.cniprgz.event.CniprEvent;
import com.cnipr.cniprgz.func.charge.BillingContext;
import com.cnipr.cniprgz.listener.ICniprListener;
import com.cnipr.cniprgz.log.OperationRec;

public class CniprListener implements ICniprListener {

	
	public void performed(CniprEvent e) {
		if (e.isFireFeeEvent && e.feeType != 0) {
			BillingContext billAgent = new BillingContext(e.feeType, e.patentList, e.userName, e.funcName, e.startPage,
					e.endPage, e.ip);
			billAgent.doBilling();
		}
		
		if (e.isFireLogEvent) {
			OperationRec record = new OperationRec();
			record.recordLog(e.patentList, e.userName, e.funcName, e.startPage,
					e.endPage, e.ip);
		}
		
	}

}
