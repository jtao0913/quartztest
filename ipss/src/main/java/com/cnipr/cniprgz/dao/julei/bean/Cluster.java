package com.cnipr.cniprgz.dao.julei.bean;

import java.io.Serializable;
import java.util.List;

public class Cluster implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private String id;

	/**
	 * 坐标
	 */
	private String x;
	private String y;
	private String z;

	/**
	 * 关键词
	 */
	private String word;
	private List<Word> lstWord;

	/**
	 * 专利
	 */
	private List<Patent> lstPatent;

	/**
	 * 检索式
	 */
	private String exp;

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the x
	 */
	public String getX() {
		return x;
	}

	/**
	 * @param x
	 *            the x to set
	 */
	public void setX(String x) {
		this.x = x;
	}

	/**
	 * @return the y
	 */
	public String getY() {
		return y;
	}

	/**
	 * @param y
	 *            the y to set
	 */
	public void setY(String y) {
		this.y = y;
	}

	/**
	 * @return the z
	 */
	public String getZ() {
		return z;
	}

	/**
	 * @param z
	 *            the z to set
	 */
	public void setZ(String z) {
		this.z = z;
	}

	/**
	 * @return the word
	 */
	public String getWord() {
		return word;
	}

	/**
	 * @param word
	 *            the word to set
	 */
	public void setWord(String word) {
		this.word = word;
	}

	/**
	 * @return the lstWord
	 */
	public List<Word> getLstWord() {
		return lstWord;
	}

	/**
	 * @param lstWord
	 *            the lstWord to set
	 */
	public void setLstWord(List<Word> lstWord) {
		this.lstWord = lstWord;
	}

	/**
	 * @return the lstPatent
	 */
	public List<Patent> getLstPatent() {
		return lstPatent;
	}

	/**
	 * @param lstPatent
	 *            the lstPatent to set
	 */
	public void setLstPatent(List<Patent> lstPatent) {
		this.lstPatent = lstPatent;
	}

	/**
	 * @return the exp
	 */
	public String getExp() {
		return exp;
	}

	/**
	 * @param exp
	 *            the exp to set
	 */
	public void setExp(String exp) {
		this.exp = exp;
	}

	@Override
	public String toString() {
		return "Cluster [id=" + id + ", x=" + x + ", y=" + y + ", z=" + z + ", word=" + word + ", lstWord=" + lstWord
				+ ", lstPatent=" + lstPatent + ", exp=" + exp + "]";
	}
	
	
}