package com.cnipr.cniprgz.struts.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.jbase.common.util.security.MD5;

public class ActivateUserAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	public String activateuser() {
		String ret = SUCCESS;
		
		ActionContext cxt = ActionContext.getContext();
		Map<String, Object> application = cxt.getApplication();

		HttpServletRequest request = (HttpServletRequest) cxt.get(ServletActionContext.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse) cxt.get(ServletActionContext.HTTP_RESPONSE);
		HttpSession session = request.getSession();

		String idValue = request.getParameter("id");
//		System.out.println(idValue);
		int id = -1;
		try {
			id = Integer.parseInt(idValue);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		String checkCode = request.getParameter("checkCode");

//		String chrUserName = "";
		String chrRealName = "";
		String RegisterTime = "";
		int intUserState = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement PrePareStmtUpdate = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			ps = conn.prepareStatement("select intUserID,chrUserName,chrRealName,dtRegisterTime,intUserState from ipr_user where intUserID=" + id);
			rs = ps.executeQuery();
			if (rs.next()) {
//				chrUserName = rs.getString("chrUserName");
				chrRealName = rs.getString("chrRealName");
				RegisterTime = rs.getString("dtRegisterTime");
				intUserState = rs.getInt("intUserState");
				
				if(intUserState==1) {
					ret = INPUT;
				}else {
					if(RegisterTime!=null&&RegisterTime.length()>=19) {
						RegisterTime = RegisterTime.substring(0, 19);
					}
					
//					MD5 md5 = new MD5();
					if (checkCode.equals(MD5.md5(chrRealName+"-"+RegisterTime))) {
						intUserState = 1;
						
						PrePareStmtUpdate = conn.prepareStatement("update ipr_user set intUserState=1 where intUserID="+id);
						PrePareStmtUpdate.executeUpdate();
						PrePareStmtUpdate.close();
						
						ret = SUCCESS;
					}else {
						ret = ERROR;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				if(PrePareStmtUpdate!=null&&!PrePareStmtUpdate.isClosed()) {
					PrePareStmtUpdate.close();
				}
				if (!conn.isClosed())
					DBPoolAccessor.closeAll(rs, PrePareStmtUpdate, conn);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		
//		 验证无误，状态更改为1，即激活
//		jsonresult = "success##注册成功";

		return ret;
	}
}
