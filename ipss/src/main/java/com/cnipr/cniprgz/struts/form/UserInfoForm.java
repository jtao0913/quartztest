package com.cnipr.cniprgz.struts.form;


public class UserInfoForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4545994895028286350L;
	
	/** user id */
	private int intUserId;

	/** user account for login */
	private String account;
	
	/** user real name */
	private String realName;
	
	/** password for login */
	private String password;
	
	/** telephone number */
	private String phone;
	
	/** mobile number*/
	private String mobile;
	
	/** fax number */
	private String fax;
	
	/** E-mail */
	private String email;
	
	/** address */
	private String address;
	
	/** company */
	private String company;
	
	/** the administrator of the user belong to */
	private int belongAdmin;
	
	/** invalidation time */
	private String overTime;
	
	/** the max number for login*/
	private int maxLoginNum;
	
	private int authCn;
	
	private int addAuthCn;
	
	private int authFr;
	
	private int addAuthFr;
	
	private int batchDownloadNum;
	
	private int analysePatent;
	
	private String remark;
	
	private String[] searchAuth;
	
	private String[] menuAuth;
	
	private String[] industryList;
	
	//private List<String> enterpriseList;
	
	//private List<String> individualList;
	
	private int adminStatus;
	
	private String enterpriseName;
	
	private String fromUrl;
	
	private String requsetInfo;
	
	private int intGroupId;
	
	private int intAdminId;

	public int getIntAdminId() {
		return intAdminId;
	}

	public void setIntAdminId(int intAdminId) {
		this.intAdminId = intAdminId;
	}

	public int getIntGroupId() {
		return intGroupId;
	}

	public void setIntGroupId(int intGroupId) {
		this.intGroupId = intGroupId;
	}

	public int getIntUserId() {
		return intUserId;
	}

	public void setIntUserId(int intUserId) {
		this.intUserId = intUserId;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public int getBelongAdmin() {
		return belongAdmin;
	}

	public void setBelongAdmin(int belongAdmin) {
		this.belongAdmin = belongAdmin;
	}

	public String getOverTime() {
		if(overTime.length()>10)
			overTime = overTime.substring(0,10);
		return overTime;
	}

	public void setOverTime(String overTime) {
		this.overTime = overTime;
	}

	public int getMaxLoginNum() {
		return maxLoginNum;
	}

	public void setMaxLoginNum(int maxLoginNum) {
		this.maxLoginNum = maxLoginNum;
	}

	public int getAuthCn() {
		return authCn;
	}

	public void setAuthCn(int authCn) {
		this.authCn = authCn;
	}

	public int getAddAuthCn() {
		return addAuthCn;
	}

	public void setAddAuthCn(int addAuthCn) {
		this.addAuthCn = addAuthCn;
	}

	public int getAuthFr() {
		return authFr;
	}

	public void setAuthFr(int authFr) {
		this.authFr = authFr;
	}

	public int getAddAuthFr() {
		return addAuthFr;
	}

	public void setAddAuthFr(int addAuthFr) {
		this.addAuthFr = addAuthFr;
	}

	public int getBatchDownloadNum() {
		return batchDownloadNum;
	}

	public void setBatchDownloadNum(int batchDownloadNum) {
		this.batchDownloadNum = batchDownloadNum;
	}

	public int getAnalysePatent() {
		return analysePatent;
	}

	public void setAnalysePatent(int analysePatent) {
		this.analysePatent = analysePatent;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String[] getSearchAuth() {
		return searchAuth;
	}

	public void setSearchAuth(String[] searchAuth) {
		this.searchAuth = searchAuth;
	}

	public String[] getMenuAuth() {
		return menuAuth;
	}

	public void setMenuAuth(String[] menuAuth) {
		this.menuAuth = menuAuth;
	}

	public String[] getIndustryList() {
		return industryList;
	}

	public void setIndustryList(String[] industryList) {
		this.industryList = industryList;
	}

/*	public String[] getEnterpriseList() {
		return enterpriseList;
	}

	public void setEnterpriseList(String[] enterpriseList) {
		this.enterpriseList = enterpriseList;
	}

	public String[] getIndividualList() {
		return individualList;
	}

	public void setIndividualList(String[] individualList) {
		this.individualList = individualList;
	}*/

	public int getAdminStatus() {
		return adminStatus;
	}

	public void setAdminStatus(int adminStatus) {
		this.adminStatus = adminStatus;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getFromUrl() {
		return fromUrl;
	}

	public void setFromUrl(String fromUrl) {
		this.fromUrl = fromUrl;
	}

	public String getRequsetInfo() {
		return requsetInfo;
	}

	public void setRequsetInfo(String requsetInfo) {
		this.requsetInfo = requsetInfo;
	}
	
}
