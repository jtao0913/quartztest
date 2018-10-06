package com.cnipr.cniprgz.func;

import java.util.List;

import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.dao.DataBaseMgrDAO;
import com.cnipr.cniprgz.dao.ManageDAO;
import com.cnipr.cniprgz.entity.IprGrant;
import com.cnipr.cniprgz.entity.IprGroup;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.IprUserMenu;
import com.cnipr.cniprgz.entity.IprUserNav;
import com.cnipr.cniprgz.struts.form.UserInfoForm;

public class ManageFunc {
	
	private ManageDAO managedao;

	public void setManagedao(ManageDAO managedao) {
		this.managedao = managedao;
	}
	/**
	 * 添加新用户
	 */
	public boolean addUser(UserInfoForm form){
		 
		//需要对密码行径加密
		int userid = managedao.addUser(form);
		String[] menuArray = form.getMenuAuth();
		if(menuArray !=null && menuArray.length>0){
			modifyUserMenu(userid,menuArray);
		}
		String[] navArray = form.getIndustryList();
		if(navArray != null && navArray.length > 0){
			modifyUserNav(userid, navArray);
		}
		return true;
	}
	
	/**
	 * 查询用户列表
	 */
	public PageBaseInfo queryUserForList(int pageNo, int pageSize, String strWhere){
		if (!strWhere.equals("")) {
			strWhere = " intAdministerState=0 and " + strWhere;
		} else {
			strWhere = " intAdministerState=0 ";
		}
		return managedao.queryUserForList(pageNo,pageSize,strWhere );
	}
	
	/**
	 * 删除单个用户
	 */
	public boolean deleteUserById(int id){
		return managedao.deleteUserById(id);
	}
	
	/**
	 * 删除所有用户
	 */
	public boolean deleteUserAll(){
		return managedao.deleteAllUser();
	}
	
	/**
	 * 根据ID获取用户信息 
	 */
	public UserInfoForm getUserInfo(int userId){
		return managedao.getUserInfoById(userId);
	}
	
	/**
	 * 修改用户信息
	 */
	public boolean modifyUser(UserInfoForm form){
		int userid = form.getIntUserId();
		String[] menuArray = form.getMenuAuth();
		if(menuArray !=null && menuArray.length>0){
			modifyUserMenu(userid,menuArray);
		}
		String[] navArray = form.getIndustryList();
		if(navArray != null && navArray.length > 0){
			modifyUserNav(userid, navArray);
		}
		return managedao.modifyUser(form);
	}
	/**
	 * 修改菜单权限
	 */
	public boolean modifyUserMenu(int userid, String[] menuArray){
		boolean flag = false;
		managedao.deleteUserMenuOrNav("ipr_user_menu", userid);
		for(String e:menuArray){
			IprUserMenu menu = new IprUserMenu();
			menu.setIntUserId(userid);
			menu.setIntMenuId(Integer.parseInt(e));
			managedao.addUserMenuOrNav("ipr_user_menu", null, menu);
		}
		return flag;
	}
	/**
	 * 修改行业导航权限
	 */
	public boolean modifyUserNav(int userid, String[] navArray){
		boolean flag = false;
		managedao.deleteUserMenuOrNav("ipr_user_nav", userid);
		for(String e:navArray){
			IprUserNav nav = new IprUserNav();
			nav.setIntUserId(userid);
			nav.setIntNavId(Integer.parseInt(e));
			managedao.addUserMenuOrNav("ipr_user_nav", nav, null);
		}
		return flag;
	}
	
	/**
	 * 查询用户列表
	 */
	public PageBaseInfo queryAdminUserForList(int pageNo, int pageSize, String strWhere){
		if (!strWhere.equals("")) {
			strWhere = " intAdministerState=1 and " + strWhere;
		} else {
			strWhere = " intAdministerState=1 ";
		}
		return managedao.queryUserForList(pageNo, pageSize, strWhere);
	}
	
	public List<IprUser> queryAdminList(){
		
		String sql = "select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where " +
				" intAdministerState=1 order by intUserID";
		return managedao.queryUserBySQL(sql);
	}
	
	/**
	 * 查询用户组
	 */
	public List<IprGroup> queryGroup(String groupName){
		return managedao.queryGroup(groupName);
	}
	/**
	 * 查询单个用户组
	 */
	public IprGroup getIprGroup(int id){
		return managedao.getSingleGroup(id);
	}
	
	/**
	 * 修改用户组信息
	 */
	public boolean modifyGroup(IprGroup group){
		return managedao.modifyGroup(group);
	}
	
	/**
	 * 删除用户组信息
	 */
	public boolean deleteGroup(int id){
		return managedao.deleteGroup(id);
	}
	
	/**
	 * 添加新的用户组
	 */
	public boolean addGroup(IprGroup group){
		return managedao.addGroup(group);
	}
	
	/**
	 * 查询权限信息列表
	 */
	public List<IprGrant> getGrantList(){
		return managedao.getGrantList();
	}
	
	/**
	 * 查询授权菜单列表
	 */
	public String[][] getParamMenuList(){
		return managedao.getParamMenuInfo();
	}
	public String[][] getMenuList(int userid){
		String[][] arr = managedao.getParamMenuInfo();
		if(userid != -1){
			List<IprUserMenu> list = managedao.getUserMenuInfo(userid);
			for(String[] array:arr){
				for(IprUserMenu e:list){
					if(String.valueOf(e.getIntMenuId()).equals(array[0]))
						array[2]="selected";
				}
			}
		}
		return arr;
	}
	
	public List<IprNavtableInfo> getNavList(int intUserid, String adminId){
		DataBaseMgrDAO DBDAO = new DataBaseMgrDAO();
		List<IprNavtableInfo> all_list = DBDAO.queryForList(1, 749, adminId);
		if(intUserid != -1){
			List<IprUserNav> select_list = managedao.getUserNavInfo(intUserid);
			for(IprNavtableInfo info : all_list){
				for(IprUserNav nav : select_list){
					if(nav.getIntNavId() == info.getIntId())
						info.setIsSelected(1);
				}
			}
		}
		return all_list;
	}
	
}
