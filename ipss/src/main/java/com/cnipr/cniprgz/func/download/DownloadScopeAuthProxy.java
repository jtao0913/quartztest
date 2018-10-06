package com.cnipr.cniprgz.func.download;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cnipr.cniprgz.authority.AbsDataAuthority;
import com.cnipr.cniprgz.commons.Constant;
import com.cnipr.cniprgz.commons.DataAccess;
import com.cnipr.cniprgz.dao.IprUserDAO;
import com.cnipr.cniprgz.dao.TodayLogDAO;
import com.cnipr.cniprgz.log.CniprLogger;
import com.opensymphony.xwork2.ActionContext;

public class DownloadScopeAuthProxy extends AbsDataAuthority {
	
	private ActionContext cxt = ActionContext.getContext();
	private Map<String, Object> application = cxt.getApplication();
	
	
	private HttpServletRequest request;

	private HttpServletResponse response;
	// 点卡当天下载剩余量（页数）
	private int restCount;
	
	public DownloadScopeAuthProxy(HttpServletRequest request,
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	@Override
	public boolean hasDataAuthority(String role, String funcName,
			String channelArray, int downloadCount) {
		if (role.equals("9")) {
			validGuestAuthority(downloadCount);
		} else {
			validRegisterAuthority(downloadCount);
		}
		
		if (!this.isAuthorityFlag())
			postValid();
		
		return this.isAuthorityFlag();
	}
	
	private void validGuestAuthority(int downloadCount) {
		TodayLogDAO logDAO = new TodayLogDAO();
		restCount = Integer.parseInt(DataAccess.getProperty("OneDayLimitForGuest")) - (downloadCount + logDAO.getLogCountByIp(com.cnipr.cniprgz.commons.Common.getRemoteAddr(request)));
		this.setAuthorityFlag(restCount >= 0);
	}
	
	private void validRegisterAuthority(int downloadCount) {
		IprUserDAO userDao = new IprUserDAO();
		int chCount = userDao.getCHCountByUserName((String)request.getSession().getAttribute(Constant.APP_USER_NAME));
		int oneDayLimit = 0;
		
		if (chCount >= 8000) {
			oneDayLimit = Integer.parseInt(DataAccess.getProperty("OneDayLimitOver8K"));
		} else if(chCount >= 2500 && chCount < 8000) {
			oneDayLimit = Integer.parseInt(DataAccess.getProperty("OneDayLimitBetween8KAnd2P5K"));
		} else if(chCount >= 1000 && chCount < 2500) {
			oneDayLimit = Integer.parseInt(DataAccess.getProperty("OneDayLimitForGuest"));
		}		
		
		TodayLogDAO logDAO = new TodayLogDAO();
		restCount = Integer.parseInt(DataAccess.getProperty("OneDayLimitForGuest")) - (downloadCount + logDAO.getLogCountByIp(com.cnipr.cniprgz.commons.Common.getRemoteAddr(request)));
		this.setAuthorityFlag(restCount >= 0);
	}
	
	// 数据权限验证后的要做的一些处理
	public void postValid() {
		// 以后可能会扩展一些log，或者监控什么的功能
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		try {
			response
					.getWriter()
					.write(
							"对不起，您当天只能下载100页的数据！当前还剩下" + restCount + "页。");
		} catch (IOException e) {
			CniprLogger.LogError("DownloadScopeAuthProxy postValid happend error : " + e.getMessage());
		}
	}

}
