package com.cnipr.cniprgz.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.cnipr.cniprgz.commons.page.PageBaseInfo;
import com.cnipr.cniprgz.commons.page.PageSearchSupporter;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.entity.IprGrant;
import com.cnipr.cniprgz.entity.IprGroup;
import com.cnipr.cniprgz.entity.IprUser;
import com.cnipr.cniprgz.entity.IprUserMenu;
import com.cnipr.cniprgz.entity.IprUserNav;
import com.cnipr.cniprgz.entity.MenuInfo;
import com.cnipr.cniprgz.struts.form.UserInfoForm;

public class ManageDAO {
	
	/**
	 * 添加用户
	 */
	public int addUser(UserInfoForm form){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int id = 0;
		/**加密*/
		String password = form.getPassword();
		Acme.Crypto.ShaHash shahash1 = new Acme.Crypto.ShaHash();
		shahash1.addASCII(password);
		byte abyte1[] = shahash1.get();
		String pwd = Acme.Crypto.CryptoUtils.toStringBlock(abyte1);
		
		try{
		  conn = DBPoolAccessor.getConnection();
		  String sql = "insert into ipr_user(" +
		  		"chrUserName," +  //用户账号
		  		"chrUserPass," +  //用户密码
		  		"chrRealName," +  //真是姓名
		  		"chrEmail," +  //E-mail
		  		"chrPhone," +  //电话
		  		"chrMobile," +  //手机
		  		"chrFax," +  //传真
		  		"chrDepartment," +  //工作单位
		  		"chrAddress," +  //地址
		  		"dtRegisterTime," +  // 注册时间
		  		//"dtCurrentCardTime," + //当前时间
		  		"intAdministerID," +   //所属管理员
		  		"dtExpireTime," +  //过期时间
		  		"intMaxLogin," +  //最大登录数
		  		"intCHCount," +  //国内权限数
		  		"intFRCount," +  //国外权限数
		  		//"dtLastVisitTime," +
		  		"intAnalyseState," + //分析功能
		  		//"chrLastVisitIP," +
		  		//"intUserState," +
		  		"intGroupID," +   //设置用户检索权限
		  		"chrAdminMemo," + //管理员修改备注
		  		//"chrOnlineList," +
		  		//"chrMerchantID," +
		  		//"intAdministerID," +
		  		//"intMaximum," +
		  		"intDownloadedNumber," + //文摘批量下载量
		  		"intAdministerState," +  //管理员权限
		  		"chrEnterpriseName" +  //企业名称
		  		//"intMaxSearchCount," +
		  		") values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		  ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
		  ps.setString(1, form.getAccount());
		  ps.setString(2, pwd);
		  ps.setString(3, form.getRealName());
		  ps.setString(4, form.getEmail());
		  ps.setString(5, form.getPhone());
		  ps.setString(6, form.getMobile());
		  ps.setString(7, form.getFax());
		  ps.setString(8, form.getCompany());
		  ps.setString(9, form.getAddress());
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		  ps.setString(10, sdf.format(new java.util.Date()));
		  ps.setInt(11, form.getBelongAdmin());
		  ps.setString(12, form.getOverTime());
		  ps.setInt(13, form.getMaxLoginNum());
		  ps.setInt(14, form.getAuthCn());
		  ps.setInt(15, form.getAuthFr());
		  ps.setInt(16, form.getAnalysePatent());
		  ps.setInt(17, form.getIntGroupId());
		  ps.setString(18, form.getRemark());
		  ps.setInt(19, form.getBatchDownloadNum());
		  ps.setInt(20, form.getAdminStatus());
		  ps.setString(21, form.getEnterpriseName());
		  
		  ps.execute();
		  rs = ps.getGeneratedKeys();
		  if(rs.next()){
			  id = rs.getInt(1);
		  }
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return id;
	}
	
	public ArrayList<IprUser> queryUserBySQL(String sql){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<IprUser> list = new ArrayList<IprUser>();
		try{
		  conn = DBPoolAccessor.getConnection();
		  ps = conn.prepareStatement(sql);
		  rs = ps.executeQuery();
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		  while(rs.next()){
			  IprUser user = new IprUser();
			  user.setIntUserId(rs.getInt("intUserID"));
			  user.setChrUserName(rs.getString("chrUserName"));
			  user.setChrRealName(rs.getString("chrRealName"));
			  java.util.Date dt = rs.getDate("dtRegisterTime");
			  user.setDtRegisterTime(sdf.format(dt));
			  java.util.Date dt1 = rs.getDate("dtExpireTime");
			  user.setDtExpireTime(sdf.format(dt1));
			  list.add(user);
		  }
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	/**
	 * 查询用户列表
	 */
	public PageBaseInfo queryUserForList(int pageNo,int pageSize, String strWhere){
		Connection conn = null;
		PageBaseInfo pageInfo = new PageBaseInfo();
		try{
		  conn = DBPoolAccessor.getConnection();
		  String sqlsource = "select intUserID,chrUserName,chrRealName,dtRegisterTime,dtExpireTime from ipr_user " +
		  		"where " + strWhere + " order by dtRegisterTime";
		  PageSearchSupporter ps = new PageSearchSupporter();
			pageInfo = ps.accountPageinfo(conn, pageNo, pageSize, sqlsource);
			if (pageInfo.getCountPagenum() < pageNo) {
				pageNo = pageInfo.getCountPagenum();
			}
			if(pageNo < 1){
				pageNo = 1;
			}	
			String sql = ps.getPageSearchSql(sqlsource, pageNo, pageSize);
			ArrayList<IprUser> arr = this.queryUserBySQL(sql);
			pageInfo.setList(arr);
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pageInfo;
	}
	
	/**
	 * 根据用户ID删除用户
	 */
	public boolean deleteUserById(int id){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from ipr_user where intUserID='"+id+"'";
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	/**
	 * 删除所有用户
	 */
	public boolean deleteAllUser(){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from ipr_user where intAdministerID='0'";
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	public UserInfoForm getUserInfoById(int id){
		UserInfoForm form = new UserInfoForm();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from ipr_user where intUserID='"+id+"'";
		try{
		  conn = DBPoolAccessor.getConnection();
		  ps = conn.prepareStatement(sql);
		  rs = ps.executeQuery();
		  while(rs.next()){
			  form.setIntUserId(rs.getInt("intUserID"));
			  form.setAccount(rs.getString("chrUserName"));
			  form.setRealName(rs.getString("chrRealName"));
			  form.setPhone(rs.getString("chrPhone"));
			  form.setMobile(rs.getString("chrMobile"));
			  form.setFax(rs.getString("chrFax"));
			  form.setOverTime(rs.getString("dtExpireTime"));
			  form.setMaxLoginNum(rs.getInt("intMaxLogin"));
			  form.setAuthCn(rs.getInt("intCHCount"));
			  form.setAuthFr(rs.getInt("intFRCount"));
			  form.setAddress(rs.getString("chrAddress"));
			  form.setEmail(rs.getString("chrEmail"));
			  form.setCompany(rs.getString("chrDepartment"));
			  form.setBatchDownloadNum(rs.getInt("intDownloadedNumber"));
			  form.setAnalysePatent(rs.getInt("intAnalyseState"));
			  form.setRemark(rs.getString("chrAdminMemo"));
			  form.setAdminStatus(rs.getInt("intAdministerState"));
			  form.setEnterpriseName(rs.getString("chrEnterpriseName"));
			  form.setIntGroupId(rs.getInt("intGroupID"));
			  form.setIntAdminId(rs.getInt("intAdministerID"));
		  }
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return form;
	}
	
	public boolean  modifyUser(UserInfoForm form){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update ipr_user set " +
				"chrUserName='"+ form.getAccount() +"', " +
				"chrRealName='"+ form.getRealName() +"'," +
				"chrPhone='" + form.getPhone() + "'," +
				"chrMobile='" + form.getMobile() + "'," +
				"chrFax='" + form.getFax() +"'," +
				"chrEmail='" + form.getEmail() +"'," +
				"chrAddress='" + form.getAddress() + "'," +
				"chrDepartment='" + form.getCompany() + "'," +
				"intAdministerID='" + form.getBelongAdmin() + "'," +
				"dtExpireTime='" + form.getOverTime() +"'," + 
				"intMaxLogin=" + form.getMaxLoginNum() +"," +
				"intCHCount=" + form.getAuthCn() + "," +
				"intFRCount=" + form.getAuthFr() + "," +
				"intDownloadedNumber=" + form.getBatchDownloadNum() +"," +
				"intAnalyseState=" + form.getAnalysePatent() + "," +
				"chrAdminMemo='" + form.getRemark() + "'," +
				"intGroupID=" + form.getIntGroupId() + "," +
				"intAdministerState=" + form.getAdminStatus() + "," +
				"chrEnterpriseName='" + form.getEnterpriseName() + "'" +
				" where intUserID ='" + form.getIntUserId() + "'";
		System.out.println(sql);
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	//查询用户组
	public List<IprGroup> queryGroup(String groupName){
		List<IprGroup> list = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		if(groupName != null && !groupName.equals(""))
			sql = "select intGroupID,chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo from ipr_group " +
					"where chrGroupName='" +groupName+"'";
		else
			sql = "select intGroupID,chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo from ipr_group";
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<IprGroup>();
			while(rs.next()){
				IprGroup group = new IprGroup();
				group.setIntGroupId(rs.getInt("intGroupID"));
				group.setChrGroupName(rs.getString("chrGroupName"));
				group.setChrChannelId(rs.getString("chrChannelID"));
				group.setChrItemGrant(rs.getString("chrItemGrant"));
				group.setChrGroupMemo(rs.getString("chrGroupMemo"));
				list.add(group);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/**
	 * 创建新的用户组
	 */
	public boolean addGroup(IprGroup group){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql ="insert into ipr_group(chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo) values('"+group.getChrGroupName()+"','" +
				group.getChrChannelId()+"','" +
				group.getChrItemGrant()+ "','" +
				group.getChrGroupMemo() +"')";
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	/**
	 * 查询单个用户组信息
	 */
	public IprGroup getSingleGroup(int id){
		IprGroup group = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select intGroupID,chrGroupName,chrChannelID,chrItemGrant,chrGroupMemo from ipr_group where " +
				"intGroupID="+id;
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			group = new IprGroup();
			while(rs.next()){
				group.setIntGroupId(rs.getInt("intGroupID"));
				group.setChrGroupName(rs.getString("chrGroupName"));
				group.setChrChannelId(rs.getString("chrChannelID"));
				group.setChrItemGrant(rs.getString("chrItemGrant"));
				group.setChrGroupMemo(rs.getString("chrGroupMemo"));
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return group;
	}
	
	/**
	 * 删除用户组信息
	 */
	public boolean deleteGroup(int id){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from ipr_group where intGroupID="+id;
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 修改用户组信息
	 */
	public boolean modifyGroup(IprGroup group){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update ipr_group set chrGroupName='"+group.getChrGroupName() + "', " +
				"chrChannelID='" + group.getChrChannelId() + "', " +
				"chrItemGrant='" + group.getChrItemGrant() + "', " +
				"chrGroupMemo='" + group.getChrGroupMemo() + "' where " +
				"intGroupID="+group.getIntGroupId();
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 获取权限列表
	 */
	public List<IprGrant> getGrantList(){
		List<IprGrant> list = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select intGrantId,chrGrantName,intChannelId,chrGrantMemo,intPrice from ipr_grant order by intGrantId";
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<IprGrant>();
			while(rs.next()){
				IprGrant grant = new IprGrant();
				grant.setIntGrantId(rs.getInt("intGrantId"));
				grant.setChrGrantName(rs.getString("chrGrantName"));
				grant.setIntChannelId(rs.getInt("intChannelId"));
				grant.setChrGrantMemo(rs.getString("chrGrantMemo"));
				grant.setIntPrice(rs.getInt("intPrice"));
				list.add(grant);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	/**
	 * 查询菜单信息，用户授权时用
	 */
	public String[][] getParamMenuInfo(){
		String[][] arr = null;
		List<MenuInfo> list = findMenuInfoByParentId(0);
		List<MenuInfo> all_list = findMenuInfoByParentId(-1);
		arr = new String[all_list.size()][3];
		int i=0;
		for(MenuInfo info:list){
			arr[i][0]=info.getIntMenuID()+"";
			arr[i][1]="|─" + info.getChrMenuName();
			arr[i][2]="";
			i++;
			List<MenuInfo> ls = findMenuInfoByParentId(info.getIntMenuID());
			for(MenuInfo info1:ls){
				arr[i][0]=info1.getIntMenuID()+"";
				arr[i][1]="|　|─" + info1.getChrMenuName();
				arr[i][2]="";
				i++;
			}
		}
		return arr;
	}
	/**
	 * 根据parentId检索菜单信息列表，
	 * 当panentId为-1时，检索全部菜单信息
	 */
	public List<MenuInfo> findMenuInfoByParentId(int parentId){
		List<MenuInfo> list = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		if(parentId == -1){
			sql = "select intMenuID,chrMenuName,chrMenuURL,intParentID,intExpandFlag from ipr_param_menu_info";
		}else{
			sql = "select intMenuID,chrMenuName,chrMenuURL,intParentID,intExpandFlag from ipr_param_menu_info where intParentID="+parentId+" order by intMenuID asc";
		}
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MenuInfo>();
			while(rs.next()){
				MenuInfo info = new MenuInfo();
				info.setIntMenuID(rs.getInt("intMenuID"));
				info.setChrMenuName(rs.getString("chrMenuName"));
				info.setChrMenuURL(rs.getString("chrMenuURL"));
				info.setIntParentID(rs.getInt("intParentID"));
//				info.setIntExpandFlag(rs.getInt("intExpandFlag"));
				list.add(info);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	/**
	 * 查询菜单授权信息
	 */
	public List<IprUserMenu> getUserMenuInfo(int userId){
		List<IprUserMenu> list = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select Id,intUserID,intMenuID from ipr_user_menu where intUserID=" + userId;
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<IprUserMenu>();
			while(rs.next()){
				IprUserMenu userMenu = new IprUserMenu();
				userMenu.setId(rs.getInt("Id"));
				userMenu.setIntMenuId(rs.getInt("intMenuId"));
				userMenu.setIntUserId(rs.getInt("intUserId"));
				list.add(userMenu);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
		
	}
	
	/**
	 * 查询行业授权信息
	 */
	public List<IprUserNav> getUserNavInfo(int userId){
		List<IprUserNav> list = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select Id,intUserID,intNavID,chrUserIP,intCNCount,intFRCount from ipr_user_nav where intUserID="+userId;
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<IprUserNav>();
			while(rs.next()){
				IprUserNav userNav = new IprUserNav();
				userNav.setId(rs.getInt("Id"));
				userNav.setIntNavId(rs.getInt("intUserID"));
				userNav.setIntNavId(rs.getInt("intNavID"));
				userNav.setChrUserIP(rs.getString("chrUserIP"));
				userNav.setIntCNCount(rs.getInt("intCNCount"));
				userNav.setIntFRCount(rs.getInt("intFRCount"));
				list.add(userNav);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	/**
	 * 删除用户菜单权限
	 */
	public boolean deleteUserMenuOrNav(String database,int userid){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from " + database + " where intUserID="+userid;
		try{
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement(sql);
			ps.execute();
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	/**
	 * 删除用户导航权限
	 */
	public boolean addUserMenuOrNav(String database,IprUserNav nav,IprUserMenu menu){
		boolean flag = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "";
		if(database !=null && "ipr_user_nav".equals(database)){
			sql = "insert into ipr_user_nav(intUserID,chrUserIP,intNavID,dtUpdateDate,intCNCount,intFRCount) values(" +
					nav.getIntUserId() + ",'" +
					nav.getChrUserIP() + "'," +
					nav.getIntNavId()+", now()," +
					nav.getIntCNCount() + "," +
					nav.getIntFRCount()+")";
		}else if(menu!=null){
			sql="insert into ipr_user_menu(intUserID,intMenuID) values(" +
					menu.getIntUserId()+"," +
					menu.getIntMenuId() + ")";
		}
		try{
			if(!"".equals(sql)){
				conn = DBPoolAccessor.getConnection();
				ps = conn.prepareStatement(sql);
				ps.execute();
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
}
