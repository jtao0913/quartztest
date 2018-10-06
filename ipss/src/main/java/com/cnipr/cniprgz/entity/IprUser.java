package com.cnipr.cniprgz.entity;

import java.util.Date;

public class IprUser {
	private Integer intUserId;

	private String chrUserName;

	private String chrUserPass;

	private String chrRealName;

	private String chrEmail;

	private String chrPhone;

	private String chrMobile;

	private String chrFax;

	private String chrDepartment;

	private String chrAddress;

	private String dtRegisterTime;

	private String dtCurrentCardTime;

	private String dtExpireTime;

	private Integer intMaxLogin;

	private Integer intChcount;

	private Integer intFrcount;

	private Date dtLastVisitTime;

	private String chrLastVisitIp;

	private Integer intUserState;

	private Integer intGroupId;

	private String chrAdminMemo;

	private String chrOnlineList;

	private String chrMerchantId;

	private String chrMac;

	private String chrIpadress;

	private int intAdministerId;

	private Integer intMaximum;

	private String chrYear;

	private Integer intDownloadedNumber;

	private String chrHerbalName;

	private Integer intHerbalDataBase;

	private String chrMenu;

	private Integer intAdministerState;

	private String chrEnterpriseName;

	private Integer intMaxSearchCount;

	private Integer intMaxNavCount;

	private Integer intMaxUserCount;

	private Integer intAnalyseState;
	
	private Integer intAnalyseNumUpperlimit;

	public Integer getIntAnalyseNumUpperlimit() {
		return intAnalyseNumUpperlimit;
	}

	public void setIntAnalyseNumUpperlimit(Integer intAnalyseNumUpperlimit) {
		this.intAnalyseNumUpperlimit = intAnalyseNumUpperlimit;
	}

	private String chrChannelId;

	private String chrItemGrant;

	private Integer intUserAreaId;

	private Integer intAdminAreaId;

	private String chrLastIp;

	private Date dtLastTime;

	private Integer intTifDpnumberOneDay;
	
	private Integer feeType;
	
	// Constructors
	/** default constructor */
	public IprUser() {
	}

	/** minimal constructor */
	public IprUser(String chrUserName, String chrUserPass, String dtRegisterTime,
			String dtCurrentCardTime, String dtExpireTime, Integer intMaxLogin,
			Integer intChcount, Integer intFrcount, Integer intUserState,
			Integer intGroupId) {
		this.chrUserName = chrUserName;
		this.chrUserPass = chrUserPass;
		this.dtRegisterTime = dtRegisterTime;
		this.dtCurrentCardTime = dtCurrentCardTime;
		this.dtExpireTime = dtExpireTime;
		this.intMaxLogin = intMaxLogin;
		this.intChcount = intChcount;
		this.intFrcount = intFrcount;
		this.intUserState = intUserState;
		this.intGroupId = intGroupId;
	}

	/** full constructor */
	public IprUser(String chrUserName, String chrUserPass, String chrRealName,
			String chrEmail, String chrPhone, String chrMobile, String chrFax,
			String chrDepartment, String chrAddress, String dtRegisterTime,
			String dtCurrentCardTime, String dtExpireTime, Integer intMaxLogin,
			Integer intChcount, Integer intFrcount, Date dtLastVisitTime,
			String chrLastVisitIp, Integer intUserState, Integer intGroupId,
			String chrAdminMemo, String chrOnlineList, String chrMerchantId,
			String chrMac, String chrIpadress, int intAdministerId,
			Integer intMaximum, String chrYear, Integer intDownloadedNumber,
			String chrHerbalName, Integer intHerbalDataBase, String chrMenu,
			Integer intAdministerState, String chrEnterpriseName,
			Integer intMaxSearchCount, Integer intMaxNavCount,
			Integer intMaxUserCount, Integer intAnalyseState,Integer intAnalyseNumUpperlimit,
			String chrChannelId, String chrItemGrant, Integer intUserAreaId,
			Integer intAdminAreaId, String chrLastIp, Date dtLastTime,
			Integer intTifDpnumberOneDay, Integer feeType) {
		this.chrUserName = chrUserName;
		this.chrUserPass = chrUserPass;
		this.chrRealName = chrRealName;
		this.chrEmail = chrEmail;
		this.chrPhone = chrPhone;
		this.chrMobile = chrMobile;
		this.chrFax = chrFax;
		this.chrDepartment = chrDepartment;
		this.chrAddress = chrAddress;
		this.dtRegisterTime = dtRegisterTime;
		this.dtCurrentCardTime = dtCurrentCardTime;
		this.dtExpireTime = dtExpireTime;
		this.intMaxLogin = intMaxLogin;
		this.intChcount = intChcount;
		this.intFrcount = intFrcount;
		this.dtLastVisitTime = dtLastVisitTime;
		this.chrLastVisitIp = chrLastVisitIp;
		this.intUserState = intUserState;
		this.intGroupId = intGroupId;
		this.chrAdminMemo = chrAdminMemo;
		this.chrOnlineList = chrOnlineList;
		this.chrMerchantId = chrMerchantId;
		this.chrMac = chrMac;
		this.chrIpadress = chrIpadress;
		this.intAdministerId = intAdministerId;
		this.intMaximum = intMaximum;
		this.chrYear = chrYear;
		this.intDownloadedNumber = intDownloadedNumber;
		this.chrHerbalName = chrHerbalName;
		this.intHerbalDataBase = intHerbalDataBase;
		this.chrMenu = chrMenu;
		this.intAdministerState = intAdministerState;
		this.chrEnterpriseName = chrEnterpriseName;
		this.intMaxSearchCount = intMaxSearchCount;
		this.intMaxNavCount = intMaxNavCount;
		this.intMaxUserCount = intMaxUserCount;
		this.intAnalyseState = intAnalyseState;
		this.intAnalyseNumUpperlimit = intAnalyseNumUpperlimit;
		this.chrChannelId = chrChannelId;
		this.chrItemGrant = chrItemGrant;
		this.intUserAreaId = intUserAreaId;
		this.intAdminAreaId = intAdminAreaId;
		this.chrLastIp = chrLastIp;
		this.dtLastTime = dtLastTime;
		this.intTifDpnumberOneDay = intTifDpnumberOneDay;
		this.feeType = feeType;
	}

