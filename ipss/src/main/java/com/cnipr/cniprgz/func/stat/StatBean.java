package com.cnipr.cniprgz.func.stat;

import java.io.Serializable;
import java.util.Date;

public class StatBean implements Serializable{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 3255408896168944504L;
	
	private int userID;
	private String userName;
	private String realName;
	private Date visitTime;
	private int count;
	private String strTime;
	private String visitIP;
	
	private int loginCount;
	private int searchCount;
	private int viewCount;
	private int downloadCount;
	private int downloadXmlCount;
	private int downloadDocCount;
	private int printCount;
	private int printXmlCount;
	private int printDocCount;
	private int viewXmlCount;
	/** 中国专利说明书查看量 */
	private int viewDocCount;
	/** 发明授权说明书查看量 */
	private int viewSQDocCount;
	/** 实用新型说明书查看量 */
	private int viewXXDocCount;
	/** 外观设计说明书查看量 */
	private int viewWGDocCount;
	/** 国外文摘浏览量 */
	private int viewFrCount;
	
	public int getViewSQDocCount() {
		return viewSQDocCount;
	}
	public void setViewSQDocCount(int viewSQDocCount) {
		this.viewSQDocCount = viewSQDocCount;
	}
	public int getViewXXDocCount() {
		return viewXXDocCount;
	}
	public void setViewXXDocCount(int viewXXDocCount) {
		this.viewXXDocCount = viewXXDocCount;
	}
	public int getViewWGDocCount() {
		return viewWGDocCount;
	}
	public void setViewWGDocCount(int viewWGDocCount) {
		this.viewWGDocCount = viewWGDocCount;
	}
	public int getViewFrCount() {
		return viewFrCount;
	}
	public void setViewFrCount(int viewFrCount) {
		this.viewFrCount = viewFrCount;
	}
	public StatBean(){
		
	}
	public StatBean(int userID,String userName,String realName,Date visitTime,int count,String strTime){
		this.userID = userID;
		this.userName = userName;
		this.realName = realName;
		this.visitTime = visitTime;
		this.count = count;
		this.strTime = strTime;
	}
	
	public StatBean(int userID,String userName,String realName,Date visitTime,int count){
		this.userID = userID;
		this.userName = userName;
		this.realName = realName;
		this.visitTime = visitTime;
		this.count = count;
	}
	/**
	 * 根据对象返回数据的字段值
	 * @param columnName
	 * @return
	 */
	public String getInfoByName(String columnName){
		String value = "";
		if("用户名".equals(columnName)){
			value = realName;
		}else if("访问次数".equals(columnName)){
			value = String.valueOf(count);
		}else if("访问时间".equals(columnName)){
			value = strTime;
		}else if("访问IP".equals(columnName)){
			value = visitIP;
		}else if("时间段".equals(columnName)){
			value=strTime;
		}else if("会话".equals(columnName)){
			value = String.valueOf(loginCount);
		}else if("查询".equals(columnName)){
			value = String.valueOf(searchCount);
		}else if("查看文摘".equals(columnName)){
			value = String.valueOf(viewCount);
		}else if("中国专利说明书浏览量".equals(columnName)){
			value = String.valueOf(viewDocCount);
		}else if("查看代码化".equals(columnName)){
			value = String.valueOf(viewXmlCount);
		}else if("下载专利".equals(columnName)){
			value = String.valueOf(downloadCount);
		}else if("说明书下载".equals(columnName)){
			value = String.valueOf(downloadDocCount);
		}else if("下载代码化".equals(columnName)){
			value = String.valueOf(downloadXmlCount);
		}else if("打印文摘".equals(columnName)){
			value = String.valueOf(printCount);
		}else if("说明书打印".equals(columnName)){
			value = String.valueOf(printDocCount);
		}else if("发明授权说明书浏览量".equals(columnName)){
			value = String.valueOf(viewSQDocCount);
		}else if("实用新型说明书浏览量".equals(columnName)){
			value = String.valueOf(viewXXDocCount);
		}else if("外观设计说明书浏览量".equals(columnName)){
			value = String.valueOf(viewWGDocCount);
		}else if("国外文摘浏览量".equals(columnName)){
			value = String.valueOf(viewFrCount);
		}
		return value;
	}
	public int getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}
	public int getSearchCount() {
		return searchCount;
	}
	public void setSearchCount(int searchCount) {
		this.searchCount = searchCount;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getDownloadCount() {
		return downloadCount;
	}
	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}
	public int getDownloadXmlCount() {
		return downloadXmlCount;
	}
	public void setDownloadXmlCount(int downloadXmlCount) {
		this.downloadXmlCount = downloadXmlCount;
	}
	public int getDownloadDocCount() {
		return downloadDocCount;
	}
	public void setDownloadDocCount(int downloadDocCount) {
		this.downloadDocCount = downloadDocCount;
	}
	public int getPrintCount() {
		return printCount;
	}
	public void setPrintCount(int printCount) {
		this.printCount = printCount;
	}
	public int getPrintXmlCount() {
		return printXmlCount;
	}
	public void setPrintXmlCount(int printXmlCount) {
		this.printXmlCount = printXmlCount;
	}
	public int getPrintDocCount() {
		return printDocCount;
	}
	public void setPrintDocCount(int printDocCount) {
		this.printDocCount = printDocCount;
	}
	public int getViewXmlCount() {
		return viewXmlCount;
	}
	public void setViewXmlCount(int viewXmlCount) {
		this.viewXmlCount = viewXmlCount;
	}
	public int getViewDocCount() {
		return viewDocCount;
	}
	public void setViewDocCount(int viewDocCount) {
		this.viewDocCount = viewDocCount;
	}
	public String getVisitIP() {
		return visitIP;
	}
	public void setVisitIP(String visitIP) {
		this.visitIP = visitIP;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public Date getVisitTime() {
		return visitTime;
	}
	public void setVisitTime(Date visitTime) {
		this.visitTime = visitTime;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getStrTime() {
		return strTime;
	}
	public void setStrTime(String strTime) {
		this.strTime = strTime;
	}
	
}
