package com.cnipr.cniprgz.dao.julei.bean;

import java.io.Serializable;

public class Word implements Serializable {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 关键词
	 */
	private String word;

	/**
	 * 权重
	 */
	private String weight;

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
	 * @return the weight
	 */
	public String getWeight() {
		return weight;
	}

	/**
	 * @param weight
	 *            the weight to set
	 */
	public void setWeight(String weight) {
		this.weight = weight;
	}

	@Override
	public String toString() {
		return "Word [word=" + word + ", weight=" + weight + "]";
	}
	
	
}