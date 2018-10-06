package com.cnipr.cniprgz.struts.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.fenye.Page;
import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.entity.IprGrant;
import com.cnipr.cniprgz.entity.IprGroup;
import com.cnipr.cniprgz.entity.IprNavtableInfo;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.func.ManageFunc;
import com.cnipr.cniprgz.struts.form.UserInfoForm;
import com.opensymphony.xwork2.ActionSupport;

public class UserManageAction extends ActionSupport {

	private ManageFunc manage;

	public void setManage(ManageFunc manage) {
		this.manage = manage;
	}

	/**
	 * 添加新用户
	 * 
	 * @author zhaoliang
	 */
/*	public String addUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserInfoForm userForm = (UserInfoForm) form;
		
		boolean rs = manage.addUser(userForm);  
		if (rs) {			
			return mapping.findForward("success");
		} else {
			return mapping.findForward("fail");

		}
	}*/

//	/**
//	 * 查询用户信息列表
//	 */
//	public ActionForward queryUser(ActionMapping mapping, ActionForm form,
//			HttpServletRequest request, HttpServletResponse response)
//			throws Exception {
//
//		PageBaseInfo userInfo = manage.queryUserForList("");
//		request.setAttribute("userlist", userInfo);
//		return mapping.findForward("userList");
//	}
	/**
	 * 查询用户信息列表
	 */
/*	public ActionForward queryUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 当前页下标
		String pageIndex = request.getParameter("pageIndex");

		if (pageIndex == null || pageIndex.equals("") || pageIndex.equals("null")) {
			pageIndex = "1";
		}
		
		String strWhere = request.getParameter("strWhere");
		if (strWhere == null) {
			strWhere = "";
		}

		PageBaseInfo userInfo = manage.queryUserForList(Integer
				.parseInt(pageIndex), Constant.PAGERECORD, strWhere);
		
		request.getSession().removeAttribute("adminUserlist");
		request.getSession().setAttribute("adminUserlist", userInfo.getList());
		Page nav = new Page();
		nav.setPageIndex(pageIndex);
		nav.setPageCount(Integer.toString(userInfo.getCountPagenum()));
		nav.setNavigationUrl(request.getContextPath());
		request.setAttribute("totalRecord", userInfo.getCountRownum());
		request.setAttribute("nav", nav);
		
		
		return mapping.findForward("userList");
	}*/

	/**
	 * 根据用户ID删除用户
	 */
	/*public ActionForward deleteById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String tempid = request.getParameter("userid");
		if (tempid != null && tempid.length() > 0) {
			int userid = Integer.parseInt(tempid);
			manage.deleteUserById(userid);
		}
		
		String userType = request.getParameter("type");
		String currentPage = request.getParameter("currentPage");
		if (currentPage == null || currentPage.equals("")) {
			currentPage = "1";
		}
		if (userType != null && userType.equals("admin")) {
//			userInfo = manage.queryAdminUserForList(Integer.parseInt(currentPage),  Constant.PAGERECORD);
//			request.setAttribute("userlist", userInfo);
			return queryAdminUser(mapping, form,
					request, response);
		} else {
			return queryUser(mapping, form,
					request, response);
		}	
	}*/
	
	/**
	 * 跳转进入用户添加页面
	 */
	/*public ActionForward goAddUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		
		List<IprNavtableInfo> DBlist = manage.getNavList(-1, null);
		List<IprGroup> groupList = manage.queryGroup(null);
		List<IprUser> adminList = manage.queryAdminList(); 
		String[][] arr = manage.getMenuList(-1);
		request.setAttribute("dbList", DBlist);
		request.setAttribute("groupList", groupList);
		request.setAttribute("menuArr", arr);
		request.setAttribute("adminList", adminList);
		
		return mapping.findForward("newUser");
	}*/

	/**
	 * 根据用户ID获取用户信息
	 */
	/*public ActionForward updateById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String tempid = request.getParameter("userid");
		UserInfoForm userform = new UserInfoForm();
		int userid = 0;
		if (tempid != null && tempid.length() > 0) {
			userid = Integer.parseInt(tempid);
			userform = manage.getUserInfo(userid);
		}
		
		String userType = request.getParameter("type");
		
		if (userType != null && userType.equals("admin")) {
			request.setAttribute("userType", userType);
		}
		List<IprNavtableInfo> DBlist = manage.getNavList(userid, (String) request
				.getSession().getAttribute(Constant.APP_USER_ID));
		List<IprGroup> groupList = manage.queryGroup(null);
		List<IprUser> adminList = manage.queryAdminList(); 
		String[][] arr = manage.getMenuList(userid);
		request.setAttribute("dbList", DBlist);
		request.setAttribute("groupList", groupList);
		request.setAttribute("menuArr", arr);
		request.setAttribute("adminList", adminList);
		request.setAttribute("userInfo", userform);
		return mapping.findForward("updatePage");
	}*/

	/**
	 * 提交修改的用户信息
	 */
	/*public ActionForward modifyUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserInfoForm userform = (UserInfoForm) form;
		manage.modifyUser(userform);
		return queryUser(mapping, form,
				request, response);
	}*/