	// Property accessors

	public Integer getIntUserId() {
		return this.intUserId;
	}

	public void setIntUserId(Integer intUserId) {
		this.intUserId = intUserId;
	}

	public String getChrUserName() {
		return this.chrUserName;
	}

	public void setChrUserName(String chrUserName) {
		this.chrUserName = chrUserName;
	}

	public String getChrUserPass() {
		return this.chrUserPass;
	}

	public void setChrUserPass(String chrUserPass) {
		this.chrUserPass = chrUserPass;
	}

	public String getChrRealName() {
		return this.chrRealName;
	}

	public void setChrRealName(String chrRealName) {
		this.chrRealName = chrRealName;
	}

	public String getChrEmail() {
		return this.chrEmail;
	}

	public void setChrEmail(String chrEmail) {
		this.chrEmail = chrEmail;
	}

	public String getChrPhone() {
		return this.chrPhone;
	}

	public void setChrPhone(String chrPhone) {
		this.chrPhone = chrPhone;
	}

	public String getChrMobile() {
		return this.chrMobile;
	}

	public void setChrMobile(String chrMobile) {
		this.chrMobile = chrMobile;
	}

	public String getChrFax() {
		return this.chrFax;
	}

	public void setChrFax(String chrFax) {
		this.chrFax = chrFax;
	}

	public String getChrDepartment() {
		return this.chrDepartment;
	}

	public void setChrDepartment(String chrDepartment) {
		this.chrDepartment = chrDepartment;
	}

	public String getChrAddress() {
		return this.chrAddress;
	}

	public void setChrAddress(String chrAddress) {
		this.chrAddress = chrAddress;
	}

	public String getDtRegisterTime() {
		return this.dtRegisterTime;
	}

	public void setDtRegisterTime(String dtRegisterTime) {
		this.dtRegisterTime = dtRegisterTime;
	}

	public String getDtCurrentCardTime() {
		return this.dtCurrentCardTime;
	}

	public void setDtCurrentCardTime(String dtCurrentCardTime) {
		this.dtCurrentCardTime = dtCurrentCardTime;
	}

	public String getDtExpireTime() {
		return this.dtExpireTime;
	}

	public void setDtExpireTime(String dtExpireTime) {
		this.dtExpireTime = dtExpireTime;
	}

	public Integer getIntMaxLogin() {
		return this.intMaxLogin;
	}

	public void setIntMaxLogin(Integer intMaxLogin) {
		this.intMaxLogin = intMaxLogin;
	}

	public Integer getIntChcount() {
		return this.intChcount;
	}

	public void setIntChcount(Integer intChcount) {
		this.intChcount = intChcount;
	}

	public Integer getIntFrcount() {
		return this.intFrcount;
	}

	public void setIntFrcount(Integer intFrcount) {
		this.intFrcount = intFrcount;
	}

	public Date getDtLastVisitTime() {
		return this.dtLastVisitTime;
	}

	public void setDtLastVisitTime(Date dtLastVisitTime) {
		this.dtLastVisitTime = dtLastVisitTime;
	}

	public String getChrLastVisitIp() {
		return this.chrLastVisitIp;
	}

	public void setChrLastVisitIp(String chrLastVisitIp) {
		this.chrLastVisitIp = chrLastVisitIp;
	}

	public Integer getIntUserState() {
		return this.intUserState;
	}

	public void setIntUserState(Integer intUserState) {
		this.intUserState = intUserState;
	}

	public Integer getIntGroupId() {
		return this.intGroupId;
	}

	public void setIntGroupId(Integer intGroupId) {
		this.intGroupId = intGroupId;
	}

	public String getChrAdminMemo() {
		return this.chrAdminMemo;
	}

