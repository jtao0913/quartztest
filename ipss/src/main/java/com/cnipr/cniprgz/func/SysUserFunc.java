/**
 * 
 */
package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.dao.MenuDAO;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.MenuInfo;

/**
 * @author liuqi
 * @功能 系统用户的相关操作
 */
public class SysUserFunc {

	private IprUserDAO iprUserDAO;

	public IprUserDAO getIprUserDAO() {
		return iprUserDAO;
	}

	public void setIprUserDAO(IprUserDAO iprUserDAO) {
		this.iprUserDAO = iprUserDAO;
	}
	
	public MenuDAO menuDAO;
	
	public MenuDAO getMenuDAO() {
		return menuDAO;
	}

	public void setMenuDAO(MenuDAO menuDAO) {
		this.menuDAO = menuDAO;
	}
	
	private String today;	
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	
	public int newUser_inactivate(String username,String realname, String password,String email) {
		int userid = iprUserDAO.newUsername_inactivate(username,realname, password, email);
		setToday(iprUserDAO.getToday());
		return userid;
	}
	
	public int validUsername(String realname,String email) {
		return iprUserDAO.validUsername(realname,email);
	}
	
	public int validUseremail(String email) {
		return iprUserDAO.validUseremail(email);
	}
	
	public String reInitPassword(String email) {
		String newpw = iprUserDAO.reInitPassword(email);
		return newpw;
	}

	/**
	 * 用户验证
	 * 
	 * @param userName
	 *            用户名
	 * @param password
	 *            密码
	 * @return true：验证通过 false：验证失败
	 */
	public IprUser validUser(String username,String password, String s_allmenu) {		
		IprUser user = iprUserDAO.validUser(username,password, s_allmenu);
		jsonresult = iprUserDAO.getErrmsg();
		
		return user;
	}
	
	private String jsonresult;

	public String getJsonresult() {
		return jsonresult;
	}

	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	
	/**
	 * 集团用户验证
	 * 
	 * @param userName
	 *            用户名
	 * @return true：验证通过 false：验证失败
	 */
	public IprUser validCorpUser(long remoteAddr) {
		return iprUserDAO.validCorpUser(remoteAddr);
	}

	/**
	 * 用户密码修改
	 * 
	 * @return 1：通过 其他：失败
	 */
	public int changePWD(int userId, String oldPWD, String newPWD) {
		return iprUserDAO.changePWD(userId, oldPWD, newPWD);
	}

	/**
	 * 用户信息查询
	 * 
	 * @param userId
	 *            用户ID
	 * @param password
	 *            密码
	 * @return 1：通过 其他：失败
	 */
	public IprUser getUserInfo(int userId) {
		return iprUserDAO.getUserInfo(userId);
	}

	/**
	 * 用户信息修改
	 * 
	 * @param userId
	 *            用户ID
	 * @return 1：通过 其他：失败
	 */
	public int changeUserInfo(int userId, String userName, String phone,
			String mobile, String fax, String email, String department,
			String address) {
		return iprUserDAO.changeUserInfo(userId, userName, phone, mobile, fax,
				email, department, address);
	}
	
	public PageBaseInfo getUserLogs(String strUserName, String strStartStatTime, String strEndStatTime, int pageNo, int pageSize) {
		return iprUserDAO.getUserLogs(strUserName, strStartStatTime, strEndStatTime, pageNo, pageSize);
	}
	
	public List<MenuInfo> getMenuInfo(int userID) {
		return null;
//		return menuDAO.getUserMenu(userID);
	}

}
