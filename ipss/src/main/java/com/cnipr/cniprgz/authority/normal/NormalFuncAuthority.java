package com.cnipr.cniprgz.authority.normal;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.authority.AbsFuncAuthority;
import com.cnipr.cniprgz.db.DBPoolAccessor;
import com.cnipr.cniprgz.log.CniprLogger;

public class NormalFuncAuthority extends AbsFuncAuthority {

	private HttpServletRequest httpRequest;
	private HttpServletResponse httpResponse;

	public NormalFuncAuthority(HttpServletRequest httpRequest,
			HttpServletResponse httpResponse) {
		this.httpRequest = httpRequest;
		this.httpResponse = httpResponse;
	}

	@Override
	public boolean hasFuncAuthority(String method, Integer userRoleId) {
		boolean flag = false;

		if (method != null && !method.equals("") && userRoleId != null
				&& userRoleId != 0) {

			flag = validFuncAuthority(method, userRoleId);
		}

		if (!flag) {
			postValid();
		}

		return flag;
	}

	private boolean validFuncAuthority(String method, Integer userRoleId) {
		boolean flag = false;

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBPoolAccessor.getConnection();
			String sql = "SELECT ipr_grant.intGrantID FROM ipr_grant WHERE ipr_grant.chrGrantName =  '"
					+ method + "'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (!rs.next()) {
				return true;
			} else {
				sql = "SELECT DISTINCT ipr_grant.chrGrantMemo FROM ipr_grant , ipr_role_func WHERE ipr_grant.intGrantID =  ipr_role_func.grantId AND ipr_role_func.groupId = "
						+ userRoleId
						+ " AND ipr_grant.chrGrantName =  '"
						+ method + "'";

				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				if (rs.next()) {
					flag = true;
				}
			}
		} catch (Exception e) {
			CniprLogger
					.LogError("NormalFuncAuthority validFuncAuthority happended error : "
							+ e.getMessage());
		} finally {
			DBPoolAccessor.closeAll(rs, ps, conn);
		}

		return flag;
	}

	private void postValid() {
		try {
			httpRequest.setAttribute("noFuncAuthority", "对不起，您没有使用该项功能的权限!");
			httpRequest.getRequestDispatcher("/authorityError.jsp").forward(httpRequest,
					httpResponse);
		} catch (ServletException e) {
			CniprLogger
					.LogError("NormalFuncAuthority validFuncAuthority happended error : "
							+ e.getMessage());
		} catch (IOException e) {
			CniprLogger
					.LogError("NormalFuncAuthority validFuncAuthority happended error : "
							+ e.getMessage());
		}
	}

}
