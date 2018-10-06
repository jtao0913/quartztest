/**
 * 检索条件
 */
package com.cnipph.common;

import java.io.Serializable;

/**
 * @author Liuc
 */
public class SearchBean implements Serializable {

	/**
	 * 版本标识
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 字
	 */
	public static final int WORD = 2;

	/**
	 * 词
	 */
	public static final int PHRASE = 0;

	// 检索条件
	/**
	 * 检索库
	 */
	private String db;

	/**
	 * 检索表达式式
	 */
	private String exp;

	/**
	 * 排序方法
	 */
	private String sortMethod;

	/**
	 * 统计结果
	 */
	private String stat;

	/**
	 * 默认检索字段
	 */
	private String defaultCols;

	/**
	 * 字词检索
	 */
	private int option;

	/**
	 * 命中点类型
	 */
	private int hitPointType;

	/**
	 * 二次检索
	 */
	private boolean isContinue;

	/**
	 * 同义词词典
	 */
	private String synonym;

	// 显示条件
	/**
	 * 概览字段
	 */
	private String summaryField;

	/**
	 * 概览显示条数
	 */
	private int summaryPageSize;

	// 关联条件
	/**
	 * 公开(公告)号
	 */
	private String pn;

	/**
	 * 申请号
	 */
	private String ap;

	/**
	 * 库标识
	 */
	private String dbFlag;

	/**
	 * 恢复连接
	 */
	private String licenceCode;

	// 其它
	/**
	 * 错误信息
	 */
	private String errorInfo;

	/**
	 * 显示表达式
	 */
	private String displayExp;

	/**
	 * 检索结果数
	 */
	private String rscount;

	/**
	 * 页面显示的数据库名称
	 */
	private String displayDBName;

	/**
	 * 页面显示的同义词典名称
	 */
	private String displaySysdict;

	/**
	 * @return db
	 */
	public String getDb() {
		return db;
	}

	/**
	 * @param db 要设置的 db
	 */
	public void setDb(String db) {
		this.db = db;
	}

	/**
	 * @return defaultCols
	 */
	public String getDefaultCols() {
		return defaultCols;
	}

	/**
	 * @param defaultCols 要设置的 defaultCols
	 */
	public void setDefaultCols(String defaultCols) {
		this.defaultCols = defaultCols;
	}

	/**
	 * @return exp
	 */
	public String getExp() {
		return exp;
	}

	/**
	 * @param exp 要设置的 exp
	 */
	public void setExp(String exp) {
		this.exp = exp;
	}

	/**
	 * @return hitPointType
	 */
	public int getHitPointType() {
		return hitPointType;
	}

	/**
	 * @param hitPointType 要设置的 hitPointType
	 */
	public void setHitPointType(int hitPointType) {
		this.hitPointType = hitPointType;
	}

	/**
	 * @return isContinue
	 */
	public boolean isContinue() {
		return isContinue;
	}

	/**
	 * @param isContinue 要设置的 isContinue
	 */
	public void setContinue(boolean isContinue) {
		this.isContinue = isContinue;
	}

	/**
	 * @return option
	 */
	public int getOption() {
		return option;
	}

	/**
	 * @param option 要设置的 option
	 */
	public void setOption(int option) {
		this.option = option;
	}

	/**
	 * @return sortMethod
	 */
	public String getSortMethod() {
		return sortMethod;
	}

	/**
	 * @param sortMethod 要设置的 sortMethod
	 */
	public void setSortMethod(String sortMethod) {
		this.sortMethod = sortMethod;
	}

	/**
	 * @return stat
	 */
	public String getStat() {
		return stat;
	}

	/**
	 * @param stat 要设置的 stat
	 */
	public void setStat(String stat) {
		this.stat = stat;
	}

	/**
	 * @return synonym
	 */
	public String getSynonym() {
		return synonym;
	}

	/**
	 * @param synonym 要设置的 synonym
	 */
	public void setSynonym(String synonym) {
		this.synonym = synonym;
	}

	/**
	 * @return summaryField
	 */
	public String getSummaryField() {
		return summaryField;
	}

	/**
	 * @param summaryField 要设置的 summaryField
	 */
	public void setSummaryField(String summaryField) {
		this.summaryField = summaryField;
	}

	/**
	 * @return summaryPageSize
	 */
	public int getSummaryPageSize() {
		return summaryPageSize;
	}

	/**
	 * @param summaryPageSize 要设置的 summaryPageSize
	 */
	public void setSummaryPageSize(int summaryPageSize) {
		this.summaryPageSize = summaryPageSize;
	}

	/**
	 * @return pn
	 */
	public String getPn() {
		return pn;
	}

	/**
	 * @param pn 要设置的 pn
	 */
	public void setPn(String pn) {
		this.pn = pn;
	}

	/**
	 * @return ap
	 */
	public String getAp() {
		return ap;
	}

	/**
	 * @param ap 要设置的 ap
	 */
	public void setAp(String ap) {
		this.ap = ap;
	}

	/**
	 * @return dbFlag
	 */
	public String getDbFlag() {
		return dbFlag;
	}

	/**
	 * @param dbFlag 要设置的 dbFlag
	 */
	public void setDbFlag(String dbFlag) {
		this.dbFlag = dbFlag;
	}

	/**
	 * @return licenceCode
	 */
	public String getLicenceCode() {
		return licenceCode;
	}

	/**
	 * @param licenceCode 要设置的 licenceCode
	 */
	public void setLicenceCode(String licenceCode) {
		this.licenceCode = licenceCode;
	}

	/**
	 * @return errorInfo
	 */
	public String getErrorInfo() {
		return errorInfo;
	}

	/**
	 * @param errorInfo 要设置的 errorInfo
	 */
	public void setErrorInfo(String errorInfo) {
		this.errorInfo = errorInfo;
	}

	/**
	 * @return displayExp
	 */
	public String getDisplayExp() {
		return displayExp;
	}

	/**
	 * @param displayExp 要设置的 displayExp
	 */
	public void setDisplayExp(String displayExp) {
		this.displayExp = displayExp;
	}

	/**
	 * @return rscount
	 */
	public String getRscount() {
		return rscount;
	}

	/**
	 * @param rscount 要设置的 rscount
	 */
	public void setRscount(String rscount) {
		this.rscount = rscount;
	}

	/**
	 * @return displayDBName
	 */
	public String getDisplayDBName() {
		return displayDBName;
	}

	/**
	 * @param displayDBName 要设置的 displayDBName
	 */
	public void setDisplayDBName(String displayDBName) {
		this.displayDBName = displayDBName;
	}

	/**
	 * @return displaySysdict
	 */
	public String getDisplaySysdict() {
		return displaySysdict;
	}

	/**
	 * @param displaySysdict 要设置的 displaySysdict
	 */
	public void setDisplaySysdict(String displaySysdict) {
		this.displaySysdict = displaySysdict;
	}
}