package com.cnipr.cniprgz.func;

import java.util.Map;

import com.cnipr.cniprgz.dao.FlztDAO;

public class FlztFunc {
	private FlztDAO flztDAO;
	public FlztDAO getFlztDAO() {
		return flztDAO;
	}
	public void setFlztDAO(FlztDAO flztDAO) {
		this.flztDAO = flztDAO;
	}

	public Map<String,String> getAllFlzt() {
		String sql = "select chrFlztInfo,chrGroupFlztInfo from ipr_flzt_contrast";
		return flztDAO.getFlztBySql(sql);
	}
}
