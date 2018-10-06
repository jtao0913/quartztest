package com.cnipr.cniprgz.func;

import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.dao.IPDenyDAO;
import com.cnipr.cniprgz.entity.MenuInfo;

public class IPDenyFunc {

	private IPDenyDAO ipdenyDAO;	

	public IPDenyDAO getIpdenyDAO() {
		return ipdenyDAO;
	}

	public void setIpdenyDAO(IPDenyDAO ipdenyDAO) {
		this.ipdenyDAO = ipdenyDAO;
	}
	
	public void insertIPDeny(String ip) {
		ipdenyDAO.insertIPDeny(ip);
	}


	public static void main(String[] args) {
	}

}
