/*
 * Generated by MyEclipse Struts Template path: templates/java/JavaClass.vtl
 */
package com.cnipph.common;

import org.apache.struts.validator.ValidatorForm;

/**
 * MyEclipse Struts Creation date: 02-25-2008 XDoclet definition:
 * 
 * @struts.form name="baseForm"
 */
public class BaseForm extends ValidatorForm {

	/**
	 * 版本标识
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 检索条件
	 */
	private SearchBean searchBean;

	/**
	 * @return searchBean
	 */
	public SearchBean getSearchBean() {
		if (searchBean == null) {
			searchBean = new SearchBean();
		}
		return searchBean;
	}

	/**
	 * @param searchBean 要设置的 searchBean
	 */
	public void setSearchBean(SearchBean searchBean) {
		this.searchBean = searchBean;
	}
}