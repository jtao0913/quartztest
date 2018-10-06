package com.cnipr.cniprgz.commons.page;

import java.util.ArrayList;

/**
 * ҳ����ʾ����ѯBaseInfoDTO
 */
public class PageBaseInfo {

	public static final int THEFIRSTPAGE = 1;

	public static final int THELASTPAGE = 2;
	
	/**
	 * ��ҳ�е����
	 */
	private ArrayList list;
	
	/**
	 * �ܼ�¼��
	 */
	private int countRownum;

	/**
	 * ��ҳ��
	 */
	private int countPagenum;

	/**
	 * ��ǰҳ��
	 */
	private int curPageNo;

	private int curRowNo;

	public PageBaseInfo() {

	}

	/**
	 * Access method for the countRownum property.
	 * 
	 * @return the current value of the countRownum property
	 */
	public int getCountRownum() {
		return countRownum;
	}

	/**
	 * Sets the value of the countRownum property.
	 * 
	 * @param aCountRownum
	 *            the new value of the countRownum property
	 */
	public void setCountRownum(int aCountRownum) {
		countRownum = aCountRownum;
	}

	/**
	 * Access method for the countPagenum property.
	 * 
	 * @return the current value of the countPagenum property
	 */
	public int getCountPagenum() {
		return countPagenum;
	}

	/**
	 * Sets the value of the countPagenum property.
	 * 
	 * @param aCountPagenum
	 *            the new value of the countPagenum property
	 */
	public void setCountPagenum(int aCountPagenum) {
		countPagenum = aCountPagenum;
	}

	/**
	 * Access method for the curPageNo property.
	 * 
	 * @return the current value of the curPageNo property
	 */
	public int getCurPageNo() {
		return curPageNo;
	}

	/**
	 * Sets the value of the curPageNo property.
	 * 
	 * @param aCurPageNo
	 *            the new value of the curPageNo property
	 */
	public void setCurPageNo(int aCurPageNo) {
		curPageNo = aCurPageNo;
	}

	/**
	 * Access method for the curRowNo property.
	 * 
	 * @return the current value of the curRowNo property
	 */
	public int getCurRowNo() {
		return curRowNo;
	}

	/**
	 * Sets the value of the curRowNo property.
	 * 
	 * @param aCurRowNo
	 *            the new value of the curRowNo property
	 */
	public void setCurRowNo(int aCurRowNo) {
		curRowNo = aCurRowNo;
	}

	public ArrayList getList() {
		return list;
	}

	public void setList(ArrayList list) {
		this.list = list;
	}

	public String disabledInfo(int pageFlag) {
		String target = "";

		boolean cant = false;

		if (pageFlag == THEFIRSTPAGE && this.curPageNo == 1)
			cant = true;

		if (pageFlag == THELASTPAGE && this.curPageNo == countPagenum)
			cant = true;

		if (cant)
			target = "disabled";

		return target;

	}

	public int getPrevPageNo() {
		if (this.curPageNo == 1)
			return 1;
		else
			return this.curPageNo - 1;
	}

	public int getLastPageNo() {
		if (this.curPageNo == this.countPagenum)
			return this.countPagenum;
		else
			return this.curPageNo + 1;
	}

}
