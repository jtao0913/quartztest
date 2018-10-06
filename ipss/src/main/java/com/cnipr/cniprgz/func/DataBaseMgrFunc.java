package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.dao.DataBaseMgrDAO;
import com.cnipr.cniprgz.dao.IprUserNavDAO;
import com.cnipr.cniprgz.entity.IprNavtableInfo;

public class DataBaseMgrFunc {

	private DataBaseMgrDAO dataBaseMgrDao;

	public void setDataBaseMgrDao(DataBaseMgrDAO dataBaseMgrDao) {
		this.dataBaseMgrDao = dataBaseMgrDao;
	}
	
	private IprUserNavDAO iprUserNavDAO;
	
	public void setIprUserNavDAO(IprUserNavDAO iprUserNavDAO) {
		this.iprUserNavDAO = iprUserNavDAO;
	}
	
	public PageBaseInfo queryForPage(int intType,int intParentId){
		return dataBaseMgrDao.queryList(10,10, intType,intParentId);
	}
	public List<IprNavtableInfo> queryForList(int intType,int intParentId, String userId){
		//return dataBaseMgrDao.queryList(10,10, intType,intParentId);
		return dataBaseMgrDao.queryForList(intType, intParentId, userId);
	}
	/**
	 * 建立新的专利数据库
	 */
	public boolean addDatabase(String type,String name,String sequence,String area,String cnExpression,String cnChannel,
			String frExpression, String frChannel,String remark,String parentId, String intAdminId){
		IprNavtableInfo navtab = new IprNavtableInfo();
		navtab.setName(name);
		int tp = type!=null && type.length()>0?Integer.parseInt(type):0;
		navtab.setIntType(tp);
		int seq = sequence!=null && sequence.length()>0?Integer.parseInt(sequence):0;
		navtab.setIntSequenceNum(seq);
		navtab.setCnExpression(cnExpression);
		navtab.setFrExpression(frExpression);
		navtab.setChrCNChannels(cnChannel);
		navtab.setChrFRChannels(frChannel);
		navtab.setIntAdministerId(Integer.parseInt(intAdminId));
		navtab.setChrMemo(remark);
		navtab.setCnExpression(cnExpression);
		int parent = parentId!=null && parentId.length()>0?Integer.parseInt(parentId):0;
		navtab.setParentId(parent);
		return doAddDatabase(navtab);
	}
	
	private boolean doAddDatabase(IprNavtableInfo navtab) {
		int intId = dataBaseMgrDao.newDataBase(navtab);
		if (intId != 0) {
			return iprUserNavDAO.addUserNav(navtab.getIntAdministerId(), intId);
		} else {
			return false;
		}
	}
	
	public IprNavtableInfo getSingleInfo(int intId){
		return dataBaseMgrDao.querySingleInfo(intId);
	}
	
	public boolean deleteSingleRecord(int intId){
		return dataBaseMgrDao.deleteDataBase(intId);
	}
	
	/**
	 * 修改专利数据库信息
	 */
	public boolean updateDBInfo(IprNavtableInfo navTable){
		return dataBaseMgrDao.modifyDataBase(navTable);
	}
	/**
	 * 导航路径
	 */
	public String getPath(int intId,int intType){
		return dataBaseMgrDao.getPath(intId, intType);
	}
	
}
