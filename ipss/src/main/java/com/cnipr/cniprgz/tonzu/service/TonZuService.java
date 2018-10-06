package com.cnipr.cniprgz.tonzu.service;

import com.cnipr.cniprgz.tonzu.bean.TowDataAnalysis;

public interface TonZuService {
	
	/**
	 * 同族专利二维数据处理，X国家、Y申请年,XY确定一个申请号
	 * @param arg
	 * @param arg1
	 * @return
	 */
	public TowDataAnalysis tonZuDataProc(String arg,String arg1) throws Exception;
}