	public void setChrAdminMemo(String chrAdminMemo) {
		this.chrAdminMemo = chrAdminMemo;
	}

	public String getChrOnlineList() {
		return this.chrOnlineList;
	}

	public void setChrOnlineList(String chrOnlineList) {
		this.chrOnlineList = chrOnlineList;
	}

	public String getChrMerchantId() {
		return this.chrMerchantId;
	}

	public void setChrMerchantId(String chrMerchantId) {
		this.chrMerchantId = chrMerchantId;
	}

	public String getChrMac() {
		return this.chrMac;
	}

	public void setChrMac(String chrMac) {
		this.chrMac = chrMac;
	}

	public String getChrIpadress() {
		return this.chrIpadress;
	}

	public void setChrIpadress(String chrIpadress) {
		this.chrIpadress = chrIpadress;
	}

	public int getIntAdministerId() {
		return this.intAdministerId;
	}

	public void setIntAdministerId(int intAdministerId) {
		this.intAdministerId = intAdministerId;
	}

	public Integer getIntMaximum() {
		return this.intMaximum;
	}

	public void setIntMaximum(Integer intMaximum) {
		this.intMaximum = intMaximum;
	}

	public String getChrYear() {
		return this.chrYear;
	}

	public void setChrYear(String chrYear) {
		this.chrYear = chrYear;
	}

	public Integer getIntDownloadedNumber() {
		return this.intDownloadedNumber;
	}

	public void setIntDownloadedNumber(Integer intDownloadedNumber) {
		this.intDownloadedNumber = intDownloadedNumber;
	}

	public String getChrHerbalName() {
		return this.chrHerbalName;
	}

	public void setChrHerbalName(String chrHerbalName) {
		this.chrHerbalName = chrHerbalName;
	}

	public Integer getIntHerbalDataBase() {
		return this.intHerbalDataBase;
	}

	public void setIntHerbalDataBase(Integer intHerbalDataBase) {
		this.intHerbalDataBase = intHerbalDataBase;
	}

	public String getChrMenu() {
		return this.chrMenu;
	}

	public void setChrMenu(String chrMenu) {
		this.chrMenu = chrMenu;
	}

	public Integer getIntAdministerState() {
		return this.intAdministerState;
	}

	public void setIntAdministerState(Integer intAdministerState) {
		this.intAdministerState = intAdministerState;
	}

	public String getChrEnterpriseName() {
		return this.chrEnterpriseName;
	}

	public void setChrEnterpriseName(String chrEnterpriseName) {
		this.chrEnterpriseName = chrEnterpriseName;
	}

	public Integer getIntMaxSearchCount() {
		return this.intMaxSearchCount;
	}

	public void setIntMaxSearchCount(Integer intMaxSearchCount) {
		this.intMaxSearchCount = intMaxSearchCount;
	}

	public Integer getIntMaxNavCount() {
		return this.intMaxNavCount;
	}

	public void setIntMaxNavCount(Integer intMaxNavCount) {
		this.intMaxNavCount = intMaxNavCount;
	}

	public Integer getIntMaxUserCount() {
		return this.intMaxUserCount;
	}

	public void setIntMaxUserCount(Integer intMaxUserCount) {
		this.intMaxUserCount = intMaxUserCount;
	}

	public Integer getIntAnalyseState() {
		return this.intAnalyseState;
	}

	public void setIntAnalyseState(Integer intAnalyseState) {
		this.intAnalyseState = intAnalyseState;
	}

	public String getChrChannelId() {
		return this.chrChannelId;
	}

	public void setChrChannelId(String chrChannelId) {
		this.chrChannelId = chrChannelId;
	}

	public String getChrItemGrant() {
		return this.chrItemGrant;
	}

	public void setChrItemGrant(String chrItemGrant) {
		this.chrItemGrant = chrItemGrant;
	}

	public Integer getIntUserAreaId() {
		return this.intUserAreaId;
	}

	public void setIntUserAreaId(Integer intUserAreaId) {
		this.intUserAreaId = intUserAreaId;
	}

	public Integer getIntAdminAreaId() {
		return this.intAdminAreaId;
	}

	public void setIntAdminAreaId(Integer intAdminAreaId) {
		this.intAdminAreaId = intAdminAreaId;
	}

	public String getChrLastIp() {
		return this.chrLastIp;
	}

	public void setChrLastIp(String chrLastIp) {
		this.chrLastIp = chrLastIp;
	}

	public Date getDtLastTime() {
		return this.dtLastTime;
	}

	public void setDtLastTime(Date dtLastTime) {
		this.dtLastTime = dtLastTime;
	}

	public Integer getIntTifDpnumberOneDay() {
		return this.intTifDpnumberOneDay;
	}

	public void setIntTifDpnumberOneDay(Integer intTifDpnumberOneDay) {
		this.intTifDpnumberOneDay = intTifDpnumberOneDay;
	}
	
	public Integer getFeeType() {
		return feeType;
	}

	public void setFeeType(Integer feeType) {
		this.feeType = feeType;
	}

}
