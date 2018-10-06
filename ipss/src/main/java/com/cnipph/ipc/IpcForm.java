/*
 * Generated by MyEclipse Struts Template path: templates/java/JavaClass.vtl
 */
package com.cnipph.ipc;

import java.util.List;

import com.cnipph.common.BaseForm;

/**
 * MyEclipse Struts Creation date: 03-09-2007 XDoclet definition:
 * 
 * @struts.form name="ipcForm"
 */
public class IpcForm extends BaseForm {

	/**
	 * 版本标识
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 检索分类号
	 */
	private String code;

	/**
	 * 逻辑关系
	 */
	private String rdoLogic;

	/**
	 * 检索库
	 */
	private String rdoDB;

	/**
	 * 查询条件
	 */
	private String txtIpc;

	/**
	 * 检索条件
	 */
	private String txtExpression;

	/**
	 * 检索类型：字、号、名
	 */
	private String hidLicenceCode;

	/**
	 * 检索结果
	 */
	private List arrayList;

	/**
	 * @return code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code 要设置的 code
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return hidLicenceCode
	 */
	public String getHidLicenceCode() {
		return hidLicenceCode;
	}

	/**
	 * @param hidLicenceCode 要设置的 hidLicenceCode
	 */
	public void setHidLicenceCode(String hidLicenceCode) {
		this.hidLicenceCode = hidLicenceCode;
	}

	/**
	 * @return rdoDB
	 */
	public String getRdoDB() {
		return rdoDB;
	}

	/**
	 * @param rdoDB 要设置的 rdoDB
	 */
	public void setRdoDB(String rdoDB) {
		this.rdoDB = rdoDB;
	}

	/**
	 * @return rdoLogic
	 */
	public String getRdoLogic() {
		return rdoLogic;
	}

	/**
	 * @param rdoLogic 要设置的 rdoLogic
	 */
	public void setRdoLogic(String rdoLogic) {
		this.rdoLogic = rdoLogic;
	}

	/**
	 * @return txtExpression
	 */
	public String getTxtExpression() {
		return txtExpression;
	}

	/**
	 * @param txtExpression 要设置的 txtExpression
	 */
	public void setTxtExpression(String txtExpression) {
		this.txtExpression = txtExpression;
	}

	/**
	 * @return txtIpc
	 */
	public String getTxtIpc() {
		return txtIpc;
	}

	/**
	 * @param txtIpc 要设置的 txtIpc
	 */
	public void setTxtIpc(String txtIpc) {
		this.txtIpc = txtIpc;
	}

	public List getArrayList() {
		return arrayList;
	}

	public void setArrayList(List arrayList) {
		this.arrayList = arrayList;
	}
}