	/**
	 * 查询管理员用户信息列表
	 */
	/* 
	 public ActionForward queryAdminUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 当前页下标
		String pageIndex = request.getParameter("pageIndex");

		if (pageIndex == null || pageIndex.equals("") || pageIndex.equals("null")) {
			pageIndex = "1";
		}
		
		String strWhere = request.getParameter("strWhere");
		if (strWhere == null) {
			strWhere = "";
		}

		PageBaseInfo userInfo = manage.queryAdminUserForList(Integer
				.parseInt(pageIndex), Constant.PAGERECORD, strWhere);
//		int startIndex =( Integer.parseInt(pageIndex) - 1 ) * Constant.PAGERECORD;
//		int endIndex = startIndex + Constant.PAGERECORD;
//		String sql = "select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user where intAdministerState=1 order by dtRegisterTime desc limit " + startIndex + ", "  + endIndex;
		
		request.getSession().removeAttribute("adminUserlist");
		request.getSession().setAttribute("adminUserlist", userInfo.getList());
		Page nav = new Page();
		nav.setPageIndex(pageIndex);
		nav.setPageCount(Integer.toString(userInfo.getCountPagenum()));
		nav.setNavigationUrl(request.getContextPath());
		request.setAttribute("totalRecord", userInfo.getCountRownum());
		request.setAttribute("nav", nav);
		
		
		return mapping.findForward("adminList");
	}*/

	/**
	 * 查询管理员用户信息列表
	 */
	/*public ActionForward queryGroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String name = request.getParameter("groupName");
		List<IprGroup> list = manage.queryGroup(name);
		request.setAttribute("groupList", list);
		return mapping.findForward("groupPage");
	}*/
	/**
	 * 查询单个用户组信息
	 */
	/*
	 public ActionForward querySingleGroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String flag = request.getParameter("copeOrModify");
		String id = request.getParameter("groupId");
		int intGroupId = Integer.parseInt(id);
		IprGroup group = manage.getIprGroup(intGroupId);
		String[] grantArray = group.getChrItemGrant().split(",");
		List<IprGrant> grantList = manage.getGrantList();
		
		for(IprGrant grant : grantList) {
			for (String strGrant : grantArray) {
				if( grant.getIntGrantId() == Integer.parseInt(strGrant)) {
					grant.setIsSelected("selected");
				}
			}
		}
		
		request.setAttribute("grantList", grantList);
		request.setAttribute("groupInfo", group);
		
		if(flag!=null && "copy".equals(flag))
			return mapping.findForward("newGroup");
		else
			return mapping.findForward("groupUpdatePage");
	}*/
	
	/**
	 * 初始化新用户组创建页面
	 */
	/*public ActionForward goNewGroupPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		List<IprGrant> grant = manage.getGrantList();
		request.setAttribute("grantList", grant);
		return mapping.findForward("newGroup");
	}*/
	
	/**
	 * 创建用户组信息
	 */
	/*public ActionForward addGroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		IprGroup group = new IprGroup();
		String name = request.getParameter("groupName");
		String channels = "";
		String memo = request.getParameter("groupMemo");
		String[] itemGrant = request.getParameterValues("itemGrant");
		Map<String,String> map = new HashMap<String,String>();
		String grant = "";
		for(String item:itemGrant){
			String[] context = item.split("#");
			grant += context[0]+",";
			map.put(context[1], context[1]);
		}
		if(grant == null || "".equals(grant))
			grant="20,29,28,27,26,25,24,23,22,21,39,40,41,38,37,36,35,33,32,34,47,48,51,50,49,52,44,45,46,58,65,63,62,61,60,57,64,59,211,66,74,73,72,71,70,69,68,67,78,75,83,82,81,80,79,77,76,88,92,91,90,221,89,87,86,85,84";
		else
			grant = grant.substring(0,grant.length()-1);
		for(String e:map.values()){
			channels+=e+",";
		}
		channels = channels.substring(0,channels.length()-1);
		group.setChrGroupMemo(memo);
		group.setChrGroupName(name);
		group.setChrItemGrant(grant);
		group.setChrChannelId(channels);
		
		manage.addGroup(group);
		List<IprGroup> list = manage.queryGroup(null);
		request.setAttribute("groupList", list);
		return mapping.findForward("groupPage");
	}*/
	/**
	 * 修改用户组信息
	 */
	/*public ActionForward modifyGroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("groupId");
		IprGroup group = new IprGroup();
		int intGroupId = Integer.parseInt(id);
		String name = request.getParameter("groupName");
		String channels = "";
		String memo = request.getParameter("groupMemo");
		String[] itemGrant = request.getParameterValues("itemGrant");
		Map<String,String> map = new HashMap<String,String>();
		String grant = "";
		for(String item:itemGrant){
			String[] context = item.split("#");
			grant += context[0]+",";
			map.put(context[1], context[1]);
		}
		if(grant == null || "".equals(grant))
			grant="20,29,28,27,26,25,24,23,22,21,39,40,41,38,37,36,35,33,32,34,47,48,51,50,49,52,44,45,46,58,65,63,62,61,60,57,64,59,211,66,74,73,72,71,70,69,68,67,78,75,83,82,81,80,79,77,76,88,92,91,90,221,89,87,86,85,84";
		else
			grant = grant.substring(0,grant.length()-1);
		for(String e:map.values()){
			channels+=e+",";
		}
		channels = channels.substring(0,channels.length()-1);
		group.setChrGroupMemo(memo);
		group.setIntGroupId(intGroupId);
		group.setChrGroupName(name);
		group.setChrItemGrant(grant);
		group.setChrChannelId(channels);
		
		manage.modifyGroup(group);
		List<IprGroup> list = manage.queryGroup(null);
		request.setAttribute("groupList", list);
		return mapping.findForward("groupPage");
	}*/
	/**
	 * 删除用户组信息
	 */
	/*public ActionForward deleteGroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String id = request.getParameter("groupId");
		int intGroupId = Integer.parseInt(id);
		manage.deleteGroup(intGroupId);
		List<IprGroup> list = manage.queryGroup(null);
		request.setAttribute("groupList", list);
		return mapping.findForward("groupPage");
	}*/
	
	
}
